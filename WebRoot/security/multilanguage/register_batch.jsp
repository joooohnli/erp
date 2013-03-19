<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db_backup document_db = new nseer_db_backup(application);%>
<%nseer_db_backup document_db1 = new nseer_db_backup(application);%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
int error_tag=0;
if(document_db.conn((String)session.getAttribute("unit_db_name"))&&document_db1.conn((String)session.getAttribute("unit_db_name"))){
String batch_amount=request.getParameter("batch_amount");
if(!batch_amount.equals("")&&validata.validata(batch_amount)){
String type=request.getParameter("type");
if(!type.equals("")){
String group_name=request.getParameter("group_name");
 String sql = "select * from document_multilanguage where "+type+"='' and tag='0' and tablename='"+group_name+"' limit "+batch_amount;
 ResultSet rs = document_db.executeQuery(sql);
 if(rs.next()){	 
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="../../security_multilanguage_register_batch_ok">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1">
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_batch_getpara.jsp"></div></td>
 </tr>
</table>
<input type="hidden" name="type" value="<%=type%>">

	<title>ActiveWidgets Grid :: Examples</title>
    <!-- ActiveWidgets stylesheet and scripts -->
	<link href="runtime/styles/classic/grid.css" rel="stylesheet" type="text/css"></link>
	<script src="runtime/lib/grid.js"></script>

	<!-- grid format -->
	<style>
		#grid1 {height: 100%; border: 2px inset; background: white}
		#grid2 {height: 100%; border: 2px inset; background: white}

		grid1 .active-column-1 {width: 100%; background-color: threedlightshadow;}
		#grid2 .active-column-1 {width: 150px; background-color: infobackground;}

		.active-column-2 {text-align: right;}
		.active-column-3 {text-align: right;}
		.active-column-4 {text-align: right;}

		.active-grid-row {border-bottom: 1px solid threedlightshadow;}
		.active-grid-column {border-right: 1px solid threedlightshadow;}

	</style>

	<!-- grid data -->
	<script>
		var data1 = [
		<%
int i=0;		
do{
	i++;
	String sql11="update document_multilanguage set tag='1' where id='"+rs.getString("id")+"'";

	document_db1.executeUpdate(sql11);
%>
			["<%=rs.getString("tablename")%>","<%=rs.getString("name")%>", "<input type=\"text\" name=\"describe\" <%=INPUT_STYLE5%> class=\"INPUT_STYLE5\" style=\"width:100%\"><input type=\"hidden\" name=\"id\" value=<%=rs.getString("id")%>><input type=\"hidden\" name=\"group_name\"  value=<%=rs.getString("tablename")%>><input type=\"hidden\" name=\"name\" value=<%=rs.getString("name")%>>"],
			<%}while(rs.next());%>
		];

		
		var columns1 = [
			"<%=demo.getLang("erp","组名")%>", "<%=demo.getLang("erp","单词")%>", "<%=demo.getLang("erp","配置")%>"
		];

		
	</script>
	<script>
		var obj1 = new Active.Controls.Grid;
		obj1.setId("grid1");
		obj1.setRowProperty("count", <%=i%>);
		obj1.setColumnProperty("count", 3);
		obj1.setDataProperty("text", function(i, j){return data1[i][j]});
		obj1.setColumnProperty("text", function(i){return columns1[i]});
		document.write(obj1);
	</script>
</form>
</div>
<%}else{
error_tag=4;
}}else{
error_tag=3;
}
}else{
error_tag=2;
}
}else{
error_tag=1;
}
if(error_tag!=0){
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_batch_getpara.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3">
<%
switch(error_tag){
	case 1:
		out.println(demo.getLang("erp","数据库连接故障，请返回。"));
		break;
	case 2:
		out.println(demo.getLang("erp","批量配置数量必须是数字，请返回！"));
		break;
	case 3:
		out.println(demo.getLang("erp","必须选择语言种类，请返回！"));
		break;
	case 4:
		out.println(demo.getLang("erp","没有符合条件的记录，请返回！"));
		break;
}
%>
</td>
 </tr>
 </table>
</div>
<%}
document_db.close();
document_db1.close();
%>