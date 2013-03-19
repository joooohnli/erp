<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js"></script>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit;
var names=['product_name','product_ID','type','product_describe','amount','amount_unit','cost_price'];
function addGoodsItem(values) {
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
</script>
<%
String realname=(String)session.getAttribute("realeditorc");
String first_kind_name=(String)session.getAttribute("first_kind_name");
String second_kind_name=(String)session.getAttribute("second_kind_name");
String third_kind_name=(String)session.getAttribute("third_kind_name");
String responsible_person_name=(String)session.getAttribute("responsible_person_name");
if(first_kind_name==null||second_kind_name==null||third_kind_name==null||responsible_person_name==null){
response.sendRedirect("../include/error/session_error.jsp");
}else{
String dbase=(String)session.getAttribute("unit_db_name");
String tablename="design_file";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="responsible_person_name";
String condition="check_tag='1' and type!='商品'";
String queue="order by register_time";
ResultSet rs1=query.queryDB(dbase,tablename,"","",first_kind_name,second_kind_name,third_kind_name,responsible_person_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
int intRowCount=query.intRowCount();
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","符合条件的物料总数")%>：<%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
</table>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","物料编号")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","物料名称")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","用途类型")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","物料描述")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","单位")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","单价")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","添加")%></td>
 </tr>
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("product_ID")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("product_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("type"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("product_describe")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("amount_unit"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="javascript:addGoodsItem(['<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=rs1.getString("product_ID")%>','<%=exchange.toHtml(rs1.getString("type"))%>','<%=rs1.getString("product_describe")%>','1','<%=exchange.toHtml(rs1.getString("amount_unit"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>'])"><%=demo.getLang("erp","添加")%></a></td>
 </tr>
</page:pages>
  </table>
  
<%query.close();%>
<page:updowntag num="<%=intRowCount%>" file="register_module_list.jsp"/>
<%}%>