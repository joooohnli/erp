<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*"

 import="java.util.*" import="java.io.*" import="java.text.*"%>

<META HTTP-EQUIV="refresh" content="600">
<%
String uname=(String)session.getAttribute("usernamec");
String unit_id=uname.substring(0,uname.indexOf("_"));
String check_main_path_temp=unit_id+"_check_main_path";
String check_main_path=(String)application.getAttribute(check_main_path_temp);
if(check_main_path==null){
	application.setAttribute(check_main_path_temp,"finished");
	response.sendRedirect("../include_auto_execute_reset_ok");
}else{
String tag22=(String)session.getAttribute("tagc");
String app22=(String)application.getAttribute(uname+"c");
String realname1=(String)session.getAttribute("realeditorc");
String human_IDD1=(String)session.getAttribute("human_IDD");
String userName1=(String)session.getAttribute("userName");
String unit_db_name=(String)session.getAttribute("unit_db_name");
String unit_name1=(String)session.getAttribute("unit_name");
String unit_id1=(String)session.getAttribute("unit_id");
String field_type1=(String)session.getAttribute("field_type");
String language1=(String)session.getAttribute("language");
out.println(unit_db_name);
}
%>