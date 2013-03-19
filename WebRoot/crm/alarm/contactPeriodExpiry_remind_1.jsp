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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String amount=request.getParameter("amount");
int intRowCount=Integer.parseInt(amount);
if(crm_db.conn((String)session.getAttribute("unit_db_name"))){
for(int i=0;i<intRowCount;i++){
String choose=request.getParameter(""+i+"");
String customer_ID="";
String id="";
if (choose!=null){
StringTokenizer tokenTO = new StringTokenizer(choose,"/"); 
	while(tokenTO.hasMoreTokens()) {
 customer_ID = tokenTO.nextToken();
		id = tokenTO.nextToken();
		}
String sql2 = "update crm_file set remind_contact_tag='1' where customer_ID='"+customer_ID+"'" ;
crm_db.executeUpdate(sql2) ;
String sql3 = "update crm_alarm_contact_expiry set remind_tag='1' where id='"+id+"'" ;
crm_db.executeUpdate(sql3) ;
}
}
crm_db.close();

response.sendRedirect("contactPeriodExpiry_1.jsp");
}else{
%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td> 
  </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="contactPeriodExpiry_1.jsp"></div>
 </td>
 </tr>
 </table>
 </div>
 <%}%>