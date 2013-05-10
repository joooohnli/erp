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
<jsp:useBean id="sum" scope="page" class="finance.Sum"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<script language="javascript" src="../../../javascript/finance/bill.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="100%";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String sql="";
ResultSet rs=null;
try{
String timea=request.getParameter("timea");
if(timea.equals("")) timea="1800-01-01";
String timeb=request.getParameter("timeb");
if(timeb.equals("")) timeb=formatter.format(now);
String select=request.getParameter("select1");
String file_id="";
String file_name="";
if(select!=null){
StringTokenizer tokenTO = new StringTokenizer(select," "); 
	while(tokenTO.hasMoreTokens()) {
		file_id = tokenTO.nextToken();
		file_name = tokenTO.nextToken();
		}

 sql="select debit_subtotal from finance_bill where tag='1' and file_id='"+file_id+"'";
      rs=finance_db.executeQuery(sql);
	 String start_balance_sum="0.00";
     if(rs.next()){
		 start_balance_sum=rs.getString("debit_subtotal"); 
	    }
 sql="select type_name from finance_config_public_char where kind='账务初始时间'";
      rs=finance_db.executeQuery(sql);
	 String account_init_time="";
     if(rs.next()){
		 account_init_time=rs.getString("type_name"); 
	    }
	 sql="select * from finance_bill where tag='0' and file_id='"+file_id+"' and settle_time>='"+timea+"' and settle_time<'"+account_init_time+"'";
	 rs=finance_db.executeQuery(sql);
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript" src="../../../javascript/winopen/winopens.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script> 
<script src="../../../javascript/table/movetable.js"></script>

<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="addRow()" value="<%=demo.getLang("erp","添加")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteRow()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","保存")%>" onClick="send('<%=file_id%>','<%=account_init_time%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="bill_locate.jsp"></div></td>
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
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","银行对账单")%></b></font></td>
 </tr>
 </table>

<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","结算方式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","票号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","借方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","贷方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","余额")%></td>
 </tr>
<%
int i=0;
while(rs.next()){
	i++;
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
tag[5].value='';
tag[6].value='<%=rs.getString("id")%>';

</script>
<%}
if(i!=0){
%>
<script>
balanceInit('<%=start_balance_sum%>','1');
</script>
<%
}
	double balance_sum=Double.parseDouble(start_balance_sum);
sql="select * from finance_bill where tag='0' and file_id='"+file_id+"' and settle_time<'"+timea+"' and settle_time>='"+account_init_time+"'";
	 rs=finance_db.executeQuery(sql);
	 while(rs.next()){
		 balance_sum+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
	 }
sql="select * from finance_bill where tag='0' and file_id='"+file_id+"' and settle_time>='"+timea+"' and settle_time<='"+timeb+"' and settle_time>='"+account_init_time+"'";
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
tag[5].value='';
tag[6].value='<%=rs.getString("id")%>';

</script>
<%}%>
<script>
recalculation('<%=balance_sum%>');
</script>
</table>
<%@include file="../../include/paper_bottom.html"%> 
</div>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="bill_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","请选择银行科目！")%></td>
 </tr>
 </table>
 </div>
<%}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>





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
<div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%>
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
finance_db.close();
}catch(Exception ex){ex.printStackTrace();}
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

<style>
.note_div{
	position:absolute;top:-100px;right:50px;width:350px;
}
</style>
<div id="note_div" class="note_div"></div>