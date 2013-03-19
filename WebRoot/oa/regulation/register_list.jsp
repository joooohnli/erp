<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script src="../../javascript/table/movetable.js">
</script>
<%
String sql = "select * from oa_planing where subject='' or check_tag='9' order by id" ;
	ResultSet rs = oa_db.executeQuery(sql) ;
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%"> 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","当前等待制定的计划总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","添加")%>" onClick=location="register.jsp"></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="80%"><%=exchange.toHtml(meeting_subject)%></td>
<td <%=TD_STYLE1%> class="TD_STYLE1" width="6%"><%=demo.getLang("erp","制定")%></td>
</tr>
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("meeting_subject"))%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><a href="register.jsp?id=<%=rs.getString("id")%>&meeting_subject=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("meeting_subject")))%>"><%=demo.getLang("erp","制定")%></a></td>
</tr>
</page:pages>
 </table>
<page:updowntag num="<%=intRowCount%>" file="register_list.jsp"/>
<%	
oa_db.close();
%>
</body>
</html>
