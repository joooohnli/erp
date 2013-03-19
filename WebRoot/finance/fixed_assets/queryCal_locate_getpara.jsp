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
String file_id=request.getParameter("file_id1").split(" ")[0];
String kind=request.getParameter("kind");
String type=request.getParameter("type");
String kind_id="";
String kind_name="";
String type_id="";
String type_name="";

if(!kind.equals("")){
	kind_id=kind.split(" ")[0];
	kind_name=kind.split(" ")[1];
}else{
	kind_id="";
}

if(!type.equals("")){
	type_id=type.split(" ")[0];
	type_name=type.split(" ")[1];
}else{
	type_id="";
}
session.setAttribute("file_id",file_id);
session.setAttribute("kind_id",kind_id);
session.setAttribute("kind_name",kind_name);
session.setAttribute("type_id",type_id);
session.setAttribute("type_name",type_name);
response.sendRedirect("queryCal_list.jsp");
%>