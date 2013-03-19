<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db securitydb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@include file="../include/head1.jsp"%>
<title><%=demo.getLang("erp","恩信科技开源ERP")%></title>

<%
	 demo.setPath(request);
String cell=request.getParameter("cell");
String email=request.getParameter("email");
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
%>
<div id="nseerGround" class="nseerGround">
<form id="form1" class="x-form" method="post" action="send_ok.jsp">
<input type="hidden" name="cell" value="<%=exchange.toHtml(cell)%>">
<input type="hidden" name="email" value="<%=exchange.toHtml(email)%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=demo.getLang("erp","发消息")%></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1">
<%String sql1 = "select * from oa_config_public_char where kind='群发工具分类' order by type_ID";
 ResultSet rs1 = db.executeQuery(sql1) ;
	 while(rs1.next()){if(!rs1.getString("type_name").equals("QQ")&&!rs1.getString("type_name").equals("msn")){%><INPUT name="check_type" type="checkbox" value="<%=exchange.toHtml(rs1.getString("type_name"))%>"><%=exchange.toHtml(rs1.getString("type_name"))%>&nbsp;<%}}db.close();%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close()"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","主题")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="subject" style="width: 30%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE7" width="20%"><%=demo.getLang("erp","内容")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="content" cols="80" rows="8" style="width: 50%"></textarea></td>
</tr>
</table>
</div>
</form>
</div>