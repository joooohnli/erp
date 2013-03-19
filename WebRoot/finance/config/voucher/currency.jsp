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

<%
try{
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","添加")%>" onClick="register();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="document.getElementById('delete_div').style.display='block';"></div></td>
</tr>
</table>
<% 
String sql = "select * from finance_config_currency";
String sql_search=sql;
%>
<%@include file="../../../include/list_page.jsp"%>
<%
ResultSet rs = finance_db.executeQuery(sql_search) ;
int k=1;
%>

<script type="text/javascript" src="../../../javascript/finance/config/currency.js"></script>
<script type='text/javascript' src='../../../javascript/include/div/divViewChange.js'></script>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","币种编号")%>'},
                       {name: '<%=demo.getLang("erp","币种名")%>'},
                       {name: '<%=demo.getLang("erp","币符")%>'},
                       {name: '<%=demo.getLang("erp","汇率")%>'},
                       {name: '<%=demo.getLang("erp","折算方式")%>'},
                       {name: '<%=demo.getLang("erp","小数位")%>'},
                       {name: '<%=demo.getLang("erp","调整时间")%>'},
                       {name: '<%=demo.getLang("erp","汇率调整")%>'}
                  ]
nseer_grid.column_width=[40,100,100,100,100,100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","折算方式")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String way_tag="";
if(rs.getString("way_tag").equals("0")){
way_tag=demo.getLang("erp","外币*汇率=本位币");
}else{
way_tag=demo.getLang("erp","外币/汇率=本位币");
}
%>
	['<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" id="<%="chec"+k%>" value="<%=rs.getString("id")%>">','<div><%=rs.getString("currency_id")%></div>','<%=exchange.toHtml(rs.getString("currency_name"))%>','<%=exchange.toHtml(rs.getString("currency_mark"))%>','<%=exchange.toHtml(rs.getString("currency_rate"))%>','<%=way_tag%>','<%=exchange.toHtml(rs.getString("currency_decimal"))%>','<%=exchange.toHtml(rs.getString("currency_time"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=change_currency("<%=rs.getString("currency_id")%>");><%=demo.getLang("erp","汇率调整")%></div>'],
<%
k++;
%>
</page:pages>
['']];

nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>

<page:updowntag num="<%=intRowCount%>" file="currency.jsp"/>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<input type="hidden" id="tag">
<div id="register_div" class="nseer_div" nseerDef="dragonly" style="width:500px;height:280px;display:none;z-index:1">


<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../../images/bg_03.gif"></TD>
 <TD>

<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%>
</div>
</div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>

<div style="width:100%;height:100%;background:#E8E8E8">
<div id="tabsF">
<ul>
<li id="current"><a href="javascript:void(0);"><span id="title_span" align="center"><%=demo.getLang("erp","添加")%></span></a></li>
</ul>
</div>

<div class="cssDiv8">
<table id="table1" class="nseer_table1" width="100%" border="0" cellspacing="1" cellpadding="1">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
	<td colspan="2"><div align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" name="B1" width="20" onClick="register_ok(this.value);">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","取消")%>" name="B1" width="20" onClick="Departure();"></div></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","币种编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%"><INPUT <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="currency_id" name="currency_id" type="text" style="width:100%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","币种名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="currency_name" name="currency_name" type="text" style="width:100%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","币符")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="currency_mark" name="currency_mark" type="text" style="width:100%"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","汇率")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="conversion_way" name="conversion_way" type="text" style="width:100%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","折算方式")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="way_tag" name="way_tag" style="width:100%">
	<option value="0"><%=demo.getLang("erp","外币*汇率=本位币")%></option>
	<option value="1"><%=demo.getLang("erp","外币/汇率=本位币")%></option>
</select>
 </td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","小数位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="currency_decimal" name="currency_decimal" type="text" style="width:100%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","调整时间")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="33%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="currency_time" name="currency_time" type="text" style="width:100%"></td>
</tr>
</table>
</div>
</div>

 </TD>
<TD  background="../../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>

<div id="delete_div" class="nseer_div" nseerDef="dragonly" style="width:500px;height:250px;display:none;">

<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../../images/bg_03.gif"></TD>
 <TD>

<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%>
</div>
</div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>

<div style="width:100%;height:100%;background:#E8E8E8">
<div id="tabsF">
<ul>
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","删除所选")%></span></a></li>
</ul>
</div>

<div class="cssDiv8">
<table id="table1" class="nseer_table1" width="100%" border="0" cellspacing="1" cellpadding="1" >
<tr>
	<tr id="tr1">
		<td id="td2">
		</td>
		<td id="td2"><div align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" name="B1" width="20" onClick="delete_currency();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","取消")%>" name="B1" width="20" onClick="document.getElementById('delete_div').style.display='none';"></div></td>
	</tr>
<tr>
<td><%=demo.getLang("erp","您确认删除所选吗？")%></td> 
</tr>
</table>
</div>
</div>

 </TD>
<TD  background="../../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<script type="text/javascript">
Calendar.setup ({inputField : "currency_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "currency_time", singleClick : true, step : 1});
</script>
<%finance_db.close();
}catch(Exception e){e.printStackTrace();}
%>