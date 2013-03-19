<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*" import="java.util.*" import="com.jspsmart.upload.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.get_name_from_ID.getNameFromID,include.nseer_cookie.*"%><%
getNameFromID getNameFromID=new getNameFromID();
String id = request.getParameter("id");
String tablename = request.getParameter("tablename");
String fieldname = request.getParameter("fieldname");
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String filename1=getNameFromID.getNameFromID((String)session.getAttribute("unit_db_name"),tablename,"id",id,fieldname);
String abfile=path+"ecommerce/file_attachments/"+filename1;
SmartUpload mySmartUpload = new SmartUpload();
mySmartUpload.initialize(pageContext);
mySmartUpload.setContentDisposition(null);
try{
mySmartUpload.downloadFile(abfile);
}catch(Exception ex){
%>
<%@include file="../top.jsp"%>
<%@include file="../include/head.jsp"%>
<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="930" valign="top"><table width="930" border="0">
	<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","反馈信息")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
	  <tr><td>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该附件已不存在！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></div></td>
 </tr>
 </table>
</td>
  </tr>
</table>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>
<%}%>