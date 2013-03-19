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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../../javascript/finance/config/report/profitLoss.js"></script>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<script language="javascript" src="../../../javascript/include/div/divViewChange.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","添加")%>" onClick="register();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="document.getElementById('reconfirm').style.display='block';"></div></td>
</tr>
</table>

<% 
String sql = "select * from finance_config_report_itemb order by id";
String sql_search=sql;
%>
<%@include file="../../../include/list_page.jsp"%>
<%
ResultSet rs = finance_db.executeQuery(sql_search) ;
int k=1;
%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","项目行次")%>'},
                       {name: '<%=demo.getLang("erp","项目名称")%>'}
                  ]
nseer_grid.column_width=[60,100,100];
nseer_grid.auto='<%=demo.getLang("erp","项目名称")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
	['<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=k%>" value="<%=rs.getString("id")%>">','<%=rs.getString("number_in_profit_table")%>','<%=exchange.toHtml(rs.getString("first_kind_name"))%>'],
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

<%finance_db.close();%>

<div id="register" class="nseer_div" nseerDef="dragAble" style="width:500px;height:250px;display:none;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>

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
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","添加项目")%></span></a></li>
</ul>
</div>
<div class="cssDiv8" >
<table id="table1" class="nseer_table1" width="100%" border="0" cellspacing="1" cellpadding="1" >
	<tr id="tr1">
		<td id="td2"></td>
		<td id="td2"><div align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" width="20" onClick="register_ok()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" name="B3" width="20" onClick="document.getElementById('register').style.display='none';"></div></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="30%"><%=demo.getLang("erp","项目行次")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:100%" type="text" id="number_in_profit_table" name="number_in_profit_table" value="" onkeyup="inputControl(this.id)"/></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="30%"><%=demo.getLang("erp","项目名称")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:100%" type="text" id="first_kind_name" name="first_kind_name" value=""/></td>
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

<div id="reconfirm" class="nseer_div" nseerDef="dragAble" style="width:500px;height:250px;display:none;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>

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
		<td id="td2"><div align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" name="B1" width="20" onClick="del(<%=k%>)">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","取消")%>" name="B1" width="20" onClick="document.getElementById('reconfirm').style.display='none';"></div></td>
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

<input type="hidden" id="tag">
<input type="hidden" id="id">
<page:updowntag num="<%=intRowCount%>" file="profitLoss.jsp"/>
