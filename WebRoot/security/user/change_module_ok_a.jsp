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
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String human_name=exchange.unURL(request.getParameter("human_name"));
String human_ID=request.getParameter("human_ID");
String current_human_ID=(String)session.getAttribute("human_IDD");
String module=request.getParameter("module");
if(current_human_ID.equals(human_ID)){
%>
<script>
window.onload=function(){window.parent.window.parent.window.frames[0].location.reload();window.parent.window.parent.window.frames[2].location.reload();};
</script>
<%}%>
<div id="nseerGround" class="nseerGround">
<form class="x-form" method="post" name="form1" action="change_choose.jsp">
<input type="hidden" name="human_ID" value="<%=human_ID%>">
<input type="hidden" name="human_name" value="<%=exchange.toHtml(human_name)%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","继续变更")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","变更完成")%>" onClick=location="change_list.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=module%><%=demo.getLang("erp","分配变更完成，请继续。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
</form>
</div>