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
<%
include.operateXML.Reading reader=new include.operateXML.Reading("xml/"+export_mod+"/"+export_mod+".xml");
%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan=2><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <form method="post" class="x-form" action="<%=export_type%>_locate.jsp">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","开始")%>"></div>
 </td>
 </tr>
 </table> 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
<%=demo.getLang("erp","请选择数据库表的名称")%>&nbsp;<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="data" style="width:220">
<%
Vector nicks=reader.getColumnAttributes("nick");
Vector names=reader.getColumnAttributes("name");
Vector services=reader.getColumnAttributes("service");
int i=0;
while(i<nicks.size()) {
String nick=(String)nicks.elementAt(i);
String name=(String)names.elementAt(i);
String service=(String)services.elementAt(i);
if(service.equals("b")){
if(tables.indexOf("⊙"+name+"⊙")!=-1){
//if(true){
%>
<option value="<%=exchange.toHtml(name)%>⊙<%=demo.getLang("erp",nick)%>"><%=demo.getLang("erp",nick)%></option>
<% }}i++;} %>
</select></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table> 
 <input type="hidden" name="export_mod" value="<%=export_mod%>">
 <input type="hidden" name="export_type" value="<%=export_type%>">
</form>
</div>