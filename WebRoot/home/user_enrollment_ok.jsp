<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,include.operateXML.*,java.sql.*" import="java.util.*" import="java.text.*" import="java.io.*" %>

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="unitinfo" class="include.nseer_cookie.UnitInfo" scope="page"/>
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>
<%@include file="head.jsp"%>
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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
 
<%
String lica = request.getParameter("lica") ;
String licb = request.getParameter("licb") ;
String licc = request.getParameter("licc") ;
String licd = request.getParameter("licd") ;
String unit_name = request.getParameter("unit_name");
String name = request.getParameter("name").toLowerCase() ;
name=unit_name+"_"+name;
String human_ID = request.getParameter("human_ID") ;
String human_name = request.getParameter("realname") ;
String passwd = request.getParameter("passwd") ;
String question = request.getParameter("question") ;
String answer = request.getParameter("answer") ;
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String current=formatter.format(now);
String license_code=lica+"-"+licb+"-"+licc+"-"+licd;
nseer_db_backup erp_db = new nseer_db_backup(application);
try{
	if(erp_db.conn(unitinfo.getDbName(unit_name))){
	String sql4="select * from security_users where name='"+name+"'";
	ResultSet rs4=erp_db.executeQuery(sql4) ;
if(!rs4.next()){
	String sql1="select * from security_license where license_code = '"+license_code+"' and enrollment_tag='0' and unit_ID='"+unit_name+"' and human_name='"+human_name+"'";
	ResultSet rs=erp_db.executeQuery(sql1) ;
if(rs.next()){
	java.util.Date date1 = formatter.parse(rs.getString("register_time"));
	long Time=(date1.getTime()/1000)+60*60*24*rs.getInt("expiry_period");
	date1.setTime(Time*1000);
	if((date1.getTime()-now.getTime())>0){
	String sql2 = "insert into security_users(name,chain_ID,chain_name,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,human_ID,human_name,passwd,question,answer,tagc,forbid_tag,type) values ('"+name+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+rs.getString("human_major_first_kind_ID")+"','"+rs.getString("human_major_first_kind_name")+"','"+rs.getString("human_major_second_kind_ID")+"','"+rs.getString("human_major_second_kind_name")+"','"+rs.getString("human_ID")+"','"+human_name+"','"+passwd+"','"+question+"','"+answer+"','1','0','"+rs.getString("type")+"')" ;
	String sql3 = "update security_license set enrollment_tag='1',active_time='"+current+"',name='"+name+"' where id="+rs.getString("id")+"" ;
	erp_db.executeUpdate(sql2) ;
	erp_db.executeUpdate(sql3) ;
	erp_db.close();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
TtoXml.createMsgXml(path+"xml/include/msg/"+human_name+".xml","1","","","⊙");
%>
<p align="left" style="padding-left: 310"><font color="#008000" size="2"><%=demo.getLang("erp","恭喜您注册成功，请牢记您的用户名和密码！")%>
  <p align="left" style="padding-left: 310"><font size="2"><%=demo.getLang("erp","用户姓名")%>：<%=human_name%>
  <p align="left" style="padding-left: 310"><font size="2"><%=demo.getLang("erp","用户名")%>：<%=name%>
  <p align="left" style="padding-left: 310">　
  <p align="left" style="padding-left: 310">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="login.jsp">
 <p align="center">　

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="260">&nbsp;</td>
 </tr>
 </table>

<%}else{

%>
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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="4" width="400" cellspacing="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","对不起，许可证已超出有效期，请联系系统管理员！")%></td>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="410">&nbsp;</td>
 </tr>
 </table>

<%
}
}else{
	erp_db.close();
	%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","对不起，用户姓名或许可证错误，请重新注册！")%></td>
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
  <p align="center"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
 </tr>
 </table>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="410">&nbsp;</td>
 </tr>
 </table>

<%
}
}else{
%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="4" width="400" cellspacing="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","对不起，用户名重复，请返回重新注册！")%></td>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="410">&nbsp;</td>
 </tr>
 </table>
 
<%
}
}else{
%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="4" width="400" cellspacing="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3">
  <p align="center"><font color="#FF0000" size="2"><%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="410">&nbsp;</td>
 </tr>
 </table>

<%
}
}
catch (Exception ex){
out.println("error1:"+ex);
}
%>
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