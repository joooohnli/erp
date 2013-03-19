<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db logisticsdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
String register=(String)session.getAttribute("realeditorc");
String provider_ID=request.getParameter("provider_ID");
String config_id=request.getParameter("config_id");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
if(vt.validata((String)session.getAttribute("unit_db_name"),"logistics_file","provider_ID",provider_ID,"check_tag").equals("5")||vt.validata((String)session.getAttribute("unit_db_name"),"logistics_file","provider_ID",provider_ID,"check_tag").equals("9")){
try{
	String sqll = "select * from logistics_file where provider_ID='"+provider_ID+"'" ;
	ResultSet rss = logisticsdb.executeQuery(sqll) ;
	if(rss.next()){
	String invoice_info=exchange.unHtml(rss.getString("invoice_info"));
	String demand_products=exchange.unHtml(rss.getString("demand_products"));
	String recommend_products=exchange.unHtml(rss.getString("recommend_products"));
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="post">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_logistics_file_draft_ok','../../xml/logistics/logistics_file.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_logistics_file_check_ok','../../xml/logistics/logistics_file.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div>
 </td>
 </tr>
</table>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
  <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" colspan="3"><input name="provider_ID" type="hidden" value="<%=rss.getString("provider_ID")%>"><%=rss.getString("provider_ID")%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color="red">*</font><%=demo.getLang("erp","物流单位名称")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_name" style="width:80%" value="<%=exchange.toHtml(rss.getString("provider_name"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_address" style="width:80%" value="<%=exchange.toHtml(rss.getString("provider_address"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color="red">*</font><%=demo.getLang("erp","产品分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="fileKind_chain" name="fileKind_chain" style="width:80%" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>"><input id="fileKind_chain_table" type="hidden" value="design_config_file_kind"></td>

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","所在区域")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type" style="width:45%">
  <%
  String sql4 = "select * from logistics_config_public_char where kind='区域' order by type_ID" ;
	 ResultSet rs4 = logistics_db.executeQuery(sql4) ;
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","物流单位曾用名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="used_provider_name" style="width:80%" value="<%=exchange.toHtml(rss.getString("used_provider_name"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开户银行")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_bank" style="width:45%" value="<%=exchange.toHtml(rss.getString("provider_bank"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","银行账号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_account" style="width:45%" value="<%=exchange.toHtml(rss.getString("provider_account"))%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","网址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_web" style="width:45%" value="<%=exchange.toHtml(rss.getString("provider_web"))%>"></td>
 
 </tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","优质级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="class" style="width:45%">
  <%
  String sql5 = "select * from logistics_config_public_char where kind='物流单位级别' order by type_ID" ;
	 ResultSet rs5 = logistics_db.executeQuery(sql5) ;
while(rs5.next()){	
	if(rs5.getString("type_name").equals(rss.getString("provider_class"))){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>" selected><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%
	}
}
%>

  </select>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color="red">*</font><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_tel1" style="width:45%" value="<%=exchange.toHtml(rss.getString("provider_tel1"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","传真")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_fax" style="width:45%" value="<%=exchange.toHtml(rss.getString("provider_fax"))%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮政编码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="provider_postcode" style="width:45%" value="<%=exchange.toHtml(rss.getString("provider_postcode"))%>"></td>
 </tr>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","联系人信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","第一联系人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person1"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_department" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person1_department"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_duty" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person1_duty"))%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_office_tel" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person1_office_tel"))%>"></td>
 
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_mobile" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person1_mobile"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_home_tel" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person1_home_tel"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_email" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person1_email"))%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_person1_sex" style="width:45%">
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
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person2"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_department" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person2_department"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_duty" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person2_duty"))%>"></td>
  <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_office_tel" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person2_office_tel"))%>"></td>
 
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_mobile" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person2_mobile"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_home_tel" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person2_home_tel"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_email" style="width:45%" value="<%=exchange.toHtml(rss.getString("contact_person2_email"))%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_person2_sex" style="width:45%">
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
 <td colspan="3" <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rss.getString("id")%>&tablename=logistics_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","开票信息")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="invoice_info"><%=invoice_info%></textarea>
</td>
 <td height="65" <%=TD_STYLE4%> class="TD_STYLE7" width="13%"><%=demo.getLang("erp","可配送产品集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="demand_products"><%=demand_products%></textarea>
</td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE7">
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="13%"><%=demo.getLang("erp","推荐配送产品集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="recommend_products"><%=recommend_products%></textarea>
</td>
<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%">&nbsp;</td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
 </tr>		
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="register" type="hidden" value="<%=exchange.toHtml(register)%>"><%=exchange.toHtml(register)%></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%>&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="register_time" type="hidden" width="100%" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","责任人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="logisticser" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","责任人编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="logisticser_ID" style="width:49%"></td>
</tr>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/logistics/logistics_file.xml"/>
<%
ResultSet rs=rss;	
String nickName="物流单位档案";%>
<%@include file="../../include/cDefineMouC.jsp"%>
</table>
 </form>　
 </div>　　　　　　　　　　　　　　
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%
	}
}catch (Exception ex){
out.println("error"+ex);
}
}else{
logistics_db.close();
design_db.close();
logisticsdb.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="file_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已提交审核，请返回！")%></td>
 </tr>
</table>
</div>
<%
}
%>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link href="../../css/include/nseerTree/nseertree.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src="../../javascript/logistics/file/treeBusiness.js"></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../javascript/crm/file/register.js"></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='../../javascript/include/nseer_cookie/toolTip.js'></script>
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
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%></div></div>
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
 Nseer_tree1.setTableName('design_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/logistics/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/logistics/file','design_config_file_kind','treeButton');
}
</script>