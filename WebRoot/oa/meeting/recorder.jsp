<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*" import="com.fredck.FCKeditor.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>


<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String meeting_ID=request.getParameter("meeting_ID");
String sql="select * from oa_meeting where meeting_ID='"+meeting_ID+"' and check_tag='1'";
ResultSet rs=oa_db.executeQuery(sql);
if(rs.next()){
%>
<form id="subjectRegister" method="POST" action="../../oa_meeting_recorder_ok?meeting_ID=<%=meeting_ID%>" onSubmit="return doValidate('../../xml/oa/oa_meeting.xml','subjectRegister')" ENCTYPE="multipart/form-data">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="recorder_list.jsp"></div></td>
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
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会议主题")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><%=exchange.toHtml(rs.getString("subject"))%></td>
</tr>
<tr>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","开始时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("begin_time"))%></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","结束时间")%>：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("end_time"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会议地点")%>：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("place"))%></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会议类型")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("type"))%></td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4"><div align="left"><fieldset><legend><%=demo.getLang("erp","会议日程")%></legend><%=rs.getString("schedule")%></fieldset></div></td>
</tr>
<%=isPrint.printOrNot3(rs.getString("attachment1"),"附件&nbsp;&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"oa_meeting","attachment1")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4"><div align="left"><fieldset><legend><%=demo.getLang("erp","备注")%></legend><%=rs.getString("remark")%></fieldset></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会议纪要")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea id="content" name="content" cols="122" rows="30"></textarea>
<script type="text/javascript">
 var oFCKeditor = new FCKeditor('content') ;
 
 oFCKeditor.BasePath = "/erp/" ;
 oFCKeditor.Height = 400;
 oFCKeditor.ToolbarSet = "Default" ; 
 oFCKeditor.ReplaceTextarea();
</script>
</td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea style="width:100%" id="content" name="content" cols="122" rows="30"></textarea></td>
<%}%>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","纪要附件")%>：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file1" width="100%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","需做计划")%>：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><INPUT name="ifplaning" type="radio" value="0" checked><%=demo.getLang("erp","是")%>&nbsp;<INPUT name="ifplaning" type="radio" value="1"><%=demo.getLang("erp","否")%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","纪要整理")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="hidden" name="dealwith_register" value="<%=exchange.toHtml(register)%>"><input type="hidden" name="dealwith_register_ID" value="<%=register_ID%>"><%=exchange.toHtml(register)%></td>
</tr>
</table>
<input type="hidden" name="meeting_subject" value="<%=exchange.toHtml(rs.getString("subject"))%>">
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%@include file="../include/paper_bottom.html"%>
 </div>
</form>
<%}else{%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">
 <%=demo.getLang("erp","该会议纪要已经整理，请返回重新选择！")%>
</td>
<td <%=TD_STYLE3%> class="TD_STYLE3">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="recorder_list.jsp"></div>
</td>
</tr>
</table>
 </div>
<%}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>