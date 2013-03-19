<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<%    
demo.setPath(request);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<%
String url=request.getParameter("url");
if(url.indexOf("alarm")==-1){
url=url.substring(0,url.length()-4)+"1"+ url.substring(url.length()-4);
}else{
	url=url.substring(0,url.length()-4)+"_1"+ url.substring(url.length()-4);
}
String task_refresh=request.getParameter("task_refresh");
%>
<META HTTP-EQUIV="refresh" content="<%=Double.parseDouble(task_refresh)*60%>">
<frameset cols="*,0" frameborder="no" border="0" framespacing="0" scrolling="auto">
  <frame src="<%=url%>" name="mainFrame" id="mainFrame" scrolling="auto"/>
  <frame src="" />
</frameset>
<noframes>
<body>
</body>
</noframes></html>
