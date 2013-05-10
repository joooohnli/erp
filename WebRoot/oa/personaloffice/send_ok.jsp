<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@include file="../include/head1.jsp"%>
<title><%=demo.getLang("erp","川大科技信息化平台")%></title>
<div id="nseerGround" class="nseerGround">
<%
Note note=new Note();
Email mail=new Email();
	 demo.setPath(request);
String cell=request.getParameter("cell");
String email=request.getParameter("email");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
String content1=subject+content;
String[] check_type=request.getParameterValues("check_type");
String[] email_box={email};
String send_type="";
if(check_type!=null){
	for(int i=0;i<check_type.length;i++){
		send_type+=check_type[i]+",";
	}
	send_type=send_type.substring(0,send_type.length()-1);
}
if(check_type!=null){
if(send_type.indexOf("发短信")!=-1){
						note.send("bjnseer","8888",cell,content1);
						}
if(send_type.indexOf("发邮件")!=-1){
	mail.send(email_box,"smtp.sina.com.cn","nseer_erp_family@sina.com","12345678",subject,content);
}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=demo.getLang("erp","发消息")%></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","发送成功！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close()"></td>
 </tr>
</table>
<%}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=demo.getLang("erp","发消息")%></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择发送方式，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="send.jsp"></div></td>
 </tr>
</table>
<%}%>
</div>