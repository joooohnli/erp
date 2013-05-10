<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crm_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link href="../../css/include/nseerTree/nseertree.css" rel="stylesheet" type="text/css">

<%
String customer_ID=request.getParameter("customer_ID");
if(vt.validata((String)session.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID,"check_tag").equals("1")){
%>
<form id="mutiValidation" method="post" action="../../ecommerce_crm_change_ok?customer_ID=<%=customer_ID%>" onSubmit="return doValidate('../../xml/crm/crm_file.xml','mutiValidation')">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
</td>
 </tr>
</table>
<%
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register_time="";
try{
	String sqll = "select * from crm_file where customer_ID='"+customer_ID+"'" ;
	ResultSet rss = crm_db1.executeQuery(sqll) ;
	while(rss.next()){
	String invoice_info=exchange.unHtml(rss.getString("invoice_info"));
	String demand=exchange.unHtml(rss.getString("demand"));
	String remark=exchange.unHtml(rss.getString("remark"));
if(rss.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rss.getString("register_time");
}
%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/include/validate/validation-framework.js">
if(!mutiValidation.agree.checked) {
	 alert("<%=demo.getLang("erp","确认提交吗？如果确认请点选确认提交")%>");
	 form.agree.focus();
	 count=count-1;
	 return (false);
	}
		return(true);
}	
</script>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" colspan="3"><input name="customer_ID" type="hidden" value="<%=rss.getString("customer_ID")%>"><%=rss.getString("customer_ID")%> 
 &nbsp;&nbsp;&nbsp;&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="37.4%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_name" style="width:60%" value="<%=exchange.toHtml(rss.getString("customer_name"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="37.4%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_address" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("customer_address"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="fileKind_chain" name="fileKind_chain" style="width:80%" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>"><input id="fileKind_chain_table" type="hidden" value="crm_config_file_kind">
 </td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type" style="width:60%">
  <%
  String sql4 = "select * from crm_config_public_char where kind='客户类型' order by type_ID" ;
	 ResultSet rs4 = crm_db.executeQuery(sql4) ;
while(rs4.next()){
	if(rs4.getString("type_name").equals(rss.getString("type"))){%>
		<option value="<%=exchange.toHtml(rs4.getString("type_name"))%>" selected><%=exchange.toHtml(rs4.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs4.getString("type_name"))%>"><%=exchange.toHtml(rs4.getString("type_name"))%></option>
<%
	}
}
%>

  </select>
		</tr>
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","优质级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="class" style="width:60%">
  <%
  String sql5 = "select * from crm_config_public_char where kind='客户级别' order by type_ID" ;
	 ResultSet rs5 = crm_db.executeQuery(sql5) ;
while(rs5.next()){	
	if(rs5.getString("type_name").equals(rss.getString("customer_class"))){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>" selected><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%
	}
}
%>

  </select>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","欠款额度")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="gather_sum_limit" style="width:60%">
  <%
  String sql6 = "select * from crm_config_public_double where kind='欠款' order by type_ID" ;
	 ResultSet rs6 = crm_db.executeQuery(sql6) ;
while(rs6.next()){
	if(rs6.getString("type_value").equals(rss.getString("gather_sum_limit"))){	
%>
		<option value="<%=rs6.getDouble("type_value")%>" selected><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("type_value"))%></option>
<%}else{%>
		<option value="<%=rs6.getDouble("type_value")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("type_value"))%></option>
<%
}
}
%>

  </select>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","回款期限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="gather_period_limit" style="width:60%" style="width: 100%;height: 14">
  <%
  String sql7 = "select * from crm_config_public_double where kind='回款' order by type_ID" ;
	 ResultSet rs7 = crm_db.executeQuery(sql7) ;
while(rs7.next()){
	if(rs7.getString("type_value").equals(rss.getString("gather_period_limit"))){	
%>
		<option value="<%=exchange.toHtml(rs7.getString("type_value"))%>" selected><%=exchange.toHtml(rs7.getString("type_value"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs7.getString("type_value"))%>"><%=exchange.toHtml(rs7.getString("type_value"))%></option>
<%
}
}
%>

  </select>
 </td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","联络期限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_period_limit" style="width:60%">
  <%
  String sql8 = "select * from crm_config_public_double where kind='联络' order by type_ID" ;
	 ResultSet rs8 = crm_db.executeQuery(sql8) ;
while(rs8.next()){
		if(rs8.getString("type_value").equals(rss.getString("contact_period_limit"))){
	%>
		<option value="<%=exchange.toHtml(rs8.getString("type_value"))%>" selected><%=exchange.toHtml(rs8.getString("type_value"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs8.getString("type_value"))%>"><%=exchange.toHtml(rs8.getString("type_value"))%></option>
<%
}
}
%>

  </select>
</tr>
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户曾用名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="used_customer_name" style="width:60%" width="100%" value="<%=rss.getString("used_customer_name")%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开户银行")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_bank" style="width:60%" value="<%=exchange.toHtml(rss.getString("customer_bank"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","银行账号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_account" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("customer_account"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","网址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_web" style="width:60%" value="<%=exchange.toHtml(rss.getString("customer_web"))%>"></td>
 
 </tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话1")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_tel1" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("customer_tel1"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话2")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_tel2" style="width:60%" value="<%=exchange.toHtml(rss.getString("customer_tel2"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","传真")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_fax" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("customer_fax"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮政编码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_postcode" style="width:60%" value="<%=exchange.toHtml(rss.getString("customer_postcode"))%>"></td>
 
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","联系人信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","第一联系人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person1"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_department" style="width:60%" value="<%=exchange.toHtml(rss.getString("contact_person1_department"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_duty" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person1_duty"))%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_office_tel" style="width:60%" value="<%=exchange.toHtml(rss.getString("contact_person1_office_tel"))%>"></td>
 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_mobile" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person1_mobile"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_home_tel" style="width:60%" value="<%=exchange.toHtml(rss.getString("contact_person1_home_tel"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_email" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person1_email"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_person1_sex" style="width:60%">
	 <%if(rss.getString("contact_person1_sex").equals("男")){%>
  <option selected><%=demo.getLang("erp","男")%></option>
  <option><%=demo.getLang("erp","女")%></option>
<%}else{%>
  <option><%=demo.getLang("erp","男")%></option>
  <option selected><%=demo.getLang("erp","女")%></option>
<%}%>
						 </select>
 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","第二联系人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person2"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_department" style="width:60%" value="<%=exchange.toHtml(rss.getString("contact_person2_department"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_duty" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person2_duty"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_office_tel" style="width:60%" value="<%=exchange.toHtml(rss.getString("contact_person2_office_tel"))%>"></td>
 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_mobile" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person2_mobile"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_home_tel" style="width:60%" value="<%=exchange.toHtml(rss.getString("contact_person2_home_tel"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_email" style="width:60%" width="100%" value="<%=exchange.toHtml(rss.getString("contact_person2_email"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_person2_sex" style="width:60%">
	 <%if(rss.getString("contact_person2_sex").equals("男")){%>
  <option selected><%=demo.getLang("erp","男")%></option>
  <option><%=demo.getLang("erp","女")%></option>
<%}else{%>
  <option><%=demo.getLang("erp","男")%></option>
  <option selected><%=demo.getLang("erp","女")%></option>
<%}%>
						 </select>
 
 </tr>
<%
String[] attachment_name1=DealWithString.divide(rss.getString("attachment_name"),20);	
%>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","动态信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><a href="javascript:winopenm('../../crm/file/query_attachment.jsp?id=<%=rss.getString("id")%>&tablename=crm_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","开票信息")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="invoice_info"><%=invoice_info%></textarea>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","最新需求")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="demand"><%=demand%></textarea>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
 </tr>		
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","销售人员编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rss.getString("sales_ID")%></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","变更人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="changer" style="width:60%" value="<%=exchange.toHtml(changer)%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","变更人编码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="changer_ID" style="width:60%" width="100%"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","变更时间")%>&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="change_time" style="width:60%" type="hidden" width="100%" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
	<input name="sales_ID" type="hidden" width="100%" value="<%=rss.getString("sales_ID")%>">
	<input name="lately_change_time" type="hidden" width="100%" value="<%=rss.getString("change_time")%>">
	<input name="file_change_amount" type="hidden" width="100%" value="<%=rss.getString("file_change_amount")%>">

 </table>
 <input name="lately_change_time" type="hidden" value="<%=exchange.toHtml(rss.getString("change_time"))%>">
 <input name="file_change_amount" type="hidden" value="<%=rss.getString("file_change_amount")%>">
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</div>
</form>

<%
	 crm_db.close();	
}
crm_db1.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
crm_db1.close(); 
crm_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="change_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已变更，请返回！")%></td>
 </tr>
</table>
</div>

<%}%>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src="../../javascript/ecommerce/treeBusiness.js"></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>
<div id="nseer1" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
</div>
</TD>
<TD  background="../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
<script>
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
  Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setParent('nseer1_0');
 Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('crm_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/ecommerce/crm');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/ecommerce/crm','crm_config_file_kind','treeButton');
}
</script>