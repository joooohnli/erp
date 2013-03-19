<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseer_db.*,java.text.*"%>
<%nseer_db_backup hr_db = new nseer_db_backup(application);%>
<%nseer_db_backup hrdb = new nseer_db_backup(application);%>
<%@include file="../../include/head.jsp"%>
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
<form class="x-form" id="register1" method="POST" action="questionesRegister_testPaper_list.jsp">
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%> 
<%
String test_ID="";
String testing_ID="";
String idcard="";
int totalsum=0;
int max_total_points=0;
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String checker=(String)session.getAttribute("realeditorc");
String id=request.getParameter("id") ;
if(hr_db.conn((String)session.getAttribute("unit_db_name"))&&hrdb.conn((String)session.getAttribute("unit_db_name"))){
		String sql="select * from hr_tester where id='"+id+"'";
		ResultSet rs=hr_db.executeQuery(sql);
while(rs.next()){
	testing_ID=rs.getString("testing_ID");
	test_ID=rs.getString("test_ID");
	idcard=rs.getString("idcard");
	max_total_points=rs.getInt("max_total_points");
}
String sql1="select * from hr_test_details where test_ID='"+test_ID+"'";
		ResultSet rs1=hr_db.executeQuery(sql1);
while(rs1.next()){
	String answer_id1="";
	String sql2="select * from hr_tester_answer_details where testing_ID='"+testing_ID+"' and question_first_kind='"+rs1.getString("question_first_kind")+"'";
	ResultSet rs2=hrdb.executeQuery(sql2);
	if(rs2.next()){
		answer_id1=rs2.getString("answer_id_group");
	}
String test_id=rs1.getString("question_id_group").substring(0,rs1.getString("question_id_group").length()-1);
StringTokenizer tokenTO = new StringTokenizer(test_id,","); 
String answer_id=answer_id1.substring(0,answer_id1.length()-1);
StringTokenizer tokenTO1 = new StringTokenizer(answer_id,","); 
	int sum=0;
while(tokenTO.hasMoreTokens()&&tokenTO1.hasMoreTokens()) {
 String sql3="select * from hr_questiones where id='"+tokenTO.nextToken()+"'";
 ResultSet rs3=hrdb.executeQuery(sql3);
 if(rs3.next()){
	if(rs3.getString("correctkey").toLowerCase().equalsIgnoreCase(tokenTO1.nextToken())){
		sum+=2;
	}
 }
}
totalsum+=sum;
	String sql4="update hr_tester_answer_details set subtotal_points='"+sum+"' where testing_ID='"+testing_ID+"' and question_first_kind='"+rs1.getString("question_first_kind")+"'";
	hrdb.executeUpdate(sql4);
}
double points=totalsum*100/max_total_points;
		String sql5="update hr_tester set total_points='"+points+"',check_tag='1',checker='"+checker+"',check_time='"+time+"' where id='"+id+"'";
		hr_db.executeUpdate(sql5);
		hr_db.close();
		hrdb.close(); 
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="answerCheck_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","阅卷完成，谢谢！试卷总成绩为：")%><%=points%></td>
 </tr>
 </table>
 <%}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="answerCheck_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
 </table>
 <%}%>
  </div>