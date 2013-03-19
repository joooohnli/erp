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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <%
String manufacture_ID=request.getParameter("manufacture_ID") ;
String procedure_name=exchange.unURL(request.getParameter("procedure_name"));
String procedure_id=exchange.unURL(request.getParameter("procedure_id"));
String details_number=exchange.unURL(request.getParameter("details_number"));
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register_ID_group="";
String sql="select * from manufacture_config_public_char where kind='工序' and type_id='"+procedure_id+"'";
ResultSet rs=manufacture_db.executeQuery(sql);
if(rs.next()){
	register_ID_group=rs.getString("register_ID");
}
int a=register_ID_group.indexOf(register_ID);
if(a!=-1){
%>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" action="../../manufacture_procedure_register_procedure_details_ok" onSubmit="return doValidate('../../xml/manufacture/manufacture_procedure.xml','mutiValidation')">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","生产登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","派工单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="manufacture_ID" type="hidden" value="<%=manufacture_ID%>"><%=manufacture_ID%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","工序名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="procedure_name" type="hidden" value="<%=exchange.toHtml(procedure_name)%>"><%=exchange.toHtml(procedure_name)%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","负责人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="procedure_responsible_person" type="text"></td>
<%
String sql2="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number+"'";
ResultSet rs2=manufacture_db.executeQuery(sql2);
if(rs2.next()){
%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","设计工时数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="details_number1" type="hidden" value="<%=details_number%>"><input name="labour_hour_amount1" type="hidden" value=" <%=rs2.getString("labour_hour_amount")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs2.getDouble("labour_hour_amount"))%>&nbsp;</td>
 
 

 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","已用工时数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="real_labour_hour_amount" type="hidden" value="<%=rs2.getString("real_labour_hour_amount")%>"><%=rs2.getDouble("real_labour_hour_amount")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","本次工时数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="labour_hour_amount" type="text"></td>
 </tr>
<%}%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","物料名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","物料编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","设计数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","补充数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","已使用数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次数量")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%">&nbsp;</td>
 </tr>
<%
try{
	String sql1="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' order by details_number";
	ResultSet rs1=manufacture_db.executeQuery(sql1);
	while(rs1.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="details_number" type="hidden" value="<%=rs1.getString("details_number")%>"><%=rs1.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_name" type="hidden" value="<%=exchange.toHtml(rs1.getString("product_name"))%>"><%=exchange.toHtml(rs1.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_ID" type="hidden" value="<%=rs1.getString("product_ID")%>"><%=rs1.getString("product_ID")%>&nbsp;</td>
<input name="product_describe" type="hidden" value="<%=rs1.getString("product_describe")%>">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="type" type="hidden" value="<%=rs1.getString("type")%>"><%=rs1.getDouble("amount")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="extra_amount" type="hidden" value="<%=rs1.getString("extra_amount")%>"><input name="design_amount" type="hidden" value="<%=rs1.getString("amount")%>"><%=rs1.getDouble("extra_amount")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount_unit" type="hidden" value="<%=exchange.toHtml(rs1.getString("amount_unit"))%>"><input name="real_module_amount" type="hidden" value="<%=rs1.getString("real_amount")%>"><%=rs1.getDouble("real_amount")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" type="text"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<input name="cost_price" type="hidden" value="<%=rs1.getString("cost_price")%>">
 </tr>
<%
	}
manufacture_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%}else{
	manufacture_db.close();
	%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td> 
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有被授权进行本工序的登记！")%></td>
 </tr>
</table>
</div>
<%}%>