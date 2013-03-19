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
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=exchange.unURL(request.getParameter("provider_name")) ;
String purchaser_ID=request.getParameter("purchaser_ID") ;
String purchaser=exchange.unURL(request.getParameter("purchaser"));
String purchasecredit_cost_price_sum=request.getParameter("purchasecredit_cost_price_sum");

session.setAttribute("crediter_ID",provider_ID);
session.setAttribute("purchasecredit_cost_price_sum",purchasecredit_cost_price_sum);
session.setAttribute("crediter_name",provider_name);
session.setAttribute("purchaser_ID",purchaser_ID);
session.setAttribute("purchaser",purchaser);
response.sendRedirect("dealwith.jsp?readXml=n");
%>