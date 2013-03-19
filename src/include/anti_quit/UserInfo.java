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

import java.sql.*;
import java.io.*;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.http.*;
import javax.servlet.ServletContext;
import include.nseer_db.nseer_db;
import include.nseer_cookie.getTime;

public class UserInfo extends java.lang.Object implements Serializable,HttpSessionBindingListener {
	//鐢ㄦ埛淇℃伅
	private String userName="";
  private String userTag="";
  private String id="";
  private nseer_db erp_db = new nseer_db("erp");

	public UserInfo(String uName,String uTag,String id) {
		this.userName=uName;
		this.userTag=uTag;
		this.id=id;
	}
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session =event.getSession();
		ServletContext ctx =session.getServletContext();
		Map map =(Map)ctx.getAttribute("user");
		if(map==null) {
			map=new HashMap();
			ctx.setAttribute("user",map);
		}
		map.put(userName+"&"+userTag,userName+"&"+userTag);
	}

	public void valueUnbound(HttpSessionBindingEvent event) {
		HttpSession session =event.getSession();
		ServletContext ctx =session.getServletContext();
		Map map =(Map)ctx.getAttribute("user");
		map.remove(userName+"&"+userTag);
		writeDB();
		ctx.removeAttribute(userName+userTag);
	}

	private void writeDB() {
		String time=new getTime().getTime("yyyy-MM-dd HH:mm:ss");
		try{
		
			String sql2 = "update security_alive_access set time2='"+time+"' where id='"+id+"'";
			erp_db.executeUpdate(sql2);
			
		erp_db.close();
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
	}
}