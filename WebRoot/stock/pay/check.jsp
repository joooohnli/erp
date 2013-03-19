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
<%nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="available" class="stock.getBalanceAmountDetails" scope="request"/>
<jsp:useBean id="length" class="stock.getLength" scope="request"/>
<jsp:useBean id="getRateFromID" class="include.get_rate_from_ID.getRateFromID" scope="page"/>
<%@include file="../include/head.jsp"%>
<script language="javascript" src="x"></script>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<%

int lll=0;
String pay_ID=request.getParameter("pay_ID") ;
String config_id=request.getParameter("config_id");
String paying_time=request.getParameter("paying_time");
String product_ID=request.getParameter("product_ID") ;
String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
String stock_ID="";
String sql9="select * from stock_workflow where object_ID='"+pay_ID+"' and check_tag='0' and paying_time='"+paying_time+"' and config_id<'"+config_id+"'";
ResultSet rs9=stockdb.executeQuery(sql9);
if(!rs9.next()){
String sql8="select * from stock_paying_gathering where pay_ID='"+pay_ID+"' and check_tag='0' order by details_number";
	ResultSet rs8=stockdb.executeQuery(sql8);
	if(rs8.next()){
try{
	
String sql3="select * from stock_config_public_char where describe1='库房' and responsible_person_ID like '%"+checker_id+"%'";
ResultSet rs3=stockdb.executeQuery(sql3);
while(rs3.next()){
	stock_ID+=rs3.getString("stock_ID")+",";
}
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql="select * from stock_pay where pay_ID='"+pay_ID+"'";
ResultSet rs=stockdb.executeQuery(sql);
if(rs.next()){
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
  form.action='check_delete_reconfirm.jsp?config_id=<%=config_id%>&pay_ID=<%=rs.getString("pay_ID")%>&paying_time=<%=rs.getString("paying_time")%>';
  form.submit();
}else{
checkOk();
}
}
</script>
<script language="javascript" src="../../javascript/stock/pay/stock.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/stock/stock_pay.xml','mutiValidation')&&TwoSubmit(this)">
 <input type="hidden" name="config_id" value="<%=config_id%>">
 <input type="hidden" name="paying_time" value="<%=paying_time%>">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="TwoSubmit(document.getElementById('mutiValidation'))" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","出库单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><input name="pay_ID" type="hidden" value="<%=pay_ID%>"><%=pay_ID%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reason" type="hidden" value="<%=exchange.toHtml(rs.getString("reason"))%>"><%=exchange.toHtml(rs.getString("reason"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库详细理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reasonexact" type="hidden" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>"><%=exchange.toHtml(rs.getString("reasonexact"))%>&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","产品名称 ")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","库房名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","当前库存数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","质检合格数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","应出库件数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","已出库件数")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","本次出库数量")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="18%"><%=demo.getLang("erp","审核序列号")%></td>
	</tr>
<%
	int j=1;
String design_ID="";
String sql6="select * from stock_paying_gathering where pay_ID='"+pay_ID+"' and check_tag='0' order by details_number";
	ResultSet rs6=stock_db.executeQuery(sql6);
	while(rs6.next()){
		int serial_number_tag=0;
		String sql1="select * from stock_cell where product_ID='"+rs6.getString("product_ID")+"' and check_tag='1'";
		ResultSet rs1=stock_db1.executeQuery(sql1);
		if(rs1.next()){
			serial_number_tag=rs1.getInt("serial_number_tag");
		}
		if(serial_number_tag==1){
		lll=length.getLength((String)session.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)session.getAttribute("unit_db_name"));
			}
String qualified_amount="";
sql9="select qualified_amount from stock_pre_paying where product_ID='"+rs6.getString("product_ID")+"' and pay_id='"+pay_ID+"' and stock_id='"+rs6.getString("stock_ID")+"'";
rs9=stock_db1.executeQuery(sql9);
if(rs9.next()){
qualified_amount=rs9.getString("qualified_amount");
}
%>
<input name="id" type="hidden" value="<%=rs6.getString("id")%>">
<input name="product_ID" type="hidden" value="<%=rs6.getString("product_ID")%>">
<input name="product_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("product_name"))%>">
<input name="stock_ID" type="hidden" value="<%=rs6.getString("stock_ID")%>">
<input name="stock_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("stock_name"))%>">
<input name="nick_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("nick_name"))%>">
<input name="available_amount" type="hidden" value="<%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),rs6.getString("stock_name"))%>">
<input name="cost_price" type="hidden" value="<%=getRateFromID.getRateFromID((String)session.getAttribute("unit_db_name"),"design_file","product_ID",rs6.getString("product_ID"),"real_cost_price")%>">
<input name="paid_subtotal" type="hidden" value="<%=rs6.getDouble("paid_subtotal")%>">
<input name="demand_amount" type="hidden" value="<%=rs6.getDouble("demand_amount")%>">
<input name="paid_amount" type="hidden" value="<%=rs6.getDouble("paid_amount")%>">
<input name="details_number" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=rs6.getString("details_number")%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("stock_name"))%>&nbsp;</td>
<%if(serial_number_tag==1){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="check_choose.jsp?product_ID=<%=rs6.getString("product_ID")%>&&stock_ID=<%=rs6.getString("stock_ID")%>&&pay_ID=<%=pay_ID%>"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),rs6.getString("stock_name"))%></a>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=qualified_amount%></td><input type="hidden" id="qualified_amount<%=j%>" value="<%=qualified_amount%>">
<%}else if(serial_number_tag==2){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="check_choose_bat.jsp?product_ID=<%=rs6.getString("product_ID")%>&&stock_ID=<%=rs6.getString("stock_ID")%>&&pay_ID=<%=pay_ID%>"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),rs6.getString("stock_name"))%></a>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=qualified_amount%></td><input type="hidden" id="qualified_amount<%=j%>" value="<%=qualified_amount%>">
<%}else{%>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),rs6.getString("stock_name"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=qualified_amount%></td><input type="hidden" id="qualified_amount<%=j%>" value="<%=qualified_amount%>">
<%}%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("demand_amount")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("paid_amount")%>&nbsp;<input type="hidden" id="paid_amount<%=j%>" value="<%=rs6.getDouble("paid_amount")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="amount<%=j%>" name="amount" value="<%=rs6.getDouble("amount")%>"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%if(serial_number_tag==1){%><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" size="<%=lll-1%>" name="serial_number_group" value="<%=rs6.getString("serial_number")%>" style="width:75%;background-color:#FFFFCC"><input name="amount_number_group" type="hidden" size="<%=lll-1%>" value="<%=rs6.getString("amount_number")%>">(S/N)<%}else if(serial_number_tag==2){%><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="serial_number_group" size="<%=lll-1%>" value="<%=rs6.getString("serial_number")%>" style="width:75%;background-color:#FFFFCC"><input name="amount_number_group" type="hidden" size="<%=lll-1%>" value="<%=rs6.getString("amount_number")%>">(B/N)<%}else{%><input name="serial_number_group" type="hidden" value=""><input name="amount_number_group" type="hidden" value=""><%}%></td>
 </tr>
<%
		 j++;
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应出库总件数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getDouble("demand_amount")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已出库总件数")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getDouble("paid_amount")%>&nbsp;</td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应出库总成本")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已出库总成本")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("paid_cost_price_sum"))%>&nbsp;</td>
 </tr>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=exchange.toHtml(checker)%>"><input name="checker_id" type="hidden" value="<%=checker_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回！")%></td>
 </tr>
 </table>
 </div>
<%}}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回！")%></td>
 </tr>
 </table>
 </div>
<%}
stock_db.close();
stock_db1.close();
stockdb.close();
%>