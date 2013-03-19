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
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
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
<form class="x-form" id="mutiValidation" method="POST" action="register.jsp">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确定")%>"></div></td>
 </tr>	
</table>
<%
String provider_ID=request.getParameter("provider_ID");
String provider_name=request.getParameter("provider_name");
String contact_person1=request.getParameter("contact_person1");
String provider_tel1=request.getParameter("provider_tel1");
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请选择联络理由")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="reason" style="width: 30%;">
  <%
  String sql5 = "select * from intrmanufacture_config_public_char where kind='联络理由' order by type_ID" ;
	 ResultSet rs5 = intrmanufacture_db.executeQuery(sql5) ;
while(rs5.next()){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%
}
intrmanufacture_db.close();
%>
  </select></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请输入理由对应编码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="reasonexact" style="width: 30%;"></td>
 </tr>
 <input name="provider_ID" type="hidden" value="<%=provider_ID%>">
	 <input name="provider_name" type="hidden" width="100%" value="<%=exchange.toHtml(provider_name)%>">
	 <input name="contact_person1" type="hidden" width="100%" value="<%=exchange.toHtml(contact_person1)%>">
	 <input name="provider_tel1" type="hidden" width="100%" value="<%=exchange.toHtml(provider_tel1)%>">
 </table> 
</form>
</div>