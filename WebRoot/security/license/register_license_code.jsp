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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db_backup hr_db = new nseer_db_backup(application);%>
<%nseer_db_backup security_db = new nseer_db_backup(application);%>
<%
String human_ID=request.getParameter("human_ID");
String choose_value_group=exchange.unURL(request.getParameter("choose_value_group"));
String[] str={"1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z"};
String license_a="";
String license_b="";
String license_c="";
String license_d="";
for(int i=0;i<5;i++){
 double r=Math.random();
 int k=(int)(r*33);
		license_a=license_a+str[k];
}
for(int j=0;j<5;j++){
 double s=Math.random();
 int l=(int)(s*33);
		license_b=license_b+str[l];
}
for(int j=0;j<5;j++){
 double s=Math.random();
 int l=(int)(s*33);
		license_c=license_c+str[l];
}
for(int j=0;j<5;j++){
 double s=Math.random();
 int l=(int)(s*33);
		license_d=license_d+str[l];
}
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String unit_id=(String)session.getAttribute("unit_id");
String license_code=license_a+"-"+license_b+"-"+license_c+"-"+license_d;
try{
if(hr_db.conn((String)session.getAttribute("unit_db_name"))&&security_db.conn((String)session.getAttribute("unit_db_name"))){
String sql="select * from hr_file where human_ID='"+human_ID+"'";
ResultSet rs=hr_db.executeQuery(sql);
if(rs.next()){
	String sql3="select * from security_license where human_ID='"+human_ID+"' and enrollment_tag='0'";
ResultSet rs3=security_db.executeQuery(sql3);
if(!rs3.next()){
		String sql1="insert into security_license(unit_ID,chain_ID,chain_name,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,human_ID,human_name,license_code,register_time,expiry_period) values('"+unit_id+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+rs.getString("human_major_first_kind_ID")+"','"+rs.getString("human_major_first_kind_name")+"','"+rs.getString("human_major_second_kind_ID")+"','"+rs.getString("human_major_second_kind_name")+"','"+rs.getString("human_ID")+"','"+rs.getString("human_name")+"','"+license_code+"','"+time+"','7')";
		security_db.executeUpdate(sql1);

}
%>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<form id="mutiValidation" method="POST" action="../../security_license_register_ok" onSubmit="return doValidate('../../xml/security/security_license.xml','mutiValidation')">
<input type="hidden" name="human_ID" value="<%=human_ID%>">
<input type="hidden" name="human_name" value="<%=exchange.toHtml(rs.getString("human_name"))%>">
<input type="hidden" name="choose_value_group" value="<%=exchange.toHtml(choose_value_group)%>">
<input type="hidden" name="unit_id" value="<%=exchange.toHtml((String)session.getAttribute("unit_id"))%>">
<input type="hidden" name="license_code" value="<%=license_a%>-<%=license_b%>-<%=license_c%>-<%=license_d%>">
<input type="hidden" name="chain_name" value="<%=exchange.toHtml(rs.getString("chain_name"))%>">
<input type="hidden" name="human_major_first_kind_name" value="<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>">
<input type="hidden" name="human_major_second_kind_name" value="<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","用户许可证")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","使用单位简称：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml((String)session.getAttribute("unit_id"))%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","姓名：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","员工档案编号：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getString("human_ID")%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","所在机构：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("chain_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","职位分类：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","职位名称：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","许可证号码：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=license_a%>-<%=license_b%>-<%=license_c%>-<%=license_d%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","EMAIL：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="human_email" value="<%=exchange.toHtml(rs.getString("human_email"))%>">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","有效期限(天)：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="expiry_period" value="7">&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","发放时间：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" name="register_time" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
 </div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
}
String sql2="update hr_file set license_tag='1' where human_ID='"+human_ID+"'";
hr_db.executeUpdate(sql2); 
hr_db.close();
security_db.close();
}else{
	response.sendRedirect("/error_conn.htm");
}
}
catch (Exception ex){ex.printStackTrace();
}
%>