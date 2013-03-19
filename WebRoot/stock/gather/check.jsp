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
<jsp:useBean id="available" class="stock.getAvailable" scope="request"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script language="javascript" src="../../javascript/stock/gather/gather.js"></script>
<%
try{

String gather_ID=request.getParameter("gather_ID") ;
String config_id=request.getParameter("config_id");
String gathering_time=request.getParameter("gathering_time");
String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
String stock_ID="";
String sql9="select * from stock_workflow where object_ID='"+gather_ID+"' and check_tag='0' and gathering_time='"+gathering_time+"' and config_id<'"+config_id+"'";
ResultSet rs9=stockdb.executeQuery(sql9);
if(!rs9.next()){
String sql8="select * from stock_paying_gathering where gather_ID='"+gather_ID+"' and check_tag='0' order by details_number";
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
String sql="select * from stock_gather where gather_ID='"+gather_ID+"'";
ResultSet rs=stockdb.executeQuery(sql);
if(rs.next()){
%>
 <script language="javascript">
function TwoSubmit(){
var form=document.getElementById('mutiValidation');
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>&gather_ID=<%=rs.getString("gather_ID")%>&gathering_time=<%=rs.getString("gathering_time")%>";
form.submit();
}else{
if(formSubmit1('<%=rs.getString("reason")%>','<%=rs.getString("qcs_dealwith_tag")%>')){
form.action = "../../stock_gather_check_ok?config_id=<%=config_id%>&gather_ID=<%=rs.getString("gather_ID")%>&gathering_time=<%=rs.getString("gathering_time")%>";
form.submit();
}
}
}
</script>
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
 <form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/stock/stock_gather.xml','mutiValidation')">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1" onClick="TwoSubmit()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","入库单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","入库单编号")%>：</td>
 <td colspan="3" <%=TD_STYLE2%> class="TD_STYLE2" width="87%"><input name="gather_ID" type="hidden" value="<%=gather_ID%>"><%=gather_ID%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","入库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reason" type="hidden" value="<%=exchange.toHtml(rs.getString("reason"))%>"><%=exchange.toHtml(rs.getString("reason"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","入库详细理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reasonexact" type="hidden" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>"><%=exchange.toHtml(rs.getString("reasonexact"))%>/<%=exchange.toHtml(rs.getString("reasonexact_details"))%><input name="reasonexact_details" type="hidden" value="<%=rs.getString("reasonexact_details")%>">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5"> 
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品编号")%> </td>
 <td width="13%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品名称")%> </td>
	 <td width="12%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","库房名称")%> </td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应入库件数")%></td>
	 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","已入库件数")%> </td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本次入库数量")%> </td>
	 <td width="13%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","审核序列号")%></td>
	</tr>
<%
String design_ID="";
String sql6="select * from stock_paying_gathering where gather_ID='"+gather_ID+"' and check_tag='0' order by details_number";
	ResultSet rs6=stock_db.executeQuery(sql6);
	while(rs6.next()){
		int serial_number_tag=0;
		String sql1="select * from stock_cell where product_ID='"+rs6.getString("product_ID")+"' and check_tag='1'";
		ResultSet rs1=stock_db1.executeQuery(sql1);
		if(rs1.next()){
			serial_number_tag=rs1.getInt("serial_number_tag");
		}
%>
<input name="id" type="hidden" value="<%=rs6.getString("id")%>">
<input name="product_ID" type="hidden" value="<%=rs6.getString("product_ID")%>">
<input name="product_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("product_name"))%>">
<input name="stock_ID" type="hidden" value="<%=rs6.getString("stock_ID")%>">
<input name="stock_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("stock_name"))%>">
<input name="nick_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("nick_name"))%>">
<input name="max_capacity_amount" type="hidden" value="<%=rs6.getString("max_capacity_amount")%>">
<input name="available_amount" type="hidden" value="<%=new Double(rs6.getDouble("max_capacity_amount")*available.available((String)session.getAttribute("unit_db_name"),rs6.getString("stock_name"))).intValue()%>">
<input name="cost_price" type="hidden" value="<%=rs6.getString("cost_price")%>">
<input name="gathered_subtotal" type="hidden" value="<%=rs6.getDouble("gathered_subtotal")%>">
<input name="demand_amount" type="hidden" value="<%=rs6.getDouble("demand_amount")%>">
<input name="gathered_amount" type="hidden" value="<%=rs6.getDouble("gathered_amount")%>">
<input name="details_number" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=rs6.getString("details_number")%>">
<input name="serial_number_group" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=rs6.getString("serial_number")%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("stock_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("demand_amount")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("gathered_amount")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" value="<%=rs6.getDouble("amount")%>"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%if(serial_number_tag==1){%><a href="check_serial_number.jsp?gather_ID=<%=gather_ID%>&&product_ID=<%=rs6.getString("product_ID")%>&&stock_ID=<%=rs6.getString("stock_ID")%>"><%=demo.getLang("erp","审核S/N")%><%}else if(serial_number_tag==2){%><a href="check_serial_number.jsp?gather_ID=<%=gather_ID%>&&product_ID=<%=rs6.getString("product_ID")%>&&stock_ID=<%=rs6.getString("stock_ID")%>"><%=demo.getLang("erp","审核B/N")%><%}else{%>&nbsp;<%}%></td>
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
<%
if((rs.getString("reason").equals("采购入库")||rs.getString("reason").equals("委外入库"))&&rs.getString("qcs_dealwith_tag").equals("3")){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检合格数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getDouble("qualified_amount")%><input type="hidden" id="qualified_amount" value="<%=rs.getDouble("qualified_amount")%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
 </tr>
<%}%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应入库总件数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getDouble("demand_amount")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已入库总件数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input id="gathered_total_amount" type="hidden" value="<%=rs.getDouble("gathered_amount")%>"><%=rs.getDouble("gathered_amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应入库总成本")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已入库总成本")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("gathered_cost_price_sum"))%>&nbsp;</td>
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
	 }catch(Exception ex){ex.printStackTrace();}
stock_db.close();
stock_db1.close();
stockdb.close();
%>