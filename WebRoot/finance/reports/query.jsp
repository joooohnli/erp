<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%
try{
String tableselect=request.getParameter("tableselect");
String timea=request.getParameter("timea");
String year="";
String month="";
String a="";
if(timea.equals("")&&timea.length()==7){
	 year=timea.substring(0,4);
	 month=timea.substring(5,7);
	 a=timea.substring(4,5);
}
if(tableselect!=null&&timea.length()==7&&validata.validata(year)&&validata.validata(month)&&a.equals("-")){
	if(tableselect.equals("资产负债表")){
	response.sendRedirect("query_report_one.jsp?tableselect="+toUtf8String.utf8String(exchange.toURL(tableselect))+"&&year="+year+"&&month="+month);
	}else if(tableselect.equals("损益表")){	
	response.sendRedirect("query_report_two.jsp?tableselect="+toUtf8String.utf8String(exchange.toURL(tableselect))+"&&year="+year+"&&month="+month); 
	}else{	 response.sendRedirect("query_report_three.jsp?tableselect="+toUtf8String.utf8String(exchange.toURL(tableselect))+"&&year="+year+"&&month="+month);
	}
 }else{%>
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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="query_locate.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","对不起，你没有选择报表或输入的时间格式错误，请返回！")%></td>
 </table>
</div>
<%
 }
}catch(Exception ex){
	ex.printStackTrace();
	}
%>