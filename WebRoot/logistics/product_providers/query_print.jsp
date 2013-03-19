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
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db logistics_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db logisticsdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String product_logistics_recommend_ID=request.getParameter("product_logistics_recommend_ID") ;
try{
String sql="select * from logistics_product_providers_recommend where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"'";
ResultSet rs=logistics_db1.executeQuery(sql);
if(rs.next()){
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" class="Noprint"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","配送单位推荐单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","配置单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("product_logistics_recommend_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","推荐人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("recommender"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
 </tr>
  </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td width="5%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","序号")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","档案编号")%> </td>
 <td width="13%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","物流单位名称")%> </td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","所在区域")%></td>
 <td width="8%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","优质级别")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","电话")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","联系人")%></td>
 <td width="13%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","网址")%></td>
	</tr>
<%
	int count=0;
	String sql5="select count(*) from logistics_product_providers_recommend_details where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"'";
ResultSet rs5=logistics_db.executeQuery(sql5);
while(rs5.next()){
	count=rs5.getInt("count(*)");
}
if(count>20){
	int m=1;
String sql6="select * from logistics_product_providers_recommend_details where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' order by details_number";
ResultSet rs6=logistics_db.executeQuery(sql6);
while(m<=20){
	rs6.next();
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
<%
String sql7="select * from purchase_file where provider_ID='"+rs6.getString("provider_ID")+"'";
ResultSet rs7=logisticsdb.executeQuery(sql7);
while(rs7.next()){	
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("type"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_class"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_tel1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("contact_person1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_web"))%>&nbsp;</td>
 </tr>
<%
}
	m++;
	}
	logisticsdb.close();
%>
</table>
接下页
&nbsp;
<div class="PageNext"></div>
&nbsp;
承上页
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<%
for(int j=0;j<count-20;j++){
rs6.next();
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
<%
String sql7="select * from purchase_file where provider_ID='"+rs6.getString("provider_ID")+"'";
ResultSet rs7=logisticsdb.executeQuery(sql7);
while(rs7.next()){	
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("type"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_class"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_tel1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("contact_person1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_web"))%>&nbsp;</td>
 </tr>
<%
}
}
%>
</table>
<%}else{
String sql6="select * from logistics_product_providers_recommend_details where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' order by details_number";
ResultSet rs6=logistics_db.executeQuery(sql6);
while(rs6.next()){		 
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
<%
String sql7="select * from logistics_file where provider_ID='"+rs6.getString("provider_ID")+"'";
ResultSet rs7=logisticsdb.executeQuery(sql7);
while(rs7.next()){	
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("type"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_class"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_tel1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("contact_person1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_web"))%>&nbsp;</td>
 </tr>
<%
}
}
%>
</table>
<%
	 }
%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","推荐要求")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><%=rs.getString("recommend_describe")%>&nbsp;</td>
 </tr>
  </table>
 <%@include file="../include/paper_bottom.html"%>
 </div>
<%
}
	logistics_db.close();
	logistics_db1.close();
	logisticsdb.close(); 
}
catch (Exception ex){
out.println("error"+ex);
}
%>