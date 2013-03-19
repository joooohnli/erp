<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
try{
String sql = "update erpPlatform_config_public_char set all_tag='1' where kind='nseer_file_1' and type_name='js'";
security_db.executeUpdate(sql);
security_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>