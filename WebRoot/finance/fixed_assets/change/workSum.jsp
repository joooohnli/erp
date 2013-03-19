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
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
String changer=(String)session.getAttribute("realeditorc");
%>
<script type="text/javascript" src="../../../javascript/finance/fixed_assets/change/workSum.js"></script>
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
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1" onClick="workSum_ok();"> <input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></div>
 </td>
 </tr>
</table>
<%
String time="";
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id="theObjTable">
 <tr style="background-image:url(../../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","工作总量调整")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","固定资产编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="file_id" style="width:49%" onkeyup="search_suggest1(this.id);"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","固定资产名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="file_name" style="width:49%" readonly/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开始使用日期")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="start_time" style="width:49%" readonly/></td>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","规格型号")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="specification" style="width:49%" readonly/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","变动前工作总量")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input id="cb_work_total" type="text" style="width:49%" readonly/></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","变动后工作总量")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input id="ca_work_total" type="text" style="width:49%" onfocus="not_choose(this);" onkeyup="decimalControl(this.id);"/></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" id="dynamic"><%=demo.getLang("erp","变动原因")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" id="change_reason" onfocus="not_choose();"></textarea>
</td>
<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","变动日期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="hidden" id="change_date" value="<%=time%>"><%=time%></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","变动人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37%"><input type="hidden" id="changer" value="<%=changer%>"><%=changer%></td>
 </tr>
</table>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
<div id="search_suggest" style="display: none; background: yellow; position:absolute; left:152px; top:102px; width: 140px; height: 94px; z-index: 10; filter:alpha(opacity=60); overflow-y: auto; overflow-x: hidden;"></div>