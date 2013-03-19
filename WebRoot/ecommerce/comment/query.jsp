<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*" import="com.fredck.FCKeditor.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@ page import="include.nseer_cookie.iisPrint"%>
<%iisPrint iisPrint=new iisPrint(request);%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<%
String write_time="";
String comment_ID=request.getParameter("comment_ID");
try{
	String sqll = "select * from ecommerce_comment where comment_ID='"+comment_ID+"'" ;
	ResultSet rss = ecommerce_db.executeQuery(sqll) ;
	while(rss.next()){
if(rss.getString("write_time").equals("1800-01-01 00:00:00.0")){
write_time="";
}else{
write_time=rss.getString("write_time");
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","反馈信息")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","姓名")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rss.getString("name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","性别")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rss.getString("sex"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","单位")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rss.getString("company"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","地址")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rss.getString("address"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","电话")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rss.getString("tel"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","Email")%>&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rss.getString("email"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","反馈信息分类")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rss.getString("kind"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","反馈时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(write_time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4" width="100%"><div align="left"><fieldset><legend><%=demo.getLang("erp","反馈信息内容")%></legend><%=rss.getString("comment")%></fieldset></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","附件")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><%=iisPrint.printOrNotSin(rss.getString("attachment1"),response,rss.getString("id"),"ecommerce_comment","attachment1")%>&nbsp;</td>
 </tr> <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","回复")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87" colspan="3"><%=rss.getString("reply")%></td>
 </tr>
 </table>
 </div>
<%@include file="../include/paper_bottom.html"%>
<%
}
	ecommerce_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>