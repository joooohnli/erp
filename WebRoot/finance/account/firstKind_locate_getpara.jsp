<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String select=request.getParameter("select1");
String file_id="";
String file_name="";
StringTokenizer tokenTO = new StringTokenizer(select," "); 
	while(tokenTO.hasMoreTokens()) {
		file_id = tokenTO.nextToken();
		file_name = tokenTO.nextToken();
		}
session.setAttribute("file_id",file_id);
session.setAttribute("file_name",file_name);
response.sendRedirect("firstKind_list.jsp");
%>