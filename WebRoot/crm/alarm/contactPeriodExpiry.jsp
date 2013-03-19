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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<form method="post" action="contactPeriodExpiry_remind.jsp"> 
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js"></script>
<%
	double contact_period_limit1=0;
	double contact_period_limit2=0;
	double contact_period_limit3=0;
	int intRowCount1 = 0;
	int intRowCount2 = 0;
	int intRowCount3 = 0;
	String sql1="select * from crm_config_public_double where kind='联络红警'";
	ResultSet rs1=crm_db.executeQuery(sql1) ;
	if(rs1.next()){
		contact_period_limit1=rs1.getDouble("type_value");
	}
	String sql2="select * from crm_config_public_double where kind='联络橙警'";
	ResultSet rs2=crm_db.executeQuery(sql2) ;
	if(rs2.next()){
		contact_period_limit2=rs2.getDouble("type_value");
	}
	String sql3="select * from crm_config_public_double where kind='联络黄警'";
	ResultSet rs3=crm_db.executeQuery(sql3) ;
	if(rs3.next()){
		contact_period_limit3=rs3.getDouble("type_value");
	}
	String sql4="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit1+"'";
	ResultSet rs4=crm_db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	String sql5="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit2+"' and period_expiry_over<'"+contact_period_limit1+"'";
	ResultSet rs5=crm_db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	String sql6="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit3+"' and period_expiry_over<'"+contact_period_limit2+"'";
	ResultSet rs6=crm_db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","督办")%>"></div></td>
 </tr>
 </table>

<%
int p=0;
String sql = "select * from crm_alarm_contact_expiry order by period_expiry_over desc" ;
String sql_search=sql;
%>
<%@include file="../../include/list_page.jsp"%>
 <input type="hidden" name="amount" value="<%=intRowCount%>">
<%
	ResultSet rs = crm_db.executeQuery(sql) ;
%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","客户编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","最近联络时间")%>'},
                       {name: '<%=demo.getLang("erp","要求联络期限（天）")%>'},
                       {name: '<%=demo.getLang("erp","未联络时间（天）")%>'},
					   {name: '<%=demo.getLang("erp","超期（天）")%>'},
					   {name: '<%=demo.getLang("erp","点选")%>'}
]
nseer_grid.column_width=[180,200,160,120,100,100,40];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<%

	while(rs.next()){
String color1="";
if(rs.getDouble("period_expiry_over")>=contact_period_limit1){
	color1="red";
}else if(rs.getDouble("period_expiry_over")>=contact_period_limit2&&rs.getDouble("period_expiry_over")<contact_period_limit1){
	color1="orange";
}else if(rs.getDouble("period_expiry_over")>=contact_period_limit3&&rs.getDouble("period_expiry_over")<contact_period_limit2){
	color1="darkturquoise";
}
String color="";
if(rs.getString("remind_tag").equals("1")){
color1="plum";
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?customer_ID=<%=rs.getString("customer_ID")%>")><span style="color:<%=color1%>"><%=rs.getString("customer_ID")%></span></div>','<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("customer_name"))%></span>','<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("lately_contact_time"))%></span>','<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("contact_period_limit"))%></span>','<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("contact_period_expiry"))%></span>','<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("period_expiry_over"))%></span>','<span style="color:<%=color1%>"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=p%>" value="<%=rs.getString("customer_ID")%>/<%=rs.getString("id")%>">&nbsp;</span>'],
<%
p++;
}
crm_db.close();
%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
</form>
<page:updowntag num="<%=intRowCount%>" file="contactPeriodExpiry.jsp"/> 
<%@include file="../../include/head_msg.jsp"%>