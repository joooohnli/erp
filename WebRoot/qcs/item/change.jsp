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
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divViewChange.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script type="text/javascript" src="../../javascript/include/div/nseerReadTableXml.js"></script>
<script language="javascript" src="../../javascript/qcs/item/register.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<!--  弹出 计数器层的样式 -->
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<%
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%try{
String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String check_time=formatter.format(now);
%>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String item_id=request.getParameter("item_id");
String sql="select item_name,analyse_method,id,register,register_id,register_time,remark,designer,default_basis,ready_basis,quality_method,quality_equipment,quality_value,sampling_standard,defect_class,attachment1,important from qcs_item where item_id='"+item_id+"'";
ResultSet rs=qcs_db.executeQuery(sql);
if(rs.next()){
%>
<body onload="locateSelectDiv()">
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data" action="../../qcs_item_change_ok?item_id=<%=item_id%>" onSubmit="return doValidate('../../xml/qcs/qcs_item.xml','mutiValidation')">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="QV_button" onclick="showQVDiv('QV_hidden','QV_table2',0,'change',event);" value="质检值" disabled>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value=<%=demo.getLang("erp","保存")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></div></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" id="item_id" name="item_id" onfocus="this.blur();"; value="<%=item_id%>"/></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","项目名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="item_name" name="item_name" type="text" width="100%" value="<%=rs.getString("item_name")%>"></td>
 </tr>
 <%
 if(rs.getString("analyse_method").equals("定性分析")){
 %>
 <script>
 document.getElementById('QV_button').disabled=false;
 </script>
 <%
 }
 %>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="designer" name="designer" type="text" width="100%" value="<%=rs.getString("designer")%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","分析方法")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input class="INPUT_STYLE3" id="analyse_method" name="analyse_method" type="text" value="<%=rs.getString("analyse_method")%>" readonly/><div class="select_div_r" id="analyse_method_div"  onclick="loadAjaxDiv('analyse_method','分析方法',event)"></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","首选质检依据")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="default_basis" name="default_basis" type="text" width="100%" value="<%=rs.getString("default_basis")%>"  onclick="loadAjaxDiv('default_basis','质检依据',event)" readonly/><div class="select_div_l" id="default_basis_div"  onclick="loadAjaxDiv('default_basis','质检依据',event)"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","备选质检依据")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input class="INPUT_STYLE3" id="ready_basis" name="ready_basis" type="text" value="<%=rs.getString("ready_basis")%>" onclick="loadAjaxDiv('ready_basis','质检依据',event)" readonly/><div class="select_div_r" id="ready_basis_div"  onclick="loadAjaxDiv('ready_basis','质检依据',event)"></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","质检方法")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_method" name="quality_method" type="text" width="100%" value="<%=rs.getString("quality_method")%>" onclick="loadAjaxDiv('quality_method','质检方法',event)" readonly/><div class="select_div_l" id="quality_method_div"  onclick="loadAjaxDiv('quality_method','质检方法',event)"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","质检设备")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input class="INPUT_STYLE3" id="quality_equipment" name="quality_equipment" type="text" value="<%=rs.getString("quality_equipment")%>" onclick="loadAjaxDiv('quality_equipment','质检设备',event)" readonly/><div class="select_div_r" id="quality_equipment_div"  onclick="loadAjaxDiv('quality_equipment','质检设备',event)"></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","抽样标准")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_standard" name="sampling_standard" type="text" width="100%" value="<%=rs.getString("sampling_standard")%>" onclick="loadAjaxDiv('sampling_standard','抽样标准',event)" readonly/><div class="select_div_l" id="sampling_standard_div"  onclick="loadAjaxDiv('sampling_standard','抽样标准',event)"></div></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","质量问题等级")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="defect_class" name="defect_class" type="text" width="100%" value="<%=rs.getString("defect_class")%>" onclick="loadAjaxDiv('defect_class','质量问题等级',event)" readonly/><div class="select_div_r" id="defect_class_div"  onclick="loadAjaxDiv('defect_class','质量问题等级',event)"></div></td>
</tr>
<%
String check_tag1="";
String check_tag2="";
if(rs.getString("important").equals("yes")){
check_tag1="checked";
}else{
check_tag2="checked";
}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","是否重点检查")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input <%=RADIO_STYLE1%> class="RADIO_STYLE1" id="important" name="important" type="radio" value="yes" <%=check_tag1%>/><%=demo.getLang("erp","是")%>&nbsp;<input <%=RADIO_STYLE1%> class="RADIO_STYLE1" id="important" name="important" type="radio" value="no" <%=check_tag2%>/><%=demo.getLang("erp","否")%>&nbsp;</td>
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
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=exchange.unURL(rs.getString("remark"))%></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=rs.getString("register")%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=rs.getString("register_time")%>" readonly></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=checker%>"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker_id" value="<%=checker_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="14%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="36%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="check_time" value="<%=check_time%>" readonly></td>
 </tr>
 <%=isPrint.hasOrNot3d(rs.getString("attachment1"),"附件&nbsp;&nbsp;&nbsp;","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,rs.getString("id"),"qcs_item")%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" id="QV_hidden" name="QV_hidden" value="<%=rs.getString("quality_value")%>">
</form>
</body>
<div id="result_div" style="position:absolute;display:none;background:yellow;height:80px; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;z-index:100"></div>
<div id="QV_div" class="nseer_div" nseerDef="dragAble" style="width:440px;height:280px;display:none;position:absolute;top:300px;left:200px" >
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"></IMG></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></IMG></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD> 
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%>
</div>
</div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>

<div style="width:100%;height:100%;background:#E8E8E8">
<div id="tabsF">
<ul>
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","质检值")%></span></a></li>
</ul>
</div>

<div class="cssDiv8">
 <table id="QV_table1" align="center" width="100%" height="100%" bgcolor="black" border="0px" cellspacing="1" cellpadding="0">
<tr>
<td style="background-color: #E7E7E7;padding-left :4px;" colspan="2">
<div style="overflow-y: auto; overflow-x: hidden; height: 176; background-color: #E8E8E8" >
<table id="QV_table2" width="375"  bgcolor="black"  border="0" cellspacing="0" cellpadding="0" align="left" >
  <tr>
          <td  id="QV" align="left" height="100%" style="background-color: #E7E7E7; background-repeat: repeat; background-attachment: scroll;  background-position: 0%">
           <%=demo.getLang("erp","质检值编码")%>/<%=demo.getLang("erp","质检值名称")%>
          </td>
  </tr>
   </table>
</div>
 </td>
</tr>
<tr>
<td bgcolor="#E7E7E7"><p align="right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","增加")%>" onClick="addRow('QV_table2',0,event);">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteSelect('QV_table2');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" width="20" onClick="setQV('QV_hidden','QV_table2')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" name="B3" width="20" onClick="document.getElementById('QV_div').style.display='none';">  
</p>
</td>
</tr>
</table>
</div>
<TD  background="../../images/bg_04.gif"></TD>
    
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></IMG></TD>
      <TD background="../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></IMG></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
</div-config>
<%}
qcs_db.close();
}catch(Exception ex){
ex.printStackTrace();
}%>