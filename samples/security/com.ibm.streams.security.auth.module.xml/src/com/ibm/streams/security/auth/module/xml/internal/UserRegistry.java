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
package com.ibm.streams.security.auth.module.xml.internal;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;


import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


public class UserRegistry {

	private static final Map<String, UserRegistry> _registryMap = new HashMap<String, UserRegistry>();
	private static final String ELEM_USERS  = "users";
	private static final String ELEM_USER   = "user";
	private static final String ATTR_NAME   = "name";
	private static final String ATTR_PASSWD = "password";
	private static final String ATTR_GROUPS = "groups";
	
	private Map<String, UserInfo> _userInfoMap = new HashMap<String, UserInfo>();
	
	
	private UserRegistry(String filename) {
		
		try {
			load(filename);
		} 
		catch (final Exception e) {
			throw new IllegalStateException("Error: Unable to load user registry, filename=" + filename, e);
		}
	}
	
    private void load(String filename) throws ParserConfigurationException, SAXException, IOException {
		if (filename == null || "".equals(filename)) {
			throw new IllegalArgumentException("filename cannot be null or empty string");			
		}
		
		File xmlFile = new File( filename );
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = dbf.newDocumentBuilder();
		Document doc = builder.parse(xmlFile);
		doc.getDocumentElement().normalize();

		String rootElemName = doc.getDocumentElement().getNodeName();
		if (!rootElemName.toLowerCase().equals( ELEM_USERS )) {
			throw new IllegalStateException("Invalid XML specified in " + filename);
		}

		NodeList nodeList = doc.getElementsByTagName( ELEM_USER );
		for (int i=0; i < nodeList.getLength(); ++i) {

			Node node = nodeList.item(i);
			if (node.getNodeType() == Node.ELEMENT_NODE && ELEM_USER.equals(node.getNodeName().toLowerCase())) {

				Element elem = (Element)node;

				String name = elem.getAttribute( ATTR_NAME );
				name = (name != null)?name.trim():null;
				String passwd = elem.getAttribute( ATTR_PASSWD );
				String groups =  elem.getAttribute( ATTR_GROUPS );

				UserInfo userInfo = new UserInfo(name, passwd.toCharArray(), groups);

				_userInfoMap.put(name, userInfo);
			}
		}
	}

	public static UserRegistry getInstance(String filename) {
		UserRegistry registry = null;
		
		synchronized( _registryMap ) {
			registry = _registryMap.get(filename);
			if (registry == null) {
				registry = new UserRegistry(filename);

				_registryMap.put(filename, registry);
			}
		}
		
		return registry;
	}
	
	public boolean verifyPassword(String userName, char[] password) {
		UserInfo userInfo = _userInfoMap.get(userName);
		if (userInfo == null) {
			return false;
		}
		else {
			char[] storedPasswd = userInfo.getPassword();
			if (Arrays.equals(storedPasswd, password) ) {
				return true;
			}
			else {
				return false;
			}
		}
	}
	
	public Set<String> getGroups(String userName) {
		UserInfo userInfo = _userInfoMap.get(userName);
		if (userInfo == null) {
			return Collections.unmodifiableSet( new HashSet<String>() );
		}
		else {
			return userInfo.getGroups();
		}
	}
	
	public int size() {
		return _userInfoMap.size();
	}
	
	public String toString() {
		return _userInfoMap.toString();
	}
	
	
	public static void main(String[] args) {
		
		try {
			UserRegistry userRegistry = UserRegistry.getInstance("users.xml");
			boolean auth1 = userRegistry.verifyPassword("user1", "passwd1".toCharArray());
			boolean auth2 = userRegistry.verifyPassword("user2", "wrongpasswd1".toCharArray());
			System.out.println(userRegistry);
			System.out.println(auth1);
			System.out.println(auth2);
			System.out.println(userRegistry.getGroups("user3"));
		} 
		catch (final Exception e) {
			e.printStackTrace();
		}
	
	}
}
