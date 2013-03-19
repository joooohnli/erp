<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" errorPage="/error.htm" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="com.jspsmart.upload.*" import="java.text.*" import="javax.servlet.*,javax.servlet.http.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
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
<%try{
	mySmartUpload.setCharset("UTF-8");
	mySmartUpload.initialize(pageContext);
	mySmartUpload.upload();
	com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
	String file=myFile.getFileName();
	int a=file.indexOf(".sql");
	if(a==file.length()-4){
	ServletContext context=session.getServletContext();
	String path=context.getRealPath("/");
	myFile.saveAs(path+"WEB-INF/" + myFile.getFileName());
	session.setAttribute("file",file);
%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><font color="#1A98F1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" onClick=location="../../security_recovery_recovery_ok">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","恢复文件上传成功，确认开始恢复吗？这个过程可能需要几分钟，请耐心等待。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
 <%}else{%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","恢复文件格式错误，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
 <%}}catch(Exception ex){ex.printStackTrace();}%>
 </div>