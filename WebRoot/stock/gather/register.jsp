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
<jsp:useBean id="length" class="stock.getLength" scope="request"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script language="javascript" src="../../javascript/stock/gather/gather.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%

int lll=0;
String gather_ID=request.getParameter("gather_ID") ;
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
String stock_ID="";
try{
String sql3="select * from stock_config_public_char where describe1='库房' and responsible_person_ID like '%"+register_ID+"%'";
ResultSet rs3=stock_db.executeQuery(sql3);
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

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="../../stock_gather_register_ok">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><%=DgButton.getDraft("'mutiValidation','../../stock_gather_register_draft_ok','../../xml/stock/stock_gather.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>" onclick="formSubmit('<%=rs.getString("reason")%>','<%=rs.getString("qcs_dealwith_tag")%>');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('register_print.jsp?gather_ID=<%=gather_ID%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><input name="gather_ID" type="hidden" value="<%=gather_ID%>"><%=gather_ID%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","入库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reason" type="hidden" value="<%=exchange.toHtml(rs.getString("reason"))%>"><%=exchange.toHtml(rs.getString("reason"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","入库详细理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reasonexact1" type="hidden" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>/<%=exchange.toHtml(rs.getString("reasonexact_details"))%>"><input name="reasonexact" type="hidden" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>"><%=exchange.toHtml(rs.getString("reasonexact"))%>/<%=exchange.toHtml(rs.getString("reasonexact_details"))%><input name="reasonexact_details" type="hidden" value="<%=exchange.toHtml(rs.getString("reasonexact_details"))%>">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品编号")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品名称")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","库房名称")%></td>
 <td width="8%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应入库件数")%></td>
 <td width="8%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","已入库件数")%></td>
 <td width="10%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本次入库数量")%></td>
 <td width="16%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","序列号")%></td>
 </tr>
<%
int i=1;
String sql6="select * from stock_pre_gathering where gather_ID='"+gather_ID+"'";
ResultSet rs6=stock_db.executeQuery(sql6);
while(rs6.next()){
if(stock_ID.indexOf(rs6.getString("stock_ID"))!= -1){
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
%>
<input name="product_ID" type="hidden" value="<%=rs6.getString("product_ID")%>" />
<input name="product_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("product_name"))%>"/>
<input name="stock_ID" type="hidden" value="<%=rs6.getString("stock_ID")%>"/>
<input name="stock_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("stock_name"))%>"/>
<input name="nick_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("nick_name"))%>"/>
<input name="max_capacity_amount" type="hidden" value="<%=rs6.getString("max_capacity_amount")%>"/>
<input name="available_amount" type="hidden" value="<%=new Double(rs6.getDouble("max_capacity_amount")*available.available((String)session.getAttribute("unit_db_name"),rs6.getString("stock_name"))).intValue()%>"/>
<input name="cost_price" type="hidden" value="<%=rs6.getString("cost_price")%>"/>
<input name="gathered_subtotal" type="hidden" value="<%=rs6.getDouble("gathered_subtotal")%>"/>
<input name="demand_amount" type="hidden" value="<%=rs6.getDouble("amount")%>"/>
<input name="gathered_amount" type="hidden" value="<%=rs6.getDouble("gathered_amount")%>"/>
<input name="details_number" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=i%>"/>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("stock_name"))%>&nbsp;</td>	 
     <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("amount")%>&nbsp;</td>	 
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("gathered_amount")%>&nbsp;</td>
<%if(rs6.getString("gather_check_tag").equals("0")&&!rs6.getString("gather_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="amount" name="amount"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">
	 <%if(serial_number_tag==1){%>
	 <input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="serial_number" size="<%=lll-1%>" style="width:75%;background-color:#FFFFCC">(S/N)<%}else if(serial_number_tag==2){%><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="serial_number" size="<%=lll-1%>" style="width:75%;background-color:#FFFFCC">(B/N)<%}else{%><input name="serial_number" type="hidden" size="<%=lll-1%>" value=""><%}%></td>
<%}else if(rs6.getString("gather_check_tag").equals("1")&&!rs6.getString("gather_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","等待审核")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="serial_number" type="hidden" value="">&nbsp;</td>
<%}else if(rs6.getString("gather_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","完成")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="serial_number" type="hidden" value="">&nbsp;</td>
<%}%>
 </tr>
<%
		}
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="demand_amount1" type="hidden" value="<%=rs.getDouble("demand_amount")%>"><%=rs.getDouble("demand_amount")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已入库总件数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="gathered_amount1" type="hidden" value="<%=rs.getDouble("gathered_amount")%>"><%=rs.getDouble("gathered_amount")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应入库总成本")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="cost_price_sum" type="hidden" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已入库总成本")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="gathered_cost_price_sum" type="hidden" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("gathered_cost_price_sum"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("gathered_cost_price_sum"))%>&nbsp;</td>
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
stock_db.close();
stock_db1.close();
stockdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>