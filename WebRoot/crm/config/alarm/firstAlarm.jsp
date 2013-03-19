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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="firstAlarm" class="x-form" method="post" action="firstAlarm_register.jsp" onSubmit="return doValidate('../../../xml/crm/crm_config_public_double.xml','firstAlarm')">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","修改")%>" style="width: 50; "></div></td>
 </tr>
</table>
<%
double gather_expiry1=0;
double contact_expiry1=0;
double gather_limit1=0.0d;
double check_expiry1=0.0d;
double return_limit1=0.0d;
String gather_expiry="";
String contact_expiry="";
String gather_limit="";
String check_expiry="";
String return_limit="";
String sql1 = "select * from crm_config_public_double where kind='回款红警'";
ResultSet rs1=crm_db.executeQuery(sql1);
if(rs1.next()){
	gather_expiry1=rs1.getDouble("type_value");
	}
if(gather_expiry1!=0) gather_expiry=gather_expiry1+"";
String sql2 = "select * from crm_config_public_double where kind='联络红警'";
ResultSet rs2=crm_db.executeQuery(sql2);
if(rs2.next()){
	contact_expiry1=rs2.getDouble("type_value");
	}
if(contact_expiry1!=0) contact_expiry=contact_expiry1+"";
String sql4 = "select * from crm_config_public_double where kind='欠款红警'";
ResultSet rs4=crm_db.executeQuery(sql4);
if(rs4.next()){
	gather_limit1=rs4.getDouble("type_value");
	}
if(gather_limit1!=0) gather_limit=gather_limit1+"";
crm_db.close();
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE11%> class="TD_STYLE1" width="22%"><%=demo.getLang("erp","请输入回款超期报警值（天）")%></td>
	<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="gather_expiry" value="<%=exchange.toHtml(gather_expiry)%>" style="width: 30%"></td>
</tr>
<%if(!gather_limit.equals("")){%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE11%> class="TD_STYLE1" width="22%"><%=demo.getLang("erp","请输入欠款超额报警值（元）")%></td>
	<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="gather_limit" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(gather_limit))%>" style="width: 30%"></td>
</tr>
<%}else{%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE11%> class="TD_STYLE1" width="22%"><%=demo.getLang("erp","请输入欠款超额报警值（天）")%></td>
	<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="gather_limit" style="width: 30%"></td>
</tr>
<%}%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE11%> class="TD_STYLE1" width="22%"><%=demo.getLang("erp","请输入联络超期报警值（天）")%></td>
	<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_expiry" value="<%=exchange.toHtml(contact_expiry)%>" style="width: 30%"></td>
</tr>
</table> 
</form>
</div>
