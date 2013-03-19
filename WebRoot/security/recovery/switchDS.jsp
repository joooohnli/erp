<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,include.data_backup.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<%
String path=application.getRealPath("/");
String filename=path+"WEB-INF/dynamic_backup.xml";
nseer_db_backup db=new nseer_db_backup(application);
String ipm=db.getMasterIp();
String ips=db.getIp();
String status="";
Solid so=new Solid(filename);
String status1=so.getValue((String)session.getAttribute("unit_db_name"));
String dynamic=so.getDynamic((String)session.getAttribute("unit_db_name"));
if(ipm!=null&&ips!=null){
	if(status1.equals("0")){
status=demo.getLang("erp","主数据源地址：")+ipm+","+demo.getLang("erp","从数据源地址：")+demo.getLang("erp","无");
	}else{
status=demo.getLang("erp","主数据源地址：")+ipm+","+demo.getLang("erp","从数据源地址：")+ips;
	}
if(dynamic.equals("5")){
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","已设置从数据源，尚未重新启动系统，无法切换！")%></td>
</tr>
 </table>
<%}else{%>
<form id="priceAlarm" method="POST" action="switchDS_change.jsp">
<input type="hidden" name="ipm" value="<%=ipm%>">
<input type="hidden" name="ips" value="<%=ips%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value= "<%=demo.getLang("erp","切换")%>"></div></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=status%></td>
<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
</tr>
</table>
</form> 
<%}}else{
status=demo.getLang("erp","尚未设置");
%>
<form id="priceAlarm" method="POST" action="switchDS_change.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value= "<%=demo.getLang("erp","设置")%>"></div></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","主或从数据源地址：")%><%=status%></td>
<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
</tr>
</table>
</form> 
<%}
%>
</div>