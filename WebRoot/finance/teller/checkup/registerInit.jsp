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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src='../../../javascript/include/div/divViewChange.js'></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="512";
try{
String select=request.getParameter("select1");
String file_id="";
String file_name="";
String sql="select type_name from finance_config_public_char where kind='账务初始时间'";
ResultSet rs=finance_db.executeQuery(sql);
	 String account_init_time="";
     if(rs.next()){
		 account_init_time=rs.getString("type_name"); 
	    }
if(select!=null){
StringTokenizer tokenTO = new StringTokenizer(select," "); 
	while(tokenTO.hasMoreTokens()) {
		file_id = tokenTO.nextToken();
		file_name = tokenTO.nextToken();
		}

%>
<div style="cursor: hand; display: none; z-index:1000; padding-top: 10px; left: 280px; width: 18px; position: absolute; background-image: url('../../../images/magnifier.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;" id='show_div' onclick="showWay(this.id)"></div>
<div style="cursor: hand; display: none; z-index:1000; padding-top: 10px; left: 280px; width: 18px; position: absolute; background-image: url('../../../images/magnifier.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;" id='show_div1' onclick="showWay1(this.id)"></div>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>	
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript" src="../../../javascript/winopen/winopens.js"></script>
<script src="../../../javascript/table/movetable.js"></script>
<script language="javascript" src="../../../javascript/finance/registerInit.js"></script>
<script language="javascript" src="../../../javascript/finance/dailyNoReach.js"></script>

<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","保存")%>" onClick="saveCurrentSum('<%=file_id%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="registerInit_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","科目")%>:<%=file_name%>(<%=file_id%>)</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">
 <span>
<%@include file="../../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","单位日记账")%></b></font></td>
 </tr>
</table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","调整前余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="last_balance_sum" name="last_balance_sum" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" onkeyup="realTimeCal();"></td>
 </tr> 
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","加:银行已收/企业未收")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="debit_sum" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" disabled></td>
 </tr>
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","减:银行已付/企业未付")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="loan_sum" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" disabled></td>
 </tr>
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE5%> class="TD_STYLE5" width="100%" colspan="2"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","对账单期初未达项")%>" onClick="notReach();"></td>
 </tr>
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","调整后余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="balance_sum" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" disabled></td>
 </tr>
</table>
<%@include file="../../include/paper_bottom.html"%>
</span> 
 </td>
 <td <%=TD_STYLE5%> class="TD_STYLE5">
 <span>
<%@include file="../../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","银行对账单")%></b></font></td>
 </tr>
</table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","调整前余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="last_balance_sum1" name="last_balance_sum1" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" onkeyup="realTimeCal1();"></td>
 </tr> 
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","加:企业已收/银行未收")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="debit_sum1" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" disabled></td>
 </tr>
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","减:企业已付/银行未付")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="loan_sum1" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" disabled></td>
 </tr>
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE5%> class="TD_STYLE5" width="100%" colspan="2"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","日记账期初未达项")%>" onclick="dailyNoReach();"></td>
 </tr>
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE1" width="40%"><%=demo.getLang("erp","调整后余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><input id="balance_sum1" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" disabled></td>
 </tr>
</table>
<%@include file="../../include/paper_bottom.html"%>
</span> 
</td>
 </tr>
</table>
</div>
<%
}else{%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","请选择银行科目！")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="registerInit_locate.jsp"></div></td>
 </tr>
 </table>
 </div>
<%}
sql="select debit_subtotal from finance_voucher where chain_id='"+file_id+"' and account_period='18'";
rs=finance_db.executeQuery(sql);
 String debit_subtotal="";
if(rs.next()){
 debit_subtotal=rs.getString("debit_subtotal");
}
sql="select debit_subtotal from finance_bill where file_id='"+file_id+"' and tag='1'";
rs=finance_db.executeQuery(sql);
String debit_subtotal1="";
if(rs.next()){
 debit_subtotal1=rs.getString("debit_subtotal");
}
%>

<div id="notReach" style="display:none;position:absolute;top:250px;left:100px;width:600;height:263px;z-index:3" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0" style="background:#FFFFFF;">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0ltop.gif"></TD>
      <TD width="100%" background="../../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../../images/bg_03.gif"></TD>
 <TD >
<div style="position:absolute;top:10px;width:100%;height:24px;background-image:url(../../../images/line.gif);">
<div style="font: bold 9pt;position:absolute;top:5px;left:3px;"><%=demo.getLang("erp","对账单明细")%>：
</div>
</div>
<div class="cssDiv3"  onclick="document.getElementById('notReach').style.display='none'; document.getElementById('show_div').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);" ></div>
<table width="100%" >
<tr height="25">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="addRow()" value="<%=demo.getLang("erp","添加")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteRow()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","保存")%>" onClick="send('<%=file_id%>','<%=account_init_time%>')"></div></td>
</tr>
<tr height="173">
<td height="173">
<div style="overflow-y: auto; overflow-x: hidden; height:173; width:575;">
<table  style="left:0;border: 1px solid;border-collapse: collapse;width: 558;" id="theObjTable">
 <tr style="background-image:url(/erp/images/line7.gif);" height=20 class="TR_STYLE2">
 <td bgcolor=#DEDBD6 class="TD_STYLE2" width="25%"><%=demo.getLang("erp","日期")%></td>
 <td bgcolor=#DEDBD6 class="TD_STYLE2" width="25%"><%=demo.getLang("erp","结算方式")%></td>
 <td bgcolor=#DEDBD6 class="TD_STYLE2" width="16%"><%=demo.getLang("erp","票号")%></td>
 <td bgcolor=#DEDBD6 class="TD_STYLE2" width="17%"><%=demo.getLang("erp","借方金额")%></td>
 <td bgcolor=#DEDBD6 class="TD_STYLE2" width="17%"><%=demo.getLang("erp","贷方金额")%></td>
 </tr>
<%
sql="select * from finance_bill where file_id='"+file_id+"' and tag='0' and settle_time<'"+account_init_time+"' and delete_tag='0' order by settle_time";
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
</script>
 
<%
   }
%>
</table>
</div>
</td>
</tr>
</table>
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

<div id="dailyNoReach" style="display:none;position:absolute;top:250px;left:100px;width:700;height:260px;z-index:3" nseerDef="dragAble">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0" style="background:#FFFFFF;">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0ltop.gif"></TD>
      <TD width="100%" background="../../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../../images/bg_03.gif"></TD>
 <TD >
<div style="position:absolute;top:10px;width:100%;height:24px;background-image:url(../../../images/line.gif);">
<div style="font: bold 9pt;position:absolute;top:5px;left:3px;"><%=demo.getLang("erp","对账单明细")%>：
</div>
</div>
<div class="cssDiv3"  onclick="document.getElementById('dailyNoReach').style.display='none'; document.getElementById('show_div1').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);" ></div>

<table width="100%" >
<tr height="25">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="addRow1()" value="<%=demo.getLang("erp","添加")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteMyRow1()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","保存")%>" onClick="send1('<%=file_id%>','<%=account_init_time%>')"></div></td>
</tr>
<tr height="173">
<td height="173">
<div style="overflow-y: auto; overflow-x: hidden; height:173; width:675;">
<table style="left:0;border: 1px solid;border-collapse: collapse;width: 658;" id="objtable">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","凭证日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","凭证类别")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","凭证号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","结算方式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","票号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","借方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","贷方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","票据日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><%=demo.getLang("erp","摘要")%></td>
 </tr>

<%
sql="select * from finance_voucher where chain_id='"+file_id+"' and account_period='19' and delete_tag='0' order by register_time,voucher_in_month_id";
  rs=finance_db.executeQuery(sql);
   while(rs.next()){
%>
<script>
addRow1();
var line=document.getElementById(row_id11);
var tag=line.getElementsByTagName('input');
tag[0].value='<%=rs.getString("register_time")%>'=='1800-01-01'?'':'<%=rs.getString("register_time")%>';
tag[1].value='<%=rs.getString("voucher_type")%>';
tag[2].value='<%=rs.getString("voucher_in_month_id")%>';
tag[3].value='<%=rs.getString("settle_way")%>';
tag[4].value='<%=rs.getString("attachment_id")%>';
tag[5].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>'==0?'':'<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>';
tag[6].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>'==0?'':'<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>';
tag[7].value='<%=rs.getString("attachment_time")%>'=='1800-01-01'?'':'<%=rs.getString("attachment_time")%>';
tag[8].value='<%=rs.getString("summary")%>';
tag[9].value='<%=rs.getString("id")%>';
</script>
<%
   }
%>
</table>
</div>
</td>
</tr>
</table>
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

<div id="way" class="nseer_div" nseerDef="dragAble" style="width:500px;height:250px;display:none;">
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
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","单位日记账")%></span></a></li>
</ul>
</div>

<div class="cssDiv8">
<table id="table1" class="nseer_table1" width="100%" border="0" cellspacing="1" cellpadding="1" >
<tr>
	<tr id="tr1">
		<td id="td2">
		</td>
		<td id="td2"><div align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","取消")%>" name="B1" width="20" onClick="document.getElementById('way').style.display='none';"></div></td>
	</tr>
<tr>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="50%"><%=demo.getLang("erp","请选择结算方式")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="50%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select1" style="width: 100%;" 
onChange="selectToB(this.value);">
 <option value="">&nbsp;</option>
<%
   sql = "select type_name from finance_config_public_char where kind='结算方式'" ;
	  rs = finance_db.executeQuery(sql) ;
while(rs.next()){%>
		<option value="<%=exchange.toHtml(rs.getString("type_name"))%>"><%=exchange.toHtml(rs.getString("type_name"))%></option>
<%
}
%>
  </select></td> 
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

<div id="way2" class="nseer_div" nseerDef="dragAble" style="width:500px;height:250px;display:none;">
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
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","银行对账单")%></span></a></li>
</ul>
</div>

<div class="cssDiv8">
<table id="table1" class="nseer_table1" width="100%" border="0" cellspacing="1" cellpadding="1" >
<tr>
	<tr id="tr1">
		<td id="td2">
		</td>
		<td id="td2"><div align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","取消")%>" name="B1" width="20" onClick="document.getElementById('way2').style.display='none';"></div></td>
	</tr>
<tr>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="50%"><%=demo.getLang("erp","请选择结算方式")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="50%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select1" style="width: 100%;" 
onChange="selectToB1(this.value);">
 <option value="">&nbsp;</option>
<%
   sql = "select type_name from finance_config_public_char where kind='结算方式'" ;
	  rs = finance_db.executeQuery(sql) ;
while(rs.next()){%>
		<option value="<%=exchange.toHtml(rs.getString("type_name"))%>"><%=exchange.toHtml(rs.getString("type_name"))%></option>
<%
}
%>
  </select></td> 
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
<script>
document.getElementById('last_balance_sum').value='<%=debit_subtotal%>';
document.getElementById('last_balance_sum1').value='<%=debit_subtotal1%>';
calculation();
calculation1();
</script>
<%}catch(Exception ex){ex.printStackTrace();}
%>
<style>
.note_div{
	position:absolute;top:-100px;right:50px;width:350px;
}
</style>
<div id="note_div" class="note_div"></div>
