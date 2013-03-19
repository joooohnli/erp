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
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%isPrint isPrint=new isPrint(request);%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/qcs/accident/accident.css" />
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../javascript/qcs/accident/accident.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data">
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_qcs_accident_draft_ok','../../xml/qcs/qcs_accident.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_qcs_accident_check_ok','../../xml/qcs/qcs_accident.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></td>
</tr>
</table>
<%
try{

String register_id=(String)session.getAttribute("human_IDD");
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String register_time=formatter.format(now);
String accident_id=request.getParameter("accident_id");

String sql = "select id,accident_time,accident_name,product_id,product_name,accident_outlines,explanation,survey_result,scene_measure,remark,attachment1 from qcs_accident where accident_id='"+accident_id+"' and check_tag='5' or check_tag='9'";
	ResultSet rs = qcs_db.executeQuery(sql) ;
    if(rs.next()){
    String id=rs.getString("id");
    String accident_time=rs.getString("accident_time");
    String accident_name=rs.getString("accident_name");
    String product_id=rs.getString("product_id");
    String product_name=rs.getString("product_name");
    String accident_outlines=rs.getString("accident_outlines");
    String explanation=rs.getString("explanation");
    String survey_result=rs.getString("survey_result");
    String scene_measure=rs.getString("scene_measure");
    String attachment1=rs.getString("attachment1");
    String remark=exchange.unHtml(rs.getString("remark"));
%>
<script language="javascript">
function TwoSubmit(){
var form=document.getElementById('accidentCheck');
form.action = "../../qcs_accident_uncheck_ok?accident_id=<%=accident_id%>";
form.submit();
}
</script>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","质量事故")%></b></font></td>
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
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="accident_id" name="accident_id" type="text" width="100%" value="<%=accident_id%>" readonly /></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><font color="red">*</font><%=demo.getLang("erp","发生日期")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" onfocus="this.blur();" id="accident_time" name="accident_time" type="text" width="100%" value="<%=accident_time%>"/></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><font color="red">*</font><%=demo.getLang("erp","事故名称")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="accident_name" name="accident_name" type="text" width="100%" value="<%=accident_name%>"/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><font color="red">*</font><%=demo.getLang("erp","产品编号")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=product_id%>" onkeyup="loadAjaxDiv('product_id');"/></td>

<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","产品名称")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" onfocus="this.blur();" id="product_name" name="product_name" type="text" width="100%" value="<%=product_name%>" readonly/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><font color="red">*</font><%=demo.getLang("erp","事故概述")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="accident_outlines" name="accident_outlines" cols="5" rows="5"><%=exchange.unURL(accident_outlines)%></textarea></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><font color="red">*</font><%=demo.getLang("erp","详细说明")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="explanation" name="explanation" cols="5" rows="5"><%=exchange.unURL(explanation)%></textarea></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><font color="red">*</font><%=demo.getLang("erp","调查结果")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="survey_result" name="survey_result" cols="5" rows="5"><%=exchange.unURL(survey_result)%></textarea></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><font color="red">*</font><%=demo.getLang("erp","现场采取措施")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="scene_measure" name="scene_measure" cols="5" rows="5"><%=exchange.unURL(scene_measure)%></textarea></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="width:100%" id="remark" name="remark" cols="5" rows="5"><%=exchange.unURL(remark)%></textarea></td>
</tr>
<%=isPrint.hasOrNot3d(attachment1,"附件&nbsp;&nbsp;&nbsp;","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,id,"qcs_accident")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","登记人")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register" name="register" type="text" width="100%" value="<%=register%>" readonly/><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_id" value="<%=register_id%>"></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","登记时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%">
<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" type="text" style="width: 100%" value="<%=register_time%>" readonly/></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "accident_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "accident_time", singleClick : true, step : 1});
</script>
<%
	qcs_db.close();
	}}catch(Exception ex){
	ex.printStackTrace();
}
%>