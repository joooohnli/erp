<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%isPrint isPrint=new isPrint(request);%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/qcs/complain/complain.css" />
<script type="text/javascript" src="../../javascript/qcs/complain/complain.js"></script>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="history.back();" value="<%=demo.getLang("erp","返回")%>"></div></td>
</tr>
</table>
<%
try{
String complain_id=request.getParameter("complain_id");
String changer_id=(String)session.getAttribute("human_IDD");
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String change_time=formatter.format(now);
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String sql="select * from qcs_complain where complain_id='"+complain_id+"'";
ResultSet rs=qcs_db.executeQuery(sql);
if(rs.next()){
	String complain_time=rs.getString("complain_time");
	String product_id=rs.getString("product_id");
	String product_name=rs.getString("product_name");
	String complainant=rs.getString("complainant");
	String company=rs.getString("company");
	String address=rs.getString("address");
	String tel=rs.getString("tel");
	String cellphone=rs.getString("cellphone");
	String email=rs.getString("email");
	String complain_way=rs.getString("complain_way");
	String complain_type=rs.getString("complain_type");
	String content=rs.getString("content");
	String remark=rs.getString("remark");
	String records=rs.getString("records");
	String suggestion=rs.getString("suggestion");
%>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","投诉回访")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%" align="left"><%=demo.getLang("erp","登记单编号")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="complain_id" name="complain_id" type="text" width="100%" value="<%=complain_id%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉日期")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" onfocus="this.blur();" id="date_start" name="complain_time" type="text" width="100%" value="<%=complain_time%>" readonly/></td>
</tr>


<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","产品编号")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=product_id%>" onkeyup="loadAjaxDiv('product_id');" readonly/></td>


<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","产品名称")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="100%" value="<%=product_name%>" readonly /></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉人姓名")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="complainant" name="complainant" type="text" width="100%" value="<%=complainant%>" readonly/></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉人单位")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="company" name="company" type="text" width="100%" value="<%=company%>" readonly/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉人地址")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="address" name="address" type="text" width="100%" value="<%=address%>" readonly/></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉人电话")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="tel" name="tel" type="text" width="100%" value="<%=tel%>" readonly/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉人手机")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="cellphone" name="cellphone" type="text" width="100%" value="<%=cellphone%>" readonly/></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉人Email")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="email" name="email" type="text" width="100%" value="<%=email%>" readonly/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="complain_way" name="complain_way" type="text" width="100%" value="<%=complain_way%>" readonly/></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉类型")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="complain_type" name="complain_type" type="text" width="100%" value="<%=complain_type%>" readonly/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","投诉内容")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="content" name="content" cols="5" rows="5" value="" readonly><%=exchange.unURL(content)%></textarea></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="remark" name="remark" cols="5" rows="5" readonly><%=exchange.unURL(remark)%></textarea></td>
</tr>
<%=isPrint.printOrNot3(rs.getString("attachment1"),"附件&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"qcs_complain","attachment1")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","处理意见")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="suggestion" name="suggestion" cols="5" rows="5" readonly/><%=exchange.unURL(suggestion)%></textarea></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","回访记录")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="records" name="records" cols="5" rows="5" readonly/><%=exchange.unURL(records)%></textarea></td>
</tr>
<%=isPrint.printOrNot3(rs.getString("attachment2"),"附件&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"qcs_complain","attachment2")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","回访人")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="changer" name="changer" type="text" width="100%" value="<%=changer%>" readonly/><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="changer_id" value="<%=changer_id%>"></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","回访时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%">
<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="change_time" type="text" style="width: 100%" value="<%=change_time%>" readonly/></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
</script>
<%
}}catch(Exception ex){
	ex.printStackTrace();
}
%>