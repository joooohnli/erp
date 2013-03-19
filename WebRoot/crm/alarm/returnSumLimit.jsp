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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
	double return_sum_limit1=0.0d;
	double return_sum_limit2=0.0d;
	double return_sum_limit3=0.0d;
	int intRowCount = 0;
	int intRowCount1 = 0;
	int intRowCount2 = 0;
	int intRowCount3 = 0;
	String sql1="select * from crm_config_public_double where kind='退货红警'";
	ResultSet rs1=crm_db.executeQuery(sql1) ;
	if(rs1.next()){
		return_sum_limit1=rs1.getDouble("type_value");
	}
	String sql2="select * from crm_config_public_double where kind='退货橙警'";
	ResultSet rs2=crm_db.executeQuery(sql2) ;
	if(rs2.next()){
		return_sum_limit2=rs2.getDouble("type_value");
	}
	String sql3="select * from crm_config_public_double where kind='退货黄警'";
	ResultSet rs3=crm_db.executeQuery(sql3) ;
	if(rs3.next()){
		return_sum_limit3=rs3.getDouble("type_value");
	}
	String sql4="select count(*) from crm_alarm_return_sum_limit where sum_over>='"+return_sum_limit1+"'";
	ResultSet rs4=crm_db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	String sql5="select count(*) from crm_alarm_return_sum_limit where sum_over>='"+return_sum_limit2+"' and sum_over<'"+return_sum_limit1+"'";
	ResultSet rs5=crm_db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	String sql6="select count(*) from crm_alarm_return_sum_limit where sum_over>='"+return_sum_limit3+"' and sum_over<'"+return_sum_limit2+"'";
	ResultSet rs6=crm_db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
	String sql7 = "select count(*) from crm_alarm_return_sum_limit" ;
	ResultSet rs7 = crm_db.executeQuery(sql7) ;
	if(rs7.next()){
	intRowCount = rs7.getInt("count(*)");
	}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>	 
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","当前退货超额报警的客户总数")%>：<%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><font color="red"><%=demo.getLang("erp","I级报警的客户总数")%>：<%=intRowCount1%><%=demo.getLang("erp","例")%>，<font color="orange"><%=demo.getLang("erp","II级报警的客户总数")%>：<%=intRowCount2%><%=demo.getLang("erp","例")%>，<font color="darkturquoise"><%=demo.getLang("erp","III级报警的客户总数")%>：<%=intRowCount3%><%=demo.getLang("erp","例")%>。</td>
 </tr>
 </table>
  <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","客户编号")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="21%"><%=demo.getLang("erp","客户名称")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","退货报警额度（元）")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","退货额度（元）")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","超额（元）")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="20">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="20">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="20">&nbsp;</td>
 </tr>
<%	
String sql = "select * from crm_alarm_return_sum_limit order by sum_over desc" ;
	ResultSet rs = crm_db.executeQuery(sql) ;
	while(rs.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="17%"><a href="../../file/query.jsp?customer_ID=<%=rs.getString("customer_ID")%>"><%=rs.getString("customer_ID")%></a></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="21%"><%=exchange.toHtml(rs.getString("customer_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("return_sum_limit"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("gather_sum_absent"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sum_over"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="20">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20">&nbsp;</td>
 </tr>
<%
}
crm_db.close();
%>
</table>
</div>
 

