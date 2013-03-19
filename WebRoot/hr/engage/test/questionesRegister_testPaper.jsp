<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hrdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%counter count=new counter(application);%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<style type="text/css">
<!--
.stedit {
	BORDER-RIGHT: 1px none #4a3163; BORDER-TOP: 1px solid #4a3163; FONT-SIZE: 9pt; BORDER-LEFT: 1px solid #4a3163; BORDER-BOTTOM: 1px none #4a3163}
.stedit1 {
	BORDER-RIGHT: 1px solid #4a3163; BORDER-TOP: 1px none #4a3163; FONT-SIZE: 9pt; BORDER-LEFT: 1px none #4a3163; BORDER-BOTTOM: 1px solid #4a3163}
--
</style>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
<%
String test_ID=request.getParameter("test_ID") ;
String first_kind_ID=request.getParameter("first_kind_ID");
String first_kind_name=request.getParameter("first_kind_name");
String second_kind_ID=request.getParameter("second_kind_ID");
String second_kind_name=request.getParameter("second_kind_name");
%>
<div id="nseerGround" class="nseerGround">
<%@include file="../../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","试 卷")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","试卷编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=test_ID%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">&nbsp;</td>
 </tr>
</table>
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
<%
int totalsum=0;
String sql1="select * from hr_test_details where test_ID='"+test_ID+"' order by id";
		ResultSet rs1=hrdb.executeQuery(sql1);
while(rs1.next()){
%>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("question_first_kind"))%></td>
 </tr>
<%
String test_id=rs1.getString("question_id_group").substring(0,rs1.getString("question_id_group").length()-1);
StringTokenizer tokenTO = new StringTokenizer(test_id,","); 
	int sum=0;
	int n=1;
while(tokenTO.hasMoreTokens()) {
 String sql3="select * from hr_questiones where id='"+tokenTO.nextToken()+"'";
 ResultSet rs3=hr_db.executeQuery(sql3);
 if(rs3.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <%=n%>.<%=rs3.getString("content")%>
 <p>A.<%=rs3.getString("keya")%></p>
 <p>B.<%=rs3.getString("keyb")%></p>
 <p>C.<%=rs3.getString("keyc")%></p>
 <p>D.<%=rs3.getString("keyd")%></p>
 <p><%=demo.getLang("erp","正确答案：")%> <%=rs3.getString("correctkey")%></p>
 </td></tr>
<%
	n++;
 }

}
}
hr_db.close();
hrdb.close();
%>
</table>
<%@include file="../../include/paper_bottom.html"%>
</div>