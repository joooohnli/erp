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
	 String handbook=demo.businessComment(mod,"您正在做的业务是 ：","document_main","reason","value");%>
 
<%
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=exchange.unURL(request.getParameter("customer_name")) ;
String sales_ID=request.getParameter("sales_ID") ;
String sales_name=exchange.unURL(request.getParameter("sales_name")) ;
String salecredit_list_price_sum=request.getParameter("salecredit_list_price_sum");
session.setAttribute("crediter_ID",customer_ID);
session.setAttribute("salecredit_list_price_sum",salecredit_list_price_sum);
session.setAttribute("crediter_name",customer_name);
session.setAttribute("sales_ID",sales_ID);
session.setAttribute("sales_name",sales_name);

response.sendRedirect("dealwith.jsp");
%>