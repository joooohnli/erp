<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import
="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="getRateFromID" class="include.get_rate_from_ID.getRateFromID" scope="page"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
 </tr>
</table>
<%

String product_ID=request.getParameter("product_ID") ;
String product_name=exchange.unURL(request.getParameter("product_name")) ;
%>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","库存明细单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=product_ID%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(product_name)%></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","库房名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","存储地址")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","当前库存数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","质检不合格数")%></td>
	</tr>
<%
int i=1;
try{
	String sql1="select * from stock_balance_details where product_ID='"+product_ID+"' order by stock_ID";
	ResultSet rs1=stock_db.executeQuery(sql1);
	while(rs1.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("stock_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("nick_name"))%>&nbsp;</td>

<%
double serial_number_tag=getRateFromID.getRateFromID((String)session.getAttribute("unit_db_name"),"stock_cell","product_ID",product_ID,"serial_number_tag");
if(serial_number_tag==0){
%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getDouble("amount")%>&nbsp;</td>

<%}else if(serial_number_tag==1){%>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="queryBalance_sn_details_getpara.jsp?product_ID=<%=product_ID%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(product_name))%>&&stock_name=<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("stock_name")))%>&&amount=<%=rs1.getDouble("amount")%>"><%=rs1.getDouble("amount")%></a>&nbsp;</td>
 </tr>
	<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><a href="queryBalance_bn_details_getpara.jsp?product_ID=<%=product_ID%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(product_name))%>&&stock_name=<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("stock_name")))%>&&amount=<%=rs1.getDouble("amount")%>"><%=rs1.getDouble("amount")%></a>&nbsp;</td>
<%}%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getDouble("unqualified_amount")%>&nbsp;</td>
<%
		 i++;
	}
%>
</table>
</div>
<%@include file="../include/paper_bottom.html"%>
<%
stock_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>