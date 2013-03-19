<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String human_name=exchange.unURL(request.getParameter("human_name"));
String human_ID=request.getParameter("human_ID");
String choose_value_group=exchange.unURL(request.getParameter("choose_value_group"));
String module=(String)session.getAttribute("module");
%>
<form class="x-form" method="post" name="form1" action="register_choose.jsp">
<input type="hidden" name="choose_value_group" value="<%=exchange.toHtml(choose_value_group)%>">
<input type="hidden" name="human_ID" value="<%=human_ID%>">
<input type="hidden" name="human_name" value="<%=exchange.toHtml(human_name)%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
     <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","分配权限")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","分配完成")%>" onClick=location="register_license_code.jsp?human_ID=<%=human_ID%>&&choose_value_group=<%=toUtf8String.utf8String(exchange.toURL(choose_value_group))%>"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=module%><%=demo.getLang("erp","分配权限完成，请继续。")%></td>
 </tr>
 </table>
 </div>
</form>