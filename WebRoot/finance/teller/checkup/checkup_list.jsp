<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,finance.AccountPeriodTime"%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="100%";
try{
	AccountPeriodTime apt=new AccountPeriodTime(); 
	String[] time=apt.getTime((String)session.getAttribute("unit_db_name"));
String timea=request.getParameter("timea");
if(timea.equals("")) timea=time[0];
String timeb=request.getParameter("timeb");
if(timeb.equals("")) timeb=time[1];
String select=request.getParameter("select1");
String file_id="";
String file_name="";

if(select!=null){
StringTokenizer tokenTO = new StringTokenizer(select," "); 
	while(tokenTO.hasMoreTokens()) {
		file_id = tokenTO.nextToken();
		file_name = tokenTO.nextToken();
		}

%>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>	
<script language="javascript" src="../../../javascript/winopen/winopens.js"></script>
<script language="javascript" src="../../../javascript/finance/checkup.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","对账")%>" onClick="checkupAuto('<%=file_id%>');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","反对账")%>" onClick="uncheckupSelect();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="checkup_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","科目")%>:<%=file_name%>(<%=file_id%>)</td>
 </tr>
 </table>
<%@include file="../../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td valign="top" align=center width="50%" >
<div style="overflow-x:scroll;overflow-y:hidden;width:410px;">
<table <%=TABLE_STYLE4%> width="700px">
 <tr <%=TR_STYLE1%> style="width:700px">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","单位日记账")%></b></font></td>
 </tr>
</table>
<table <%=TABLE_STYLE5%> width="700px" id="objtable">
 <tr <%=TR_STYLE2%> style="width:700px">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","凭证日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","结算方式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","票号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","借方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","贷方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","两清")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","票据日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","凭证号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="21%"><%=demo.getLang("erp","摘要")%></td>
 </tr>

<%
String sql="select * from finance_voucher where chain_id='"+file_id+"' and (account_period='19' or account_tag='1') and register_time>='"+timea+"' and register_time<='"+timeb+"' and delete_tag='0' order by register_time,voucher_in_month_id";
ResultSet rs=finance_db.executeQuery(sql);
   while(rs.next()){
%>
<script>
addRow1();
var line=document.getElementById(row_id11);
var tag=line.getElementsByTagName('input');
tag[0].value='<%=rs.getString("register_time")%>'=='1800-01-01'?'':'<%=rs.getString("register_time")%>';
tag[1].value='<%=rs.getString("settle_way")%>';
tag[2].value='<%=rs.getString("attachment_id")%>';
tag[3].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>'==0?'':'<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>';
tag[4].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>'==0?'':'<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>';
if(<%=rs.getString("checkup_tag")%>=='1') tag[5].value='√';
if(<%=rs.getString("checkup_tag")%>=='2') tag[5].value='A√';
tag[6].value='<%=rs.getString("attachment_time")%>'=='1800-01-01'?'':'<%=rs.getString("attachment_time")%>';
tag[7].value='<%=rs.getString("voucher_in_month_id")%>';
tag[8].value='<%=rs.getString("summary")%>';
tag[9].value='<%=rs.getString("id")%>';
</script>
<%
   }
%>
</table>
</div>
 </td>
 <td valign="top" align=center width="50%">
<div width="330px">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","银行对账单")%></b></font></td>
 </tr>
</table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE7" id="theObjTable">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="18%"><%=demo.getLang("erp","日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="18%"><%=demo.getLang("erp","结算方式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="17%"><%=demo.getLang("erp","票号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><%=demo.getLang("erp","借方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><%=demo.getLang("erp","贷方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","两清")%></td>
 </tr>
<%
sql="select * from finance_bill where file_id='"+file_id+"' and tag='0' and settle_time>='"+timea+"' and settle_time<='"+timeb+"' and delete_tag='0' order by settle_time";
  rs=finance_db.executeQuery(sql);
   while(rs.next()){
%>
<script>
addRow();
var line=document.getElementById(row_id1);
var tag=line.getElementsByTagName('input');
tag[0].value='<%=rs.getString("settle_time")%>'=='1800-01-01'?'':'<%=rs.getString("settle_time")%>';
tag[1].value='<%=rs.getString("way")%>';
tag[2].value='<%=rs.getString("attachment_id")%>';
tag[3].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>'==0?'':'<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>';
tag[4].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>'==0?'':'<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>';
tag[5].value='<%=rs.getString("id")%>';
if(<%=rs.getString("checkup_tag")%>=='1') tag[6].value='√';
if(<%=rs.getString("checkup_tag")%>=='2') tag[6].value='A√';
</script>
 
<%
   }
%>
</table>
</div>
</td>
 </tr>
</table>
</div>
<%@include file="../../include/paper_bottom.html"%>

<%

}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="checkup_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","请选择银行科目！")%></td>
 </tr>
 </table>
 </div>
<%}}catch(Exception ex){ex.printStackTrace();}
%>

<div id="query" class="nseer_div" nseerDef="dragAble" style="width:500px;height:250px;z-index:10;display:none;">
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
<div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%>
</div>
</div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>

<div style="width:100%;height:100%;background:#E8E8E8">
<div id="tabsF">
<ul>
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","银企对账")%></span></a></li>
</ul>
</div>

<div class="cssDiv8">
<table id="table1" class="nseer_table1" width="100%" border="0" cellspacing="1" cellpadding="1" >
<tr>
	<tr id="tr1">
		<td id="td2">
		<td colspan="3"><div align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" onClick='unCheckup();'>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","取消")%>" name="B1" width="20" onClick="document.getElementById('query').style.display='none';"></div></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
<td <%=TD_STYLE11%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp"," 从")%></td>
<td <%=TD_STYLE11%> class="TD_STYLE2" width="50%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="timea" onfocus="" id="date_start" type="text" style="width: 45%"><%=demo.getLang("erp","至")%><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="timeb" onfocus="" id="date_end" type="text" style="width: 45%"></td>
<td <%=TD_STYLE11%> class="TD_STYLE2" width="35%"><%=demo.getLang("erp","的")%><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select1" id="selected" style="width: 90%;">
 <option value="0"><%=demo.getLang("erp","全部")%></option>
  <option value="2"><%=demo.getLang("erp","自动勾对")%></option>
   <option value="1"><%=demo.getLang("erp","手工勾对")%></option>
</select></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="10%"><%=demo.getLang("erp","数据")%></td>
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

 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>