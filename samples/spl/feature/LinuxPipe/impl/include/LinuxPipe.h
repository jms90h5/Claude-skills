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
/* (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2012     */
/* All Rights reserved.                                             */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
#ifndef SAMPLE_LINUX_PIPE
#define SAMPLE_LINUX_PIPE

#include <string>
#include <stdexcept>
#include <sys/select.h>
#include <SPL/Runtime/Utility/CV.h>
#include <SPL/Runtime/Utility/Mutex.h>

namespace Sample
{
    /// Exception class for LinuxPipe
    class LinuxPipeException : public std::runtime_error
    {
    public:
        /// Constructor
        /// @param err error string
        LinuxPipeException(std::string const & err) 
            : std::runtime_error(err) {}
    };

    /*! Helper class to launch a linux pipe command 
    Usage: 
    \code
    // Writer thread
    LinuxPipe pipe;
    try {
        pipe.setup("sed 's/streams/STREAMS/g' | sed 's/spl/SPL/g'");
    } catch(SPLRuntimeException const & e) {
        cerr << "Error during pipe setup: " << e.getExplanation() << endl;
        throw;
    }
    try {
        while(getLine(line)) { // getLine() is a user function
            pipe.writeLine(line);
        }
    } catch(SPLRuntimeException const & e) {
        cerr << "Error during pipe write: " << e.getExplanation() << endl;
        throw;
    }
    pipe.shutdown();
    
    // reader thread
    LineOutput res;
    try {
        while(!pipe.readLine(res)) {
            useLine(res); // useLine() is a user function
        } 
    } catch(SPLRuntimeException const & e) {
        cerr << "Error during pipe read: " << e.getExplanation() << endl;
        throw;
    }
    \endcode
    */
    class LinuxPipe 
    {
    public:
        class LineOutput;
        struct TerminationInfo;

        /// Constructor
        ///
        LinuxPipe()
            : shutdown_(false), terminated_(false) {}

        /// Destructor
        ///
        ~LinuxPipe() { terminate(); }

        /// Setup a pipe
        /// @param the pipe command. E.g.: "sed 's/streams/STREAMS/g' | sed 's/spl/SPL/g'"
        /// @throws LinuxPipeException if an error occurs during the pipe setup
        void setup(std::string const & command);
        
        /// Write a line to the standard input of the pipe. This call will block
        /// if the pipe is full.
        /// @param line line to be written
        /// @throws LinuxPipeException if the pipe has terminated. The
        /// getTerminationInfo() function should be used to check for the
        /// reason.
        void writeLine(std::string const & line);
        
        /// Read a line. If both standard output and standard error have a line
        /// available, return both. Otherwise, return one. This call will block
        /// until there is a line to read.
        /// @param res (out parameter) the read line(s) 
        /// @return true if the pipeline was shutdown properly and there is no
        /// more data to be read.
        /// @throws LinuxPipeException if the pipe has terminated. The
        /// getTerminationInfo() function should be used to check for the
        /// reason.
        bool readLine(LineOutput & res);
        
        /// Shutdown the pipe. This call will block if the pipe is healthy and
        /// is not completely drained. The reading thread should continue to
        /// issue readLine() calls until the pipe is drained.
        /// @param wait if true, the call will block until the pipe is
        /// drained. Otherwise, the call will return without blocking.
        void shutdown(bool wait=true);  
        
        /// Get the termination info
        /// @return termination info
        TerminationInfo const & getTerminationInfo()
        {
            return termInfo_;
        }

        enum ReasonCode
        { 
            Shutdown, //!< Terminated due to explicit shutdown
            Unknown,  //!< Terminated due to an unknown reason (signal, coredump, etc.)
            Exit      //!< Terminated due to pipe exiting with a status
        };
        
        struct TerminationInfo
        {
            ReasonCode reason; //!< Reason of termination
            int exitCode;      //!< Exit code if reason==Exit
        };
        
        /// Class that represents line output from a read operation on the pipe
        class LineOutput 
        {
        public:
            /// Constructor
            ///
            LineOutput()
                : hasStdOut_(false), hasStdErr_(false) {}

            /// Check if the result contains a line from the standard output
            /// @return true if there is, false otherwise
            bool hasStdOutLine() const { return hasStdOut_; }

            /// Check if the result contains a line from the standard error
            /// @return true if there is, false otherwise
            bool hasStdErrLine() const { return hasStdErr_; }

            /// Get the line from the standard output
            /// @pre hasStdOutLine()==true
            /// @return line from the standard output
            std::string const & getStdOutLine() const { return stdOutLine_; }

            /// Get the line from the standard error
            /// @pre hasStdErrLine()==true
            /// @return line from the standard error
            std::string const & getStdErrLine() const { return stdErrLine_; }
        private:
            LineOutput(std::string const * stdOutLine,
                       std::string const * stdErrLine)
                : hasStdOut_(stdOutLine!=nullptr),
                  hasStdErr_(stdErrLine!=nullptr)                  
            { 
                if(hasStdOut_) 
                    stdOutLine_ = *stdOutLine;
                if(hasStdErr_) 
                    stdErrLine_ = *stdErrLine;
            }
            bool hasStdOut_;
            bool hasStdErr_;
            std::string stdOutLine_;
            std::string stdErrLine_;
            friend class LinuxPipe;
        };
        
    private:
        enum { READ=0, WRITE };

        void terminate();              
        std::string getTermInfoExplanation();

        pid_t child_; // child process
        int stdInPipe_[2]; // pipe for std in of the linux pipe
        int stdOutPipe_[2]; // pipe for the std out of the linux pipe
        int stdErrPipe_[2]; // pipe for the std err of the linux pipe
        int maxfd_; // max file descriptor + 1 for select on stdOut and stdIn
        fd_set readSet_; // read set fds for select on stdOut and stdIn
        bool stdOutClosed_; // completion status of std out
        bool stdErrClosed_; // completion status of std err
        std::string stdOutResult_; // temporary result holder for stdOut
        std::string stdErrResult_; // temporary result holder for stdErr

        SPL::CV cv_;
        SPL::Mutex mutex_;
        volatile bool shutdown_;
        volatile bool terminated_;
        TerminationInfo termInfo_;
    };
};

#endif /* SAMPLE_LINUX_PIPE */
