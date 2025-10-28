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
/* (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2015, 2015     */
/* All Rights reserved.                                             */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
package com.ibm.streams.security.auth.module.xml;

import java.io.IOException;
import java.security.Principal;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.FailedLoginException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

import com.ibm.streams.security.authc.GroupPrincipal;
import com.ibm.streams.security.authc.UserPrincipal;

import com.ibm.streams.security.auth.module.xml.internal.UserInfo;
import com.ibm.streams.security.auth.module.xml.internal.UserRegistry;

/**
 * A simple LoginModule example that reads user repository information from a XML file.
 * Example:
 *
 * users.xml:
 * ----------
 * <?xml version="1.0" encoding="UTF-8"?>
 * <users>
 *    <user name="user1" password="passwd1" groups="group1" />
 *    <user name="user2" password="passwd2" groups="group1,group2" />
 *    <user name="user3" password="passwd3" groups="group1,group2,group3" />
 *    <user name="user4" password="passwd4" groups="" />
 * </users>
 * 
 *
 * login config xml example:
 * -------------------------
 * <?xml version="1.0" encoding="UTF-8"?>
 * <securityDomain xmlns="http://www.ibm.com/xmlns/prod/streams/security/domain/config/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
 * <authentication>
 *   <jaas>
 *     <jaasConfig name="streams-jaas">
 *       <loginModule moduleClass="com.ibm.streams.security.auth.module.xml.SimpleUserLoginModule" flag="sufficient">
 *         <moduleOption name="usersFile" value="/home/streamsadmin/users.xml" />
 *       </loginModule>
 *      </jaasConfig>
 *    </jaas>
 *   </authentication>
 *  </securityDomain>
 * 
 */
public class SimpleUserLoginModule implements LoginModule {

	private static final String OPTION_USER_FILE = "usersFile";
	
	private Subject _subject;
	private CallbackHandler _callbackHandler;
	private Map<String, ?> _sharedState;
	private Map<String, ?> _options;
	private String _filename;
	private boolean _authenticated;
	private String _username;
	private Principal _userPrincipal;
	private Set<Principal> _groupPrincipals = new HashSet<Principal>();
	
	@Override
	public void initialize(Subject subject, CallbackHandler callbackHandler, Map<String, ?> sharedState, Map<String, ?> options) {
		_subject = subject;
		_callbackHandler = callbackHandler;
		_sharedState = sharedState;
		_options = options;

		_filename = (String)options.get( OPTION_USER_FILE );
	}

	@Override
	public boolean login() throws LoginException {

		_authenticated = false;
		
		if (_filename == null) {
			throw new LoginException("The option usersFile cannot be null");
		}
		
		Callback[] callbacks = new Callback[2];
		callbacks[0] = new NameCallback("Username: ");
		callbacks[1] = new PasswordCallback("Password: ", false);
		
		if (_callbackHandler != null) {
			try {
				_callbackHandler.handle(callbacks);
			} 
			catch (final IOException e) {
				throw new LoginException(e.getMessage());
			} 
			catch (final UnsupportedCallbackException e) {
				throw new LoginException(e.getMessage());
			}
		}
		
		String user = ((NameCallback)callbacks[0]).getName();
		if (user == null) {
			throw new LoginException("Username cannot be null");
		}
		
		char[] passwd = ((PasswordCallback)callbacks[1]).getPassword();
		if (passwd == null) {
			throw new LoginException("Password cannot be null");
		}
		
		
		UserRegistry userRegistry = UserRegistry.getInstance( _filename );
		boolean isAuth = userRegistry.verifyPassword(user, passwd);
		if (!isAuth) {
			throw new FailedLoginException("Login failed");
		}
		else {
			_username = user;
			_userPrincipal = new UserPrincipal( _username );
			
			Set<String> groups = userRegistry.getGroups( _username );
			for(String group : groups) {
				_groupPrincipals.add( new GroupPrincipal(group) );
			}
		}
		
		_authenticated = true;
		
		return _authenticated;
	}
	
	@Override
	public boolean commit() throws LoginException {
		
		if (!_authenticated) {
			return false;
		}
		else {
			
			if (!_subject.getPrincipals().contains( _userPrincipal) ) {
				_subject.getPrincipals().add( _userPrincipal );
			}
			
			for(Principal groupPrincipal : _groupPrincipals) {
				if (!_subject.getPrincipals().contains( groupPrincipal ) ) {
					_subject.getPrincipals().add( groupPrincipal );
				}
			}
		
			return true;
		}
	}

	@Override
	public boolean abort() throws LoginException {
		
		_subject = null;
		_userPrincipal = null;
		_groupPrincipals.clear();
		_username = null;
		
		return true;
	}

	@Override
	public boolean logout() throws LoginException {
		
		_subject.getPrincipals().remove( _userPrincipal );
		_subject.getPrincipals().removeAll( _groupPrincipals );
		_subject = null;
		_userPrincipal = null;
		_groupPrincipals.clear();
		_username = null;
		
		return true;
	}

}
