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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%
String register_ID=(String)session.getAttribute("human_ID");
String manufacture_ID=request.getParameter("manufacture_ID") ;
String procedure_name=exchange.unURL(request.getParameter("procedure_name")) ;
String register_ID_group="";
String sql1="select * from manufacture_config_public_char where kind='工序'&&type_name='"+procedure_name+"'";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	register_ID_group=rs1.getString("register_ID");
}
int a=register_ID_group.indexOf(register_ID);
if(a!=-1){
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close()"></div></td> 
 </tr>
 </table>
<%
double labour_hour_amount=0.0d;
double subtotal=0.0d;
String sql="select sum(labour_hour_amount),sum(subtotal) from manufacture_proceduring where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"'";
ResultSet rs=manufacture_db.executeQuery(sql);
while(rs.next()){
	labour_hour_amount=rs.getDouble("sum(labour_hour_amount)");
	subtotal=rs.getDouble("sum(subtotal)");
}
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="140"><%=demo.getLang("erp","派工单编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="242"><%=manufacture_ID%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="140"><%=demo.getLang("erp","工序名称")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="242"><%=exchange.toHtml(procedure_name)%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="140"><%=demo.getLang("erp","实际工时数")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="242"><%=labour_hour_amount%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="140"><%=demo.getLang("erp","实际工时成本")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="242"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(subtotal)%>&nbsp;</td>
	</tr>
 </table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="140"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="62"><%=demo.getLang("erp","负责人")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="21%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="82"><%=demo.getLang("erp","本次工时数")%> </td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="7%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","单位工时成本（元）")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","本次工时成本（元）")%></td>
 </tr>
<%
try{
String sql6="select * from manufacture_proceduring where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' order by register_time";
ResultSet rs6=manufacture_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("register_time"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("procedure_responsible_person"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("procedure_describe")%>&nbsp;</td>	 
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("labour_hour_amount")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("register"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 </tr>
<%
	}
	manufacture_db.close();
%>
</table>
<%
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	manufacture_db.close();
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有被授权进行本工序的登记。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close()"></div></td> 
 </tr>
 </table>
<%}%> 