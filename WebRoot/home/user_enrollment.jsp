<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*"%>

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<script language="javascript" src="../javascript/ajax/ajax-validation4.js"></script>
<script type="text/javascript" src="../javascript/include/div/divcolor.js"></script>
<%
	  demo.setPath(request);
	  String language=request.getParameter("language");
	  if(language==null) language="chinese";
	  session.setAttribute("language",language);
%>
<%@include file="head.jsp"%>
<link rel="stylesheet" type="text/css" href="../javascript/ajax/niceforms-default.css" />
<script type="text/javascript" src="../javascript/ajax/niceforms.js"></script>  
<TABLE width="80%" height="90%" border=0 cellPadding=0 cellSpacing=0 align="center" bgcolor="#F3F6F7"  class="example" id="example1">
 <script>
setGradient('example1','#A5E3FF','#ffffff',0);
</script>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../images/bg_03.gif"></TD>
 <TD>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
    <tr>
      <td <%=TD_STYLE3%> class="TD_STYLE3" height="80"></td>
    </tr>
  </table>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650">
    <tr>
      <td <%=TD_STYLE3%> class="TD_STYLE3">	
        <p align="center"><b><font color="#800000" size="3"><%=demo.getLang("erp","川大科技ERP系统用户注册")%></font></b></td>
    </tr>
  </table>
<script language="javascript">
   
    function setfocus(){
	  document.form1.lica.focus();
	}
    function b1keyup(){
		if(document.form1.lica.value.length ==5){
			document.form1.licb.focus();
		}
	}
	function b2keyup(){
		if(document.form1.licb.value.length == 5){
			document.form1.licc.focus();
		}
	}
	function b3keyup(){
		if(document.form1.licc.value.length == 5){
			document.form1.licd.focus();
		}
	}
	function b4keyup(){
		if(document.form1.licd.value.length == 5){
			document.form1.realname.focus();
		}
	}
 </script>
 <script language="javascript" src="../javascript/input_control/Check.js"></script>
<script language="javascript">
var count=0;
function CheckForm(TheForm) {
	trimform(TheForm);
	if(count>0) {
 	return false;
 	}

 	count++;
	if (TheForm.lica.value == "") {
		alert("<%=demo.getLang("erp","请填写您的许可证号！")%>");
		TheForm.name.focus();
		count=count-1;
		return false;
	}
	if (TheForm.licb.value == "") {
		alert("<%=demo.getLang("erp","请填写您的许可证号！")%>");
		TheForm.name.focus();
		count=count-1;
		return false;
	}
	if (TheForm.licc.value == "") {
		alert("<%=demo.getLang("erp","请填写您的许可证号！")%>");
		TheForm.name.focus();
		count=count-1;
		return false;
	}
	if (TheForm.licd.value == "") {
		alert("<%=demo.getLang("erp","请填写您的许可证号！")%>");
		TheForm.name.focus();
		count=count-1;
		return false;
	}

	if (TheForm.realname.value == "") {
		alert("<%=demo.getLang("erp","请填写您的用户姓名！")%>");
		TheForm.name.focus();
		count=count-1;
		return false;
	}

	if (TheForm.name.value == "") {
		alert("<%=demo.getLang("erp","请填写您的用户名！")%>");
		TheForm.name.focus();
		count=count-1;
		return false;
	}
	if (TheForm.pwd.value == "") {
		alert("<%=demo.getLang("erp","请填写您的密码！")%>");
		TheForm.pwd.focus();
		count=count-1;
		return false;
	}
	if (TheForm.pwd.value != TheForm.passwd.value) {
		alert("<%=demo.getLang("erp","请正确填写您的新密码！")%>");
		TheForm.passwd.focus();
		count=count-1;
		return false;
	}
	if (TheForm.question.value == "") {
		alert("<%=demo.getLang("erp","请填写确认身份的问题！")%>");
		TheForm.question.focus();
		count=count-1;
		return false;
	}
	if (TheForm.answer.value == "") {
		alert("<%=demo.getLang("erp","请填写确认身份的答案！")%>");
		TheForm.answer.focus();
		count=count-1;
		return false;
	}
	return true;
}
</script>

<form id="userName" class="x-form" name="form1" method="POST" action="user_enrollment_ok.jsp?language=<%=language%>" onSubmit="return CheckForm(this)">
   <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650">
      <tr>
	  <td <%=TD_STYLE3%> class="TD_STYLE3">
	  &nbsp;</td>
	  </tr>
	  </table>
	
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650">
      <tr>
	  <td <%=TD_STYLE3%> class="TD_STYLE3">
	  &nbsp;</td>
	  </tr>
	  </table>
	  
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" style="width:65%" align="center">
  
     <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","授权许可证")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="75%" colspan="2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="lica" style="width:12%" onkeyup="return b1keyup()">-<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="licb" style="width:12%" onkeyup="return b2keyup()">-<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="licc" style="width:12%" onkeyup="return b3keyup()">-<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="licd" style="width:12%" onkeyup="return b4keyup()"></td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","使用单位简称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="75%" colspan="2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="unit_name" style="width:33%" value="nseer" id="nseer_name" onFocus="this.blur()"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","用户姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="75%" colspan="2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="realname" style="width:33%"></td>
 </tr>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","用户名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="validator_dup" name="name" style="width:100%" onblur="ajax_validation('userName','nseer_name','validator_dup','security_users','name','../vd5',this)"></td><td <%=TD_STYLE21%> class="TD_STYLE2"><div id="loaddiv" style="display:none;border:1px solid red;background-color: #FF0033;width:50%;height:100%; text-align:center;"></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","密码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="75%" colspan="2"><input type="password" name="passwd" style="background-color: #ffffff" style="width:33%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","确认密码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="75%" colspan="2"><input type="password" name="pwd" style="background-color: #ffffff" style="width:33%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","忘记密码时确认身份的问题 ")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="75%" colspan="2"><input type="text" name="question" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:33%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%"><%=demo.getLang("erp","忘记密码时确认身份的答案")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="75%" colspan="2"><input type="text" name="answer" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:33%"></td>
 </tr>
 </table> 
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="20"></td>
 </tr>
 </table>
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <p align="center"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","注册")%>" name="B1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  &nbsp;&nbsp; <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="login.jsp"></td> 
 </tr>
</table>  
 </form> 

  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" height="10">
    <tr>
      <td <%=TD_STYLE3%> class="TD_STYLE3" height="200"></td>
    </tr>
  </table>
 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="80%" height="83">
        <tr>
          <td <%=TD_STYLE3%> class="TD_STYLE3" height="79" align="center"><%=demo.getLang("erp","四川大学计算机学院版权所有 All Rights Reserved.")%>
          </td>
        </tr>
</table>       
 
<%@include file="foot.htm"%>
<TD  background="../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0lbottom.gif" ></TD>
      <TD background="../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0rbottom.gif"></TD>
    </TR>
  </TBODY>
</TABLE>