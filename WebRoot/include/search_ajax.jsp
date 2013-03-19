<%/*<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%
try{
	nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
	String search_tag=request.getParameter("search_tag");
		String keyword=request.getParameter("keyword");
	if(search_tag.equals("0")){
		String s="";
		String sql="select * from erp_keywords where keyword like '"+keyword+"%' order by search_time desc";
		ResultSet rs=db.executeQuery(sql);
		while(rs.next()){
			s+="◎"+rs.getString("keyword")+"⊙"+rs.getString("search_time")+"次";
		}
		out.print(s);
	}else if(search_tag.equals("1")){
		String sql="select keyword,search_time from erp_keywords where keyword ='"+keyword+"' order by search_time desc";
		ResultSet rs=db.executeQuery(sql);
		if(rs.next()){
			int search_time=rs.getInt("search_time")+1;
			sql="update erp_keywords set search_time='"+search_time+"' where keyword ='"+keyword+"'";
			db.executeUpdate(sql);
		}else{
			sql="insert into erp_keywords(keyword,search_time) values ('"+keyword+"','1')";
			db.executeUpdate(sql);
		}
	}
	db.close();
}catch(Exception e){e.printStackTrace();}
%>