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
<%@include file="head.jsp"%>
<%%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="unitinfo" class="include.nseer_cookie.UnitInfo" scope="page"/>
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>
<script type="text/javascript" src="../javascript/include/div/divcolor.js"></script>
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
<%
String name = request.getParameter("name") ;
String question = request.getParameter("question") ;
String answer = request.getParameter("answer") ;
if(name.indexOf("_")!=-1){
String unit_db_name=unitinfo.getDbName(name.substring(0,name.indexOf("_")));
String pwd = request.getParameter("pwd") ;
String passwd = request.getParameter("passwd") ;
try
{
	nseer_db_backup erp_db = new nseer_db_backup(application);
	if(erp_db.conn(unit_db_name)){
	String sql1 = "select * from security_users where name = '"+name+"'";
	ResultSet rs1=erp_db.executeQuery(sql1) ;
if(rs1.next()&&question.equals(rs1.getString("question"))&&answer.equals(rs1.getString("answer"))&&pwd.equals(passwd)&&!pwd.equals("")&&!passwd.equals("")){
	String sql = "update security_users set passwd='"+passwd+"' where id = '"+rs1.getString("id")+"'";
	erp_db.executeUpdate(sql);
	erp_db.close();
%>
　
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <p align="center"></td>
 </tr>
 </table>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="4" width="300" cellspacing="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","您的密码重新设置成功！")%></font></td>
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
  <p align="center"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="login.jsp"></td>
 </tr>
 </table>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="400">
 <p align="center"></td>
 </tr>
 </table>

<%@include file="foot.htm"%>

<%
}else{
%>
　
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <p align="center"></td>
 </tr>
 </table>
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="4" width="300" cellspacing="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","对不起，用户名或确认身份的问题或答案不正确，请重新输入！")%></font></td>
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
  <p align="center"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
 </tr>
 </table>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="400">
 <p align="center"></td>
 </tr>
 </table>

<%@include file="foot.htm"%>

<%
	}
}else{
%>
　
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <p align="center"></td>
 </tr>
 </table>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="4" width="300" cellspacing="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","数据库连接故障，请返回！")%></font></td>
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
  <p align="center"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
 </tr>
 </table>
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="400">
 <p align="center"></td>
 </tr>
 </table>

<%@include file="foot.htm"%>

<%
	}
}	
catch (Exception ex){
	out.println("error"+ex);
}


}else{
%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <p align="center"></td>
 </tr>
 </table>
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="4" width="300" cellspacing="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","用户名错误！")%></font></td>
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
  <p align="center"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
 </tr>
 </table>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="400">
 <p align="center"></td>
 </tr>
 </table>
<%}%> 

<TD  background="../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0lbottom.gif" ></TD>
      <TD background="../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0rbottom.gif"></TD>
    </TR>
  </TBODY>
</TABLE>