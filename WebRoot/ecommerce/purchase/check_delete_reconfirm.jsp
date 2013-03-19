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
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%
String config_id=request.getParameter("config_id");
String product_ID=request.getParameter("product_ID");
String promotion2=request.getParameter("promotion2");
String opinion2=request.getParameter("opinion2");
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
%>
<form class="x-form" method="post" action="../../ecommerce_purchase_check_delete_ok">
<input type="hidden" name="config_id" value="<%=config_id%>">
<input type="hidden" name="product_ID" value="<%=product_ID%>">
<input type="hidden" name="promotion2" value="<%=promotion2%>">
<input type="hidden" name="opinion2" value="<%=opinion2%>">
<input type="hidden" name="checker_ID" value="<%=checker_ID%>">
<input type="hidden" name="checker" value="<%=exchange.toHtml(checker)%>">
<input type="hidden" name="check_time" value="<%=exchange.toHtml(check_time)%>">
<input name="lately_change_time" type="hidden" value="<%=exchange.toHtml(lately_change_time)%>">
<input name="file_change_amount" type="hidden" value="<%=file_change_amount%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table> 
 <div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>"> 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10"><%=demo.getLang("erp","该产品未通过发布审核，您确认吗？请选择处理：")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10">&nbsp;</td>
 </tr>
 
<%
int i=1;
String sql6="select * from ecommerce_workflow where type_id='03' and object_ID='"+product_ID+"' and config_id<'"+config_id+"' order by id";
ResultSet rs6=design_db.executeQuery(sql6);
while(rs6.next()){
	String choice="从流程"+i+"开始重新审核";
	i++;
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="<%=rs6.getString("config_id")%>"><%=demo.getLang("erp",choice)%></td>
 </tr>
	<%
}
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=""><%=demo.getLang("erp","禁止发布")%></td>
 </tr>
 </table>
</form>
 </div>