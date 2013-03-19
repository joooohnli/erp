<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_cookie.*,java.text.*" import="com.fredck.FCKeditor.*"%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db oa_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<%
String changer_ID=(String)session.getAttribute("human_IDD");
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String id=request.getParameter("id");
String sql="select * from oa_messager where id='"+id+"'";
ResultSet rs=oa_db.executeQuery(sql);
if(rs.next()){
%>
<form id="mutiValidation" method="POST" action="../../oa_messager_change_ok">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="change_list.jsp"></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","对象类型")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="messager_type" style="width: 40%;height: 14">
  <%
  String sql5 = "select * from oa_config_public_char where kind='群发对象分类' order by type_name" ;
	 ResultSet rs5 = oa_db1.executeQuery(sql5) ;
while(rs5.next()){
	if(rs.getString("type").equals(rs5.getString("type_name"))){%>
		<option value="<%=rs5.getString("type_name")%>" selected><%=rs5.getString("type_name")%></option>
<%}else{%>
		<option value="<%=rs5.getString("type_name")%>"><%=rs5.getString("type_name")%></option>
<%
	}
}
%>
</select></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","群发工具")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="tool_type" style="width: 40%;height: 14">
  <%
  sql5 = "select * from oa_config_public_char where kind='群发工具分类' order by type_name" ;
	 rs5 = oa_db1.executeQuery(sql5) ;
while(rs5.next()){
	if(rs.getString("tool_type").equals(rs5.getString("type_name"))){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>" selected><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%
	}
}
oa_db1.close();
%>
</select></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","内容")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2"><textarea id="content" name="content" cols="122" rows="30"><%=rs.getString("content")%></textarea>
<script type="text/javascript">
 var oFCKeditor = new FCKeditor('content') ;
 oFCKeditor.BasePath = "/erp/" ;
 oFCKeditor.Height = 400;
 oFCKeditor.ToolbarSet = "Default" ; 
 oFCKeditor.ReplaceTextarea();
</script>
</td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2"><textarea style="width:100%" id="content" name="content" cols="122" rows="30"><%=exchange.unHtml(rs.getString("content"))%></textarea></td>
<%}%>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","变更人")%>&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%"><input type="hidden" name="changer" value="<%=exchange.toHtml(changer)%>"><input type="hidden" name="changer_ID" value="<%=changer_ID%>"><%=exchange.toHtml(changer)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","变更时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%"><input type="hidden" name="change_time" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="id" value="<%=id%>">
</form>
<%}
oa_db.close();
%>