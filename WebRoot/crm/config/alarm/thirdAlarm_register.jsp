<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db_backup crm_db = new nseer_db_backup(application);%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String gather_limit2=request.getParameter("gather_limit") ;
StringTokenizer tokenTO = new StringTokenizer(gather_limit2,","); 
int i1 = 0;
String gather_limit="";
 while(tokenTO.hasMoreTokens()) {
  String gather_limit1 = tokenTO.nextToken();
		gather_limit +=gather_limit1;
  i1++;
		}
/*String return_limit2=request.getParameter("return_limit") ;
StringTokenizer tokenTO1 = new StringTokenizer(return_limit2,","); 
int i2 = 0;
String return_limit="";
 while(tokenTO1.hasMoreTokens()) {
  String return_limit1 = tokenTO1.nextToken();
		return_limit +=return_limit1;
  i2++;
		}*/
String gather_expiry=request.getParameter("gather_expiry") ;
String contact_expiry=request.getParameter("contact_expiry") ;
//String check_expiry=request.getParameter("check_expiry") ;
%>

<%
if(crm_db.conn((String)session.getAttribute("unit_db_name"))){
String sql="select * from crm_config_public_double where kind='欠款黄警'";
ResultSet rs=crm_db.executeQuery(sql);
if(rs.next()){
	String sql1="update crm_config_public_double set type_value='"+gather_limit+"' where kind='欠款黄警'";
	crm_db.executeUpdate(sql1);
}else{
	String sql2="insert into crm_config_public_double(kind,type_value) values('欠款黄警','"+gather_limit+"')";
	crm_db.executeQuery(sql2);
}
/*String sql3="select * from crm_config_public_double where kind='退货黄警'";
ResultSet rs3=crm_db.executeQuery(sql3);
if(rs3.next()){
	String sql4="update crm_config_public_double set type_value='"+return_limit+"' where kind='退货黄警'";
	crm_db.executeQuery(sql4);
}else{
	String sql5="insert into crm_config_public_double(kind,type_value) values('退货黄警','"+return_limit+"')";
	crm_db.executeQuery(sql5);
}*/
String sql6="select * from crm_config_public_double where kind='回款黄警'";
ResultSet rs6=crm_db.executeQuery(sql6);
if(rs6.next()){
	String sql7="update crm_config_public_double set type_value='"+gather_expiry+"' where kind='回款黄警'";
	crm_db.executeUpdate(sql7);
}else{
	String sql8="insert into crm_config_public_double(kind,type_value) values('回款黄警','"+gather_expiry+"')";
	crm_db.executeQuery(sql8);
}
String sql9="select * from crm_config_public_double where kind='联络黄警'";
ResultSet rs9=crm_db.executeQuery(sql9);
if(rs9.next()){
	String sql10="update crm_config_public_double set type_value='"+contact_expiry+"' where kind='联络黄警'";
	crm_db.executeUpdate(sql10);
}else{
	String sql11="insert into crm_config_public_double(kind,type_value) values('联络黄警','"+contact_expiry+"')";
	crm_db.executeQuery(sql11);
}
/*String sql12="select * from crm_config_public_double where kind='订单响应黄警'";
ResultSet rs12=crm_db.executeQuery(sql12);
if(rs12.next()){
	String sql13="update crm_config_public_double set type_value='"+check_expiry+"' where kind='订单响应黄警'";
	crm_db.executeQuery(sql13);
}else{
	String sql14="insert into crm_config_public_double(kind,type_value) values('订单响应黄警','"+check_expiry+"')";
	crm_db.executeQuery(sql14);
}*/
crm_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="thirdAlarm.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","提交成功，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
 </div>
<%
}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td> 
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="thirdAlarm.jsp"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td> 
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
  </div>
 <%}%>