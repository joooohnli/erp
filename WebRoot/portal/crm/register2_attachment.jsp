<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="com.jspsmart.upload.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload"/>
<%@include file="../top.jsp"%>
<%@include file="../include/head.jsp"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength"/>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#4c89b5,endColorStr=#FFFFFF)" >
<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>

    <td width="930" valign="top"><table width="930" border="0">
	<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","我要购买")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
	  <tr><td>
<%nseer_db_backup crm_db = new nseer_db_backup(application);%>

<%
DealWithString DealWithString=new DealWithString(application);
	String discussion_ID=request.getParameter("discussion_ID");
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
	String file=DealWithString.joinIn(discussion_ID,myFile.getFileName());
	myFile.saveAs(path+"crm/discussion_attachments/" + file);
if(crm_db.conn("ondemand1")){
	String sql="update crm_discussion set attachment_name='"+file+"' where discussion_ID='"+discussion_ID+"'";
	crm_db.executeUpdate(sql);
	crm_db.close();
%>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <%=demo.getLang("erp","提交成功，需要审核！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回首页")%>" style="width: 59; " onClick=location="../index.jsp"></div></td>
 </tr>
 </table>
 <%	}else{
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register2_choose_attachment.jsp?discussion_ID=<%=discussion_ID%>"></div>
 </td>
 </tr>
 </table>
 <%}
}catch(Exception ex){
%>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"> <%=demo.getLang("erp","附件类型错误或附件容量太大(最大")%><%=d/1024%>KB)，<%=demo.getLang("erp","请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="register2_choose_attachment.jsp?discussion_ID=<%=discussion_ID%>"></div></td>
 </tr>
 </table>
<%}%>
</td>
  </tr>
</table>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>

