<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,java.text.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../top.jsp"%>

<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
%>
<%@include file="../include/head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/div/alert.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css">
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","注册客户信息")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
	  <tr><td>
<form id="mutiValidation" class="x-form" method="post" action="../../portal_design_register1_ok" onSubmit="return doValidate('../../xml/crm/crm_file.xml','mutiValidation')">
 <input name="select1" value="" type="hidden">
  <input name="select2" value="" type="hidden">
 <input name="select3" value="" type="hidden">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div id="loaddiv" style="display:none;border:1px solid red; height:20px;background-color: #FF0033;width:63%;float :left ;" ></div>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></div>
 </td>
 </tr>
</table>
<%
try{
String time="";
String sales_ID=(String)session.getAttribute("human_IDD");
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","客户名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input id="validator_dup" type="text" <%=INPUT_STYLE1%> style="width:80%" name="customer_name"><a href="javascript:ajax_validation('mutiValidation','validator_dup','crm_file','customer_name','../../vdf','customer_ID','../../crm/file/query.jsp',this)" onMouseOver="toolTip('<%=demo.getLang("erp","该功能用于检验客户信息是否重复！")%>',this)" onMouseOut="toolTip()"><img src="../../images/dup.gif" width="15" height="14" align="center" border="0"></a></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_address" style="width:80%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","客户分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="fileKind_chain" name="fileKind_chain" style="width:80%" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off"><input id="fileKind_chain_table" type="hidden" value="crm_config_file_kind"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type" style="width:45%">
  <%
  String sql4 = "select * from crm_config_public_char where kind='客户类型' and type_name!='合作伙伴' order by type_ID" ;
	 ResultSet rs4 = crm_db.executeQuery(sql4) ;
while(rs4.next()){%>

		<option value="<%=rs4.getString("type_name")%>"><%=rs4.getString("type_name")%></option>
<%}%>
  </select>
</tr>
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","优质级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="class1" style="width:45%">
  <%
  String sql5 = "select * from crm_config_public_char where kind='客户级别' order by type_ID" ;
	 ResultSet rs5 = crm_db.executeQuery(sql5) ;
while(rs5.next()){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%}%>
  </select>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","欠款额度")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="gather_sum_limit" style="width:45%">
  <%
  String sql6 = "select * from crm_config_public_double where kind='欠款' order by type_ID" ;
	 ResultSet rs6 = crm_db.executeQuery(sql6) ;
while(rs6.next()){%>
		<option value="<%=rs6.getDouble("type_value")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("type_value"))%></option>
<%}%>
  </select>
</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","回款期限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="gather_period_limit" style="width:45%">
  <%
  String sql7 = "select * from crm_config_public_double where kind='回款' order by type_ID" ;
	 ResultSet rs7 = crm_db.executeQuery(sql7) ;
while(rs7.next()){%>
		<option value="<%=exchange.toHtml(rs7.getString("type_value"))%>"><%=exchange.toHtml(rs7.getString("type_value"))%></option>
<%}%>
</select>
 </td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","联络期限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_period_limit" style="width:45%">
  <%
  String sql8 = "select * from crm_config_public_double where kind='联络' order by type_ID" ;
	 ResultSet rs8 = crm_db.executeQuery(sql8) ;
while(rs8.next()){%>
		<option value="<%=exchange.toHtml(rs8.getString("type_value"))%>"><%=exchange.toHtml(rs8.getString("type_value"))%></option>
<%}%>
  </select>
</tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户曾用名")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="used_customer_name" style="width:80%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开户银行")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_bank" style="width:45%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","银行账号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_account" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","网址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_web" style="width:45%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话1")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_tel1" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话2")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_tel2" style="width:45%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","传真")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_fax" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮政编码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="customer_postcode" style="width:45%"></td>
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","联系人信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","第一联系人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_department" style="width:45%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_duty" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_office_tel" style="width:45%"></td> 
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_mobile" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_home_tel" style="width:45%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person1_email" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_person1_sex" style="width:45%" style="width:45%" >
  <option value="<%=demo.getLang("erp","男")%>"><%=demo.getLang("erp","男")%></option>
  <option value="<%=demo.getLang("erp","女")%>"><%=demo.getLang("erp","女")%></option>
 </select>
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","第二联系人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_department" style="width:45%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_duty" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_office_tel" style="width:45%"></td>
</tr>
	
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_mobile" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_home_tel" style="width:45%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person2_email" style="width:45%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_person2_sex" style="width:45%">
  <option value="<%=demo.getLang("erp","男")%>"><%=demo.getLang("erp","男")%></option>
  <option value="<%=demo.getLang("erp","女")%>"><%=demo.getLang("erp","女")%></option>
  		  </select>
 
 </tr>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","动态信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","开票信息")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="invoice_info"></textarea>
</td>
 
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","最新需求")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="demand"></textarea>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%>&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","建档时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="register_time" type="hidden" width="100%" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td> 
 </tr>
<input type="hidden" name="sales_ID" value="<%=sales_ID%>">
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_file.xml"/>
<%String nickName="客户档案";%>
<%@include file="../../include/cDefineMou.jsp"%>
 
</table>
<%crm_db.close();
 }catch(Exception ex){
	 ex.printStackTrace();
 }
%>
<%
String uname=(String)session.getAttribute("realeditorc");
%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<input type="hidden" name="hidden_name" value="<%=uname%>">
</form>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>
<script type="text/javascript" src="../../javascript/include/nseer_cookie/importJs.js"></script>
<script type="text/javascript" src="../../javascript/crm/file/treeBusiness.js"></script>
<script type="text/javascript" src="../../javascript/crm/file/register.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divLocate.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/NseerTreeDB.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/kindCounter.js"></script>
<script type="text/javascript" src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../javascript/include/covers/cover.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divViewChange.js"></script>
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
 Nseer_tree1.setTableName('crm_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/crm/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/crm/file','crm_config_file_kind','treeButton');
}
</script>
