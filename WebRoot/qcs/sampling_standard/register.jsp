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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="sum" scope="page" class="finance.Sum"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../javascript/qcs/sampling_standard/register.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src="../../javascript/include/validate/validation-framework.js"></script>
<!--  弹出 计数器层的样式 -->
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type="text/javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script language="javascript" src="../../javascript/include/div/divViewChange.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript">
function openDialog(s,color)
{
var sHTML =  document.getElementById(s).innerHTML;
	
new NeatDialog(sHTML, "川大科技&nbsp;loading...", false,color);
}

</script>
<% 
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
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
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  id="formula_button" onclick="showFormulaDiv('formula_div');" value="抽样公式" disabled>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  id="add_button" onclick="addRow('bill_body');" value="添加">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  id="del_button" onclick="deleteSelect('bill_body')" value=<%=demo.getLang("erp","删除")%>>&nbsp;<%=DgButton.getDraft("'mutiValidation','../../qcs_sampling_standard_register_draft_ok','../../xml/qcs/qcs_sampling_standard.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  onClick="registerOk()" value=<%=demo.getLang("erp","保存")%>></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","抽样标准")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id="bill_head">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","标准编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" onclick="alert('<%=demo.getLang("erp","标准编号由系统生成")%>');"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" value="" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","标准名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="standard_name" type="text" width="100%" value=""></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","抽样方法")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="method_id" name="method_name" onchange="addAqlRow(this,'bill_head','bill_body');">
 <option value=""></option>
<%
  String sql0 = "select type_id,type_name from qcs_config_public_char where kind='抽样方法' order by id" ;
	 ResultSet rs0 = qcs_db.executeQuery(sql0) ;
while(rs0.next()){
%>
		<option value="<%=rs0.getString("type_id")%>/<%=exchange.toHtml(rs0.getString("type_name"))%>"><%=exchange.toHtml(rs0.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="designer" type="text" width="100%" value=""></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%" id="batch"><%=demo.getLang("erp","批量数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%" id="sample"><%=demo.getLang("erp","样本数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%" id="formula"><%=demo.getLang("erp","抽样公式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%" id="accept"><%=demo.getLang("erp","允收数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%" id="reject"><%=demo.getLang("erp","拒收数")%></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=register%>"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_ID" value="<%=register_ID%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=time%>" readonly></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%" height="65"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","附件")%>&nbsp;&nbsp;&nbsp;：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file" width="100%"></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</form>
<div id="formula_div" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:400px;height:200px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif" ></TD>
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
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
<tr><td style="background-color:green">
<%for(int i=0;i<10;i++) {
%><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="<%=i%>" style="width:25px;" name="B1" class="input" onClick="writeIn(this.value)"><%}%>
</td>
</tr>
<tr>
<td style="background-color:green">
<input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="+" name="B1" class="input" onClick="writeIn(this.value)"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  style="width:25px;" value="-" name="B1" class="input" onClick="writeIn(this.value)"><input  style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="*" name="B1" class="input" onClick="writeIn(this.value)"><input  style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="/" name="B1" class="input" onClick="writeIn(this.value)"><input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="(" name="B1" class="input" onClick="writeIn(this.value)"><input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value=")" name="B1" class="input" onClick="writeIn(this.value)"><input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="." name="B1" class="input" onClick="writeIn(this.value)"><input style="width:75px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="批量数" name="B1" class="input" onClick="writeIn(this.value)">
</td>
</tr>
<tr><td><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" id="formula_id"></textarea></td></tr>
<tr><td><p align="right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="<%=demo.getLang("erp","清空")%>" onClick="document.getElementById('formula_id').value='';">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="<%=demo.getLang("erp","确定")%>" onClick="formulaOk();">  
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  value="<%=demo.getLang("erp","关闭")%>" onClick="document.getElementById('formula_div').style.display='none';"></p></td>
</tr>
</table>

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
</div>