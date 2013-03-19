/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.anti_quit;

public class User  {
	String userName="";
	String enterTime="";

	public User(String uName,String eTime) {
		this.userName=uName;
		this.enterTime=eTime;
	}
	public void setName(String uName) {
		this.userName=uName;
	}
	public String getName() {
		return this.userName;
	}
	public void setTime(String eTime) {
		this.enterTime=eTime;
	}
	public String getTime() {
		return this.enterTime;
	}
}