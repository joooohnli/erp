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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String config_id=request.getParameter("config_id");
String manufacture_ID=request.getParameter("manufacture_ID");
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String reason = request.getParameter("reason");
String procedure_ID=request.getParameter("procedure_ID") ;
String procedure_name=request.getParameter("procedure_name") ;
String procedure_responsible_person=request.getParameter("procedure_responsible_person") ;
String module_time=request.getParameter("module_time");
%>
	<form id="register1" class="x-form" method="POST" action="../../manufacture_module_balance_check_delete_ok">
<input name="config_id" type="hidden" value="<%=config_id%>">
<input name="manufacture_ID" type="hidden" value="<%=manufacture_ID%>">
<input name="module_time" type="hidden" value="<%=module_time%>">
<input name="register_time" type="hidden" value="<%=exchange.toHtml(register_time)%>">
<input name="procedure_responsible_person" type="hidden" value="<%=exchange.toHtml(procedure_responsible_person)%>">
<input name="check_time" type="hidden" value="<%=exchange.toHtml(check_time)%>">
<input name="checker" type="hidden" value="<%=exchange.toHtml(checker)%>">
<input name="reason" type="hidden" value="<%=reason%>">
<input name="procedure_ID" type="hidden" value="<%=procedure_ID%>">
<input name="procedure_name" type="hidden" value="<%=procedure_name%>">

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check.jsp?manufacture_ID=<%=manufacture_ID%>&&procedure_ID=<%=procedure_ID%>&&procedure_name=<%=exchange.toURL(procedure_name)%>&&register_time=<%=exchange.toURL(register_time)%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该物料申领/退回单未通过审核，您确认吗？请选择处理：")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
int i=1;
String sql6="select config_id from manufacture_workflow where object_ID='"+manufacture_ID+"' and type_id='05' and config_id<'"+config_id+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"' order by id";
ResultSet rs6=manufacture_db.executeQuery(sql6);
while(rs6.next()){
	String choice="从流程"+i+"开始重新审核";
	i++;
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="<%=rs6.getString("config_id")%>"><%=demo.getLang("erp",choice)%></td>
 </tr>
<%
}
manufacture_db.close();
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=""><%=demo.getLang("erp","转入草稿箱")%></td>
 </tr>
 </table>
</form>
</div>