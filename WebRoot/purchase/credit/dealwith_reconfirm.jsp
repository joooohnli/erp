<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<%
String gather_ID=request.getParameter("gather_ID");
String purchaser_ID=request.getParameter("purchaser_ID");
String purchaser=exchange.unURL(request.getParameter("purchaser"));
String purchasecredit_cost_price_sum=exchange.unURL(request.getParameter("purchasecredit_cost_price_sum"));
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
try{
String sql="select * from stock_apply_gather where gather_ID='"+gather_ID+"'";
ResultSet rs=stockdb.executeQuery(sql);
if(rs.next()){
	String remark=exchange.unHtml(rs.getString("remark"));
%>
 <script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "../../purchase_credit_dealwith_purchase_ok?gather_ID=<%=rs.getString("gather_ID")%>";
}else{
form.action = "../../purchase_credit_dealwith_pay_ok?gather_ID=<%=rs.getString("gather_ID")%>";
}
}
</script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/stock/stock_apply_gather.xml','mutiValidation')&&TwoSubmit(this)">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","放货转采购单")%>&nbsp;<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind>&nbsp;<%=demo.getLang("erp","放货退回")%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
 </tr>
 </table>
<input type="hidden" name="purchasecredit_cost_price_sum" value="<%=purchasecredit_cost_price_sum%>">
<div id="nseerGround" class="nseerGround">
  <%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","放货登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","放货单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><input name="gather_ID" type="hidden" value="<%=rs.getString("gather_ID")%>"><%=rs.getString("gather_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","供应商名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="provider_name" type="hidden" value="<%=exchange.toHtml(rs.getString("gatherer_name"))%>"><%=exchange.toHtml(rs.getString("gatherer_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","供应商编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="provider_ID" type="hidden" value="<%=rs.getString("gatherer_ID")%>"><%=rs.getString("gatherer_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","电话")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_contact_person_tel"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","时间")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" onfocus="" value="<%=exchange.toHtml(time)%>"></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","处理数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","折扣（%）")%></td>
 </tr>
<%
int i=1;
String sql6="select * from stock_apply_gather_details where gather_ID='"+rs.getString("gather_ID")+"'";
ResultSet rs6=stock_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID<%=i%>" value="<%=rs6.getString("product_ID")%>" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" value="<%=exchange.toHtml(rs6.getString("product_name"))%>" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" value="<%=rs6.getString("product_describe")%>" onFocus="this.blur()"><%=rs6.getString("product_describe")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount<%=i%>" type="hidden"  value="<%=exchange.toHtml(rs6.getString("amount"))%>"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="dealwith_amount<%=i%>" value="<%=exchange.toHtml(rs6.getString("amount"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount_unit<%=i%>" type="hidden"  value="<%=exchange.toHtml(rs6.getString("amount_unit"))%>"><%=exchange.toHtml(rs6.getString("amount_unit"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price<%=i%>" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="off_discount<%=i%>"></td>
 </tr>
<%
	i++;
	}
%>
<input name="product_amount" type="hidden" value="<%=i-1%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总计")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%><input name="original_cost_price_sum" type="hidden"  value="<%=rs.getString("cost_price_sum")%>">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总件数")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("demand_amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","采购人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="purchaser" type="hidden" value="<%=exchange.toHtml(rs.getString("purchaser"))%>"><%=exchange.toHtml(rs.getString("purchaser"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","采购人编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="purchaser_ID" type="hidden" value="<%=rs.getString("purchaser_ID")%>"><%=rs.getString("purchaser_ID")%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">
 <input name="register_ID" type="hidden" value="<%=register_ID%>">
 <input name="register" type="hidden" value="<%=exchange.toHtml(register)%>"><%=exchange.toHtml(register)%></td>
<%
	 String type="";
String sql2="select * from purchase_file where provider_ID='"+rs.getString("gatherer_ID")+"'";
ResultSet rs2=stock_db.executeQuery(sql2);
if(rs2.next()){
	type=rs2.getString("type");
}
stock_db.close();
%>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","供应商区域")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="type" type="hidden" value="<%=exchange.toHtml(type)%>"><%=exchange.toHtml(type)%></td> 
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td  <%=TD_STYLE1%> class="TD_STYLE8" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>	
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
stockdb.close(); 
}
catch (Exception ex){
out.println("error"+ex);
}
%>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>