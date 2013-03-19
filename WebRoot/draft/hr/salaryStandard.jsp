<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String standard_ID=request.getParameter("standard_ID");

if(vt.validata((String)session.getAttribute("unit_db_name"),"hr_salary_standard","standard_ID",standard_ID,"check_tag").equals("5")||vt.validata((String)session.getAttribute("unit_db_name"),"hr_salary_standard","standard_ID",standard_ID,"check_tag").equals("9")){
try{
	String sql = "select * from hr_salary_standard where standard_ID='"+standard_ID+"'" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
	if(rs.next()){
%>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
<div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<form id="mutiValidation" method="POST" action="../../hr_salary_standard_uncheck_ok?standard_ID=<%=rs.getString("standard_ID")%>" onSubmit="return doValidate('mutiValidation')">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_hr_salaryStandard_draft_ok','../../xml/hr/hr_salary_standard.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_hr_salaryStandard_check_ok','../../xml/hr/hr_salary_standard.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","薪酬标准单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <input type="hidden" name="major_type" value="">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","薪酬标准编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="standard_ID" type="hidden" value="<%=rs.getString("standard_ID")%>"><%=rs.getString("standard_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","薪酬标准名称")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="standard_name" type="text" value="<%=exchange.toHtml(rs.getString("standard_name"))%>"></td>
	 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","薪酬总额")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("salary_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","制定人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="designer" type="text" value="<%=exchange.toHtml(rs.getString("designer"))%>"></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=demo.getLang("erp","薪酬项目名称")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=demo.getLang("erp","金额")%></td>
 </tr>
<%
String sql6="select * from hr_salary_standard_details where standard_ID='"+standard_ID+"' order by details_number";
ResultSet rs6=hr_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="details_number" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=rs6.getString("details_number")%>"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="item_name" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=exchange.toHtml(rs6.getString("item_name"))%>"><%=exchange.toHtml(rs6.getString("item_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="salary" type="text" style="width: 22%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("salary"))%>" style="background-color:#FFFFCC"></td>
 </tr>
<%
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
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" type="text" value="<%=exchange.toHtml(register)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
	hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
hr_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="salaryStandard_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已提交审核，请返回！")%></td>
 </tr>
</table>
</div>
<%}%>