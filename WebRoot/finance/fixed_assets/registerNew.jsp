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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">

<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../css/finance/tabs.css">
<script type="text/javascript" src="../../javascript/finance/fixed_assets/registerNew.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divLocate.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="post">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div id="loaddiv" style="display:none;border:1px solid red; height:20px;background-color: #FF0033;width:63%;float :left ;" ></div>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1" onClick="registerNew_ok();">&nbsp;<input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></div>
 </td>
 </tr>
</table>
<%
String time="";
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
int count=0;
String sql="";
ResultSet rs=null;
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id="theObjTable">
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","类别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" colspan="3"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="type_name2" name="type_name1" style="width:40%" onFocus="showKind('nseer1',this,showNseer1)" onkeyup="search_suggest1(this.id)" autocomplete="off"><input id="type_name2_table" type="hidden" value="finance_config_assets_kind"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","固定资产编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="file_id2" name="file_id1" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","固定资产名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="file_name2" name="file_name1" style="width:49%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","增加方式")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="addway" name="addway1" style="width:49%" onFocus="showKind('nseer2',this,showNseer2)" onkeyup="search_suggest(this.id)" autocomplete="off"><input id="addway_table" type="hidden" value="finance_config_assets_fluctuationway"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","所在机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="department" name="department1" style="width:49%" onFocus="showKind('nseer4',this,showNseer4)" onkeyup="search_suggest(this.id)" autocomplete="off"><input id="department_table" type="hidden" value="hr_config_file_kind"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","规格型号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="specification" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","存放地址")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="deposit_place" type="text" style="width:49%"></td>
  </tr>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","折旧信息")%></div></td></tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","使用状态")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="status" style="width:49%" onchange="changeTag();">
  <%
   sql = "select describe2,type_name from finance_config_public_char where kind='使用状态'" ;
   rs = finance_db.executeQuery(sql) ;
while(rs.next()){%>
		<option value="<%=exchange.toHtml(rs.getString("describe2"))%>/<%=exchange.toHtml(rs.getString("type_name"))%>"><%=exchange.toHtml(rs.getString("describe2"))%>/<%=exchange.toHtml(rs.getString("type_name"))%></option>
<%
}
%>
  </select>
</td>
  <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","开始使用日期")%></td>
  <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="start_time" name="start_time1" style="width:49%" onkeyup="start_time2(this);"></td>
  
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","折旧方法")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="calway" style="width:49%" onchange="chooseIn();">
  <%
   sql = "select name from finance_config_calway" ;
   rs = finance_db.executeQuery(sql) ;
while(rs.next()){%>
		<option value="<%=exchange.toHtml(rs.getString("name"))%>"><%=exchange.toHtml(rs.getString("name"))%></option>
<%
}
finance_db.close();	
%>

  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","使用年限")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="lifecycle1" style="width:20%" onkeyup="lifecycle();"><%=demo.getLang("erp","年")%><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="lifecycle2" style="width:20%" onkeyup="lifecycle();"><%=demo.getLang("erp","月")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","币种")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="currency" style="width:49%" bvalue="人民币">
		<option value="人民币">人民币</option>
</select></td>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","原值")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="original_value" name="original_value1" style="width:49%" onkeyup="original_value2(this);"><input type="hidden" id="original_value_hidden"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","净残值率")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:20%;" maxlength="6" id="remnant_value_rate2" onkeyup="remnant_value_rate1(this);">%<input type="hidden" id="remnant_value_rate2_hidden"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","净残值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input id="remnant_value" name="remnant_value1" type="text" style="width:49%" onkeyup="remnant_value1(this);" onblur="remnant_validate(this);"><input type="hidden" id="remnant_value_hidden"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","已计提月份")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:49%" id="caled_month" onFocus="judgement(this)" onkeyup="caled_month1(this);"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","累计折旧")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input id="caled_sum" type="text" style="width:49%" onkeyup="caled_sum1(this);"><input type="hidden" id="caled_sum_hidden"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" id="dynamic"><%=demo.getLang("erp","月折旧率")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:49%" id="caled_subtotal_rate" readonly/><input type="hidden" id="caled_subtotal_rate_hidden"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","月折旧额")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input id="caled_subtotal" type="text" style="width:49%" readonly/><input type="hidden" id="caled_subtotal_hidden"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","净值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:49%" id="net_value" onkeyup="net_value1(this);" onblur="net_validate(this);"><input type="hidden" id="net_value_hidden"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","折旧对应科目")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input id="cal_file_name" type="text" style="width:49%" onFocus="showKind1(this)" onkeyup="search_suggest(this.id)" autocomplete="off"><input id="cal_file_name_table" type="hidden" value="finance_config_file_kind"></td>
 </tr>
</table>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>

<div id="search_div" onclick="showAny('ccc0')" style="CURSOR: hand; display: none; width: 18px; height:18px; background-image: url('../../images/finance/search.gif');"></div>
<style>
.note_div{
	position:absolute;top:-100px;right:50px;width:350px;
}
</style>
<div id="note_div" class="note_div"></div>
<script type="text/javascript">
Calendar.setup ({inputField : "start_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "start_time", singleClick : true, step : 1});
</script>

<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src="../../javascript/finance/fixed_assets/treeBusiness.js"></script>

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
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;"></div>
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

<div id="nseer2" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY><TR><TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"></TD>
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
 <div  id="nseer2_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;"></div>
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

<div id="nseer3" nseerDef="dragAble" style="background:#E8E8E8;position:absolute;width:600px;height:305px;top:130px;left:50px;display:none;z-index:1;">
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
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(20)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div id="nseer3_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;">

<div id="Tabs1">
<ul>
<li id="main_cur"><a href="javascript:changeTab('nseer5');"><span><%=demo.getLang("erp","全部科目")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer6');"><span><%=demo.getLang("erp","资产类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer7');"><span><%=demo.getLang("erp","负债类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer8');"><span><%=demo.getLang("erp","权益类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer9');"><span><%=demo.getLang("erp","成本类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer10');"><span><%=demo.getLang("erp","损益类")%></span></a></li>
</ul>
</div>
<div id="nseer5" style="display:block;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer6" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer7" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer8" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;">
<script>
var Nseer_tree8 = new Tree('Nseer_tree8');
 Nseer_tree8.setImagesPath('../../images/');
 Nseer_tree8.setTableName('finance_config_file_kind');
 Nseer_tree8.setCondition('kind_tag=\'3\'');
 Nseer_tree8.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag3');//xml文件路径
 Nseer_tree8.addRootNode('No0','<%=demo.getLang("erp","权益类")%>',false,'1',[]);
initMyTree(Nseer_tree8);
createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag3','finance_config_file_kind','treeButton');
</script>
</div>
<div id="nseer9" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;">
<script>
var Nseer_tree9 = new Tree('Nseer_tree9');
 Nseer_tree9.setImagesPath('../../images/');
 Nseer_tree9.setTableName('finance_config_file_kind');
 Nseer_tree9.setCondition('kind_tag=\'4\'');
 Nseer_tree9.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag4');//xml文件路径
 Nseer_tree9.addRootNode('No0','<%=demo.getLang("erp","成本类")%>',false,'1',[]);
initMyTree(Nseer_tree9);
createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag4','finance_config_file_kind','treeButton');
</script>
</div>
<div id="nseer10" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;">
<script>
var Nseer_tree10 = new Tree('Nseer_tree10');
 Nseer_tree10.setImagesPath('../../images/');
 Nseer_tree10.setTableName('finance_config_file_kind');
 Nseer_tree10.setCondition('kind_tag=\'5\'');
 Nseer_tree10.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag5');//xml文件路径
 Nseer_tree10.addRootNode('No0','<%=demo.getLang("erp","损益类")%>',false,'1',[]);
initMyTree(Nseer_tree10);
createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag5','finance_config_file_kind','treeButton');
</script>
</div>
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
function changeTab(nseer_d){
	for(var i=5;i<11;i++){
		if(document.getElementById('nseer'+i)!=null&&document.getElementById('nseer'+i)!='undefined'){
			document.getElementById('nseer'+i).style.display='none';
		}
	}
	var div_obj=document.getElementById('Tabs1');
	var lis=div_obj.getElementsByTagName('li');
	for(var i=0;i<lis.length;i++){lis[i].id='';}
	lis[parseInt(nseer_d.substring(5))-5].id='main_cur';
	document.getElementById(nseer_d).style.display='block';
	document.getElementById('Tabs1').blur();
}
function fa_config_kind(){
loadCover('nseer3');
document.getElementById('nseer1').style.display='none';
document.getElementById('nseer2').style.display='none';
document.getElementById('nseer4').style.display='none';
document.getElementById('nseer3').style.display='block';
}
</script>

<div id="nseer4" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
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
 <div id="nseer4_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;"></div>
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
var Nseer_tree1,Nseer_tree2,Nseer_tree4;
function showNseer1(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
  Nseer_tree1 = new Tree('Nseer_tree1');
  Nseer_tree1.setParent('nseer1_0');
  Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('finance_config_assets_kind');
 Nseer_tree1.setModuleName('../../xml/finance/fixed_assets/fa_subject_tree');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","固定资产分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/finance/fixed_assets/fa_subject_tree','finance_config_assets_kind','treeButton');
}
function showNseer2(){
 if(Nseer_tree2=='undefined'||typeof(Nseer_tree2)=='object'){return;}
 Nseer_tree2 = new Tree('Nseer_tree2');
  Nseer_tree2.setParent('nseer2_0');
  Nseer_tree2.setImagesPath('../../images/');
 Nseer_tree2.setTableName('finance_config_assets_fluctuationway');
 Nseer_tree2.setModuleName('../../xml/finance/fixed_assets/fa_fluctuationWay_tree');
 Nseer_tree2.addRootNode('No0','<%=demo.getLang("erp","固定资产增减方法")%>',false,'1',[]);
initMyTree(Nseer_tree2);
createButton('../../xml/finance/fixed_assets/fa_fluctuationWay_tree','finance_config_assets_fluctuationway','treeButton');
}
function showNseer4(){
 if(Nseer_tree4=='undefined'||typeof(Nseer_tree4)=='object'){return;}
 Nseer_tree4 = new Tree('Nseer_tree4');
 Nseer_tree4.setParent('nseer4_0');
 Nseer_tree4.setImagesPath('../../images/');
 Nseer_tree4.setTableName('hr_config_file_kind');
 Nseer_tree4.setModuleName('../../xml/finance/fixed_assets/fa_hr_tree');
 Nseer_tree4.addRootNode('No0','<%=demo.getLang("erp","全部机构")%>',false,'1',[]);
initMyTree(Nseer_tree4);
createButton('../../xml/finance/fixed_assets/fa_hr_tree','hr_config_file_kind','treeButton');
}
</script>
<script>
function open_trees(obj,obj1) {
	obj1.style.display ='none';
	loadCover(obj);
	if(Nseer_tree5=='undefined'||typeof(Nseer_tree5)!='object'){
		changeTab('nseer5');
	}else{
		document.getElementById(obj).style.display ='block';
	}
}

var Nseer_tree5,Nseer_tree6,Nseer_tree7,Nseer_tree8,Nseer_tree9,Nseer_tree10;
var timei2=0;

function showKind1(obj){
if(document.getElementById('showTree_div')) document.body.removeChild(document.getElementById('showTree_div'));
var u=window.location.href.split('://')[1].split('/');
var url='';
for(var i=0;i<u.length-3;i++){url+='../';}
		var dup_div=document.createElement('div');
		dup_div.id='showTree_div';
		dup_div.style.position='absolute';
		dup_div.style.width=18;
		dup_div.style.hidden=30;
		dup_div.style.paddingTop=4;
		dup_div.style.cursor='hand';
		dup_div.style.backgroundImage='url('+url+'images/finance/search.gif)';
		dup_div.onclick=function (){document.body.removeChild(dup_div); open_trees('nseer3',dup_div);};
		dup_div.style.display='block';
		document.body.appendChild(dup_div);
     	loadMirror(obj,dup_div.id);
     	Magnifying=obj.id;
if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
if(document.addEventListener) document.addEventListener('mousedown',closeResult,event);	
}

function addTree(s){
inWaiting();
if(timei2++ <s){setTimeout("addTree("+s+");",1000);}else{ 
	if(Nseer_tree5=='undefined'||typeof(Nseer_tree5)!='object'){
	Nseer_tree5 = new Tree('Nseer_tree5');
	Nseer_tree5.setParent('nseer5');
	Nseer_tree5.setImagesPath('../../images/');
 	Nseer_tree5.setTableName('finance_config_file_kind');
 	Nseer_tree5.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag0');//xml文件路径
 	Nseer_tree5.addRootNode('No0','<%=demo.getLang("erp","全部科目")%>',false,'1',[]);
	initMyTree(Nseer_tree5);
	createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag0','finance_config_file_kind','treeButton');
	document.getElementById('nseer3').style.display ='block';
	}
}
}
function changeTab(nseer_d){
	for(var i=5;i<11;i++){
		if(document.getElementById('nseer'+i)!=null&&document.getElementById('nseer'+i)!='undefined'){
			document.getElementById('nseer'+i).style.display='none';
		}
	}
	var div_obj=document.getElementById('Tabs1');
	var lis=div_obj.getElementsByTagName('li');
	for(var i=0;i<lis.length;i++){lis[i].id='';}
	lis[parseInt(nseer_d.substring(5))-5].id='main_cur';
	document.getElementById(nseer_d).style.display='block';
	document.getElementById('Tabs1').blur();
	if(nseer_d=='nseer5'){
		if(Nseer_tree5=='undefined'||typeof(Nseer_tree5)!='object'){
			addTree(1);
		}
	}
	if(nseer_d=='nseer6'){
		if(Nseer_tree6=='undefined'||typeof(Nseer_tree6)!='object'){
			Nseer_tree6 = new Tree('Nseer_tree6');
			Nseer_tree6.setParent('nseer6');
 			Nseer_tree6.setImagesPath('../../images/');
 			Nseer_tree6.setTableName('finance_config_file_kind');
 			Nseer_tree6.setCondition('kind_tag=\'1\'');
 			Nseer_tree6.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag1');//xml文件路径
 			Nseer_tree6.addRootNode('No0','<%=demo.getLang("erp","资产类")%>',false,'1',[]);
			initMyTree(Nseer_tree6);
			createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag1','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer7'){
		if(Nseer_tree7=='undefined'||typeof(Nseer_tree7)!='object'){
			Nseer_tree7 = new Tree('Nseer_tree7');
			Nseer_tree7.setParent('nseer7');
 			Nseer_tree7.setImagesPath('../../images/');
 			Nseer_tree7.setTableName('finance_config_file_kind');
 			Nseer_tree7.setCondition('kind_tag=\'2\'');
 			Nseer_tree7.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag2');//xml文件路径
 			Nseer_tree7.addRootNode('No0','<%=demo.getLang("erp","负债类")%>',false,'1',[]);
			initMyTree(Nseer_tree7);
			createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag2','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer8'){
		if(Nseer_tree8=='undefined'||typeof(Nseer_tree8)!='object'){
			Nseer_tree8 = new Tree('Nseer_tree8');
			Nseer_tree8.setParent('nseer8');
 			Nseer_tree8.setImagesPath('../../images/');
 			Nseer_tree8.setTableName('finance_config_file_kind');
 			Nseer_tree8.setCondition('kind_tag=\'3\'');
 			Nseer_tree8.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag3');//xml文件路径
 			Nseer_tree8.addRootNode('No0','<%=demo.getLang("erp","权益类")%>',false,'1',[]);
			initMyTree(Nseer_tree8);
			createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag3','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer9'){
		if(Nseer_tree9=='undefined'||typeof(Nseer_tree9)!='object'){
			Nseer_tree9 = new Tree('Nseer_tree9');
			Nseer_tree9.setParent('nseer9');
 			Nseer_tree9.setImagesPath('../../images/');
 			Nseer_tree9.setTableName('finance_config_file_kind');
 			Nseer_tree9.setCondition('kind_tag=\'4\'');
 			Nseer_tree9.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag4');//xml文件路径
 			Nseer_tree9.addRootNode('No0','<%=demo.getLang("erp","成本类")%>',false,'1',[]);
			initMyTree(Nseer_tree9);
			createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag4','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer10'){
		if(Nseer_tree10=='undefined'||typeof(Nseer_tree10)!='object'){
			Nseer_tree10 = new Tree('Nseer_tree10');
			Nseer_tree10.setParent('nseer10');
 			Nseer_tree10.setImagesPath('../../images/');
 			Nseer_tree10.setTableName('finance_config_file_kind');
 			Nseer_tree10.setCondition('kind_tag=\'5\'');
 			Nseer_tree10.setModuleName('../../xml/finance/fixed_assets/fa_kind_tree/tag5');//xml文件路径
 			Nseer_tree10.addRootNode('No0','<%=demo.getLang("erp","损益类")%>',false,'1',[]);
			initMyTree(Nseer_tree10);
			createButton('../../xml/finance/fixed_assets/fa_kind_tree/tag5','finance_config_file_kind','treeButton');
		}
	}
}
</script>