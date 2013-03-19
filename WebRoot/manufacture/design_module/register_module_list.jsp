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
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<%
String design_ID=request.getParameter("design_ID") ;
String procedure_name=exchange.unURL(request.getParameter("procedure_name")) ;
String product_ID="";
String sql1="select * from manufacture_design_procedure where design_ID='"+design_ID+"'";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	product_ID=rs1.getString("product_ID");
}
String sql="select * from design_module where product_ID='"+product_ID+"' and check_tag='1'";
ResultSet rs=design_db.executeQuery(sql);
if(rs.next()){
%>
<form id="register_module" method="POST" action="register_module_reconfirm.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","预览")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="history.back()" value="<%=demo.getLang("erp","返回")%>"></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","工序物料设计单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><input name="product_name1" type="hidden" value="<%=exchange.toHtml(rs.getString("product_name"))%>"><%=demo.getLang("erp","制造")%>:<%=rs.getString("product_name")%><%=demo.getLang("erp","产品，供选择的物料清单如下：")%>&nbsp;</td>
 
 </tr>
 </table>
<input name="procedure_name" type="hidden" value="<%=procedure_name%>">
<input name="design_ID" type="hidden" value="<%=design_ID%>">
<input name="module_design_ID" type="hidden" value="<%=rs.getString("design_ID")%>">
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","物料名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","物料编号")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","设计数量")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","可用数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","单价（元）")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","本工序数量")%></td>
 </tr>
<%
int i=1;
String sql6="select * from design_module_details where design_ID='"+rs.getString("design_ID")+"'";
ResultSet rs6=design_db.executeQuery(sql6);

while(rs6.next()){

%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_name" type="hidden" value="<%=rs6.getString("product_name")%>"><%=rs6.getString("product_name")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_ID" type="hidden" value="<%=rs6.getString("product_ID")%>"><%=rs6.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="type" type="hidden" value="<%=rs6.getString("type")%>"><input name="product_describe" type="hidden" value="<%=rs6.getString("product_describe")%>"><%=rs6.getString("product_describe")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value="<%=rs6.getString("amount")%>"><%=rs6.getDouble("amount")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="design_balance_amount" type="hidden" value="<%=rs6.getString("design_balance_amount")%>"><%=rs6.getDouble("design_balance_amount")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount_unit" type="hidden" value="<%=rs6.getString("amount_unit")%>"><%=rs6.getString("amount_unit")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price" type="hidden" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="using_amount" type="text"></td>
 </tr>
<%
	i++;
	}
	design_db.close();
	manufacture_db.close();
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%}else{%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="history.back()" value="<%=demo.getLang("erp","返回")%>"></div></td> 
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","物料组成设计尚未完成，不能进行工序物料设计，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td> 
 </tr>
 </table>
</div>
<%}%> 