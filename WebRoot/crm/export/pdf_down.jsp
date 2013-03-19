<%/*<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="com.jspsmart.upload.*" import="java.text.*" import="javax.servlet.*,javax.servlet.http.*"%><%
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String filename=request.getParameter("filename");
SmartUpload mySmartUpload = new SmartUpload();
mySmartUpload.initialize(pageContext);
mySmartUpload.setContentDisposition(null);
mySmartUpload.downloadFile(path+"pdf_files/"+filename);
%>