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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hrdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%counter count=new counter(application);%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String test_ID="";
int test_limited_time=0;
int questiones_amount=0;
int max_total_points=0;
String human_major_first_kind_ID="";
String human_major_first_kind_name="";
String human_major_second_kind_ID="";
String human_major_second_kind_name="";
String human_major_first_kind=request.getParameter("select4");
if(human_major_first_kind!=null&&!human_major_first_kind.equals("")){
StringTokenizer tokenTO4 = new StringTokenizer(human_major_first_kind,"/"); 
	while(tokenTO4.hasMoreTokens()) {
 human_major_first_kind_ID = tokenTO4.nextToken();
		human_major_first_kind_name = tokenTO4.nextToken();
		}
}
String human_major_second_kind=request.getParameter("select5");
if(human_major_second_kind!=null&&!human_major_second_kind.equals("")){
StringTokenizer tokenTO5 = new StringTokenizer(human_major_second_kind,"/"); 
	while(tokenTO5.hasMoreTokens()) {
 human_major_second_kind_ID = tokenTO5.nextToken();
		human_major_second_kind_name = tokenTO5.nextToken();
		}
}
String human_name=request.getParameter("human_name") ;
String idcard=request.getParameter("idcard") ;
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
try{
	String sql2="select * from hr_test where human_major_first_kind_name='"+human_major_first_kind_name+"' and human_major_second_kind_name='"+human_major_second_kind_name+"' order by rand()";
	ResultSet rset2=hr_db.executeQuery(sql2) ;
if(rset2.next()){
test_ID=rset2.getString("test_ID");
test_limited_time=rset2.getInt("test_limited_time");
questiones_amount=rset2.getInt("questiones_amount");
max_total_points=rset2.getInt("max_total_points");

String remind="您的简历尚未注册，请及时注册！";
String sql3="select * from hr_resume where idcard='"+idcard+"' ";
	ResultSet rset3=hr_db.executeQuery(sql3) ;
if(rset3.next()){
remind="您的简历已注册！";
}
%>
<SCRIPT language=javascript>
<!--
var sec=0;
var min=0;
var hour=0;
flag=0;
idt=window.setTimeout("autoAction();",1000);
function autoAction(){
sec++;
if(sec==60){
sec=0;
min+=1;
}
if(min==60){
min=0;
hour+=1;
}
if((min==<%=test_limited_time%>-1)&&(flag==0)){
window.alert("您的答题时间还剩1分钟，请抓紧时间！");
flag=1;
}
document.form1.usedtime.value=hour+":"+min+":"+sec;idt=window.setTimeout("autoAction();",1000);
}
var testTime=<%=test_limited_time%>*60;
function usedTime(){
	if (testTime<0)
	{
	document.form1.submit()
	}
	else{
	testTime--;
	setTimeout("usedTime()",1000);}}
</SCRIPT>
<script language="javascript">
 function CheckForm(TheForm) 
 {
  if (document.form1.check1[1].checked)
 {
		alert("请点击我要交卷！");

		return(false);
	}
	return(true);
 }
</script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<body onload="usedTime();">
<form name="form1" method="POST" action="../../../hr_engage_test_answerRegister_ok" onSubmit="return CheckForm(this)">
<input type="hidden" name="human_name" value="<%=exchange.toHtml(human_name)%>">
<input type="hidden" name="idcard" value="<%=exchange.toHtml(idcard)%>">
<input type="hidden" name="questiones_amount" value="<%=questiones_amount%>">
<input type="hidden" name="max_total_points" value="<%=max_total_points%>">
<input type="hidden" name="test_ID" value="<%=test_ID%>">
<input type="hidden" name="test_time" value="<%=time%>">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" height="20">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","答题限定时间：")%><%=test_limited_time%><%=demo.getLang("erp","分钟")%>
 &nbsp;<%=demo.getLang("erp","答题已用时间")%>：<input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="usedtime" style="width:30%;background-color:#E9F8F3" onFocus="this.blur()"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="radio" value="V1" style="width: 18; " name="check1"><%=demo.getLang("erp","我要交卷")%>&nbsp;<input type="radio" value="V2" checked name="check1"><%=demo.getLang("erp","再检查一遍")%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1"></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%@include file="../../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","试卷")%></b></font></td>
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","试题数量")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=questiones_amount%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","姓名")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(human_name)%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","身份证号码")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(idcard)%></td>
 </tr>
</table>
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
<%
String sql="select * from hr_test_details where test_ID='"+test_ID+"' order by id";
ResultSet rs=hrdb.executeQuery(sql);
while(rs.next()){
%>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("question_first_kind"))%></td>
 </tr>
<input name="first_kind<%=rs.getString("id")%>" type="hidden" value="<%=exchange.toHtml(rs.getString("question_first_kind"))%>">
<%
String test_id=rs.getString("question_id_group").substring(0,rs.getString("question_id_group").length()-1);
StringTokenizer tokenTO = new StringTokenizer(test_id,","); 
int n = 1;
 while(tokenTO.hasMoreTokens()) {
 String sqll="select * from hr_questiones where id='"+tokenTO.nextToken()+"'";
 ResultSet rsl=hr_db.executeQuery(sqll);
 if(rsl.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <%=n%>.<%=rsl.getString("content")%>
 <p><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=rs.getString("id")+n%>" value="a">A.<%=rsl.getString("keya")%></p>
 <p><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=rs.getString("id")+n%>" value="b">B.<%=rsl.getString("keyb")%></P>
 <p><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=rs.getString("id")+n%>" value="c">C.<%=rsl.getString("keyc")%></p>
 <p><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=rs.getString("id")+n%>" value="d">D.<%=rsl.getString("keyd")%></p>
 <p><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="<%=rs.getString("id")+n%>" value="e">E.<%=rsl.getString("keye")%></p></td> 
 </tr>
<%
 }
n++;
			}
%>
<input name="count<%=rs.getString("id")%>" type="hidden" value="<%=n-1%>">
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">

<%
}
hr_db.close();
hrdb.close();
%>
</table>
<%@include file="../../include/paper_bottom.html"%>
</div>
</form>
<%
}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="548" height="25">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="294" height="25">
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<input type="hidden" name="human_name" value="<%=exchange.toHtml(human_name)%>">
<input type="hidden" name="idcard" value="<%=exchange.toHtml(idcard)%>">
<input type="hidden" name="questiones_amount" value="<%=questiones_amount%>">
<input type="hidden" name="max_total_points" value="<%=max_total_points%>">
<input type="hidden" name="test_ID" value="<%=test_ID%>">
<input type="hidden" name="test_time" value="<%=time%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="answerRegister.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该套试卷未出，请返回确认！")%></td>
 </tr>
</table>
</div>
<%
hr_db.close();
hrdb.close();
}
}catch(Exception ex){ 
out.println("error"+ex); 
}
%>