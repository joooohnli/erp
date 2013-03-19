<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db finance_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 

<style> 
.tdp 
{ 
border-bottom: 1 solid #000000; 
border-left: 1 solid #000000; 
border-right: 0 solid #ffffff; 
border-top: 0 solid #ffffff; 
} 
.tabp 
{ 
border-color: #000000 #000000 #000000 #000000; 
border-style: solid; 
border-top-width: 2px; 
border-right-width: 2px; 
border-bottom-width: 1px; 
border-left-width: 1px; 
} 
.NOPRINT { 
font-family: "宋体"; 
font-size: 9pt; 
} 

</style>

<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript" src="../../javascript/finance/voucher.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_ajax.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_add.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_del.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_set.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_write.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_closeshow.js"></script>
<script language="javascript" src="../../javascript/finance/voucher_focus.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>

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
<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","币种")%><input style="width: 100; height: 20; border-style: none; border-bottom: 1px solid #000000;" id="d_currency_name"><input id="d_cash_tag" type="hidden">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","汇率")%><input style="width: 100; height: 20; border-style: none; border-bottom: 1px solid #000000;" id="d_currency_rate" name="TH5" size="20">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","金额")%><input type="text" onkeyup="" id="d_currency_amount" style="width: 104; height: 20; border-style: none; border-bottom: 1px solid #000000;">
</td>
</tr>
<tr height="20px">
<td><%=demo.getLang("erp","余额方向")%>：<input type="radio" id="d_sum_direct1" name="d_sum_direct" value="1" checked><%=demo.getLang("erp","借方")%>&nbsp;&nbsp;<input type="radio" id="d_sum_direct2" name="d_sum_direct" value="0"><%=demo.getLang("erp","贷方")%></td>
<td><p align="right">   
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
String table_width="820";
String debit_sum="";
String loan_sum="";
String debit="";
String loan="";
String id="";
String sql1="";
String cash_item="";
String cash_itema="";
String checker="";
String check_time="";
ResultSet rs1=null;
String voucher_in_month_id=request.getParameter("voucher_in_month_id") ;
String register_time=request.getParameter("register_time") ;

try{
String sql="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(strhead.indexOf(browercheck.IE)==-1){
if(rs.next()){	debit_sum=rs.getString("debit_sum").substring(0,rs.getString("debit_sum").indexOf("."))+rs.getString("debit_sum").substring(rs.getString("debit_sum").indexOf(".")+1);
	loan_sum=rs.getString("loan_sum").substring(0,rs.getString("loan_sum").indexOf("."))+rs.getString("loan_sum").substring(rs.getString("loan_sum").indexOf(".")+1);

String check_tag="";
String color1="#FF9A31";
checker=rs.getString("checker");
check_time=rs.getString("check_time");

if(rs.getString("check_tag").equals("0")){
check_tag="等待";
}else if(rs.getString("check_tag").equals("1")){
check_tag="通过";
color1="3333FF";
}else if(rs.getString("check_tag").equals("9")){
check_tag="未通过";
color1="red";
}
%>

 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="Noprint"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></td>
 </tr>
</table>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><input name="example"  type="text" value="<%=demo.getLang("erp","记帐凭证")%>" style="width:200px; height:35px; border-style: none; font : small-caps 600 20pt/20pt 宋体; border-bottom:  3px double #000000; text-align: center;" readonly/></td>
 </tr>
</table> 
<style>
.div1{CURSOR: hand; display: none; padding-top: 7px; left: 130px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.div2{CURSOR: hand; display: none; padding-top: 7px; left: 420px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.input1{width: 100%; height: 98%; border-style: none; border-right:  1px solid #000000;}
.input2{width: 100%; height: 98%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000;}
.input3{width: 100%; height: 98%; border-style: none; border-bottom:  1px solid #000000;}
</style>
<div id="search_suggest" style="display: none; background: yellow; position:absolute; left:0px; top:80px; width: 150px; height: 100px; z-index: 10; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;"></div>
<div >
<table border="0" width="581" cellspacing="0" cellpadding="0" align="center">
<tr width="574" height="24" >
 <td width="55">
 <input name="voucher_type" type="text" id="subject" style="width: 57; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000" value="<%=rs.getString("voucher_type")%>" onFocus="this.blur();"></td>
  <td width="30">
 <b><%=demo.getLang("erp","字第")%></b>
  <td width="55">
 <input name="voucher_id" type="hidden" id="subject2" style="width: 50; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000" value="<%=rs.getString("voucher_in_month_ID")%>"><%=rs.getString("voucher_in_month_ID")%>
  <td width="5"><b><%=demo.getLang("erp","号")%></b>
  <td width="50">
  <td width="129">
 <b><%=demo.getLang("erp","制单时间")%>：</b>
  <td width="59"><%=rs.getString("register_time")%>
  <td width="66">
  <td width="94">
 <b><%=demo.getLang("erp","附件数")%>：</b>
  <td width="72">
 <input name="attachment_amount" type="text" id="subject4" style="width: 68; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000" value="<%=rs.getString("attachment_amount")%>" onFocus="this.blur();">
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
}else{
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
</script>
<tr height="30" id="<%=rs6.getString("details_number")%>">
          <td width="210" height="30">
          <input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" class="input1" onFocus="this.blur();" value="<%=rs6.getString("summary")%>"></td>    
          <td width="410" height="30">
          <input name="file_name1" id="ddd<%=rs6.getString("details_number")%>file" type="text" class="input1" onFocus="fox(this.id)" value="<%=file_name%>">
          </td>    
          <td width="155" height="30">
          <input name="debit" type="text" id="aaa<%=rs6.getString("details_number")%>" onFocus="this.blur();" class="input2" value="<%=debit%>">
          </td>
          <td width="155" height="30">
          <input name="loan" type="text" id="bbb<%=rs6.getString("details_number")%>" onFocus="this.blur();" class="input2" value="<%=loan%>">
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
</script>
<tr height="30" id="<%=rs6.getString("details_number")%>">
<td>
<input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000;border-bottom:  1px solid #000000;" onFocus="this.blur()" value="<%=rs6.getString("summary")%>">
</td>
<td>
<input name="file_name1" id="ddd<%=rs6.getString("details_number")%>file" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000; border-bottom:  1px solid #000000;" onFocus="fox(this.id)" value="<%=file_name%>">
</td>
<td>
<input name="debit" id="aaa<%=rs6.getString("details_number")%>" type="text" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000;" onFocus="this.blur()" value="<%=debit%>">
</td>
<td>
<input name="loan" id="bbb<%=rs6.getString("details_number")%>" type="text" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000;" value="<%=loan%>" onFocus="this.blur()">
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
<input name="summary" id="ccc<%=j%>" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000;border-bottom:  1px solid #000000;" onFocus="this.blur();">
</td>
<td>
<input name="file_name1" id="ddd<%=j%>" type="text" style="width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000; border-bottom:  1px solid #000000;" onFocus="this.blur();">
</td>
<td>
<input name="debit" id="aaa<%=j%>" type="text" maxlength="15" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000;" onFocus="this.blur();">
</td>
<td>
<input name="loan" id="bbb<%=j%>" type="text" maxlength="15" style="width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom:  1px solid #000000;" onFocus="this.blur();">
</td>
  </tr>
 <%}}%>
 </table>
</div>
 </td>
</tr>
<tr width="582" height="30">
           <td  width="187" height="30" style="background-color: #ffffff;"></td>        
           <td  width="286" height="30" style="background-color: #ffffff;"></td>        
           <td  width="41" height="30" style="background-color: #D8D7CB;"><p align="right"><b><%=demo.getLang("erp","合计")%></td>
           <td width="155" height="30"><input name="debit_sum" type="text" id="aOuter" maxlength="15" style="width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none;" readonly value="<%=debit_sum%>"/></td>
		   <td width="155" height="30"><input name="loan_sum" type="text" id="bOuter" maxlength="15" style="width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none;" readonly value="<%=loan_sum%>"/></td>
		   <td height="30"  width="34" style="background-color: #D8D7CB;" ></td>
        </tr>
       <tr height="5" style="background: #D8D7CB" ><td width="597" height="5" colspan="6" style="background: #D8D7CB"></td>
       </tr>       
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6"><font size="2"><%=demo.getLang("erp","数量")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="qty" readonly/ name="TH5" size="20">*<%=demo.getLang("erp","单价")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="netPrice" readonly/ name="TH6" size="20">＝<input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="sum" name="T56" readonly size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4"> 
        |&nbsp;<%=demo.getLang("erp","外币")%><input class="textbox" id="currency" onkeyup="writeAssis()" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" name="TH7" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">&nbsp;<input class="textbox"  style="width: 65; height: 20; border-style:none; border-bottom: 1px solid #000000" onkeyup="writeAssis()" id="cPrice" name="TH8" size="20">*<%=demo.getLang("erp","汇率")%><input class="textbox" style="width: 55; height: 20; border-style:none; border-bottom: 1px solid #000000" id="currency_rate" onkeyup="writeAssis()" name="TH9" size="20">=<input class="textbox" style="width: 90; height: 20; border-style:none; border-bottom: 1px solid #000000" readonly id="cSum" name="T89" size="20"></font></td>         
        </tr>    
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6" ><font size="2"><%=demo.getLang("erp","部门")%><input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="department" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        <%=demo.getLang("erp","项目")%><input class="textbox" style="width: 100; height: 20;border-style:none; border-bottom: 1px solid #000000" id="project" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","结算方式")%>&nbsp;<input class="textbox" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_way" onkeyup="writeAssis()" name="TH5" size="20" readonly/><%=demo.getLang("erp","单号/票号")%><input class="textbox" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" id="attachment_id" onkeyup="writeAssis()" name="TH5" size="20" readonly/><%=demo.getLang("erp","票据日期")%><input class="textbox" style="width: 76; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_time" onkeyup="writeAssis()" name="TH5" size="20" readonly/></font></td>      
        </tr>
        <tr style="background:#FFFFFF">
        <td colspan="6"><font size="2"><%=demo.getLang("erp","往来单位")%><input class="textbox" style="width: 136; height: 20; border-style:none; border-bottom: 1px solid #000000" id="customer" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","货品")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="product" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        | <%=demo.getLang("erp","订单")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="order" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4"> <%=demo.getLang("erp","备注")%><input class="textbox" style="width: 130; height: 20; border-style:none; border-bottom: 1px solid #000000" id="remark" onkeyup="writeAssis()" name="TH5" size="20"> </font></td>
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
 <tr><td height="20"><%=demo.getLang("erp","会计主管")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accountant" onFocus="this.blur();" value="<%=rs.getString("accountant")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","记帐")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accounter" onFocus="this.blur();" value="<%=rs.getString("accounter")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","出纳")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="cashier" onFocus="this.blur();" value="<%=rs.getString("cashier")%>">
</td>
 <td height="20"><%=demo.getLang("erp","审核")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="checker" onFocus="this.blur();" value="<%=checker%>">
</td>
 <td height="20"><%=demo.getLang("erp","制单")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="register" value="<%=rs.getString("register")%>" onFocus="this.blur()"></td>
 </tr>
 </table>

<%}%>
<%@include file="../include/paper_bottom.html"%>
</div>
<%}else{
if(rs.next()){
	debit_sum=rs.getString("debit_sum").substring(0,rs.getString("debit_sum").indexOf("."))+rs.getString("debit_sum").substring(rs.getString("debit_sum").indexOf(".")+1);
	loan_sum=rs.getString("loan_sum").substring(0,rs.getString("loan_sum").indexOf("."))+rs.getString("loan_sum").substring(rs.getString("loan_sum").indexOf(".")+1);

String check_tag="";
String color1="#FF9A31";
checker=rs.getString("checker");
check_time=rs.getString("check_time");

if(rs.getString("check_tag").equals("0")){
check_tag="等待";
}else if(rs.getString("check_tag").equals("1")){
check_tag="通过";
color1="3333FF";
}else if(rs.getString("check_tag").equals("9")){
check_tag="未通过";
color1="red";
}
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="Noprint"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></td>
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
.div1{CURSOR: hand; display: none; padding-top: 7px; left: 125px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.div2{CURSOR: hand; display: none; padding-top: 7px; left: 420px; width: 18px; height:28; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;}
.input1{width: 145px; height: 100%; border-style: none; border-right:  0px solid #000000;}
.input3{width: 295px; height: 100%; border-style: none; border-right:  0px solid #000000;}
.input2{width: 110px; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  0px solid #000000;}
.input4{width: 110px; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  0px solid #000000;}
</style>
<div id="search_suggest" style="display: none; background: yellow; position:absolute; left:0px; top:80px; width: 150px; height: 100px; z-index: 10; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;"></div>
<div >
<table border="0" width="581" cellspacing="0" cellpadding="0" align="center">
<tr width="574" height="24" >
 <td width="55">
 <input name="voucher_type" type="text" id="subject" style="width: 57; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000" value="<%=rs.getString("voucher_type")%>" onFocus="this.blur();"></td>
  <td width="30">
 <b><%=demo.getLang("erp","字第")%></b>
  <td width="55">
 <input name="voucher_id" type="hidden" id="subject2" style="width: 50; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000" value="<%=rs.getString("voucher_in_month_ID")%>"><%=rs.getString("voucher_in_month_ID")%>
  <td width="5"><b><%=demo.getLang("erp","号")%></b>
  <td width="50">
  <td width="119">
 <b><%=demo.getLang("erp","制单时间")%>：</b>
  <td width="69"><%=rs.getString("register_time")%>
  <td width="66">
  <td width="94">
 <b><%=demo.getLang("erp","附件数")%>：</b>
  <td width="72">
 <input name="attachment_amount" type="text" id="subject4" style="width: 68; height: 23; text-align: Right; border-style:none; border-bottom: 1px solid #000000" value="<%=rs.getString("attachment_amount")%>" onFocus="this.blur();">
</tr>
</table>
  <table id="Outer" height="210" align="center" width="682" bgcolor=black  border=0 cellspacing=1 cellpadding=0 align=center>
		<tr width="581">
           <td height="30"  width="164" style="background-color: #D8D7CB;">
            <p align="center"><b><%=demo.getLang("erp","摘要")%>
            </td>    
           <td height="30"  width="302" style="background-color: #D8D7CB;" colspan="2">
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
}else{
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
</script>
 <tr height="30" id="<%=rs6.getString("details_number")%>">
          <td width="310" style="background:#FFFFFF;border-right:  1px solid #000000;">
          <input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" class="input1" onFocus="this.blur();" value="<%=rs6.getString("summary")%>"></td>    
          <td width="360" style="background:#FFFFFF;border-right:  1px solid #000000;"><span id="ddd<%=rs6.getString("details_number")%>file" style="width:100%;height:100%" onFocus="fox(this.id);"><%=file_name%></span></td>    
          <td width="165" style="background:#FFFFFF; border-right:  1px solid #000000; background-image: url('../../images/finance/voucher.bmp')">
          <input name="debit" type="text" id="aaa<%=rs6.getString("details_number")%>" maxlength="15" class="input2" onFocus="this.blur();" value="<%=debit%>">
          </td>
          <td width="165"style="background:#FFFFFF; border-right:  1px solid #000000; background-image: url('../../images/finance/voucher.bmp')">
          <input name="loan" type="text" id="bbb<%=rs6.getString("details_number")%>" maxlength="15" class="input2" onFocus="this.blur();" value="<%=loan%>">
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
</script>
<tr height="30" id="<%=rs6.getString("details_number")%>">
         <td style="border-right:  1px solid #000000;">
         <input name="summary" id="ccc<%=rs6.getString("details_number")%>" type="text" class="input1" onFocus="this.blur();" value="<%=rs6.getString("summary")%>"></td>
		 <td style="border-right:  1px solid #000000;"><span id="ddd<%=rs6.getString("details_number")%>file" style="width:100%;height:100%;background:#FFFFFF; border-top:  1px solid #000000;" onFocus="fox(this.id);"><%=file_name%></span></td>  
         <td>
         <input name="debit" type="text" id="aaa<%=rs6.getString("details_number")%>" maxlength="15" class="input2" onFocus="this.blur();" value="<%=debit%>">
         </td>
         <td>
         <input name="loan" type="text" id="bbb<%=rs6.getString("details_number")%>" maxlength="15" class="input2" onFocus="this.blur();" value="<%=loan%>">
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
          <td height="30" style="border-right:  1px solid #000000;">
          <input name="summary" id="ccc<%=j%>" type="text" class="input1" onFocus="this.blur();"></td>    
          <td height="30" style="border-right:  1px solid #000000;">
          <input name="file_name1" id="ddd<%=j%>" type="text" class="input3" onFocus="this.blur();"></td>    
          <td height="30">
          <input name="debit" type="text" id="aaa<%=j%>" class="input2" onFocus="this.blur();"></td>
          <td height="30">
          <input name="loan" type="text" id="bbb<%=j%>"  class="input2" onFocus="this.blur();">
          </td>
  </tr>
 <%}}%>
 </table>
</div>
 </td>
</tr>
        <tr width="582" height="30">
           <td style=" width: 114px; background-color: #ffffff;"></td>
		   <td style=" width:290px; background-color: #ffffff;"></td>
		   <td style=" width:44px; background-color: #D8D7CB;"><p align="right"><b><%=demo.getLang("erp","合计")%></td>        
           <td width="109px" style="background-color: #ffffff; background-image: url('../../images/finance/voucher.bmp');"><input name="debit_sum" type="text" id="aOuter" maxlength="15" class="input4" readonly value="<%=debit_sum%>"/></td>        
           <td width="109px" style="background-color: #ffffff; background-image: url('../../images/finance/voucher.bmp');"><input name="loan_sum" type="text" id="bOuter" maxlength="15" class="input4" readonly value="<%=loan_sum%>"/></td>

		   <td height="30"  width="18" style="background-color: #D8D7CB;"></td>
		   </tr>
       <tr height="5" style="background: #D8D7CB" ><td width="597" height="5" colspan="6" style="background: #D8D7CB"></td>
       </tr>      
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6"><font size="2"><%=demo.getLang("erp","数量")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="qty" disabled/ name="TH5" size="20">*<%=demo.getLang("erp","单价")%><input class="textbox" style="width: 60; height: 20; border-style:none; border-bottom: 1px solid #000000" id="netPrice" disabled/ name="TH6" size="20">＝<input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="sum" name="T56" disabled size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4"> 
        |&nbsp;<%=demo.getLang("erp","外币")%><input class="textbox" id="currency" onkeyup="writeAssis()" style="width: 70; height: 20; border-style:none; border-bottom: 1px solid #000000" name="TH7" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">&nbsp;<input class="textbox"  style="width: 65; height: 20; border-style:none; border-bottom: 1px solid #000000" onkeyup="writeAssis()" id="cPrice" name="TH8" size="20">*<%=demo.getLang("erp","汇率")%><input class="textbox" style="width: 50; height: 20; border-style:none; border-bottom: 1px solid #000000" id="currency_rate" onkeyup="writeAssis()" name="TH9" size="20">=<input class="textbox" style="width: 90; height: 20; border-style:none; border-bottom: 1px solid #000000" disabled id="cSum" name="T89" size="20"></font></td>         
        </tr>    
        <tr style="background:#FFFFFF">
        <td height="17" colspan="6" ><font size="2"><%=demo.getLang("erp","部门")%><input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="department" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        <%=demo.getLang("erp","项目")%><input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="project" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","结算方式")%>&nbsp;<input class="textbox" style="width: 65; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_way" onkeyup="writeAssis()" name="TH5" size="20" disabled/><%=demo.getLang("erp","单号/票号")%><input class="textbox" style="width: 75; height: 20; border-style:none; border-bottom: 1px solid #000000" id="attachment_id" onkeyup="writeAssis()" name="TH5" size="20" disabled/><%=demo.getLang("erp","票据日期")%><input class="textbox" style="width: 72; height: 20; border-style:none; border-bottom: 1px solid #000000" id="settle_time" onkeyup="writeAssis()" name="TH5" size="20" disabled/></font></td>      
        </tr>
        <tr style="background:#FFFFFF">
        <td colspan="6"><font size="2"><%=demo.getLang("erp","往来单位")%><input class="textbox" style="width: 128; height: 20; border-style:none; border-bottom: 1px solid #000000" id="customer" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">        
        | <%=demo.getLang("erp","货品")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="product" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand" src="../../images/finance/arrow.gif" border="0" width="7" height="4">       
        | <%=demo.getLang("erp","订单")%> <input class="textbox" style="width: 100; height: 20; border-style:none; border-bottom: 1px solid #000000" id="order" onkeyup="writeAssis()" name="TH5" size="20"><img style="CURSOR: hand"  src="../../images/finance/arrow.gif" border="0" width="7" height="4"> <%=demo.getLang("erp","备注")%><input class="textbox" style="width: 135; height: 20; border-style:none; border-bottom: 1px solid #000000" id="remark" onkeyup="writeAssis()" name="TH5" size="20"> </font></td>
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
 <tr><td height="20"><%=demo.getLang("erp","会计主管")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accountant" onFocus="this.blur();" value="<%=rs.getString("accountant")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","记帐")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="accounter" onFocus="this.blur();" value="<%=rs.getString("accounter")%>">
 </td>
 <td height="20"><%=demo.getLang("erp","出纳")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="cashier" onFocus="this.blur();" value="<%=rs.getString("cashier")%>">
</td>
 <td height="20"><%=demo.getLang("erp","审核")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="checker" onFocus="this.blur();" value="<%=checker%>">
</td>
 <td height="20"><%=demo.getLang("erp","制单")%><input class="textbox" style="width: 80; height: 20; border-style:none; border-bottom: 1px solid #000000" id="register" value="<%=rs.getString("register")%>" onFocus="this.blur()"></td>
 </tr>
 </table>

<%}%>
<%@include file="../include/paper_bottom.html"%>
</div>
<%}%>
<div id="ddd0data" style="position:absolute;top:200;left:50;width:660;height:150;display:none;" nseerDef="dragonly">
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
<div class="cssDiv3"  onclick="document.getElementById('ddd0data').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<table style="width:100%;height:100%;background:#FFFFFF" >
<tr height="10px">
<td height="25"><%=demo.getLang("erp","数量金额")%></td>
</tr>
<tr>
<td colspan="2">
<%=demo.getLang("erp","数量")%><input style="width: 80; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#EEEEEE" id="quantity" name="TH5" onkeyup="div_match(this.id)">×<%=demo.getLang("erp","单价")%><input type="text" name="net_price>" id="net_price" size="12" style="width: 80; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#EEEEEE" onkeyup="div_match(this.id)"><%=demo.getLang("erp","税率")%>(%)<input type="text" name="tax_rate" id="tax_rate" size="12" style="width: 40; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#EEEEEE"  onkeyup="div_match(this.id)"><%=demo.getLang("erp","含税单价")%><input type="text" name="list_price" id="list_price" size="12" style="width: 80; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#EEEEEE" onkeyup="div_match(this.id)">=<%=demo.getLang("erp","金额")%><input type="text" name="subtotal" id="subtotal" size="12" style="width: 120; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#EEEEEE" onkeyup="div_match(this.id)">
</td>
</tr>
<tr height="20px">
<td><%=demo.getLang("erp","余额方向")%>：<input type="radio" id="sum_direct1" value="1" name="sum_direct" checked><%=demo.getLang("erp","借方")%>&nbsp;&nbsp;<input type="radio" id="sum_direct2" value="0" name="sum_direct"><%=demo.getLang("erp","贷方")%></td>
<td><p align="right">   
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
<div class="cssDiv2"><%=demo.getLang("erp","金额")%>：
</div>
</div>
<div class="cssDiv3"  onclick="closedata2('qian',event)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<table id="Outer2" align="center" width="100%"  bgcolor=black border=0 cellspacing=1 cellpadding=0 align=center>
<tr width="500px">
<td height="23"></td> 
</tr>
<tr width="500px">
<td height="20"  width="499" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; background-position: 0% 50%" colspan="2"><%=demo.getLang("erp","科目")%>：&nbsp;<font size="2" color="#FF0000"><input type="text" id="fileName" style="background-color: #FFFFFF; border-style:none; border-bottom: none;" onFocus="this.blur()"/></font></td> 
</tr>
<tr>
<td height="20"  width="499" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; background-position: 0% 50%" colspan="2"><%=demo.getLang("erp","金额")%>：</td> 
</tr>
<tr width="499">
<td width="499" style="background-color: #FFFFFF" style="padding-left :4px;" colspan="2">
<div style="overflow-y: auto; overflow-x: hidden; width: 507; height: 176; background-color: #888888" >
<table id="tablefield2" width="490"  bgcolor="black"  border="0" cellspacing="0" cellpadding="0" align="left" >
  <tr height="25">
          <td width="100" height="25" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0%">
            <p align="center"><%=demo.getLang("erp","项目编码")%></p>
          </td>
          <td width="290" height="25" style="background-color: #FFFFFF; background-repeat: repeat; background-attachment: scroll; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0%">
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
<td height="25" bgcolor="#FFFFFF"><%=demo.getLang("erp","余额方向")%>：<input type="radio" id="cash_direct1" value="1" name="cash_direct"><%=demo.getLang("erp","借方")%>&nbsp;&nbsp;<input type="radio" id="cash_direct2" value="0" name="cash_direct"><%=demo.getLang("erp","贷方")%>
</td>
<td height="25" bgcolor="#FFFFFF"><p align="right"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" name="B3" width="20" onClick="closedata2('qian',event)"></p>
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


<div id="settlement" style="position:absolute;top:200;left:50;width:540;height:150;display:none;" nseerDef="dragonly">
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
</select>&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","票号")%><input style="width: 100; height: 20; border-style: none; border-bottom: 1px solid #000000;background:#FFFFFF;" id="attachmentId" name="TH5" size="20">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","票据日期")%><input name="settleTime" type="text" onfocus="" id="settleTime" style="width: 104; height: 20; border-style: none; border-bottom: 1px solid #000000; background:#FFFFFF;" size="20">

</td>
</tr>
<tr height="20px">
<td><p align="right"> 
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

<div style="width:392px; height:158px;display:none; position:absolute; left:100px; top:50px; max-height:180px;" id="itemc" nseerDef="dragonly">
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
<iframe width="372px" height="180px" style="max-height:180px; ovetflow:auto;" src="registerNew_cash.jsp">
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
<%
finance_db.close();
finance_db1.close();
}
catch (Exception ex){
	ex.printStackTrace();
}
%>