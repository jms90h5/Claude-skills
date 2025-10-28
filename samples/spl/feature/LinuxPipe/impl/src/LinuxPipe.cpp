/* begin_generated_IBM_Teracloud_ApS_copyright_prolog               */
/*                                                                  */
/* This is an automatically generated copyright prolog.             */
/* After initializing,  DO NOT MODIFY OR MOVE                       */
/* **************************************************************** */
/* THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                */
/* TERACLOUD APS AND IBM MAKES NO REPRESENTATIONS OR WARRANTIES,    */
/* EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   */
/* COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       */
/* AND IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION   */
/* OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE */
/* RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  */
/* OF THIS SAMPLE CODE.                                             */
/*                                                                  */
/* LIMITATION OF LIABILITY. IN NO EVENT WILL IBM BE LIABLE TO ANY   */
/* PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL   */
/* DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    */
/* THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  */
/* PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   */
/* ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                */
/*                                                                  */
/* (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2011     */
/* All Rights reserved.                                             */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
#include "LinuxPipe.h"

#include <SPL/Runtime/Utility/RuntimeUtility.h>
#include <SPL/Runtime/Common/RuntimeException.h>

#include <cassert>
#include <cerrno>
#include <fcntl.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sys/wait.h>
#include <unistd.h>

#include <vector>
#include <sstream>

using namespace SPL;
using namespace Sample;

static bool writeFull(int fd, char const * buf, size_t count)
{
    while(count>0) {
        ssize_t n = ::write(fd, buf, count);        
        if(n==-1 && errno!=EINTR) {
            return false;
        } else if(n>0) {
            count -= n;
            buf += n;
        }
    }
    return true;
}

std::string LinuxPipe::getTermInfoExplanation()
{
    AutoMutex am(mutex_);
    std::ostringstream explanation;
    if(termInfo_.reason == LinuxPipe::Shutdown)
        explanation << "Shutdown";
    else if(termInfo_.reason == LinuxPipe::Unknown)
        explanation << "Unknown";
    else if(termInfo_.reason == LinuxPipe::Exit) {
        explanation << "Exit";
        explanation << ", Exit code: " << termInfo_.exitCode;
    } else {
        assert(!"cannot happen");
    }
    return explanation.str();
}

void LinuxPipe::setup(std::string const & command)
{
    if(pipe(stdInPipe_)) 
        throw LinuxPipeException(RuntimeUtility::getErrorNoStr());
    if(pipe(stdOutPipe_)) 
        throw LinuxPipeException(RuntimeUtility::getErrorNoStr());
    if(pipe(stdErrPipe_))
        throw LinuxPipeException(RuntimeUtility::getErrorNoStr());
    // Setup fds that need to be closed upon the exec call
    fcntl(stdInPipe_[WRITE], F_SETFD, FD_CLOEXEC);
    fcntl(stdOutPipe_[READ], F_SETFD, FD_CLOEXEC);
    fcntl(stdErrPipe_[READ], F_SETFD, FD_CLOEXEC);
    pid_t pid = fork(); 
    if(pid == -1) 
        throw LinuxPipeException(RuntimeUtility::getErrorNoStr());
    if(pid) { 
        child_ = pid;
        // We are in the parent process 
        // Close unused side of pipes  
        close(stdInPipe_[READ]);
        close(stdOutPipe_[WRITE]); 
        close(stdErrPipe_[WRITE]);
        // Set the in sides of the pipes to non-blocking
        fcntl(stdOutPipe_[READ], F_SETFL, O_NONBLOCK);
        fcntl(stdErrPipe_[READ], F_SETFL, O_NONBLOCK);
        // Setup select descriptors
        FD_ZERO(&readSet_);
        FD_SET(stdOutPipe_[READ], &readSet_);
        FD_SET(stdErrPipe_[READ], &readSet_);
        stdOutClosed_ = stdErrClosed_ = false;
        maxfd_ = 1 + std::max(stdOutPipe_[READ], stdErrPipe_[READ]);
        return;
    } else { 
        // We are in the child process
        // Close and replace standard in with the input side of the pipe     
        if(0>dup2(stdInPipe_[READ],STDIN_FILENO))                                          
            throw LinuxPipeException(RuntimeUtility::getErrorNoStr());     
        // Close and replace standard out with the output side of the pipe 
        if(0>dup2(stdOutPipe_[WRITE],STDOUT_FILENO))                                          
            throw LinuxPipeException(RuntimeUtility::getErrorNoStr());
        // Close and replace standard err with the output side of the pipe 
        if(0>dup2(stdErrPipe_[WRITE],STDERR_FILENO))                                          
            throw LinuxPipeException(RuntimeUtility::getErrorNoStr());

        // Run the pipe
        std::string name = "/bin/sh";
        std::vector<std::string> args;
        args.push_back("-c");
        args.push_back(command);

        std::vector<char*> cargs;

        cargs.push_back(const_cast<char*>(name.c_str()));
        
        for(auto& str : args)
            cargs.push_back(const_cast<char*>(str.c_str()));

        // Should already be null from the resize() but being explicit here to match the execvp requirements
        cargs.push_back(nullptr);
        
        // Replace the child fork with a new process 
        if(execvp(name.c_str(), cargs.data()) == -1) {
            throw LinuxPipeException(RuntimeUtility::getErrorNoStr());
        }
    }
}

void LinuxPipe::writeLine(std::string const & line)
{
    if(!writeFull(stdInPipe_[WRITE], line.data(), line.length())) {
        terminate();
        throw LinuxPipeException(getTermInfoExplanation()); 
    }
    if(!writeFull(stdInPipe_[WRITE], "\n", 1)) {
        terminate();
        throw LinuxPipeException(getTermInfoExplanation()); 
    }
}

static int readFromPipe(std::string & buffer, int fd)
{
    char buf[1024]; 
    ssize_t cnt = read(fd, buf, 1023);
    if (cnt>0) { 
        buf[cnt] = '\0';
        buffer += buf;
    }
    return cnt;
}

bool LinuxPipe::readLine(LineOutput & out)
{
    std::string outLine, errLine;
    bool hasOutLine = false, hasErrLine = false;
    while(!hasOutLine && !hasErrLine) {
        size_t pos = stdOutResult_.find('\n');
        if(pos!=std::string::npos) {
            hasOutLine = true;
            outLine = stdOutResult_.substr(0, pos);
            stdOutResult_ = stdOutResult_.substr(pos+1);
        }
        pos = stdErrResult_.find('\n');
        if(pos!=std::string::npos) {
            hasErrLine = true;
            errLine = stdErrResult_.substr(0, pos);
            stdErrResult_ = stdErrResult_.substr(pos+1);
        }
        if(hasOutLine || hasErrLine) {
            out = LineOutput(hasOutLine?(&outLine):NULL,
                             hasErrLine?(&errLine):NULL);
            return false; 
        }
        // Both are closed
        if(stdOutClosed_ && stdErrClosed_) {
            terminate();
            if(termInfo_.reason==Shutdown)
                return true;
            throw LinuxPipeException(getTermInfoExplanation()); 
        }
        fd_set workSet;
        memcpy(&workSet, &readSet_, sizeof(readSet_));
        select(maxfd_, &workSet, NULL, NULL, NULL);
        // we do not care about the select result, really...
        if(!stdOutClosed_) {
            int res = readFromPipe(stdOutResult_, stdOutPipe_[READ]);
            stdOutClosed_ = (res==0);
            if (res==-1 && errno!=EAGAIN && errno!=EINTR) {
                terminate();
                throw LinuxPipeException(getTermInfoExplanation()); 
            }
        }
        if(!stdErrClosed_) {
            int res = readFromPipe(stdErrResult_, stdErrPipe_[READ]);
            stdErrClosed_ = (res==0);
            if (res==-1 && errno!=EAGAIN && errno!=EINTR) {
                terminate();
                throw LinuxPipeException(getTermInfoExplanation()); 
            }          
        }
    }
    return false;
}

void LinuxPipe::terminate()
{
    AutoMutex am(mutex_);
    if(terminated_)
        return;
    terminated_ = true;
    int status; 
    int res = waitpid(child_, &status, WNOHANG); 
    if(res==child_) {
        if(WIFEXITED(status)) { 
            termInfo_.reason = Exit;
            termInfo_.exitCode = WEXITSTATUS(status);
            if(shutdown_ && termInfo_.exitCode==0)
                termInfo_.reason = Shutdown;
        } else {            
            termInfo_.reason = Unknown;
            termInfo_.exitCode = 0;
        }
    } else {
        if(shutdown_ && res==0)            
            termInfo_.reason = Shutdown;
        else
            termInfo_.reason = Unknown;
        termInfo_.exitCode = 0;
        ::kill(child_, SIGKILL);
        ::waitpid(child_, &status, 0); 
    } 
    if(shutdown_) {
        cv_.signal();
    } else {
        close(stdInPipe_[WRITE]);
    }
    close(stdOutPipe_[READ]); 
    close(stdErrPipe_[READ]);
}

void LinuxPipe::shutdown(bool wait/*=false*/)
{
    AutoMutex am(mutex_);
    if(shutdown_)
        return;
    shutdown_ = true;
    if(terminated_)
        return;
    close(stdInPipe_[WRITE]);
    if(wait) 
        while(!terminated_)
            cv_.wait(mutex_);
}



