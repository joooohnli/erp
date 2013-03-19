<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_cookie.exchange,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<%nseer_db document_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db document_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String id=request.getParameter("id");
String strpage=request.getParameter("page");
String sql = "select * from document_multilanguage where id='"+id+"'";
	ResultSet rs = document_db.executeQuery(sql);
	if(rs.next()){
		if(rs.getInt("language_tag")==0){
	%>
<form id="mutiValidation" method="POST" action="../../security_multilanguage_register_ok?id=<%=id%>" onSubmit="return doValidate('../../xml/document/document_multilanguage.xml','mutiValidation')">
<input type="hidden" name="page" value="<%=strpage%>">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_list.jsp"></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","分类")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type" style="width: 20%;">
 <option value="<%=exchange.toHtml(rs.getString("kind"))%>"selected><%=exchange.toHtml(rs.getString("kind"))%></option>
</select></td>
</tr>

<input type="hidden" name="group_name" value="<%=exchange.toHtml(rs.getString("tablename"))%>">
<input type="hidden" name="name" value="<%=exchange.toHtml(rs.getString("name"))%>">

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","组名")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("tablename"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","单词")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("name"))%></td>
</tr>
<% 
int i=0;
String[] column=new String[1000];
String sql2 = "select * from document_config_public_char where kind='语言类型' order by type_ID";
ResultSet rs2 = document_db1.executeQuery(sql2) ;
while(rs2.next()){
column[i]=rs2.getString("type_name");

%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=column[i]%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="colvalue" style="width:20%" value="<%=exchange.toHtml(rs.getString(column[i]))%>"></td>
</tr>
<input type="hidden" name="colname" value="<%=exchange.toHtml(column[i])%>">

<%
	
i++;
}%>

</table>
 </div>
</form>

<%}
else{
%>
 <div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","已配置请变更")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
</table>
 </div>
<%}
	}
document_db.close();
document_db1.close();

%>