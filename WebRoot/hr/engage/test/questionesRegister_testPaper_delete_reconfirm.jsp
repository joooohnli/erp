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

<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String test_ID=request.getParameter("test_ID") ;
String first_kind_ID=request.getParameter("first_kind_ID");
String first_kind_name=exchange.unURL(request.getParameter("first_kind_name"));
String second_kind_ID=request.getParameter("second_kind_ID");
String second_kind_name=exchange.unURL(request.getParameter("second_kind_name"));
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form class="x-form" id="register1" method="POST" action="../../../hr_engage_test_questionesRegister_testPaper_delete_ok">
<input name="first_kind_ID" type="hidden" value="<%=first_kind_ID%>">
<input name="first_kind_name" type="hidden" value="<%=exchange.toHtml(first_kind_name)%>">
<input name="second_kind_ID" type="hidden" value="<%=second_kind_ID%>">
<input name="second_kind_name" type="hidden" value="<%=exchange.toHtml(second_kind_name)%>">
<input name="test_ID" type="hidden" value="<%=test_ID%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您确认删除该试卷吗？")%></td>
 </tr>
 </table>
  </div>
