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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="100%";
try{
String timea=(String)session.getAttribute("timea");
sum.calculate(finance_db,timea);
String[] file_id=sum.getFile_id();
int[] parent_category_id=sum.getParent_category_id();
int[] category_id=sum.getCategory_id();
String[] details_tag=sum.getDetails_tag();
String[] file_name=sum.getFile_name();
double[] debit_sum=sum.getDebit_sum();
double[] loan_sum=sum.getLoan_sum();
int[] debit_count=sum.getDebit_count();
int[] loan_count=sum.getLoan_count();
double[] current_balance_sum=sum.getCurrent_balance_sum();
double[] last_balance_sum=sum.getLast_balance_sum();
double debit_sum_all=sum.getDebit_sum_all();
double loan_sum_all=sum.getLoan_sum_all();
double current_balance_sum_all=sum.getCurrent_balance_sum_all();
double last_balance_sum_all=sum.getLast_balance_sum_all();
int debit_count_all=sum.getDebit_count_all();
int loan_count_all=sum.getLoan_count_all();
int count=sum.getCount();
int real_count=sum.getReal_count();
int[] result=sum.getResult();
%>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script src="../../javascript/table/movetable.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","昨日余额")%>" onClick="yes_display()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="queryReportDiary_locate.jsp"></div></td>
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
 <td align="center"><font size="4"><b><%=demo.getLang("erp","资金日报表")%></b></font></td>
 </tr>
 </table>
<div id="today" style="display:block">
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","科目编码")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="180"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","科目名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="120"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","币种")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","今日共借")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","今日共贷")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="18"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","方向")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","今日余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","借方笔数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","贷方笔数")%></td>
 </tr>
<%
for(int i=0;i<real_count;i++){
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=file_id[result[i]]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=file_name[result[i]]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%if(debit_sum[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_sum[result[i]])%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_sum[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_sum[result[i]])%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}if(current_balance_sum[result[i]]>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum[result[i]])%></td>
 <%}else if(current_balance_sum[result[i]]<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(current_balance_sum[result[i]]))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(debit_count[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=debit_count[result[i]]%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_count[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=loan_count[result[i]]%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}%>

</tr>
<%}%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%if(debit_sum_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_sum_all)%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_sum_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_sum_all)%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}if(current_balance_sum_all>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum_all)%></td>
 <%}else if(current_balance_sum_all<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(current_balance_sum_all))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(debit_count_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=debit_count_all%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_count_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=loan_count_all%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}%>

</tr>
</table>
</div>
<script>
function yes_display(){
var yes=document.getElementById('yesterday');
var today=document.getElementById('today');
yes.style.display=yes.style.display=='block'?'none':'block';
today.style.display=today.style.display=='none'?'block':'none';
}
</script>

<div id="yesterday" style="display:none">
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","科目编码")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="180"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","科目名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="120"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","币种")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="18"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","方向")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","昨日余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","今日共借")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","今日共贷")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="18"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","方向")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","今日余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","借方笔数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","贷方笔数")%></td>
 </tr>
<%
for(int i=0;i<real_count;i++){
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=file_id[result[i]]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=file_name[result[i]]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%if(last_balance_sum[result[i]]>0){%>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
    <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum[result[i]])%></td>
<%} else if(last_balance_sum[result[i]]<0){%>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td>
	<td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(last_balance_sum[result[i]]))%></td>
<%	}else{%>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
	<td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}%>
<%if(debit_sum[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_sum[result[i]])%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_sum[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_sum[result[i]])%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}if(current_balance_sum[result[i]]>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum[result[i]])%></td>
 <%}else if(current_balance_sum[result[i]]<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(current_balance_sum[result[i]]))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(debit_count[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=debit_count[result[i]]%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_count[result[i]]!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=loan_count[result[i]]%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}%>

</tr>
<%}%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%if(last_balance_sum_all>0){%>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
    <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum_all)%></td>
<%} else if(last_balance_sum_all<0){%>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
    <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(last_balance_sum_all))%></td>
<%	}else{%>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
    <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}%>
<%if(debit_sum_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_sum_all)%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_sum_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_sum_all)%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}if(current_balance_sum_all>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum_all)%></td>
 <%}else if(current_balance_sum_all<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(current_balance_sum_all))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(debit_count_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=debit_count_all%></td>
<%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}if(loan_count_all!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=loan_count_all%></td>
<%}else{%>  
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%}%>

</tr>
</table>
</div>
<%@include file="../include/paper_bottom.html"%> 
<%
finance_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>