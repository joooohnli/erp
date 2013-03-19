<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" errorPage="/error.htm" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>

 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String timea=request.getParameter("timea");
String timeb=request.getParameter("timeb");
String voucher_in_month_ID=request.getParameter("voucher_in_month_ID");
String keyword=request.getParameter("keyword");
if(timea==null) timea="";
if(timeb==null) timeb="";
if(voucher_in_month_ID==null) voucher_in_month_ID="";
if(keyword==null) keyword="";
session.setAttribute("timea",timea);
session.setAttribute("timeb",timeb);
session.setAttribute("voucher_in_month_ID",voucher_in_month_ID);
session.setAttribute("keyword",keyword);
response.sendRedirect("uncheck_list.jsp");
%>