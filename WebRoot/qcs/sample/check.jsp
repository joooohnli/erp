<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*,include.get_name_from_ID.getNameFromID"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%isPrint isPrint=new isPrint(request);%>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../javascript/qcs/sample/sample.js"></script>
<script language="javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/qcs/purchase/purchase.css" />
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
String sample_id=request.getParameter("sample_id");
String config_id=request.getParameter("config_id");
try{
String sqla="select id from qcs_workflow where object_ID='"+sample_id+"' and check_tag='0' and config_id<'"+config_id+"'";
ResultSet rsa=qcs_db.executeQuery(sqla);
if(!rsa.next()){
	String sql = "select id,quality_type,apply_id,sampling_person,sampling_time,register,register_time,attachment1,remark from qcs_sample where sample_id='"+sample_id+"' and check_tag='0'";
	ResultSet rs = qcs_db.executeQuery(sql) ;
    if(rs.next()){
    String id=rs.getString("id");
    String quality_type=rs.getString("quality_type");
    String apply_id=rs.getString("apply_id");
    String sampling_person=rs.getString("sampling_person");
    String sampling_time=rs.getString("sampling_time");
    String register=rs.getString("register");
    String register_time=rs.getString("register_time");
    String attachment1=rs.getString("attachment1");
    String remark=rs.getString("remark");
%>
<%String table_width1="820px";%>
<script language="javascript">
function TwoSubmit(){
var form=document.getElementById('sample_check');
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>";
}else{
form.action = "../../qcs_sample_check_ok?config_id=<%=config_id%>";
}
if (doValidate('../../xml/qcs/qcs_sample.xml','sample_check')){
form.submit();
}
}
</script>
<body onload="locateSelectDiv()">
<form id="sample_check" METHOD="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked> <%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
<%=demo.getLang("erp","通过")%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" onClick="TwoSubmit();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","样品登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sample_id" name="sample_id" type="text" width="100%" value="<%=sample_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_type" name="quality_type" type="text" width="100%" value="<%=quality_type%>"  onclick="loadDiv('quality_type');this.blur();" readonly /><div class="select_div_l" id="quality_type_div"  onclick="loadDiv('quality_type')"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="apply_id" name="apply_id" type="text" width="100%" value="<%=apply_id%>" onkeyup="loadDiv('apply_id');"/></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","取样人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_person" name="sampling_person" type="text" width="37%" value="<%=sampling_person%>" /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","取样时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_time" name="sampling_time" type="text" width="37%" value="<%=sampling_time%>"/></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr>
 <td>
 <div style="overflow:scroll;width:100%;height:200px;">
<table <%=TABLE_STYLE5%> style="width:200%;border-collapse: collapse;border: 1px solid;" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="sample_lable" name="sample_lable"><%=demo.getLang("erp","样品标签号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="product_id" name="product_id"><%=demo.getLang("erp","产品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="product_name" name="product_name"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="amount_unit" name="amount_unit"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="sumtotal" name="sumtotal"><%=demo.getLang("erp","总数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="sampling_amount" name="sampling_amount"><%=demo.getLang("erp","取样数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="view_cycle" name="view_cycle"><%=demo.getLang("erp","观察周期(天)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="deposit_limit" name="deposit_limit"><%=demo.getLang("erp","保存期限(天)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="deposit_place" name="deposit_place"><%=demo.getLang("erp","存放位置")%></td>
 </tr>
</table>
</div>
</td>
</tr>
</table>
<script>
<%
sql="select * from qcs_sample_details where sample_id='"+sample_id+"' order by details_number";
rs=qcs_db.executeQuery(sql);
int i=1;
while(rs.next()){
%>
	addRow('bill_body');
	var table_obj=document.getElementById('bill_body');
	document.getElementById(table_obj.rows[0].cells[0].id+'<%=i%>').value='<%=rs.getString("sample_lable")%>';
   	document.getElementById(table_obj.rows[0].cells[1].id+'<%=i%>').value='<%=rs.getString("product_id")%>';
    document.getElementById(table_obj.rows[0].cells[2].id+'<%=i%>').value='<%=rs.getString("product_name")%>';
    document.getElementById(table_obj.rows[0].cells[3].id+'<%=i%>').value='<%=rs.getString("amount_unit")%>';
    document.getElementById(table_obj.rows[0].cells[4].id+'<%=i%>').value='<%=rs.getString("sumtotal")%>';
    document.getElementById(table_obj.rows[0].cells[5].id+'<%=i%>').value='<%=rs.getString("sampling_amount")%>';
    document.getElementById(table_obj.rows[0].cells[6].id+'<%=i%>').value='<%=rs.getString("view_cycle")%>';
    document.getElementById(table_obj.rows[0].cells[7].id+'<%=i%>').value='<%=rs.getString("deposit_limit")%>';    
    document.getElementById(table_obj.rows[0].cells[8].id+'<%=i%>').value='<%=rs.getString("deposit_place")%>';
<%
i++;
}
%>
</script>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register" name="register" type="text" width="37%" value="<%=register%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register_time" name="register_time" type="text" width="37%" value="<%=register_time%>" readonly /></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="checker" name="checker" type="text" width="37%" value="<%=checker%>" readonly /><input id="checker_id" name="checker_id" type="hidden" value="<%=checker_id%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="check_time" name="check_time" type="text" width="37%" value="<%=time%>" readonly /></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" /><%=exchange.unURL(remark)%></textarea></td>
</tr>
 <%=isPrint.hasOrNot3d(attachment1,"附件&nbsp;&nbsp;&nbsp;","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,id,"qcs_sample")%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
</body>
<script type="text/javascript">
Calendar.setup ({inputField : "sampling_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
</script>
<%
}}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
</table>
</div>
<%}
	qcs_db.close();
}catch (Exception ex){
ex.printStackTrace();
}
%>
