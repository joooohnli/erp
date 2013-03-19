<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<form class="x-form" id="check" method="post" action="../../security_license_register_module">
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db db=new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
String human_name=request.getParameter("human_name");
String human_ID=request.getParameter("human_ID");
String choose_value_group=request.getParameter("choose_value_group");
if(choose_value_group==null){
	choose_value_group="";

getArryFromValue aa=new getArryFromValue();

String field_type=(String)session.getAttribute("field_type");
	String[] str=aa.getArryFromOneValue((String)session.getAttribute("unit_db_name"),"document_main","reason","kind","模块",field_type);
for(int i=0;i<str.length;i++){
	String table1=str[i]+"_view";
	String sql="delete from "+table1+" where human_ID='"+human_ID+"'";
	db.executeUpdate(sql);
}
}
%>
<input type="hidden" name="choose_value_group" value="<%=exchange.toHtml(choose_value_group)%>">
<input type="hidden" name="human_ID" value="<%=human_ID%>">
<input type="hidden" name="human_name" value="<%=exchange.toHtml(human_name)%>">

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","分配权限")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","分配完成")%>" onClick=location="register_license_code.jsp?human_ID=<%=human_ID%>&&choose_value_group=<%=toUtf8String.utf8String(exchange.toURL(choose_value_group))%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td> 
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3" width="50%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="choose_value" style="width: 20%;">
			 <%
			 String field_type=(String)session.getAttribute("field_type");
String sql="";
if(field_type.equals("0")){
	sql = "select * from document_main order by id";
}else{
	sql = "select * from document_main where fieldType_tag='1' order by id";
}
ResultSet rs=db.executeQuery(sql);
while(rs.next()){

	%>
			<option value="<%=rs.getString("reason")%>/<%=rs.getString("value")%>"><%=demo.getLang("erp",rs.getString("value"))%></option>
			
			<%}
			
			
db.close();%>
  </select></td>
    
 </tr>
 </table>
 </div>
</form>