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

import include.nseer_db.*;
import java.sql.*;
import javax.servlet.*;

public class addHref {

	private String a="";
	private String b="";
	private String c="";
	private String d="";
	private ServletContext dbApplication;

	public addHref(ServletContext dbApplication){
		this.dbApplication=dbApplication;
	}
	public String addHref(String unit_db_name,String a){
		this.a=a;
		this.d=a;
		nseer_db_backup db=new nseer_db_backup(dbApplication);
		try{
			int m=0;
			int j=d.indexOf("**");
				while(j!=-1){
					d=d.substring(0,j)+d.substring(j+2);
					m++;
					j=d.indexOf("**");
				}
			if(m%2!=0){
				a="falsefalse";
			}else{
			int i=a.indexOf("**");
				while(i!=-1){
					b=a.substring(0,i);
					a=a.substring(i+2);
					i=a.indexOf("**");
					c=a.substring(0,i);
					String sql="select * from document_comment where name='"+c+"'";
					if(db.conn(unit_db_name)){
					ResultSet rs=db.executeQuery(sql);
					if(!rs.next()){
						String sql1="insert into document_comment(comment_tag,name) values('1','"+c+"')";
						db.executeUpdate(sql1);
					}
						db.close();
					}
					a=a.substring(i+2);
					a=b+"<a href=javascript:winopen(&#39;../comment/query_getpara.jsp?keyword="+c+"&#39;)>"+c+"</a>"+a;
					i=a.indexOf("**");
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return a;
	}
}