<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*,include.get_name_from_ID.AccountPeriod"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataFinanceTag"/>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db finance_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css">
<link rel="stylesheet" type="text/css" href="../../css/finance/tabs.css">
<script language="javascript" src="../../javascript/include/div/prompt.js"></script>
<script language="javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/finance/voucher.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_ajax.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_add.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_del.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_set.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_write.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_closeshow.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_focus.js"></script>
<body onpaste="return false;">
<div id="currency_div" style="position:absolute;top:200;left:50;width:540;height:150;display:none;" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD >
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","辅助项")%>
</div>
</div>
<div class="cssDiv3"  onClick="closeCurrency('0');"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<table style="width:100%;height:100%;background:#FFFFFF;">
<tr>
<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","币种")%><input style="width: 100; height: 20; border-style: none; border-bottom: 1px solid #000000;" id="d_currency_name"><input id="d_cash_tag" type="hidden">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","汇率")%><input style="width: 100; height: 20; border-style: none; border-bottom: 1px solid #000000;" id="d_currency_rate" name="TH5">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","金额")%><input type="text" onkeyup="" id="d_currency_amount" style="width: 104; height: 20; border-style: none; border-bottom: 1px solid #000000;">
</td>
</tr>
<tr height="20px">
<td><%=demo.getLang("erp","余额方向")%>：<input type="radio" id="d_sum_direct1" name="d_sum_direct" value="1" checked><%=demo.getLang("erp","借方")%>&nbsp;&nbsp;<input type="radio" id="d_sum_direct2" name="d_sum_direct" value="0"><%=demo.getLang("erp","贷方")%></td>
<td><p align="right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" width="20" onClick="closeCurrency('1');">&nbsp;&nbsp;    
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" name="B3" width="20" onClick="closeCurrency('0');">
</td>
</tr>
</table>
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
<%
AccountPeriod accountPeriod=new AccountPeriod();
String[] account_period=accountPeriod.getAccountPeriod((String)session.getAttribute("unit_db_name"));
String table_width="820";
String debit_sum="";
String loan_sum="";
String debit="";
String loan="";
String id="";
String sql1="";
String cash_item="";
String cash_itema="";
ResultSet rs1=null;
String voucher_in_month_id=request.getParameter("voucher_in_month_id") ;
String register_time=request.getParameter("register_time") ;
String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
String sql="";
ResultSet rs=null;
		if(strhead.indexOf(browercheck.IE)==-1){
try{
 sql="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"'";
  rs=finance_db.executeQuery(sql);
if(rs.next()){
	debit_sum=rs.getString("debit_sum").substring(0,rs.getString("debit_sum").indexOf("."))+rs.getString("debit_sum").substring(rs.getString("debit_sum").indexOf(".")+1);
	loan_sum=rs.getString("loan_sum").substring(0,rs.getString("loan_sum").indexOf("."))+rs.getString("loan_sum").substring(rs.getString("loan_sum").indexOf(".")+1);
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="register_new" name="mutiValidation" method="POST" action="../../finance_voucher_change_ok">
 <table <%=TABLE_STYLE8%> class="TABLE_STYLE8">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteRow(event)"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" onClick="send('<%=account_period[1]%>','<%=account_period[2]%>','1');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
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
 <td align="center" style="height:45px;"><input name="example"  type="text" value="<%=demo.getLang("erp","记帐凭证")%>" style="width:200px; height:35px; border-style: none; font : small-caps 600 20pt/20pt 宋体; border-bottom:  3px double #000000; text-align: center;"  readonly/></td>
 </tr>
</table> 
<style>
.div1{CURSOR: hand; display: none; padding-top: 7px; left: 130px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.div2{CURSOR: hand; display: none; padding-top: 7px; left: 420px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.input1{width: 100%; height: 98%; border-style: none; border-right:  1px solid #000000;}
.input2{width: 100%; height: 98%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000;  padding-right:1px; padding-top : 10px;}
.input3{width: 100%; height: 98%; border-style: none; border-bottom:  1px solid #000000;}
</style>

<div id="search_suggest" style="display: none; background: yellow; position:absolute; left:0px; top:80px; width: 150px; height: 100px; z-index: 10; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;"></div>
<div >
<table border="0" width="581" cellspacing="0" cellpadding="1" align="center">
<tr width="574" height="24" >
 <td width="55">
 <input name="voucher_type" type="text" id="subject" style="width: 57; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000; padding-right:1px; padding-top : 4px;" value="<%=rs.getString("voucher_type")%>"></td>
  <td width="30">
 <b><%=demo.getLang("erp","字第")%></b>
  <td width="55">&nbsp;&nbsp;<input name="voucher_id" type="hidden" id="voucher_id" style="width: 50; height: 23; text-align: Right;  border-style: none; border-bottom: 1px solid #000000; padding-right:1px; padding-top : 4px;" value="<%=rs.getString("voucher_in_month_ID")%>"><%=rs.getString("voucher_in_month_ID")%>
  <td width="5"><b><%=demo.getLang("erp","号")%></b>
  <td width="70">
  <td width="70">
 <b><%=demo.getLang("erp","制单时间")%>：</b>
  <td width="70">
 <input name="check_time" type="hidden" value="<%=time%>">
 <input name="register_time" type="hidden" id="date_start" value="<%=rs.getString("register_time")%>"><%=rs.getString("register_time")%>
  <td width="66">
  <td width="60">
 <b><%=demo.getLang("erp","附件数")%>：</b>
  <td width="72">
 <input name="attachment_amount" type="text" id="subject4" style="width: 68; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000; padding-right:1px; padding-top : 4px;" value="<%=rs.getString("attachment_amount")%>">
</tr>
</table>
  <table id="Outer" height="210" align="center" width="684" bgcolor=black  border=0 cellspacing=1 cellpadding=0 align=center>
     <tr width="581">
           <td height="30"  width="213" style="background-color: #D8D7CB;">
            <p align="center"><b><%=demo.getLang("erp","摘要")%>
            </td>    
           <td height="30"  width="422" style="background-color: #D8D7CB;" colspan="2">
            <p align="center"><b><%=demo.getLang("erp","财务科目")%>
            </td>    
           <td height="30"  width="155" style="background-color: #D8D7CB;">
            <p align="center"><b><%=demo.getLang("erp","借方金额")%>
            </td>    
           <td height="30"  width="155" style="background-color: #D8D7CB;">
            <p align="center"><b><%=demo.getLang("erp","贷方金额")%>
            </td>    
           <td height="30"  width="32" style="background-color: #D8D7CB;">
            </td>    
        </tr>
<tr width="682" height="112">
<td width="682" colspan="6" style="background:#FFFFFF">
<div style="overflow-y: auto; overflow-x: hidden; width: 683; height: 149; background:#ffffff">
<table id="tablefield" width="662"  bgcolor="black"  border=0 cellspacing=0 cellpadding=0 align="left">
<%
}
int i=0;
String sql6="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' order by id";
ResultSet rs6=finance_db.executeQuery(sql6);
while(rs6.next()){
	cash_item="";
	cash_itema="";
	sql1="select * from finance_cash_table where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"' and details_number='"+rs6.getString("details_number")+"'";
	rs1=finance_db1.executeQuery(sql1);
	if(rs1.next()){
		do{
		if(rs1.getDouble("debit")==0){
			cash_item="⊙□";
			cash_itema+=rs1.getString("number_in_cash_table")+","+rs1.getString("loan")+"□";
		}else{
			cash_itema="⊙□";
			cash_item+=rs1.getString("number_in_cash_table")+","+rs1.getString("debit")+"□";
		}
	}while(rs1.next());
	cash_item=rs6.getString("details_number")+"◇"+cash_item.substring(0,cash_item.length()-1);
	cash_itema=rs6.getString("details_number")+"◇"+cash_itema.substring(0,cash_itema.length()-1);
	}else{
		cash_item=rs6.getString("details_number")+"◇⊙";
		cash_itema=rs6.getString("details_number")+"◇⊙";
	}
%>
<script>
cash_item[<%=rs6.getInt("details_number")%>]='<%=cash_item%>';
cash_itema[<%=rs6.getInt("details_number")%>]='<%=cash_itema%>';
</script>
<%
	String file_name=rs6.getString("chain_id")+" "+rs6.getString("chain_name");
if(rs6.getDouble("debit_subtotal")!=0){	debit=rs6.getString("debit_subtotal").substring(0,rs6.getString("debit_subtotal").indexOf("."))+rs6.getString("debit_subtotal").substring(rs6.getString("debit_subtotal").indexOf(".")+1);
%>
<script>
debit_tag[<%=rs6.getInt("details_number")%>]='1';
</script>
<%
}else{
%>
<script>
debit_tag[<%=rs6.getInt("details_number")%>]='0';
</script>
<%
	debit="";
}
if(rs6.getDouble("loan_subtotal")!=0){ loan=rs6.getString("loan_subtotal").substring(0,rs6.getString("loan_subtotal").indexOf("."))+rs6.getString("loan_subtotal").substring(rs6.getString("loan_subtotal").indexOf(".")+1);
}else{
	loan="";
}
	if(rs6.getString("details_number").equals("0")){
			  double aa=rs6.getDouble("product_amount")*rs6.getDouble("product_price");
%>
<script>
qty[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_amount")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")%>,2);
netPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_price")%>,2);
tax_rate[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("tax_rate")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("tax_rate")%>,2);
sum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")*rs6.getDouble("product_price")%>,2);
currency[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("currency")%>';
currency_rate[<%=rs6.getInt("details_number")%>]=FormatNumberPoint(<%=rs6.getDouble("currency_rate")%>,2);
if(parseFloat(<%=rs6.getDouble("currency_rate")%>)!=0){
cSum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("debit_subtotal")%>)!=0?FormatNumberPoint(<%=rs6.getDouble("debit_subtotal")%>,2):FormatNumberPoint(<%=rs6.getDouble("loan_subtotal")%>,2);
cPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("currency_rate")%>)==0?'':FormatNumberPoint(cSum[<%=rs6.getInt("details_number")%>]/parseFloat(<%=rs6.getDouble("currency_rate")%>),2);
currency_tag[<%=rs6.getInt("details_number")%>]='1';
}else{
currency_tag[<%=rs6.getInt("details_number")%>]='0';
cSum[<%=rs6.getInt("details_number")%>]='';
cPrice[<%=rs6.getInt("details_number")%>]='';
}
department[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("department")%>';
project[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("project")%>';
attachment_id[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("attachment_id")%>';
settle_way[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_way")%>';
settle_time[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_time")%>'=='1800-01-01'?'':'<%=rs6.getString("settle_time")%>';
customer[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("customer")%>';
product[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("product")%>';
order[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("order_id")%>';
remark[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("remark")%>';
bank_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("bank_tag")%>';
cash_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_tag")%>';
if('<%=rs6.getString("cash_tag")%>'=='1') document.getElementById('d_cash_tag').value='1';
corr_stock_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("corr_stock_tag")%>';
cash_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_direct")%>';
sum_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("stock_direct")%>';//库存核算科目的借贷
cash_sum[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_sum")%>';

</script>
  <tr height="30" id="<%=rs6.getString("details_number")%>">
          <td width="210" height="30">
          <input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" class="input1" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_suggest('ccc<%=rs6.getString("details_number")%>')" autocomplete="off" value="<%=rs6.getString("summary")%>"><div class="div1" id="c_div<%=rs6.getString("details_number")%>" onclick="showSummary('ccc<%=rs6.getString("details_number")%>')"></div>
          </td>    
          <td width="410" height="30">
          <input name="file_name1" id="ddd<%=rs6.getString("details_number")%>" type="text" class="input1" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_file('ddd<%=rs6.getString("details_number")%>')" autocomplete="off"  ondblclick="dbclick(this.id)" value="<%=file_name%>"><div class="div2" id="d_div0" onclick="fill('ddd<%=rs6.getString("details_number")%>')"></div>
          </td>    
          <td width="155" height="30">
          <input name="debit" type="text" id="aaa<%=rs6.getString("details_number")%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" value="<%=debit%>">
          </td>
          <td width="155" height="30">
          <input name="loan" type="text" id="bbb<%=rs6.getString("details_number")%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Excessively_firefox(this.id,event)" onFocus="fo(this.id)" value="<%=loan%>">
           </td>
  </tr>
<%
	}else{
%>
<script>
qty[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_amount")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")%>,2);
netPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_price")%>,2);
tax_rate[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("tax_rate")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("tax_rate")%>,2);
sum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")*rs6.getDouble("product_price")%>,2);
currency[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("currency")%>';
currency_rate[<%=rs6.getInt("details_number")%>]=FormatNumberPoint(<%=rs6.getDouble("currency_rate")%>,2);
if(parseFloat(<%=rs6.getDouble("currency_rate")%>)!=0){
cSum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("debit_subtotal")%>)!=0?FormatNumberPoint(<%=rs6.getDouble("debit_subtotal")%>,2):FormatNumberPoint(<%=rs6.getDouble("loan_subtotal")%>,2);
cPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("currency_rate")%>)==0?'':FormatNumberPoint(cSum[<%=rs6.getInt("details_number")%>]/parseFloat(<%=rs6.getDouble("currency_rate")%>),2);
currency_tag[<%=rs6.getInt("details_number")%>]='1';
}else{
currency_tag[<%=rs6.getInt("details_number")%>]='0';
cSum[<%=rs6.getInt("details_number")%>]='';
cPrice[<%=rs6.getInt("details_number")%>]='';
}
department[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("department")%>';
project[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("project")%>';
attachment_id[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("attachment_id")%>';
settle_way[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_way")%>';
settle_time[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_time")%>'=='1800-01-01'?'':'<%=rs6.getString("settle_time")%>';
customer[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("customer")%>';
product[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("product")%>';
order[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("order_id")%>';
remark[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("remark")%>';
bank_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("bank_tag")%>';
cash_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_tag")%>';
if('<%=rs6.getString("cash_tag")%>'=='1') document.getElementById('d_cash_tag').value='1';
corr_stock_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("corr_stock_tag")%>';
cash_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_direct")%>';
sum_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("stock_direct")%>';
cash_sum[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_sum")%>';
</script>
<tr height="30" id="<%=rs6.getString("details_number")%>">
<td>
<input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000;border-bottom:  1px solid #000000;" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rs6.getString("summary")%>"><div style="CURSOR: hand; display:none; padding-top: 7px; left:130px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;" id='c_div<%=rs6.getString("details_number")%>' onclick="showSummary('ccc<%=rs6.getString("details_number")%>')"></div>
</td>
<td>
<input name="file_name1" id="ddd<%=rs6.getString("details_number")%>" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000; border-bottom:  1px solid #000000;" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_file(this.id)" autocomplete="off" ondblclick="dbclick(this.id)" value="<%=file_name%>"><div style="CURSOR: hand; display:none; padding-top: 7px;left:420px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;" id='d_div<%=rs6.getString("details_number")%>' onclick="fill('ddd<%=rs6.getString("details_number")%>')"></div>
</td>
<td>
<input name="debit" id="aaa<%=rs6.getString("details_number")%>" type="text" maxlength="15" onkeyup="match(this.id)" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000; padding-top : 10px; padding-right : 1px;" onkeydown="Clear(this.id,event)" autocomplete="off" onFocus="fo(this.id)" value="<%=debit%>">
</td>
<td>
<input name="loan" id="bbb<%=rs6.getString("details_number")%>" type="text" maxlength="15" onkeyup="match(this.id)" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000; padding-top : 10px; padding-right : 1px;" onkeydown="Excessively_firefox(this.id,event)" value="<%=loan%>" autocomplete="off" onFocus="fo(this.id)">
</td>
  </tr>
<%
}
i++;	  
}
if(i<5){
	for(int j=i;j<5;j++){
%>
<tr height="30" id="<%=j%>">
<td>
<input name="summary" id="ccc<%=j%>" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000;border-bottom:  1px solid #000000;" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_suggest(this.id)" autocomplete="off"><div style="CURSOR: hand; display:none; padding-top: 7px; left:130px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;" id='c_div<%=j%>' onclick="showSummary('ccc<%=j%>')"></div>
</td>
<td>
<input name="file_name1" id="ddd<%=j%>" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000; border-bottom:  1px solid #000000;" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_file(this.id)" autocomplete="off" ondblclick="dbclick(this.id)"><div style="CURSOR: hand; display:none; padding-top: 7px;left:420px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;" id='d_div<%=j%>' onclick="fill('ddd<%=j%>')"></div>
</td>
<td>
<input name="debit" id="aaa<%=j%>" type="text" maxlength="15" onkeyup="match(this.id)" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000; padding-right:1px; padding-top : 10px;" onkeydown="Clear(this.id,event)" autocomplete="off" onFocus="fo(this.id)">
</td>
<td>
<input name="loan" id="bbb<%=j%>" type="text" maxlength="15" onkeyup="match(this.id)" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000; padding-right:1px; padding-top : 10px;" onkeydown="Excessively_firefox(this.id,event)" autocomplete="off" onFocus="fo(this.id)">
</td>
  </tr>
 <%}}%>
 </table>
</div>
 </td>
<tr width="582" height="30">
           <td  width="187" height="30" style="background-color: #ffffff;"></td>        
           <td  width="286" height="30" style="background-color: #ffffff;"></td>        
           <td  width="41" height="30" style="background-color: #D8D7CB;"><p align="right"><b><%=demo.getLang("erp","合计")%></td>
           <td width="155" height="30"><input name="debit_sum" type="text" id="aOuter" maxlength="15" style="width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; padding-top : 10px;" readonly value="<%=debit_sum%>"/></td>
		   <td width="155" height="30"><input name="loan_sum" type="text" id="bOuter" maxlength="15" style="width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; padding-top : 10px;" readonly value="<%=loan_sum%>"/></td>
		   <td height="30"  width="34" style="background-color: #D8D7CB;" ></td>
        </tr>
       <tr height="5" style="background: #D8D7CB" ><td width="597" height="5" colspan="6" style="background: #D8D7CB"></td>
       </tr>      
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6"><font size="2"><%=demo.getLang("erp","数量")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="qty" readonly/ name="TH5">*<%=demo.getLang("erp","单价")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="netPrice" readonly/ name="TH6">＝<input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="sum" name="T56" readonly><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4"> 
        |&nbsp;<%=demo.getLang("erp","外币")%><input class="textbox" id="currency" onkeyup="writeAssis()" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" name="TH7"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">&nbsp;<input class="textbox"  style="width: 65; height: 20; border-style:none; border-bottom: 1px solid #000000" onkeyup="writeAssis()" id="cPrice" name="TH8">*<%=demo.getLang("erp","汇率")%><input class="textbox" style="width: 55; height: 20; border-style:none; border-bottom: 1px solid #000000" id="currency_rate" onkeyup="writeAssis()" name="TH9">=<input class="textbox" style="width: 90; height: 20; border-style:none; border-bottom: 1px solid #000000" readonly id="cSum" name="T89"></font></td>         
        </tr>    
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6" ><font size="2"><%=demo.getLang("erp","部门")%><input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="department" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        <%=demo.getLang("erp","项目")%><input class="textbox" style="width: 100; height: 20;border-style:none; border-bottom: 1px solid #000000" id="project" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","结算方式")%>&nbsp;<input class="textbox" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_way" onkeyup="writeAssis()" name="TH5" readonly/><%=demo.getLang("erp","单号/票号")%><input class="textbox" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" id="attachment_id" onkeyup="writeAssis()" name="TH5" readonly/><%=demo.getLang("erp","票据日期")%><input class="textbox" style="width: 76; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_time" onkeyup="writeAssis()" name="TH5" readonly/></font></td>      
        </tr>
        <tr style="background:#FFFFFF">
        <td colspan="6"><font size="2"><%=demo.getLang("erp","往来单位")%><input class="textbox" style="width: 136; height: 20; border-style:none; border-bottom: 1px solid #000000" id="customer" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","货品")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="product" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        | <%=demo.getLang("erp","订单")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="order" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4"> <%=demo.getLang("erp","备注")%><input class="textbox" style="width: 130; height: 20; border-style:none; border-bottom: 1px solid #000000" id="remark" onkeyup="writeAssis()" name="TH5"> </font></td>
<input type="hidden" id="page_bank_tag">
<input type="hidden" id="page_cash_tag">
<input type="hidden" id="page_corr_stock_tag">
<input type="hidden" id="cash_direct">
<input type="hidden" id="stock_direct">
<input type="hidden" id="cash_sum">
<input type="hidden" id="page_currency_tag">
        </tr>
 </table>
<%
sql="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"'";
rs=finance_db.executeQuery(sql);
if(rs.next()){			
%>
 <table width="680" border="0" align="center">
 <tr><td height="20"><%=demo.getLang("erp","会计主管")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accountant" name="accountant" value="<%=rs.getString("accountant")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","记帐")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accounter" name="accounter" value="<%=rs.getString("accounter")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","出纳")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="cashier" name="cashier" value="<%=rs.getString("cashier")%>">
</td>
 <td height="20"><%=demo.getLang("erp","审核")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="checker" name="checker" value="<%=checker%>">
</td>
 <td height="20"><%=demo.getLang("erp","制单")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="register" name="register" value="<%=rs.getString("register")%>" onFocus="this.blur()"></td>
 </tr>
 </table>
<input type="hidden" id="accountant_id" name="accountant_id" value="<%=rs.getString("accountant_id")%>">
<input type="hidden" id="accounter_id" name="accounter_id" value="<%=rs.getString("accounter_id")%>">
<input type="hidden" id="cashier_id" name="cashier_id" value="<%=rs.getString("cashier_id")%>">
<input type="hidden" id="checker_id" name="checker_id" value="<%=checker_id%>">
<input type="hidden" id="register_id" name="register_id" value="<%=rs.getString("register_id")%>">
<%}%>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
catch (Exception ex){
	ex.printStackTrace();
}
}else{
try{
  sql="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"'";
 rs=finance_db.executeQuery(sql);
if(rs.next()){
	debit_sum=rs.getString("debit_sum").substring(0,rs.getString("debit_sum").indexOf("."))+rs.getString("debit_sum").substring(rs.getString("debit_sum").indexOf(".")+1);
	loan_sum=rs.getString("loan_sum").substring(0,rs.getString("loan_sum").indexOf("."))+rs.getString("loan_sum").substring(rs.getString("loan_sum").indexOf(".")+1);
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="register_new" name="mutiValidation" method="POST" action="../../finance_voucher_change_ok">
 <table <%=TABLE_STYLE8%> class="TABLE_STYLE8">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteRow(event)"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" onClick="send('<%=account_period[1]%>','<%=account_period[2]%>','1');"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
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
 <td align="center"><input name="example"  type="text" value="<%=demo.getLang("erp","记帐凭证")%>" style="width:200px; height:35px; border-style: none; font : small-caps 600 20pts/20pts 宋体; border-bottom:  3px double #000000; text-align: center;" readonly/></td>
 </tr>
</table> 
<style>
.div1{CURSOR: hand; display: none; padding-top: 7px; left: 130px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.div2{CURSOR: hand; display: none; padding-top: 7px; left: 420px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.input1{width: 150px; height: 100%; border-style: none; border-right:  0px solid #000000;}
.input3{width: 291px; height: 100%; border-style: none; border-right:  0px solid #000000;}
.input2{width: 110px; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  0px solid #000000;  padding-right:1px;padding-top : 10px;}
.input4{width: 110px; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  0px solid #000000; padding-right:1px;padding-top : 10px;}
</style>

<div id="search_suggest" style="display: none; background: yellow; position:absolute; left:0px; top:80px; width: 150px; height: 100px; z-index: 10; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;"></div>
<div >
<table border="0" width="581" cellspacing="0" cellpadding="1" align="center">
<tr width="574" height="30" >
 <td width="55">
 <input name="voucher_type" type="text" id="subject" style="width: 57; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000; padding-right:1px;padding-top : 4px;" value="<%=rs.getString("voucher_type")%>"></td>
  <td width="30">
 <b><%=demo.getLang("erp","字第")%></b>
  <td width="55">&nbsp;&nbsp;<input name="voucher_id" type="hidden" id="voucher_id" style="width: 50; height: 23; text-align: Right;  border-style: none; border-bottom: 1px solid #000000; padding-right:1px;padding-top : 4px;" value="<%=rs.getString("voucher_in_month_ID")%>"><%=rs.getString("voucher_in_month_ID")%>
  <td width="5"><b><%=demo.getLang("erp","号")%></b>
  <td width="70">
  <td width="70">
 <b><%=demo.getLang("erp","制单时间")%>：</b>
  <td width="70">
 <input name="check_time" type="hidden" value="<%=time%>">
 <input name="register_time" type="hidden" id="date_start" value="<%=rs.getString("register_time")%>"><%=rs.getString("register_time")%>
  <td width="66">
  <td width="60">
 <b><%=demo.getLang("erp","附件数")%>：</b>
  <td width="72">
 <input name="attachment_amount" type="text" id="subject4" style="width: 68; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000; padding-right:1px;padding-top : 4px;" value="<%=rs.getString("attachment_amount")%>">
</tr>
</table>
  <table id="Outer" height="210" align="center" width="682" bgcolor=black  border=0 cellspacing=1 cellpadding=0 align=center>
     <tr width="581">
           <td height="30"  width="169" style="background-color: #D8D7CB;">
            <p align="center"><b><%=demo.getLang("erp","摘要")%>
            </td>    
           <td height="30"  width="297" style="background-color: #D8D7CB;" colspan="2">
            <p align="center"><b><%=demo.getLang("erp","财务科目")%>
            </td>    
           <td height="30"  width="109" style="background-color: #D8D7CB;">
            <p align="center"><b><%=demo.getLang("erp","借方金额")%>
            </td>    
           <td height="30"  width="109" style="background-color: #D8D7CB;">
            <p align="center"><b><%=demo.getLang("erp","贷方金额")%>
            </td>    
           <td height="30"  width="18" style="background-color: #D8D7CB;">
            </td>    
        </tr>
<tr width="589" height="112">
<td width="589" colspan="6" style="background:#FFFFFF">
<div style="overflow-y: auto; overflow-x: hidden; width: 680; height: 150; background:#ffffff">

<table id="tablefield" width="662"  bgcolor=black  border=0 cellspacing=0 cellpadding=0 align=left>
<%
}
int i=0;
String sql6="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' order by id";
ResultSet rs6=finance_db.executeQuery(sql6);
while(rs6.next()){
	cash_item="";
	cash_itema="";
	sql1="select * from finance_cash_table where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"' and details_number='"+rs6.getString("details_number")+"'";
	rs1=finance_db1.executeQuery(sql1);
	if(rs1.next()){
		do{
		if(rs1.getDouble("debit")==0){
			cash_item="⊙□";
			cash_itema+=rs1.getString("number_in_cash_table")+","+rs1.getString("loan")+"□";
		}else{
			cash_itema="⊙□";
			cash_item+=rs1.getString("number_in_cash_table")+","+rs1.getString("debit")+"□";
		}
	}while(rs1.next());
	cash_item=rs6.getString("details_number")+"◇"+cash_item.substring(0,cash_item.length()-1);
	cash_itema=rs6.getString("details_number")+"◇"+cash_itema.substring(0,cash_itema.length()-1);
	}else{
		cash_item=rs6.getString("details_number")+"◇⊙";
		cash_itema=rs6.getString("details_number")+"◇⊙";
	}
%>
<script>
cash_item[<%=rs6.getInt("details_number")%>]='<%=cash_item%>';
cash_itema[<%=rs6.getInt("details_number")%>]='<%=cash_itema%>';
</script>
<%
	String file_name=rs6.getString("chain_id")+" "+rs6.getString("chain_name");
if(rs6.getDouble("debit_subtotal")!=0){	debit=rs6.getString("debit_subtotal").substring(0,rs6.getString("debit_subtotal").indexOf("."))+rs6.getString("debit_subtotal").substring(rs6.getString("debit_subtotal").indexOf(".")+1);
%>
<script>
debit_tag[<%=rs6.getInt("details_number")%>]='1';
</script>
<%
}else{
%>
<script>
debit_tag[<%=rs6.getInt("details_number")%>]='0';
</script>
<%
	debit="";
}
if(rs6.getDouble("loan_subtotal")!=0){ loan=rs6.getString("loan_subtotal").substring(0,rs6.getString("loan_subtotal").indexOf("."))+rs6.getString("loan_subtotal").substring(rs6.getString("loan_subtotal").indexOf(".")+1);
}else{
	loan="";
}
	if(rs6.getString("details_number").equals("0")){
			  double aa=rs6.getDouble("product_amount")*rs6.getDouble("product_price");
%>
<script>
qty[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_amount")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")%>,2);
netPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_price")%>,2);
tax_rate[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("tax_rate")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("tax_rate")%>,2);
sum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")*rs6.getDouble("product_price")%>,2);
currency[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("currency")%>';
currency_rate[<%=rs6.getInt("details_number")%>]=FormatNumberPoint(<%=rs6.getDouble("currency_rate")%>,2);
if(parseFloat(<%=rs6.getDouble("currency_rate")%>)!=0){
cSum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("debit_subtotal")%>)!=0?FormatNumberPoint(<%=rs6.getDouble("debit_subtotal")%>,2):FormatNumberPoint(<%=rs6.getDouble("loan_subtotal")%>,2);
cPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("currency_rate")%>)==0?'':FormatNumberPoint(cSum[<%=rs6.getInt("details_number")%>]/parseFloat(<%=rs6.getDouble("currency_rate")%>),2);
currency_tag[<%=rs6.getInt("details_number")%>]='1';
}else{
currency_tag[<%=rs6.getInt("details_number")%>]='0';
cSum[<%=rs6.getInt("details_number")%>]='';
cPrice[<%=rs6.getInt("details_number")%>]='';
}
department[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("department")%>';
project[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("project")%>';
attachment_id[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("attachment_id")%>';
settle_way[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_way")%>';
settle_time[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_time")%>'=='1800-01-01'?'':'<%=rs6.getString("settle_time")%>';
customer[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("customer")%>';
product[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("product")%>';
order[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("order_id")%>';
remark[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("remark")%>';
bank_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("bank_tag")%>';
cash_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_tag")%>';
if('<%=rs6.getString("cash_tag")%>'=='1') document.getElementById('d_cash_tag').value='1';
corr_stock_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("corr_stock_tag")%>';
cash_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_direct")%>';
sum_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("stock_direct")%>';
cash_sum[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_sum")%>';
</script>
  <tr height="30" id="<%=rs6.getString("details_number")%>">
          <td width="310" style="background:#FFFFFF;border-right:  1px solid #000000;">
          <input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" class="input1" onFocus="fo(this.id)" onkeyup="search_suggest('ccc<%=rs6.getString("details_number")%>')" autocomplete="off" value="<%=rs6.getString("summary")%>"><div class="div1" id="c_div<%=rs6.getString("details_number")%>" onclick="showSummary('ccc<%=rs6.getString("details_number")%>')"></div>
          </td>    
          <td width="360" style="background:#FFFFFF;border-right:  1px solid #000000;">
          <input name="file_name1" id="ddd<%=rs6.getString("details_number")%>" type="text" class="input3" onFocus="fo(this.id)" ondblclick="dbclick(this.id)" onkeyup="search_file('ddd<%=rs6.getString("details_number")%>')" autocomplete="off" value="<%=file_name%>"><div class="div2" id="d_div<%=rs6.getString("details_number")%>" onclick="fill('ddd<%=rs6.getString("details_number")%>')"></div>
          </td>    
          <td width="165" style="background:#FFFFFF; border-right:  1px solid #000000; background-image: url('../../images/finance/voucher.bmp')">
          <input name="debit" type="text" id="aaa<%=rs6.getString("details_number")%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" value="<%=debit%>">
          </td>
          <td width="165"style="background:#FFFFFF; border-right:  1px solid #000000; background-image: url('../../images/finance/voucher.bmp')">
          <input name="loan" type="text" id="bbb<%=rs6.getString("details_number")%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Excessively(this.id,event)" onFocus="fo(this.id)" value="<%=loan%>">
           </td>
  </tr>
<%
	}else{
%>
<script>
qty[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_amount")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")%>,2);
netPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_price")%>,2);
tax_rate[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("tax_rate")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("tax_rate")%>,2);
sum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("product_price")%>)==0?'':FormatNumberPoint(<%=rs6.getDouble("product_amount")*rs6.getDouble("product_price")%>,2);
currency[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("currency")%>';
currency_rate[<%=rs6.getInt("details_number")%>]=FormatNumberPoint(<%=rs6.getDouble("currency_rate")%>,2);
if(parseFloat(<%=rs6.getDouble("currency_rate")%>)!=0){
cSum[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("debit_subtotal")%>)!=0?FormatNumberPoint(<%=rs6.getDouble("debit_subtotal")%>,2):FormatNumberPoint(<%=rs6.getDouble("loan_subtotal")%>,2);
cPrice[<%=rs6.getInt("details_number")%>]=parseFloat(<%=rs6.getDouble("currency_rate")%>)==0?'':FormatNumberPoint(cSum[<%=rs6.getInt("details_number")%>]/parseFloat(<%=rs6.getDouble("currency_rate")%>),2);
currency_tag[<%=rs6.getInt("details_number")%>]='1';
}else{
currency_tag[<%=rs6.getInt("details_number")%>]='0';
cSum[<%=rs6.getInt("details_number")%>]='';
cPrice[<%=rs6.getInt("details_number")%>]='';
}
department[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("department")%>';
project[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("project")%>';
attachment_id[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("attachment_id")%>';
settle_way[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_way")%>';
settle_time[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("settle_time")%>'=='1800-01-01'?'':'<%=rs6.getString("settle_time")%>';
customer[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("customer")%>';
product[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("product")%>';
order[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("order_id")%>';
remark[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("remark")%>';
bank_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("bank_tag")%>';
cash_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_tag")%>';
if('<%=rs6.getString("cash_tag")%>'=='1') document.getElementById('d_cash_tag').value='1';
corr_stock_tag[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("corr_stock_tag")%>';
cash_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_direct")%>';
sum_direct_temp[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("stock_direct")%>';
cash_sum[<%=rs6.getInt("details_number")%>]='<%=rs6.getString("cash_sum")%>';
</script>
<tr height="30" id="<%=rs6.getString("details_number")%>">
         <td style="border-right:  1px solid #000000;">
         <input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" class="input1" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_suggest('ccc<%=rs6.getString("details_number")%>')" autocomplete="off" value="<%=rs6.getString("summary")%>"><div class="div1" id="c_div<%=rs6.getString("details_number")%>" onclick="showSummary('ccc<%=rs6.getString("details_number")%>')"></div>
         </td>    
         <td style="border-right:  1px solid #000000;">
         <input name="file_name1" id="ddd<%=rs6.getString("details_number")%>" type="text" class="input3" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" ondblclick="dbclick(this.id)" onkeyup="search_file('ddd<%=rs6.getString("details_number")%>')" autocomplete="off" value="<%=file_name%>"><div class="div2" id="d_div<%=rs6.getString("details_number")%>" onclick="fill('ddd<%=rs6.getString("details_number")%>')" autocomplete="off"></div>
         </td>    
         <td>
         <input name="debit" type="text" id="aaa<%=rs6.getString("details_number")%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" value="<%=debit%>">
         </td>
         <td>
         <input name="loan" type="text" id="bbb<%=rs6.getString("details_number")%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Excessively(this.id,event)" onFocus="fo(this.id)" value="<%=loan%>">
         </td>
  </tr>
<%
}
i++;	  
}
if(i<5){
	for(int j=i;j<5;j++){
%>
<tr height="30" id="<%=j%>">
         <td style="border-right:  1px solid #000000;">
         <input name="summary" id="ccc<%=j%>" type="text" class="input1" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" onkeyup="search_suggest('ccc<%=j%>')" autocomplete="off"><div class="div1" id="c_div<%=j%>" onclick="showSummary('ccc<%=j%>')"></div>
         </td>    
         <td style="border-right:  1px solid #000000;">
         <input name="file_name1" id="ddd<%=j%>" type="text" class="input3" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)" ondblclick="dbclick(this.id)" onkeyup="search_file('ddd<%=j%>')" autocomplete="off"><div class="div2" id="d_div<%=j%>" onclick="fill('ddd<%=j%>')" autocomplete="off"></div>
         </td>    
         <td>
         <input name="debit" type="text" id="aaa<%=j%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Clear(this.id,event)" onFocus="fo(this.id)">
         </td>
         <td>
         <input name="loan" type="text" id="bbb<%=j%>" maxlength="15" onkeyup="match(this.id)" class="input2" onkeydown="Excessively(this.id,event)" onFocus="fo(this.id)">
         </td>
  </tr>
 <%}}%>
 </table>
</div>
 </td>
<tr width="582" height="30">
           <td style=" width: 119px; background-color: #ffffff;"></td>
		   <td style=" width:285px; background-color: #ffffff;"></td>
		   <td style=" width:44px; background-color: #D8D7CB;"><p align="right"><b><%=demo.getLang("erp","合计")%></td>
		   

		   <td width="109px" style="background-color: #ffffff; background-image: url('../../images/finance/voucher.bmp');"><input name="debit_sum" type="text" id="aOuter" maxlength="15" class="input4" readonly value="<%=debit_sum%>"/>　 </td>        
           <td width="109px" style="background-color: #ffffff; background-image: url('../../images/finance/voucher.bmp');"><input name="loan_sum" type="text" id="bOuter" maxlength="15" class="input4" readonly value="<%=loan_sum%>"/></td>

		   <td height="30"  width="18" style="background-color: #D8D7CB;"></td>
		   </tr>
       <tr height="5" style="background: #D8D7CB" ><td width="597" height="5" colspan="6" style="background: #D8D7CB"></td>
       </tr>      
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6"><font size="2"><%=demo.getLang("erp","数量")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="qty" disabled/ name="TH5">*<%=demo.getLang("erp","单价")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="netPrice" disabled/ name="TH6">＝<input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="sum" name="T56" disabled><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4"> 
        |&nbsp;<%=demo.getLang("erp","外币")%><input class="textbox" id="currency" onkeyup="writeAssis()" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" name="TH7"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">&nbsp;<input class="textbox"  style="width: 65; height: 20; border-style:none; border-bottom: 1px solid #000000" onkeyup="writeAssis()" id="cPrice" name="TH8">*<%=demo.getLang("erp","汇率")%><input class="textbox" style="width: 50; height: 20; border-style:none; border-bottom: 1px solid #000000" id="currency_rate" onkeyup="writeAssis()" name="TH9">=<input class="textbox" style="width: 90; height: 20; border-style:none; border-bottom: 1px solid #000000" disabled id="cSum" name="T89"></font></td>         
        </tr>    
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6" ><font size="2"><%=demo.getLang("erp","部门")%><input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="department" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        <%=demo.getLang("erp","项目")%><input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="project" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","结算方式")%>&nbsp;<input class="textbox" style="width: 65; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_way" onkeyup="writeAssis()" name="TH5" disabled/><%=demo.getLang("erp","单号/票号")%><input class="textbox" style="width: 75; height: 20; border-style:none; border-bottom: 1px solid #000000" id="attachment_id" onkeyup="writeAssis()" name="TH5" disabled/><%=demo.getLang("erp","票据日期")%><input class="textbox" style="width: 72; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_time" onkeyup="writeAssis()" name="TH5" disabled/></font></td>        
        </tr>
        <tr style="background:#FFFFFF">
        <td colspan="6"><font size="2"><%=demo.getLang("erp","往来单位")%><input class="textbox" style="width: 128; height: 20; border-style:none; border-bottom: 1px solid #000000" id="customer" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","货品")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="product" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        | <%=demo.getLang("erp","订单")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="order" onkeyup="writeAssis()" name="TH5"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4"> <%=demo.getLang("erp","备注")%><input class="textbox" style="width: 135; height: 20; border-style:none; border-bottom: 1px solid #000000" id="remark" onkeyup="writeAssis()" name="TH5"> </font></td>
<input type="hidden" id="page_bank_tag">
<input type="hidden" id="page_cash_tag">
<input type="hidden" id="page_corr_stock_tag">
<input type="hidden" id="cash_direct">
<input type="hidden" id="stock_direct">
<input type="hidden" id="cash_sum">
<input type="hidden" id="page_currency_tag">
        </tr>
 </table>
<%
sql="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"'";
rs=finance_db.executeQuery(sql);
if(rs.next()){			
%>
 <table width="680" border="0" align="center">
 <tr><td height="20"><%=demo.getLang("erp","会计主管")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accountant" name="accountant" value="<%=rs.getString("accountant")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","记帐")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accounter" name="accounter" value="<%=rs.getString("accounter")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","出纳")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="cashier" name="cashier" value="<%=rs.getString("cashier")%>">
</td>
 <td height="20"><%=demo.getLang("erp","审核")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="checker" name="checker" value="<%=checker%>">
</td>
 <td height="20"><%=demo.getLang("erp","制单")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="register" name="register" value="<%=rs.getString("register")%>" onFocus="this.blur()"></td>
 </tr>
 </table>
<input type="hidden" id="accountant_id" name="accountant_id" value="<%=rs.getString("accountant_id")%>">
<input type="hidden" id="accounter_id" name="accounter_id" value="<%=rs.getString("accounter_id")%>">
<input type="hidden" id="cashier_id" name="cashier_id" value="<%=rs.getString("cashier_id")%>">
<input type="hidden" id="checker_id" name="checker_id" value="<%=checker_id%>">
<input type="hidden" id="register_id" name="register_id" value="<%=rs.getString("register_id")%>">
<%}%>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
catch (Exception ex){
	ex.printStackTrace();
}
 }
%>
<div id="summarydata" style="position:absolute;width:300px;height:120px;top:180px;left:220px;display:none" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0" bgcolor="White">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","摘要选择")%>：
</div>
</div>
<div class="cssDiv3"  onclick="document.getElementById('summarydata').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
 <tr> 
      <td <%=TD_STYLE11%> class="TD_STYLE1" width="40%" valign="top"><%=demo.getLang("erp","请选择凭证摘要")%></td>
      <td <%=TD_STYLE21%> class="TD_STYLE2" width="60%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="t0" onchange="writer(this)" style="width: 100%;">
<option value="">
<%      
       sql = "select * from finance_config_summary";
       rs = finance_db.executeQuery(sql) ;
while(rs.next()){
%>
<option value="<%=exchange.toHtml(rs.getString("name"))%>"><%=exchange.toHtml(rs.getString("name"))%>
<%}
%>
</select>
</tr>
  </table>
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

<div id="file_tree" nseerDef="dragAble" style="background:#E8E8E8;position:absolute;width:600px;height:305px;top:130px;left:50px;display:none;z-index:1;">
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
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;">
<div id="Tabs1">
<ul>
<li id="current"><a href="javascript:changeTab('nseer0');"><span><%=demo.getLang("erp","全部科目")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer1');"><span><%=demo.getLang("erp","资产类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer2');"><span><%=demo.getLang("erp","负债类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer3');"><span><%=demo.getLang("erp","权益类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer4');"><span><%=demo.getLang("erp","成本类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer5');"><span><%=demo.getLang("erp","损益类")%></span></a></li>
</ul>
</div>
<div id="nseer0" style="display:block;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer1" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer2" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer3" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer4" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
<div id="nseer5" style="display:none;width:93%;height:80%;position:absolute;top:13%;left:6.5%;overflow:auto;"></div>
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
<div id="ddd0data" style="position:absolute;top:200;left:50;width:640;height:150;display:none;" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","辅助项")%>：
</div>
</div>
<div class="cssDiv3"  onclick="document.getElementById('ddd0data').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);" ></div>
<table style="width:100%;height:100%;background:#FFFFFF;">
<tr height="10px">
<td height="25"><%=demo.getLang("erp","数量金额")%></td>
</tr>
<tr>
<td colspan="2"><%=demo.getLang("erp","数量")%>
<input style="width: 80; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#FFFFFF" id="quantity" name="TH5" onkeyup="div_match(this.id)">×<%=demo.getLang("erp","单价")%><input type="text" name="net_price>" id="net_price" size="12" style="width: 80; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#FFFFFF" onkeyup="div_match(this.id)"><%=demo.getLang("erp","税率")%>(%)<input type="text" name="tax_rate" id="tax_rate" size="12" style="width: 40; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#FFFFFF"  onkeyup="div_match(this.id)"><%=demo.getLang("erp","含税单价")%><input type="text" name="list_price" id="list_price" size="12" style="width: 80; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#FFFFFF" onkeyup="div_match(this.id)">=<%=demo.getLang("erp","金额")%><input type="text" name="subtotal" id="subtotal" size="12" style="width: 120; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#FFFFFF" onkeyup="div_match(this.id)">
</td>
</tr>
<tr height="20px">
<td><%=demo.getLang("erp","余额方向")%>：<input type="radio" id="sum_direct1" value="1" name="sum_direct" checked><%=demo.getLang("erp","借方")%>&nbsp;&nbsp;<input type="radio" id="sum_direct2" value="0" name="sum_direct"><%=demo.getLang("erp","贷方")%></td>
<td><p align="right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" width="20" onClick="closedata('ddd0data')">&nbsp;&nbsp;    
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" name="B3" width="20" onClick="document.getElementById('ddd0data').style.display='none';">
</td>
</tr>
</table>
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

<div style="width:392px; height:160px;display:none; position:absolute; left:0px; top:0px; max-height:180px;" id="itemc" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","项目选择")%>：
</div>
</div>
<div class="cssDiv3"  onclick="document.getElementById('itemc').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<iframe width="372px" height="140px" style="max-height:180px; ovetflow:auto;" src="registerNew_cash.jsp">
</iframe>
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

<div id="qian" style="position:absolute;top:200;left:170;width:530;height:290px;display:none;" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","辅助项")%>：
</div>
</div>
<div class="cssDiv3"  onclick="closedata2('qian',event)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<table id="Outer2" align="center" width="100%" height="100%" bgcolor=black border=0 cellspacing=1 cellpadding=0>
<tr width="500px">
<td height="23"></td> 
</tr>
<tr width="500px">
<td height="20"  width="499" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; background-position: 0% 50%" colspan="2"><%=demo.getLang("erp","科目")%>：&nbsp;<font size="2" color="#FF0000"><input type="text" id="fileName" style="background-color: #FFFFFF; border-style:none; border-bottom: none;width:90%" onFocus="this.blur()"/></font></td> 
</tr>
<tr>
<td height="20"  width="499" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; background-position: 0% 50%" colspan="2"><%=demo.getLang("erp","金额")%>：</td> 
</tr>
<tr width="499">
<td width="499" style="background-color: #FFFFFF" style="padding-left :4px;" colspan="2">
<div style="overflow-y: auto; overflow-x: hidden; width: 504; height: 176; background-color: #888888" >
<table id="tablefield2" width="487"  bgcolor="black"  border="0" cellspacing="0" cellpadding="0" align="left" >
  <tr height="25">
          <td width="100" height="25" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0%">
            <p align="center"><%=demo.getLang("erp","项目编码")%></p>
          </td>
          <td width="280" height="25" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0%">
            <p align="center"><%=demo.getLang("erp","项目名称")%></p>
          </td>    
          <td width="100" height="25" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0%">
            <p align="center"><%=demo.getLang("erp","金额")%></p>
          </td>
  </tr>
   </table>
</div>
 </td>
</tr width="499">
<tr>
<td height="25" bgcolor="#FFFFFF"><%=demo.getLang("erp","余额方向")%>：<input type="radio" id="cash_direct1" value="1" name="cash_direct" checked><%=demo.getLang("erp","借方")%>&nbsp;&nbsp;<input type="radio" id="cash_direct2" value="0" name="cash_direct"><%=demo.getLang("erp","贷方")%>
</td>
<td height="25" bgcolor="#FFFFFF"><p align="right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","增加")%>" onClick="addRow1(event)">&nbsp;&nbsp;    
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteRow1(event)">&nbsp;&nbsp;
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" width="20" onClick="setCash('qian',event)">&nbsp;&nbsp;    
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" name="B3" width="20" onClick="closedata2('qian',event)">  
</p>
</td>
</tr>
</table>
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

<div id="settlement" style="position:absolute;top:200;left:50;width:540;height:120;display:none;" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","辅助项")%>：
</div>
</div>
<div class="cssDiv3"  onclick="document.getElementById('settlement').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<table style="width:100%;height:100%;background:#FFFFFF;">
<tr height="10px">
<td height="25"><%=demo.getLang("erp","辅助项")%></td>
</tr>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","结算方式")%>
<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="settleWay" style="width: 20%;">
<option value="">
<%      
       sql = "select type_name from finance_config_public_char where kind='结算方式'";
       rs = finance_db.executeQuery(sql) ;
while(rs.next()){
%>
<option value="<%=exchange.toHtml(rs.getString("type_name"))%>"><%=exchange.toHtml(rs.getString("type_name"))%>
<%}
%>
</select>&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","票号")%><input style="width: 100; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#FFFFFF;" id="attachmentId" name="TH5">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","票据日期")%><input name="settleTime" type="text" onkeyup="inputCancel(this.id)" id="settleTime" style="width: 104; height: 20; border-style: none; border-bottom: 1px solid #000000; background:#FFFFFF;">

</td>
</tr>
<tr height="20px">
<td><p align="right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" width="20" onClick="closedata1('settlement')">&nbsp;&nbsp;    
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" name="B3" width="20" onClick="document.getElementById('settlement').style.display='none';">
</td>
</tr>
</table>
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


<input type="hidden" id="qty_arr" name="qty_arr">
<input type="hidden" id="netPrice_arr" name="netPrice_arr">
<input type="hidden" id="tax_rate_arr" name="tax_rate_arr">
<input type="hidden" id="sum_arr" name="sum_arr">
<input type="hidden" id="currency_arr" name="currency_arr">
<input type="hidden" id="cPrice_arr" name="cPrice_arr">
<input type="hidden" id="currency_rate_arr" name="currency_rate_arr">
<input type="hidden" id="cSum_arr" name="cSum_arr">
<input type="hidden" id="department_arr" name="department_arr">
<input type="hidden" id="project_arr" name="project_arr">
<input type="hidden" id="attachment_id_arr" name="attachment_id_arr">
<input type="hidden" id="settle_way_arr" name="settle_way_arr">
<input type="hidden" id="settle_time_arr" name="settle_time_arr">
<input type="hidden" id="customer_arr" name="customer_arr">
<input type="hidden" id="product_arr" name="product_arr">
<input type="hidden" id="order_arr" name="order_arr">
<input type="hidden" id="remark_arr" name="remark_arr">
<input type="hidden" id="bank_tag_arr" name="bank_tag_arr">
<input type="hidden" id="cash_tag_arr" name="cash_tag_arr">
<input type="hidden" id="corr_stock_tag_arr" name="corr_stock_tag_arr">
<input type="hidden" id="cash_direct_arr" name="cash_direct_arr">
<input type="hidden" id="stock_direct_arr" name="stock_direct_arr">
<input type="hidden" id="cash_item_arr" name="cash_item_arr">
<input type="hidden" id="cash_itema_arr" name="cash_itema_arr">
<input type="hidden" id="cash_sum_arr" name="cash_sum_arr">
<input type="hidden" id="currency_tag_arr" name="currency_tag_arr">
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<script>
write_hidden();
write_hidden1();
</script>
</form>
<%
finance_db.close();
finance_db1.close();
%>

<script type="text/javascript">
Calendar.setup ({inputField : "settleTime", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<!--固定的-->
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script language="javascript" src="../../javascript/finance/voucher/treeBusiness.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script>
var Nseer_tree0,Nseer_tree1,Nseer_tree2,Nseer_tree3,Nseer_tree4,Nseer_tree5;
var timei2=0;
function addTree(s){
inWaiting();
if(timei2++ <s){setTimeout("addTree("+s+");",1000);}else{ 
	if(Nseer_tree0=='undefined'||typeof(Nseer_tree0)!='object'){
	Nseer_tree0 = new Tree('Nseer_tree0');
	Nseer_tree0.setImagesPath('../../images/');
	Nseer_tree0.setTableName('finance_config_file_kind');
	Nseer_tree0.setModuleName('../../xml/finance/voucher/tag0');
	Nseer_tree0.addRootNode('No0','<%=demo.getLang("erp","全部科目")%>',false,'1',[]);
	Nseer_tree0.setParent('nseer0');
	initMyTree(Nseer_tree0);
	createButton('../../xml/finance/voucher/tag0','finance_config_file_kind','treeButton');
	document.getElementById('file_tree').style.display ='block';
	}
}
}
function changeTab(nseer_d){
	for(var i=0;i<6;i++){
		if(document.getElementById('nseer'+i)!=null&&document.getElementById('nseer'+i)!='undefined'){
			document.getElementById('nseer'+i).style.display='none';
		}
	}
	var div_obj=document.getElementById('Tabs1');
	var lis=div_obj.getElementsByTagName('li');
	for(var i=0;i<lis.length;i++){lis[i].id='';}
	lis[parseInt(nseer_d.substring(5))].id='main_cur';
	document.getElementById(nseer_d).style.display='block';
	document.getElementById('Tabs1').blur();
	if(nseer_d=='nseer0'){
		if(Nseer_tree0=='undefined'||typeof(Nseer_tree0)!='object'){			
			addTree(1);
		}
	}
	if(nseer_d=='nseer1'){
		if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)!='object'){
			Nseer_tree1 = new Tree('Nseer_tree1');
			Nseer_tree1.setImagesPath('../../images/');
			Nseer_tree1.setTableName('finance_config_file_kind');
			Nseer_tree1.setCondition('kind_tag=\'1\'');
			Nseer_tree1.setModuleName('../../xml/finance/voucher/tag1');//xml文件路径
			Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","资产类")%>',false,'1',[]);
			Nseer_tree1.setParent('nseer1');
			initMyTree(Nseer_tree1);
			createButton('../../xml/finance/voucher/tag1','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer2'){
		if(Nseer_tree2=='undefined'||typeof(Nseer_tree2)!='object'){
			Nseer_tree2 = new Tree('Nseer_tree2');
			Nseer_tree2.setImagesPath('../../images/');
			Nseer_tree2.setTableName('finance_config_file_kind');
			Nseer_tree2.setCondition('kind_tag=\'2\'');
			Nseer_tree2.setModuleName('../../xml/finance/voucher/tag2');//xml文件路径
			Nseer_tree2.addRootNode('No0','<%=demo.getLang("erp","负债类")%>',false,'1',[]);
			Nseer_tree2.setParent('nseer2');
			initMyTree(Nseer_tree2);
			createButton('../../xml/finance/voucher/tag2','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer3'){
		if(Nseer_tree3=='undefined'||typeof(Nseer_tree3)!='object'){
			Nseer_tree3 = new Tree('Nseer_tree3');
			Nseer_tree3.setImagesPath('../../images/');
			Nseer_tree3.setTableName('finance_config_file_kind');
			Nseer_tree3.setCondition('kind_tag=\'3\'');
			Nseer_tree3.setModuleName('../../xml/finance/voucher/tag3');//xml文件路径
			Nseer_tree3.addRootNode('No0','<%=demo.getLang("erp","权益类")%>',false,'1',[]);
			Nseer_tree3.setParent('nseer3');
			initMyTree(Nseer_tree3);
			createButton('../../xml/finance/voucher/tag3','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer4'){
		if(Nseer_tree4=='undefined'||typeof(Nseer_tree4)!='object'){
			Nseer_tree4 = new Tree('Nseer_tree4');
			Nseer_tree4.setImagesPath('../../images/');
			Nseer_tree4.setTableName('finance_config_file_kind');
			Nseer_tree4.setModuleName('../../xml/finance/voucher/tag4');//xml文件路径
			Nseer_tree4.setCondition('kind_tag=\'4\'');
			Nseer_tree4.addRootNode('No0','<%=demo.getLang("erp","成本类")%>',false,'1',[]);
			Nseer_tree4.setParent('nseer4');
			initMyTree(Nseer_tree4);
			createButton('../../xml/finance/voucher/tag4','finance_config_file_kind','treeButton');
		}
	}
	if(nseer_d=='nseer5'){
		if(Nseer_tree5=='undefined'||typeof(Nseer_tree5)!='object'){
			Nseer_tree5 = new Tree('Nseer_tree5');
			Nseer_tree5.setImagesPath('../../images/');
			Nseer_tree5.setTableName('finance_config_file_kind');
			Nseer_tree5.setModuleName('../../xml/finance/voucher/tag5');//xml文件路径
			Nseer_tree5.setCondition('kind_tag=\'5\'');
			Nseer_tree5.addRootNode('No0','<%=demo.getLang("erp","成本类")%>',false,'1',[]);
			Nseer_tree5.setParent('nseer5');
			initMyTree(Nseer_tree5);
			createButton('../../xml/finance/voucher/tag5','finance_config_file_kind','treeButton');
		}
	}
}
</script>