<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="com.jspsmart.upload.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*" import="javax.servlet.*,javax.servlet.http.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload"/>
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db_backup design_db = new nseer_db_backup(application);%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
	String product_ID=request.getParameter("product_ID");
	mySmartUpload.setCharset("UTF-8");
    mySmartUpload.initialize(pageContext);	
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);

	try{
	mySmartUpload.upload();
	com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);

	String file_name=myFile.getFileName();
	ServletContext context=session.getServletContext();
	String path=context.getRealPath("/");
	String file=DealWithString.joinIn(product_ID,myFile.getFileName());
	myFile.saveAs(path+"design/file_attachments/" + file);
	if(design_db.conn((String)session.getAttribute("unit_db_name"))){
	String sql="update design_file set attachment_name='"+file+"' where product_ID='"+product_ID+"'";
	design_db.executeUpdate(sql);
	design_db.close();
%>
 <div id="nseerGround" class="nseerGround"> 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="check_list.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","审核通过，请返回！")%></td>
 </tr>
 </table>
 </div>
<%}else{
	design_db.close();	
	%>
 <div id="nseerGround" class="nseerGround"> 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="check_choose_attachment.jsp?product_ID=<%=product_ID%>"></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td>
 </tr>
 </table>
 </div>
<%}	
  }catch(Exception ex){%>
  <div id="nseerGround" class="nseerGround"> 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="check_choose_attachment.jsp?product_ID=<%=product_ID%>"></div></td>
 </tr>
 </table>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <%=demo.getLang("erp","附件类型错误或附件容量太大(最大")%><%=d/1024%>KB)，<%=demo.getLang("erp","请返回。")%></td>
 </tr>
 </table>
  </div>
<%}%>