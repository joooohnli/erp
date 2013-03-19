<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.text.*" import="java.io.*" %>

<%
try{
ServletContext ctx =session.getServletContext();
String userName=(String)session.getAttribute("usernamec");
String xmlFile_s="xml/include/listPage/"+userName+session.getId()+".xml";
String path=ctx.getRealPath("/");
File f=new File(path+xmlFile_s);
session.removeAttribute("USERC");
session.removeValue("usernamec");
session.removeValue("human_IDD");
session.removeValue("tagc");
session.removeValue("realeditorc");
session.removeValue("idc");
session.removeValue("unit_db_name");
session.removeValue("language");
f.delete();
response.sendRedirect("login.jsp");
}catch(Exception ex){ex.printStackTrace();}
%>