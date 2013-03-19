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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
 <form id="itemNameRegister" class="x-form" method="post" action="../../../manufacture_config_procedure_itemName_change_ok" onSubmit="return doValidate('../../../xml/manufacture/manufacture_config_public_char.xml','itemNameRegister')">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="itemName.jsp"></div></td>
 </tr>
 </table>
 <%
String id=request.getParameter("id");
try{
	String sql="select * from manufacture_config_public_char where id='"+id+"'";
	ResultSet rs=manufacture_db.executeQuery(sql);
	if(rs.next()){
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<input type="hidden" name="id" value="<%=id%>">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","工序项目编号")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="hidden" name="type_ID" value="<%=rs.getString("type_ID")%>"><%=rs.getString("type_ID")%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","工序项目名称")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="hidden" name="type_name" value="<%=exchange.toHtml(rs.getString("type_name"))%>"><%=exchange.toHtml(rs.getString("type_name"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE7" width="20%"><%=demo.getLang("erp","工序项目描述")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="describe1"><%=exchange.unHtml(rs.getString("describe1"))%></textarea></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE7" width="20%"><%=demo.getLang("erp","负责人编号（多个编号之间请用\"半角逗号\"加\"一个空格\"隔开，如\", \"）")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="register_ID" cols="122" rows="6"><%=rs.getString("register_ID")%></textarea></td>
</tr>
</table>
</div> 
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%
	}
	manufacture_db.close();
}catch (Exception ex) {
		out.println("error"+ex);
	}	
%>
</form>