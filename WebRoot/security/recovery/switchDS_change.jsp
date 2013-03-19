<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*,include.data_backup.*" import ="include.nseer_db.*,java.text.*"%>
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
String ipm=request.getParameter("ipm");
String ips=request.getParameter("ips");
String path=application.getRealPath("/");
String filename=path+"WEB-INF/dynamic_backup.xml";
Solid so=new Solid(filename);
String status1=so.getValue((String)session.getAttribute("unit_db_name"));
if(status1.equals("1")){
%>
<form id="mutiValidation" method="POST" action="../../security_recovery_switchDS_change_ok">
<input type="hidden" name="ipm" value="<%=ipm%>">
<input type="hidden" name="ips" value="<%=ips%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" width="80%"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" width="20%"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="switchDS.jsp"></div></td>
</tr>
</table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" width="80%"><%=demo.getLang("erp","要想切换成功，必须重新启动系统，")%><%=demo.getLang("erp","重启后系统仍为实时备份策略，")%><%=demo.getLang("erp","您确认现在切换吗？")%></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" width="20%"></td>
</tr>
</table> 
</form>
<%}else{%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="80%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="20%"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="switchDS.jsp"></div></td>
 </tr>
 </table> 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="80%"><%=demo.getLang("erp","未启用实时备份或已经切换数据源，")%><%=demo.getLang("erp","无法切换，")%><%=demo.getLang("erp","请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="20%"></td>
 </tr>
 </table> 
<%}%>
 </tr>
 </table>
 </div>