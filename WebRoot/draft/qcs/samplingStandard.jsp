<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="include.nseer_cookie.exchange" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="sum" scope="page" class="finance.Sum"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript" src="../../javascript/draft/qcs/samplingStandard.js"></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script language="javascript" src="../../javascript/include/div/divViewChange.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>

<% 
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<%
try{
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String standard_id = request.getParameter("standard_id");
String config_id=request.getParameter("config_id");
String sqla="select id from qcs_workflow where object_ID='"+standard_id+"' and check_tag='0' and config_id<'"+config_id+"'";
ResultSet rsa=qcs_db.executeQuery(sqla);
if(!rsa.next()){
String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql = "select id,standard_name,sampling_method,designer,quality_level,mil_std,aql,remark,attachment1,register,register_id,register_time from qcs_sampling_standard where standard_id='"+standard_id+"'" ;
ResultSet rs = qcs_db.executeQuery(sql) ;
if(rs.next()){
String standard_name=rs.getString("standard_name");
String sampling_method=rs.getString("sampling_method");
String designer=rs.getString("designer");
String remark=rs.getString("remark");
String attachment1=rs.getString("attachment1");
String id=rs.getString("id");
String quality_level=rs.getString("quality_level");
String mil_std=rs.getString("mil_std");
String AQL=rs.getString("aql");
String register=rs.getString("register");
String register_time=rs.getString("register_time");
String register_id=rs.getString("register_id");
if(quality_level.equals("")){
}
%>
<body onload="locateSelectDiv()">
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript">
function TwoSubmit(){
var form=document.getElementById('mutiValidation');
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>";
}else{
form.action = "../../qcs_sampling_standard_check_ok?config_id=<%=config_id%>";
}
if(doValidate('../../xml/qcs/qcs_sampling_standard.xml','mutiValidation')){
form.submit();
}
}
</script>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8"><div <%=DIV_STYLE1%>class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_qcs_samplingStandard_draft_ok','../../xml/qcs/qcs_sampling_standard.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="formula_button" onclick="showFormulaDiv('formula_div');" value="公式">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add_button" onclick="addRow('bill_body');" value="添加">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="del_button" onclick="deleteSelect('bill_body')" value=<%=demo.getLang("erp","删除")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_qcs_samplingStandard_check_ok','../../xml/qcs/qcs_sampling_standard.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></div></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" name="standard_id" value="<%=standard_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","标准名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="standard_name" type="text" width="100%" value="<%=standard_name%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","抽样方法")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="method_id" name="method_name" onchange="addAqlRow(this,'bill_head','bill_body');">
<%

  String sql0 = "select type_id,type_name from qcs_config_public_char where kind='抽样方法' order by id" ;
	 ResultSet rs0 = qcs_db.executeQuery(sql0) ;
while(rs0.next()){
String sampling_method_temp=rs0.getString("type_id")+"/"+exchange.toHtml(rs0.getString("type_name"));
if(sampling_method_temp.equals(sampling_method)){%>
<option value="<%=rs0.getString("type_id")%>/<%=exchange.toHtml(rs0.getString("type_name"))%>" selected><%=exchange.toHtml(rs0.getString("type_name"))%></option>
<%
}else{
%>
		<option value="<%=rs0.getString("type_id")%>/<%=exchange.toHtml(rs0.getString("type_name"))%>"><%=exchange.toHtml(rs0.getString("type_name"))%></option>
<%

}
}
%>
  </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="designer" type="text" width="100%" value="<%=designer%>"></td>
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
<script>
	 initBillHead('method_id','bill_head','bill_body');
<%if(sampling_method.equals("04/国标")||sampling_method.equals("03/自定义")){%>
	 document.getElementById('level_id').value='<%=quality_level%>';
	 document.getElementById('class_id').value='<%=mil_std%>';
	 document.getElementById('aql_id').value='<%=AQL%>';
<%}%>
<% String sql1 = "select * from qcs_sampling_standard_details where standard_id='"+standard_id+"' order by id" ;
	 ResultSet rs1 = qcs_db.executeQuery(sql1) ;
	 int m=0;
	 while(rs1.next()){
%>
	 addRow('bill_body');
	 var bill_body=document.getElementById('bill_body');
	  document.getElementById(bill_body.rows[0].cells[0].id+<%=m+1%>).value='<%=rs1.getString("batch")%>';
	  <%if(sampling_method.equals("04/国标")){%>
	  document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).value='<%=rs1.getString("sample_code")%>';
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).value='<%=rs1.getString("sampling_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).value='<%=rs1.getString("accept_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[4].id+<%=m+1%>).value='<%=rs1.getString("reject_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[0].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[4].id+<%=m+1%>).onfocus=function (){this.blur();};
	  <%}else if(sampling_method.equals("01/固定数量")){%>
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).value='<%=rs1.getString("sampling_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).value='<%=rs1.getString("accept_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).value='<%=rs1.getString("reject_amount")%>';
	  <%}else{%>
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).value='<%=rs1.getString("sampling_amount")%>'
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).value='<%=rs1.getString("sampling_formula")%>';
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).value='<%=rs1.getString("accept_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[4].id+<%=m+1%>).value='<%=rs1.getString("reject_amount")%>';
	  <%}%>
	 	 
<%
m++;
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=register%>"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_id" value="<%=register_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=register_time%>" readonly></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=checker%>"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker_id" value="<%=checker_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="check_time" value="<%=time%>" readonly></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%" height="65"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=exchange.unHtml(remark)%></textarea>
</td>
 </tr>
<%=isPrint.hasOrNot3d(attachment1,"附件&nbsp;&nbsp;&nbsp;","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,id,"qcs_sampling_standard")%>
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
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">

<table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
<tr><td style="background-color:green">
<%for(int i=0;i<10;i++) {
%><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=i%>" style="width:25px;" name="B1" class="input" onClick="writeIn(this.value)"><%}%>
</td>
</tr>
<tr>
<td style="background-color:green">
<input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="+" name="B1" class="input" onClick="writeIn(this.value)"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" style="width:25px;" value="-" name="B1" class="input" onClick="writeIn(this.value)"><input  style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="*" name="B1" class="input" onClick="writeIn(this.value)"><input  style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="/" name="B1" class="input" onClick="writeIn(this.value)"><input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="(" name="B1" class="input" onClick="writeIn(this.value)"><input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=")" name="B1" class="input" onClick="writeIn(this.value)"><input style="width:25px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="." name="B1" class="input" onClick="writeIn(this.value)"><input style="width:75px;" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="批量数" name="B1" class="input" onClick="writeIn(this.value)">
</td>
</tr>
<tr><td><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" id="formula_id"></textarea></td></tr>
<tr><td><p align="right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","清空")%>" onClick="document.getElementById('formula_id').value='';">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" onClick="formulaOk();">  
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭")%>" onClick="document.getElementById('formula_div').style.display='none';"></p></td>
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
<%}}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回")%></td>
 </tr>
</table>
</div>
<%}
qcs_db.close();
}catch(Exception e){
e.printStackTrace();
}%>