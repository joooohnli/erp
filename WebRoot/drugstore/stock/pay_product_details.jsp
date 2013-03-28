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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="available" class="stock.getBalanceAmountDetails" scope="request"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String pay_ID=request.getParameter("pay_ID") ;
String product_ID=request.getParameter("product_ID") ;
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String reasonexact_details=request.getParameter("reasonexact_details") ;
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
String stock_ID="";
String sql8="select * from stock_pay_details where pay_ID='"+pay_ID+"' and product_ID='"+product_ID+"' and pay_tag='0'";
ResultSet rs8=stockdb.executeQuery(sql8);
if(rs8.next()){
	String sql3="select * from stock_config_public_char where responsible_person_ID like '%"+register_ID+"%'";
	ResultSet rs3=stockdb.executeQuery(sql3);
	while(rs3.next()){
		stock_ID+=rs3.getString("stock_ID")+",";
	}
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String time=formatter.format(now);
	String design_ID="";
	try{
	String sql2="select * from stock_cell where product_ID='"+product_ID+"'";
		ResultSet rs2=stockdb.executeQuery(sql2);
		if(rs2.next()){
			design_ID=rs2.getString("design_ID");
	String sql6="";
	if(reason.equals("内部调入")){
		sql6="select * from stock_cell_details where design_ID='"+design_ID+"' and stock_name!='"+reasonexact_details+"'";
	}else if(reason.equals("内部调出")){
		sql6="select * from stock_cell_details where design_ID='"+design_ID+"' and stock_name='"+reasonexact_details+"'";
	}else{
	sql6="select * from stock_cell_details where design_ID='"+design_ID+"' order by details_number";
	}
	ResultSet rs6=stockdb.executeQuery(sql6);
	if(rs6.next()){
	String sql="select * from stock_pay_details where pay_ID='"+pay_ID+"' and product_ID='"+product_ID+"'";
	ResultSet rs=stockdb.executeQuery(sql);
	if(rs.next()){
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="../../stock_stock_pay_product_details_ok" onSubmit="return doValidate('../../xml/stock/stock_pre_paying.xml','mutiValidation')">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="pay.jsp?pay_ID=<%=pay_ID%>"></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","出库调度单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<input name="reasonexact" type="hidden" value="<%=reasonexact%>">
<input name="reasonexact_details" type="hidden" value="<%=reasonexact_details%>">
<input name="reason" type="hidden" value="<%=reason%>">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="pay_ID" type="hidden" value="<%=pay_ID%>"><%=pay_ID%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="product_ID" type="hidden" value="<%=product_ID%>"><%=product_ID%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="product_name" type="hidden" value="<%=exchange.toHtml(rs.getString("product_name"))%>"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","成本单价")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="cost_price" type="hidden" value="<%=rs.getString("cost_price")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price"))%>&nbsp;</td>
 </tr>	
 <input name="paid_subtotal" type="hidden" value="<%=rs.getDouble("paid_subtotal")%>">
 <input name="cost_price" type="hidden" value="<%=rs.getDouble("cost_price")%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","库房名称")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","存储地址")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","当前库存数量")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","本次出库数量")%></td>
	</tr>
<%
	String sql1="";
	if(reason.equals("内部调入")){
		sql1="select * from stock_cell_details where design_ID='"+design_ID+"' and stock_name!='"+reasonexact_details+"'";
	}else if(reason.equals("内部调出")){
		sql1="select * from stock_cell_details where design_ID='"+design_ID+"' and stock_name='"+reasonexact_details+"'";
	}else{
	sql1="select * from stock_cell_details where design_ID='"+design_ID+"' order by details_number";
	}
	ResultSet rs1=stock_db.executeQuery(sql1);
	while(rs1.next()){
%>
<input name="stock_ID" type="hidden" value="<%=rs1.getString("stock_ID")%>">
<input name="stock_name" type="hidden" value="<%=exchange.toHtml(rs1.getString("stock_name"))%>">
<input name="nick_name" type="hidden" value="<%=exchange.toHtml(rs1.getString("nick_name"))%>">
<input name="available_amount" type="hidden" value="<%=available.balanceAmount((String)session.getAttribute("unit_db_name"),product_ID,rs1.getString("stock_name"))%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("details_number")%><input name="details_number" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=rs1.getString("details_number")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("stock_name")%>&nbsp;</td>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="nick_name_pdf" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=exchange.toHtml(rs1.getString("nick_name"))%>"> <%=exchange.toHtml(rs1.getString("nick_name"))%>&nbsp;</td>
 
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="unit_db_name" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=available.balanceAmount((String)session.getAttribute("unit_db_name"),product_ID,rs1.getString("stock_name"))%>"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),product_ID,rs1.getString("stock_name"))%>&nbsp;</td>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount"></td>
 </tr>
<%
	}
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应出库数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getDouble("amount")%><input name="demand_amount" type="hidden" value="<%=rs.getDouble("amount")%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已出库数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="paid_amount" type="hidden" value="<%=rs.getDouble("paid_amount")%>"><%=rs.getDouble("paid_amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
<%
	}
	}else{
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","对不起，该产品无调出库或未分配存储空间，请返回！")%></td>
 </tr>
 </table>
 </div>
<%
	}
	}else{
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","对不起，该产品尚未制定安全库存配置单，请返回！")%></td>
 </tr>
 </table>
 </div>
<%
	}
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="pay.jsp?pay_ID=<%=pay_ID%>"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已调度，请返回！")%></td>
 </tr>
 </table>
 </div>
<%}
stock_db.close();
stockdb.close();		
%>
