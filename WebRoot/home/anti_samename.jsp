<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" %>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>
<html>
<%@include file="head.jsp"%>
　
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
 
<%
String name = request.getParameter("name") ;
String unit_id = request.getParameter("unit_id") ;
name=unit_id+"_"+name;
nseer_db erp_db = new nseer_db("mysql");
try{
String sql1="select * from unit_info where unit_id='"+unit_id+"'";
ResultSet rs1=erp_db.executeQuery(sql1) ;
if(rs1.next()){
erp_db = new nseer_db(rs1.getString("unit_db_name"));
 
	String sql="select * from security_users where name='"+name+"'";
	ResultSet rset=erp_db.executeQuery(sql) ;
if(rset.next()){
%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font size="2"><%=demo.getLang("erp","对不起，用户重名，请重试！")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">　
  <p align="center"><input type="button" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></td>
 </tr>
 </table>
 
<%}else{%>

 <center>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font size="2"><%=demo.getLang("erp","恭喜您，用户名可用，请继续注册！")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">　
  <p align="center"><input type="button" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></td>
 </tr>
 </table>
 
<%
}}else{%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font size="2"><%=demo.getLang("erp","对不起，单位简称错误，请重试！")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="15%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">　
  <p align="center"><input type="button" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></td>
 </tr>
 </table>

<%
}
erp_db.close();
}
catch (Exception ex){
	ex.printStackTrace();
}
%>