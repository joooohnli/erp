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
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js">
</script>
<%
	String sql = "select * from logistics_discussion where check_check_tag='0' and excel_tag='2' and modify_check_tag='0' order by register_time" ;
	ResultSet rs = logistics_db.executeQuery(sql) ;
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","当前可修改的报价单总数")%>：<%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","报价单编号")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","客户名称")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","收货人")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","预提货时间")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","运输方式")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","销售总额")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","删除")%></td>
 </tr>
	<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String register_time="";
//if(rs.getString("register_time").equals("0000-00-00")){
//register_time="";
//}else{
register_time=rs.getString("register_time");
//}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("discussion_ID")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("customer_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("demand_contact_person"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("demand_pay_time"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("demand_pay_type"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("sale_price_sum")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="delete_reconfirm.jsp?id=<%=rs.getString("id")%>"><%=demo.getLang("erp","删除")%></a></td>
 </tr>
</page:pages>
  </table>
  
<page:updowntag num="<%=intRowCount%>" file="delete_list.jsp"/>

<%	
logistics_db.close();
%>
</body>
</html>