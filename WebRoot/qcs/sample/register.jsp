<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.get_name_from_ID.getNameFromID"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<script type="text/javascript" src="../../javascript/qcs/sample/sample.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/qcs/purchase/purchase.css" />
<script language="javascript" src="../../javascript/include/div/divDisappear.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
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
String register=(String)session.getAttribute("realeditorc");
String register_id=(String)session.getAttribute("human_IDD");
try{	
String table_width1="820px";
%>
<body onload="locateSelectDiv()">
<form id="sample_register" METHOD="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8"><%=DgButton.getDraft("'sample_register','../../qcs_sample_register_draft_ok','../../xml/qcs/qcs_sample.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>" onClick="showFormSubmit('register','../../xml/qcs/qcs_sample.xml','sample_register');"></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sample_id" name="sample_id" type="text" width="100%" onfocus="alert('<%=demo.getLang("erp","登记单编号由系统生成")%>');this.blur();" value="" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_type" name="quality_type" type="text" width="100%" value=""  onclick="loadDiv('quality_type');this.blur();" readonly /><div class="select_div_l" id="quality_type_div"  onclick="loadDiv('quality_type')"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="apply_id" name="apply_id" type="text" width="100%" value="" onkeyup="loadDiv('apply_id');"/></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","取样人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_person" name="sampling_person" type="text" width="37%" value="" /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","取样时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_time" name="sampling_time" type="text" width="37%" value=""/></td>
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
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register" name="register" type="text" width="37%" value="<%=register%>" readonly /><input id="register_id" name="register_id" type="hidden" value="<%=register_id%>"/></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register_time" name="register_time" type="text" width="37%" value="<%=time%>" readonly /></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" /></textarea></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","附件")%>&nbsp;&nbsp;&nbsp;：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file" width="100%"></td>
</tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
 </div>
</form>
</body>
<script type="text/javascript">
Calendar.setup ({inputField : "sampling_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
</script>
<%
}catch (Exception ex){
//out.println("error"+ex);
}
%>
