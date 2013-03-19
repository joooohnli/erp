<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td> 
 </tr>
</table>
<%
String id=request.getParameter("id");
try{
	String sql = "select * from hr_questiones where id='"+id+"'" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
	if(rs.next()){
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","试题I级分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("first_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","试题II级分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("second_kind_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","正确答案")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("correctkey"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","试题出处")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("derivation"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","题干")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" ><%=rs.getString("content")%>&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案a")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" ><%=rs.getString("keya")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案b")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" ><%=rs.getString("keyb")%>&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案c")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" ><%=rs.getString("keyc")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案d")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" ><%=rs.getString("keyd")%>&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案e")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" ><%=rs.getString("keye")%>&nbsp;</td>
 </tr>
</table>
<%
}
			 hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</form>
</div>