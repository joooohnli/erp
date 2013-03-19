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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head.jsp"%>
<%counter count=new counter(application);%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>

<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/account-init.js"></script>
<style>
.table1 {font-size:10pt;width:350px;height:450px;}

.input{
BORDER-BOTTOM:  1px;
BORDER-left:  1px ;
BORDER-right:  1px ;
BORDER-top:  1px ;
width:100%;
}
</style>
<script type="text/javascript">
function send(){
var nyear=document.getElementById('date_start').value;
var year=document.getElementById('year').value;
var month=document.getElementById('month').value;
var period="";
for(var i=1;i<25;i++){
period+=document.getElementById(i).value+'☉';
}
window.location.href='../../../finance_config_account_init_registerTime_ok?nyear='+nyear+'&&year='+year+'&&month='+month+'&&period='+encodeURI(period);
}
</script>
<%
String sql="select * from finance_account_period";
ResultSet rs=finance_db.executeQuery(sql);
if(!rs.next()){

%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" onClick="send()"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE1%> style="border:1px solid" width="300">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="30%"><%=demo.getLang("erp","启用自然日期")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="nyear" onfocus="" id="date_start" style="width: 50%">(YYYY-MM-DD)</td>
</tr>
 </table>
 <p>&nbsp;</p>
<TABLE border=0 align="center" cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width=8 height=8><IMG height=8 src="../../../images/a_1.gif" 

            width=8 border=0></TD>
      <TD align=right background="../../../images/b_1.gif" height=8><IMG 

            height=8 src="../../../images/c_1.gif" width=34 border=0></TD>
      <TD width=8 height=8><IMG height=8 src="../../../images/d_1.gif" 

            width=8 border=0></TD>
    </TR>
    <TR>
      <TD vAlign=top width=8 background="../../../images/a_3.gif"><IMG 

            height=32 src="../../../images/a_2.gif" width=8 border=0></TD>
      <TD bgColor=#ffffff><table border="0" cellpadding="6" cellspacing="0">
        <tr>
          <td><table border=0 cellspacing=1 cellpadding=0 bgcolor=#000000 align=center id=theObjTable class="table1"><div><%=demo.getLang("erp","启用年度")%><input style="width:70px" name="year" id="year" readonly><input type=button onclick="change_year(1)"  readonly><input type=button onclick="change_year(2)"><%=demo.getLang("erp","月度")%><input style="width:70px" name="month" id="month" readonly><input type=button onclick="change_month(1)"><input type=button onclick="change_month(2)"></div>

<tr>
<td style="background:#ffffff"><%=demo.getLang("erp","期间")%></td>
<td style="background:#ffffff"><%=demo.getLang("erp","初始期间")%></td>
<td style="background:#ffffff"><%=demo.getLang("erp","结束期间")%></td>
</tr>
<tr>
<td style="background:#B5BEE1">01</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="1" onchange="time_change(1,this)" disabled></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="2" onchange="time_change(2,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">02</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="3" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="4" onchange="time_change(4,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">03</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="5" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="6" onchange="time_change(6,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">04</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="7" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="8" onchange="time_change(8,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">05</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="9" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="10" onchange="time_change(10,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">06</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="11" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="12" onchange="time_change(12,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">07</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="13" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="14" onchange="time_change(14,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">08</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="15" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="16" onchange="time_change(16,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">09</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="17" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="18" onchange="time_change(18,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">10</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="19" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="20" onchange="time_change(20,this)" onmousedown='focus_v(this)' disabled>
</td>
</tr>
<tr><td style="background:#B5BEE1">11</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="21" readonly></td>
<td style="background:#66CCFF"><input type="text" class="input" style="background:#66CCFF" name="period" id="22" onchange="time_change(22,this)" onmousedown='focus_v(this)'></td></tr>
<tr><td style="background:#B5BEE1">12</td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="23" readonly></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" name="period" id="24" readonly>
</td>
</tr>
</table></td>
        </tr>
        <tr>
          <td></td>
        </tr>
      </table></TD>
      <TD vAlign=bottom width=8 background="../../../images/d_2.gif"><IMG 

            height=24 src="../../../images/d_3.gif" width=8 border=0></TD>
    </TR>
    <TR>
      <TD width=8 height=8><IMG height=8 src="../../../images/a_4.gif" 

            width=8 border=0></TD>
      <TD align=left background="../../../images/c_4.gif" height=8><IMG 

            height=8 src="../../../images/b_4.gif" width=25 border=0></TD>
      <TD width=8 height=8><IMG height=8 src="../../../images/d_4.gif" 

            width=8 border=0></TD>
    </TR>
  </TBODY>
</TABLE>
</div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<script type="text/javascript">
window.onload=function (){
var now = new Date(); 
var yy = now.getFullYear();
var nn = now.getMonth(); 
var dd = now.getDate();
document.getElementById('year').value=yy;
document.getElementById('month').value=nn+1;
time_init(yy,nn+1);
time();
}

function time(){
for(var i=1;i<25;i++){
Calendar.setup ({inputField : i+"", ifFormat : "%Y-%m-%d", showsTime : false, button : i+"", singleClick : true, step : 1});
}
}
</script>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
</script>
<%}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","重新设置")%>" onclick=location="registerTime_change_reconfirm.jsp"></div></td>
 </tr>
 </table>
<%
String year="";
sql="select * from finance_config_public_char where kind='账务初始时间'";
rs=finance_db.executeQuery(sql);
if(rs.next()){
	year=rs.getString("type_name").substring(0,4);
%>
<table <%=TABLE_STYLE1%> style="border:1px solid" width="300">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="30%"><%=demo.getLang("erp","启用自然日期")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" value="<%=rs.getString("type_name")%>" style="width: 50%" readonly></td>
</tr>
 </table>
<%}%>
 <p>&nbsp;</p>
<TABLE border=0 align="center" cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width=8 height=8><IMG height=8 src="../../../images/a_1.gif" 

            width=8 border=0></TD>
      <TD align=right background="../../../images/b_1.gif" height=8><IMG 

            height=8 src="../../../images/c_1.gif" width=34 border=0></TD>
      <TD width=8 height=8><IMG height=8 src="../../../images/d_1.gif" 

            width=8 border=0></TD>
    </TR>
    <TR>
      <TD vAlign=top width=8 background="../../../images/a_3.gif"><IMG 

            height=32 src="../../../images/a_2.gif" width=8 border=0></TD>
      <TD bgColor=#ffffff><table border="0" cellpadding="6" cellspacing="0">
        <tr>
          <td><table border=0 cellspacing=1 cellpadding=0 bgcolor=#000000 align=center id=theObjTable class="table1"><div><%=demo.getLang("erp","启用年度")%><input style="width:70px" name="year" id="year" value="<%=year%>" readonly>&nbsp;<%=demo.getLang("erp","月度")%><input style="width:70px" name="month" id="month" readonly></div>

<tr>
<td style="background:#ffffff"><%=demo.getLang("erp","期间")%></td>
<td style="background:#ffffff"><%=demo.getLang("erp","初始期间")%></td>
<td style="background:#ffffff"><%=demo.getLang("erp","结束期间")%></td>
</tr>
<%
String disable="";
int init_period=12;
sql="select * from finance_account_period";
rs=finance_db.executeQuery(sql);
while(rs.next()){
	if(rs.getString("account_finished_tag").equals("1")){
		disable="disabled";
	}else{
		disable="readonly";
		init_period--;
	}
%>
<tr>
<td style="background:#B5BEE1"><%=rs.getString("account_period")%></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" value="<%=rs.getString("start_time")%>" <%=disable%>></td>
<td style="background:#33FFFF"><input type="text" class="input" style="background:#33FFFF" value="<%=rs.getString("end_time")%>" <%=disable%>>
</td>
</tr>
<%}
init_period++;
%>
</table></td>
        </tr>
        <tr>
          <td></td>
        </tr>
      </table></TD>
      <TD vAlign=bottom width=8 background="../../../images/d_2.gif"><IMG 

            height=24 src="../../../images/d_3.gif" width=8 border=0></TD>
    </TR>
    <TR>
      <TD width=8 height=8><IMG height=8 src="../../../images/a_4.gif" 

            width=8 border=0></TD>
      <TD align=left background="../../../images/c_4.gif" height=8><IMG 

            height=8 src="../../../images/b_4.gif" width=25 border=0></TD>
      <TD width=8 height=8><IMG height=8 src="../../../images/d_4.gif" 

            width=8 border=0></TD>
    </TR>
  </TBODY>
</TABLE>
</div>
 </div>
<script>
	document.getElementById('month').value='<%=init_period%>';
</script>
<%}
finance_db.close();
%>