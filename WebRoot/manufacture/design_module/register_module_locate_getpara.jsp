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
String first_kind_ID="";
String first_kind_name="";
String second_kind_ID="";
String second_kind_name="";
String third_kind_ID="";
String third_kind_name="";
String responsible_person_ID="";
String responsible_person_name="";
String first_kind=request.getParameter("select1");
if(first_kind!=null&&!first_kind.equals("")){
StringTokenizer tokenTO = new StringTokenizer(first_kind,"/"); 
	while(tokenTO.hasMoreTokens()) {
 first_kind_ID = tokenTO.nextToken();
		first_kind_name = tokenTO.nextToken();
		}
}
String second_kind=request.getParameter("select2");
if(second_kind!=null&&!second_kind.equals("")){
StringTokenizer tokenTO1 = new StringTokenizer(second_kind,"/"); 
	while(tokenTO1.hasMoreTokens()) {
 second_kind_ID = tokenTO1.nextToken();
		second_kind_name = tokenTO1.nextToken();
		}
}
String third_kind=request.getParameter("select3");
if(third_kind!=null&&!third_kind.equals("")){
StringTokenizer tokenTO2 = new StringTokenizer(third_kind,"/"); 
	while(tokenTO2.hasMoreTokens()) {
 third_kind_ID = tokenTO2.nextToken();
		third_kind_name = tokenTO2.nextToken();
		}
}
String responsible_person=request.getParameter("select4");
if(responsible_person!=null&&!responsible_person.equals("")){
StringTokenizer tokenTO3 = new StringTokenizer(responsible_person,"/"); 
	while(tokenTO3.hasMoreTokens()) {
 responsible_person_ID = tokenTO3.nextToken();
		responsible_person_name = tokenTO3.nextToken();
		}
}
session.setAttribute("first_kind_name",first_kind_name);
session.setAttribute("second_kind_name",second_kind_name);
session.setAttribute("third_kind_name",third_kind_name);
session.setAttribute("responsible_person_name",responsible_person_name);
response.sendRedirect("register_module_list.jsp");
%>

