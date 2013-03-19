<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.nseer_cookie.iisPrint"%>
<%iisPrint iisPrint=new iisPrint(request);%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String change_time=exchange.unURL(request.getParameter("time"));
String news_ID=request.getParameter("news_ID");
try{
	String sql = "select * from ecommerce_news_dig where news_ID='"+news_ID+"' and change_time='"+change_time+"'" ;
	ResultSet rs = ecommerce_db.executeQuery(sql) ;
	if(rs.next()){
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","新闻")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","新闻编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getString("news_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","新闻标题")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("topic"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","新闻分类")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4" width="100%"><div align="left"><fieldset><legend><%=demo.getLang("erp","新闻内容")%></legend><%=rs.getString("content")%></fieldset></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","图片1")%>&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=iisPrint.printOrNotSin(rs.getString("attachment1"),response,rs.getString("id"),"ecommerce_news_dig","attachment1")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE81" width="13%"><%=demo.getLang("erp","图片2")%>&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=iisPrint.printOrNotSin(rs.getString("attachment2"),response,rs.getString("id"),"ecommerce_news_dig","attachment2")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","图片3")%>&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=iisPrint.printOrNotSin(rs.getString("attachment3"),response,rs.getString("id"),"ecommerce_news_dig","attachment3")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%">&nbsp;</td>
 </tr>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核意见")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><%=exchange.toHtml(rs.getString("opinion"))%>&nbsp;</textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","档案变更累计")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><a href="javascript:winopen('change_file_dig.jsp?news_ID=<%=rs.getString("news_ID")%>&&time=<%=exchange.toURL(rs.getString("lately_change_time"))%>')"><%=rs.getString("file_change_amount")%></a>&nbsp</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","最近变更时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><a href="javascript:winopen('change_file_dig.jsp?news_ID=<%=rs.getString("news_ID")%>&&time=<%=exchange.toURL(rs.getString("lately_change_time"))%>')"><%=lately_change_time%></a>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
</div>
<%
 }else{
%>

<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","没有变更")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%
}
ecommerce_db.close(); 
}
catch (Exception ex){
out.println("error"+ex);
}
%>