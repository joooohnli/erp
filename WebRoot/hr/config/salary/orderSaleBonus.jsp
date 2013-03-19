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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String pay_type=""; 
String bonus_cost_for_profit_type=""; 
String sql = "select * from hr_config_public_char where kind='订单销售绩效计算方式'";
ResultSet rs = hr_db.executeQuery(sql) ;
if(rs.next()){
bonus_cost_for_profit_type=rs.getString("bonus_cost_for_profit_type");
pay_type=rs.getString("type_name");
}else{
pay_type="尚未设置";
}
hr_db.close();
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","设置")%>" onClick=location="orderSaleBonus_change.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<%if(pay_type.equals("按毛利润计算")){%>
	<td <%=TD_STYLE3%> class="TD_STYLE3"><p align=left><%=demo.getLang("erp","销售绩效计算方式：")%><%=pay_type%>（<%=bonus_cost_for_profit_type%>）</td>
	<%}else{%>
	<td <%=TD_STYLE3%> class="TD_STYLE3"><p align=left><%=demo.getLang("erp","销售绩效计算方式：")%><%=pay_type%></td>
	<%}%>
 </tr>
 </table>
  </div>