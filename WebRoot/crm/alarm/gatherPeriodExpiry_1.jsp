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
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%> 
<script src="../../javascript/table/movetable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
	double gather_period_limit1=0;
	double gather_period_limit2=0;
	double gather_period_limit3=0;
	int intRowCount1 = 0;
	int intRowCount2 = 0;
	int intRowCount3 = 0;
	String sql1="select * from crm_config_public_double where kind='回款红警'";
	ResultSet rs1=crm_db.executeQuery(sql1) ;
	if(rs1.next()){
		gather_period_limit1=rs1.getDouble("type_value");
	}
	String sql2="select * from crm_config_public_double where kind='回款橙警'";
	ResultSet rs2=crm_db.executeQuery(sql2) ;
	if(rs2.next()){
		gather_period_limit2=rs2.getDouble("type_value");
	}
	String sql3="select * from crm_config_public_double where kind='回款黄警'";
	ResultSet rs3=crm_db.executeQuery(sql3) ;
	if(rs3.next()){
		gather_period_limit3=rs3.getDouble("type_value");
	}
	String sql4="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit1+"'";
	ResultSet rs4=crm_db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	String sql5="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit2+"' and period_expiry_over<'"+gather_period_limit1+"'";
	ResultSet rs5=crm_db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	String sql6="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit3+"' and period_expiry_over<'"+gather_period_limit2+"'";
	ResultSet rs6=crm_db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
%>
<%
int m=0;
String sql = "select * from crm_alarm_gather_expiry order by period_expiry_over desc" ;
String sql_search=sql;
%>
<%@include file="../../include/list_page.jsp"%>
 <input type="hidden" name="amount" value="<%=intRowCount%>">
<%
	ResultSet rs = crm_db.executeQuery(sql) ;
if(intRowCount!=0){
	session.setAttribute("task_content","none");
%>
<form method="post" action="gatherPeriodExpiry_remind_1.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1" colspan="2">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","回款报警")%>：<%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","督办")%>"></div>
  </td>
 </tr> 
</table>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","订单编号")%>'},
					   {name: '<%=demo.getLang("erp","点选")%>'}
]
nseer_grid.column_width=[100,40];
nseer_grid.auto='<%=demo.getLang("erp","订单编号")%>';
nseer_grid.data = [
<%
	while(rs.next()){
String color1="";
if(rs.getDouble("period_expiry_over")>=gather_period_limit1){
	color1="red";
}else if(rs.getDouble("period_expiry_over")>=gather_period_limit2&&rs.getDouble("period_expiry_over")<gather_period_limit1){
	color1="orange";
}else if(rs.getDouble("period_expiry_over")>=gather_period_limit3&&rs.getDouble("period_expiry_over")<gather_period_limit2){
	color1="darkturquoise";
}
			String color="";
if(rs.getString("remind_tag").equals("1")){
color1="plum";
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../order/query.jsp?order_ID=<%=rs.getString("order_ID")%>")><span style="color:<%=color1%>"><%=rs.getString("order_ID")%></span></div>','<span style="color:<%=color1%>"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=m%>" value="<%=rs.getString("order_ID")%>/<%=rs.getString("id")%>"></span>'],
<%
m++;
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
<%
}else{
%>
<table valign="center">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td><%session.removeAttribute("task_content");%></td>
</tr>
</table>
<%}
crm_db.close();
%>