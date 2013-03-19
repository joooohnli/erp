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
<%nseer_db designdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link href="../../css/include/nseerTree/nseertree.css" rel="stylesheet" type="text/css">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<%
String checker_ID=(String)session.getAttribute("human_IDD");
String checker=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register_time="";
String product_ID=request.getParameter("product_ID");
String config_id=request.getParameter("config_id");
String sql6="select * from ecommerce_workflow where type_id='04' and object_ID='"+product_ID+"' and check_tag='0' and config_id<'"+config_id+"'";
ResultSet rs6=design_db.executeQuery(sql6);
if(!rs6.next()&&vt.validata((String)session.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"excel_tag3").equals("1")){

try{

	String sqll = "select * from design_file where product_ID='"+product_ID+"'" ;
	ResultSet rss = designdb.executeQuery(sqll) ;
	while(rss.next()){
	String provider_group=exchange.unHtml(rss.getString("provider_group"));
	String product_describe=exchange.unHtml(rss.getString("product_describe"));
	String promotion3=exchange.unHtml(rss.getString("promotion3"));
	String opinion3=exchange.unHtml(rss.getString("opinion3"));
	
if(rss.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rss.getString("register_time");
}
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>&product_ID=<%=product_ID%>";
}else{
form.action = "../../ecommerce_intrmanufacture_check_ok?config_id=<%=config_id%>&product_ID=<%=product_ID%>";
}
}
</script>
<form id="mutiValidation" method="post" onSubmit="return doValidate('../../xml/design/design_file.xml','mutiValidation')&&TwoSubmit(this)">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
 <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div>
 </td>
 </tr>
</table>

<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" colspan="3"><input name="product_ID" type="hidden" value="<%=rss.getString("product_ID")%>"><%=rss.getString("product_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%" ><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_name" style="width:60%" value="<%=exchange.toHtml(rss.getString("product_name"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","制造商")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%" ><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="factory_name" style="width:60%" value="<%=exchange.toHtml(rss.getString("factory_name"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="fileKind_chain" name="fileKind_chain" style="width:80%" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>"><input id="fileKind_chain_table" type="hidden" value="design_config_file_kind">
 </td>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品简称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_nick" style="width:60%" value="<%=rss.getString("product_nick")%>"></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","用途类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type" style="width:60%">
  <%
  String field_type=(String)session.getAttribute("field_type");
String sql4="";
if(field_type.equals("0")){
	sql4 = "select * from design_config_public_char where kind='产品用途' order by id";
}else{
	sql4 = "select * from design_config_public_char where kind='产品用途' and describe1='1' order by id";
}
	 ResultSet rs4 = design_db.executeQuery(sql4) ;
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档次级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_class" style="width:60%">
  <%
  String sql5 = "select * from design_config_public_char where kind='档次级别' order by type_ID" ;
	 ResultSet rs5 = design_db.executeQuery(sql5) ;
while(rs5.next()){	
	if(rs5.getString("type_name").equals(rss.getString("product_class"))){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>" selected><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%
	}
}
%>

  </select>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计量单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="personal_unit" style="width:60%"  value="<%=exchange.toHtml(rss.getString("personal_unit"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计量值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="personal_value" style="width:60%"  value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rss.getDouble("personal_value"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","市场单价(元)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="list_price" style="width:60%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rss.getDouble("list_price"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计划成本单价")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="cost_price" style="width:60%" type="text"value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rss.getDouble("cost_price"))%>"></td>
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","保修期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="warranty" style="width:60%" value="<%=exchange.toHtml(rss.getString("warranty"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","替代品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="twin_name" style="width:60%" value="<%=exchange.toHtml(rss.getString("twin_name"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","替代品编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="twin_ID" style="width:60%" value="<%=rss.getString("twin_ID")%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生命周期(年)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="lifecycle" style="width:60%" value="<%=exchange.toHtml(rss.getString("lifecycle"))%>"></td>
 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="amount_unit" style="width:60%" value="<%=exchange.toHtml(rss.getString("amount_unit"))%>"></td>
<%
String[] attachment_name1=DealWithString.divide(rss.getString("attachment_name"),20);
%>

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><a href="javascript:winopenm('../../design/file/query_attachment.jsp?id=<%=rss.getString("id")%>&tablename=design_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","供应商集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="provider_group"><%=provider_group%></textarea>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","产品描述")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="product_describe"><%=product_describe%></textarea>
</td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","促销信息")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="promotion3"><%=promotion3%></textarea>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","审核意见")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="opinion3"><%=opinion3%></textarea>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品经理")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4" style="width:60%">
	<option value="<%=rss.getString("chain_id")%>/<%=exchange.toHtml(rss.getString("chain_name"))%>/<%=rss.getString("responsible_person_ID")%>/<%=exchange.toHtml(rss.getString("responsible_person_name"))%>"><%=rss.getString("responsible_person_ID")%>/<%=exchange.toHtml(rss.getString("responsible_person_name"))%></option>

 </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="hidden" name="register"  style="width:60%" value="<%=exchange.toHtml(rss.getString("register"))%>"><%=exchange.toHtml(rss.getString("register"))%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="hidden" name="checker_ID"  style="width:60%" value="<%=checker_ID%>"><input type="hidden" name="checker"" value="<%=exchange.toHtml(checker)%>"><%=exchange.toHtml(checker)%></td>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%>&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input  name="check_time" style="width:60%" type="hidden"" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 </table>
 <input name="lately_change_time" type="hidden" value="<%=exchange.toHtml(rss.getString("change_time"))%>">
 <input name="file_change_amount" type="hidden" value="<%=rss.getString("file_change_amount")%>">
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"> 
<%
	 design_db.close();	
}
designdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	 design_db.close();	
designdb.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2"">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2"">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核或前面尚有审核流程未完成，请返回！")%></td>
 </tr>
</table>
<%}%>
</div>

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
 Nseer_tree1.setModuleName('../../xml/ecommerce/design');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/ecommerce/design','design_config_file_kind','treeButton');
}
</script>