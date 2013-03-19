<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*"%>
<%@include file="../../include/head.jsp"%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../../javascript/winopen/winopenm.js"></script>
<%
String id=request.getParameter("id");
try{
	String sql = "select * from ecommerce_contact where id='"+id+"'" ;
	ResultSet rs = ecommerce_db.executeQuery(sql) ;
	while(rs.next()){
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" style="width: 50; " onClick="javascript:winopen('query_print.jsp?id=<%=id%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE7%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("tel"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","传真")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("fax"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("email"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("postcode"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=exchange.toHtml(rs.getString("address"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务1")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("qq1"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务2")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("qq2"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务3")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("qq3"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务4")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("qq4"))%>&nbsp;</td>
 </tr>

  <%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment1"),0);
%>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","附件")%></td>
 <%
if(rs.getString("attachment1").equals("")){	
%>
	<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
<%}else{%>
	
	<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=ecommerce_contact&fieldname=attachment1')">
<%=attachment_name1[1]%></a>&nbsp;</td>
<%}%>

 
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
 </table>
 </div>
<%
}
ecommerce_db.close(); 
}
catch (Exception ex){
out.println("error2:"+ex);
}
%>