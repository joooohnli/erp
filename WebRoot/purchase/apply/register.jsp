<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<%
String[] choice=request.getParameterValues("choice");
if(choice!=null){
%>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form  id="mutiValidation" method="POST" action="../../purchase_apply_register_ok" onSubmit="return doValidate('../../xml/purchase/purchase_apply.xml','mutiValidation')">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
 </tr>
 </table>
 <%
String[] product_ID1=new String[100000];
double[] amount=new double[100000];
String condition="";
String choice_group="";
int i;
int m=0;
for(i=0;i<choice.length-1;i++){
	condition=condition+"pay_ID='"+choice[i]+"'"+" or ";
	choice_group=choice_group+choice[i]+", ";
}
condition=condition+"pay_ID='"+choice[i]+"'";
choice_group=choice_group+choice[i];
	String sql = "select distinct product_ID from stock_pay_details where "+condition+"" ;
	ResultSet rs = stockdb.executeQuery(sql) ;
	while(rs.next()){
		double amount1=0.0d;
		String sql1="select sum(apply_purchase_amount) as total_apply_purchase_amount from stock_pay_details where product_ID='"+rs.getString("product_ID")+"' and ("+condition+")";
		ResultSet rs1 = stock_db.executeQuery(sql1) ;
		if(rs1.next()){
			amount1=rs1.getDouble("total_apply_purchase_amount");
		}
			product_ID1[m]=rs.getString("product_ID");
			amount[m]=amount1;
			m++;
	}
String[] product_ID=new String[m];
String[] product_name=new String[m];
String[] product_describe=new String[m];
String[] pay_ID_group=new String[m];
for(i=0;i<m;i++){
	String sql2="select distinct pay_ID,product_ID,product_name,product_describe from stock_pay_details where product_ID='"+product_ID1[i]+"'";
	ResultSet rs2 = stockdb.executeQuery(sql2) ;
	while(rs2.next()){
		double amount2=0.0d;
		product_ID[i]=rs2.getString("product_ID");
		product_name[i]=rs2.getString("product_name");
		product_describe[i]=rs2.getString("product_describe");
		String sql3="select sum(apply_purchase_amount) as total_apply_purchase_amount from stock_pay_details where product_ID='"+product_ID1[i]+"' and pay_ID='"+rs2.getString("pay_ID")+"'";
		ResultSet rs3 = stock_db.executeQuery(sql3) ;
		if(rs3.next()){
			amount2=rs3.getDouble("total_apply_purchase_amount");
		}
		int a=choice_group.indexOf(rs2.getString("pay_ID"));
		
		if(a!=-1){
			if(pay_ID_group[i]==null){
				pay_ID_group[i]=rs2.getString("pay_ID");
			}else{
				pay_ID_group[i]=pay_ID_group[i]+", "+rs2.getString("pay_ID");
			}
		}
	}
}
stock_db.close();
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","采购计划单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","计划制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="designer" style="width: 44%; "></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","产品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品名称")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=demo.getLang("erp","出库单编号集合")%></td>
 </tr>
<%
		 int p=1;
for(int j=0;j<product_ID.length;j++){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=p%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="product_ID" value="<%=product_ID[j]%>"><%=product_ID[j]%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="product_name" value="<%=exchange.toHtml(product_name[j])%>"><%=exchange.toHtml(product_name[j])%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="product_describe" value="<%=product_describe[j]%>"><%=product_describe[j]%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="amount" value="<%=amount[j]%>"><%=amount[j]%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><input type="hidden" name="pay_ID_group" value="<%=exchange.toHtml(pay_ID_group[j])%>"><%=exchange.toHtml(pay_ID_group[j])%>&nbsp;</td>
 </tr>
<%
	p++;
	}
%>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" cols="115" rows="4"></textarea>
</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 <%}else{
stockdb.close();
stock_db.close();
	%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td> 
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择出库单，请返回。")%></td>
	</tr>
 </table>
  </div>
 <%}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>