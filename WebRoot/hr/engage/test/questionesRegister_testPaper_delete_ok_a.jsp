<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.excel_export.Solid" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>

<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%String first_kind_ID=request.getParameter("first_kind_ID");%>
<%String first_kind_name=request.getParameter("first_kind_name");%>
<%String second_kind_ID=request.getParameter("second_kind_ID");%>
<%String second_kind_name=request.getParameter("second_kind_name");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form class="x-form" id="register1" method="POST" action="questionesRegister_testPaper_list.jsp">		
<input name="first_kind_ID" type="hidden" value="<%=first_kind_ID%>">
<input name="first_kind_name" type="hidden" value="<%=exchange.toHtml(first_kind_name)%>">
<input name="second_kind_ID" type="hidden" value="<%=second_kind_ID%>">
<input name="second_kind_name" type="hidden" value="<%=exchange.toHtml(second_kind_name)%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>" name="B1"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该试卷已删除，请返回！")%></td>
 </tr>
 </table>
  </div>
