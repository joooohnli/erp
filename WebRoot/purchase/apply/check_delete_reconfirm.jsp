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
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String apply_ID=request.getParameter("apply_ID");
String config_ID=request.getParameter("config_ID");
String pay_ID_group=request.getParameter("pay_ID_group");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String remark = request.getParameter("remark");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form class="x-form" id="register1" method="POST" action="../../purchase_apply_check_delete_ok">
<input name="apply_ID" type="hidden" value="<%=apply_ID%>">
<input name="config_ID" type="hidden" value="<%=config_ID%>">
<input name="designer" type="hidden" value="<%=exchange.toHtml(designer)%>">
<input name="register" type="hidden" value="<%=exchange.toHtml(register)%>">
<input name="register_time" type="hidden" value="<%=exchange.toHtml(register_time)%>">
<input name="check_time" type="hidden" value="<%=exchange.toHtml(check_time)%>">
<input name="checker" type="hidden" value="<%=exchange.toHtml(checker)%>">
<input name="checker_ID" type="hidden" value="<%=exchange.toHtml(checker_ID)%>">
<input name="remark" type="hidden" value="<%=remark%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1"> 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check.jsp?apply_ID=<%=apply_ID%>&&config_ID=<%=config_ID%>"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10"><%=demo.getLang("erp","该采购计划未通过审核，您确认吗？")%></td>
 </tr>
<%
int i=1;
String sql6="select config_id from purchase_workflow where object_ID='"+apply_ID+"' and config_id<'"+config_ID+"' order by id";
ResultSet rs6=purchase_db.executeQuery(sql6);
while(rs6.next()){
	String choice="从流程"+i+"开始重新审核";
	i++;
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="<%=rs6.getString("config_id")%>"><%=demo.getLang("erp",choice)%></td>
 </tr>
<%
}
if(!pay_ID_group.equals("新发生")){
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=""><%=demo.getLang("erp","重新制定")%></td>
 </tr>
<%
}else{
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=""><%=demo.getLang("erp","转入草稿箱")%></td>
 </tr>
<%}
	purchase_db.close();
%>
 </table>
</form>
 </div>