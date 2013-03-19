/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.sql.*;
import java.io.*;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.http.*;
import javax.servlet.ServletContext;
import include.nseer_db.*;
import include.nseer_cookie.getTime;
import include.operateXML.*;

public class UserInfo extends java.lang.Object implements Serializable,HttpSessionBindingListener {

  private String userName="";
  private String userTag="";
  private String id="";
  private String unit="";

	public UserInfo(String unit,String uName,String uTag,String id) {
		this.userName=uName;
		this.userTag=uTag;
		this.id=id;
		this.unit=unit;
	}
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session =event.getSession();
		ServletContext ctx =session.getServletContext();
		Map map =(Map)ctx.getAttribute("user");
		if(map==null) {
			map=new HashMap();
			ctx.setAttribute("user",map);
		}
		map.put(unit+"&"+userName+"&"+userTag,unit+"&"+userName+"&"+userTag);
		System.out.println(unit+"&"+"userName:"+userName+"&"+userTag+" enter");
	}

	public void valueUnbound(HttpSessionBindingEvent event) {
		HttpSession session =event.getSession();
		ServletContext ctx =session.getServletContext();
		Map map =(Map)ctx.getAttribute("user");
		map.remove(unit+"&"+userName+"&"+userTag);
		String xmlFile_s="xml/include/listPage/"+userName+userTag+".xml";
		Reading reader=new Reading(xmlFile_s);
		String path=ctx.getRealPath("/");
		String dbase=reader.getAttributeByTable("database", "name:"+userName);
		writeDB(dbase,ctx);
		//ctx.removeAttribute(userName);
		File f=new File(path+xmlFile_s);
		//f.delete();
		String count=(String)ctx.getAttribute(unit);
		count=(Integer.parseInt(count)-1)+"";
		ctx.setAttribute(unit,count);
		System.out.println(unit+"&"+"userName:"+userName+"&"+userTag+" out");
	}

	private void writeDB(String unit_db_name,ServletContext dbApplication) {
		nseer_db_backup erp_db = new nseer_db_backup(dbApplication);
		
		String time=new getTime().getTime("yyyy-MM-dd HH:mm:ss");
		try{
		if(erp_db.conn(unit_db_name)){
			//String sql1 = "update security_users set tag='0' where id='"+rs.getString("id")+"'";
			//erp_db.executeUpdate(sql1);
			String sql2 = "update security_alive_access set time2='"+time+"' where id='"+id+"'";
			erp_db.executeUpdate(sql2);
			erp_db.close();
		} else {
				System.out.println("i am sorry!");
 		}
		}catch (Exception ex){
			ex.printStackTrace();
		}
	}
}