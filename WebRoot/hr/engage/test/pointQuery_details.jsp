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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
<%
String test_ID=request.getParameter("test_ID") ;
String testing_ID=request.getParameter("testing_ID") ;
String human_name=exchange.unURL(request.getParameter("human_name")) ;
String idcard=exchange.unURL(request.getParameter("idcard")) ;
String examtime=exchange.unURL(request.getParameter("examtime")) ;
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
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","姓名")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(human_name)%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","身份证号码")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(idcard)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","试卷编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=test_ID%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","答题用时")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=examtime%></td>
 </tr>
</table>
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
<%
String color="";
int totalsum=0;
String sql1="select * from hr_test_details where test_ID='"+test_ID+"' order by id";
		ResultSet rs1=hrdb.executeQuery(sql1);
while(rs1.next()){
%>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("question_first_kind")%></td>
 </tr>
<%
	String answer_id1="";
	String sql2="select * from hr_tester_answer_details where testing_ID='"+testing_ID+"' and question_first_kind='"+rs1.getString("question_first_kind")+"' and test_ID='"+test_ID+"'";
	ResultSet rs2=hr_db.executeQuery(sql2);
	if(rs2.next()){
		answer_id1=rs2.getString("answer_id_group");
	}
String test_id=rs1.getString("question_id_group").substring(0,rs1.getString("question_id_group").length()-1);
StringTokenizer tokenTO = new StringTokenizer(test_id,","); 
String answer_id=answer_id1.substring(0,answer_id1.length()-1);
StringTokenizer tokenTO1 = new StringTokenizer(answer_id,","); 
	int sum=0;
	int n=1;
while(tokenTO.hasMoreTokens()&&tokenTO1.hasMoreTokens()) {
	String answer=tokenTO1.nextToken();
	if(answer.equals("f")) answer="没有选择";
 String sql3="select * from hr_questiones where id='"+tokenTO.nextToken()+"'";
 ResultSet rs3=hr_db.executeQuery(sql3);
 if(rs3.next()){
	if(rs3.getString("correctkey").equals(answer)){
		color="#5A9992";
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <%=n%>.<%=rs3.getString("content")%>
 A.<%=rs3.getString("keya")%>
 B.<%=rs3.getString("keyb")%>
 C.<%=rs3.getString("keyc")%>
 D.<%=rs3.getString("keyd")%>
 <%=demo.getLang("erp","正确答案：")%> <%=rs3.getString("correctkey")%>
 <%=demo.getLang("erp","应试者答案：")%><%=answer%>
 </td>
 </tr>
<%
	}else{
		color="#FF0000";
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <%=n%>.<%=rs3.getString("content")%>
 A.<%=rs3.getString("keya")%>
 B.<%=rs3.getString("keyb")%>
 C.<%=rs3.getString("keyc")%>
 D.<%=rs3.getString("keyd")%>
 <%=demo.getLang("erp","正确答案：")%> <%=rs3.getString("correctkey")%>
 <font size="4" color="<%=color%>"><%=demo.getLang("erp","应试者答案：")%><%=answer%>
 </td></tr>
<%

	}
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