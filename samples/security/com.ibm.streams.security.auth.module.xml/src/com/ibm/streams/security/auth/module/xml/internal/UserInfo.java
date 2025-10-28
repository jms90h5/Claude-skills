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

import java.io.Serializable;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public final class UserInfo implements Serializable {

	private static final long serialVersionUID = 4456261901559748058L;

	private String _name;
	private char[] _passwd;
	private Set<String> _groups = new HashSet<String>();
	
	public UserInfo(String name, char[] password, String groupNames) {
		
		if (name == null) {
			throw new IllegalArgumentException("name cannot be null");
		}
		
		this._name = name.trim();
		
		if ("".equals( _name ) ) {
			throw new IllegalArgumentException("name cannot be empty string");
		}
		
		this._passwd = password;
		
		if (groupNames != null) {
			String[] grpArr = groupNames.split(",");
			for(String grp : grpArr) {
				grp = grp.trim();
				if (!"".equals(grp)) {
					this._groups.add(grp);
				}
			}
		}
	}
	
	public String getName() {
		return _name;
	}
	
	public char[] getPassword() {
		return _passwd;
	}
	
	public Set<String> getGroups() {
		return Collections.unmodifiableSet( _groups );
	}
	
	public String toString() {
		return "name: " + _name + ", groups=" + _groups;
	}
}
