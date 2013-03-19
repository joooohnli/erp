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
String contact_ID=request.getParameter("contact_ID") ;
String config_ID=request.getParameter("config_ID") ;
String person_contacted=request.getParameter("person_contacted") ;
String provider_name=request.getParameter("provider_name") ;
String check_time=request.getParameter("check_time") ;
String checker_ID=request.getParameter("checker_ID") ;
String reason=request.getParameter("reason") ;
String checker=request.getParameter("checker") ;
String provider_ID=request.getParameter("provider_ID") ;
String reasonexact=request.getParameter("reasonexact") ;
String contact_type=request.getParameter("contact_type") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_content=request.getParameter("contact_content") ;
String contact_time=request.getParameter("contact_time") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form class="x-form" id="form1" method="post" action="../../purchase_contact_check_delete_ok">
<input type="hidden" name="contact_ID" value="<%=contact_ID%>">
<input type="hidden" name="config_ID" value="<%=config_ID%>">
<input type="hidden" name="person_contacted" value="<%=person_contacted%>">
<input type="hidden" name="provider_name" value="<%=provider_name%>">
<input type="hidden" name="reason" value="<%=reason%>">
<input type="hidden" name="check_time" value="<%=check_time%>">
<input type="hidden" name="checker_ID" value="<%=checker_ID%>">
<input type="hidden" name="provider_ID" value="<%=provider_ID%>">
<input type="hidden" name="checker" value="<%=checker%>">
<input type="hidden" name="reasonexact" value="<%=reasonexact%>">
<input type="hidden" name="contact_type" value="<%=contact_type%>">
<input type="hidden" name="person_contacted_tel" value="<%=person_contacted_tel%>">
<input type="hidden" name="contact_content" value="<%=exchange.toHtml(contact_content)%>">
<input type="hidden" name="contact_time" value="<%=contact_time%>">
<input type="hidden" name="contact_person" value="<%=contact_person%>">
<input type="hidden" name="contact_person_ID" value="<%=contact_person_ID%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1"> 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check.jsp?contact_ID=<%=contact_ID%>"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10"><%=demo.getLang("erp","该产品供应商联络单未通过审核，您确认吗？")%></td>
 </tr>
<%
int i=1;
String sql6="select config_id from purchase_workflow where object_ID='"+contact_ID+"' and config_id<'"+config_ID+"' order by id";
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
purchase_db.close();
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=""><%=demo.getLang("erp","转入草稿箱")%></td>
 </tr>
</table>
</div>