
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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="POST" action="../../stock_gather_check_serial_number_ok" onSubmit="return doValidate('../../xml/stock/stock_paying_gathering.xml','mutiValidation')">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
<%
String gather_ID=request.getParameter("gather_ID");
String product_ID=request.getParameter("product_ID");
String stock_ID=request.getParameter("stock_ID");
String sql="select * from stock_paying_gathering where gather_ID='"+gather_ID+"' and product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"' and check_tag='0'";
ResultSet rs=stock_db.executeQuery(sql);
if(rs.next()){
%>
<input name="product_ID" type="hidden" value="<%=product_ID%>">
<input name="gather_ID" type="hidden" value="<%=gather_ID%>">
<input name="stock_ID" type="hidden" value="<%=stock_ID%>">
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE7" width="20%"><%=demo.getLang("erp","S/N或B/N（多个S/N或B/N之间请用\"半角逗号\"加\"一个空格\"隔开，如\", \"）")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="serial_number"><%=rs.getString("serial_number")%></textarea></td>
</tr>
<%
	}
stock_db.close();
%>
</table>
</form>
</div>