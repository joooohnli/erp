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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divViewChange.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script type="text/javascript" src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script language="javascript" src="../../javascript/qcs/item/register.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<!--  弹出 计数器层的样式 -->
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<%
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String register=(String)session.getAttribute("realeditorc");
String register_id=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<body onload="locateSelectDiv()">
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="QV_button" onclick="showQVDiv('QV_hidden','QV_table2',0,'register',event);" value="质检值" disabled>&nbsp;<%=DgButton.getDraft("'mutiValidation','../../qcs_item_register_draft_ok','../../xml/qcs/qcs_item.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="registerOk()" value=<%=demo.getLang("erp","保存")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","质检项目")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id="bill_head">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","项目编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" value="" id="item_id" name="item_id" onfocus="alert('<%=demo.getLang("erp","项目编号由系统生成")%>');this.blur();";/></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","项目名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="item_name" name="item_name" type="text" width="100%" value=""></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="designer" name="designer" type="text" width="100%" value=""></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","分析方法")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input class="INPUT_STYLE3" id="analyse_method" name="analyse_method" onclick="loadAjaxDiv('analyse_method','分析方法')" type="text" value="" readonly/><div class="select_div_r" id="analyse_method_div"  onclick="loadAjaxDiv('analyse_method','分析方法')"></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","首选质检依据")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="default_basis" onclick="loadAjaxDiv('default_basis','质检依据')" name="default_basis" type="text" width="100%" value=""  readonly/><div class="select_div_l" id="default_basis_div"  onclick="loadAjaxDiv('default_basis','质检依据')"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","备选质检依据")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input class="INPUT_STYLE3" id="ready_basis" onclick="loadAjaxDiv('ready_basis','质检依据')" name="ready_basis" type="text" value=""  readonly/><div class="select_div_r" id="ready_basis_div"  onclick="loadAjaxDiv('ready_basis','质检依据')"></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","质检方法")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_method" onclick="loadAjaxDiv('quality_method','质检方法')" name="quality_method" type="text" width="100%" value=""  readonly/><div class="select_div_l" id="quality_method_div"  onclick="loadAjaxDiv('quality_method','质检方法')"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","质检设备")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input class="INPUT_STYLE3" id="quality_equipment" name="quality_equipment" onclick="loadAjaxDiv('quality_equipment','质检设备')" type="text" value=""  readonly/><div class="select_div_r" id="quality_equipment_div" onclick="loadAjaxDiv('quality_equipment','质检设备')"></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","抽样标准")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_standard" name="sampling_standard" onclick="loadAjaxDiv('sampling_standard','抽样标准')" type="text" width="100%" value=""  readonly/><div class="select_div_l" id="sampling_standard_div"  onclick="loadAjaxDiv('sampling_standard','抽样标准')"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","质量问题等级")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="defect_class" name="defect_class" onclick="loadAjaxDiv('defect_class','质量问题等级')" type="text" width="100%" value=""  readonly/><div class="select_div_r" id="defect_class_div" onclick="loadAjaxDiv('defect_class','质量问题等级')"></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","是否重点检查")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=RADIO_STYLE1%> class="RADIO_STYLE1" id="important" name="important" type="radio" value="yes"  checked/><%=demo.getLang("erp","是")%>&nbsp;<input <%=RADIO_STYLE1%> class="RADIO_STYLE1" id="important" name="important" type="radio" value="no" /><%=demo.getLang("erp","否")%>&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"></td>
 
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%" height="65"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=register%>"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_id" value="<%=register_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=time%>" readonly></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","附件")%>&nbsp;&nbsp;&nbsp;：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file" width="100%"><input type="hidden" id="QV_hidden" name="QV_hidden"></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
</body>
