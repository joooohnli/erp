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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td> 
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <form id="mutiValidation" class="x-form" method="POST" action="register.jsp">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确定")%>"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
</table>
<%
String customer_ID=request.getParameter("customer_ID");
String customer_name=request.getParameter("customer_name");
String contact_person1=request.getParameter("contact_person1");
String customer_tel1=request.getParameter("customer_tel1");
%>

<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="10%"><%=demo.getLang("erp","请选择联络理由")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="30%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="reason" style="width: 180;">
  <%
  String sql5 = "select * from crm_config_public_char where kind='联络理由' order by type_ID" ;
	 ResultSet rs5 = crm_db.executeQuery(sql5) ;
while(rs5.next()){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%
}
crm_db.close();
%>

  </select></td>
 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="10%"><%=demo.getLang("erp","请输入理由对应编码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="reasonexact" type="text" style="width: 180;"></td>
 
 </tr>
 <input name="customer_ID" type="hidden" width="100%" value="<%=customer_ID%>">
 <input name="customer_name" type="hidden" width="100%" value="<%=exchange.toHtml(customer_name)%>">
 <input name="contact_person1" type="hidden" width="100%" value="<%=exchange.toHtml(contact_person1)%>">
 <input name="customer_tel1" type="hidden" width="100%" value="<%=exchange.toHtml(customer_tel1)%>">
 </table> 
</form>
</div>