<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*" import="com.fredck.FCKeditor.*"%>
<%@include file="../top.jsp"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength"/>

<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="930" valign="top"><table width="930" border="0">
	<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","我要应聘")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
	  <tr><td>
<%
String details_number=request.getParameter("details_number") ;
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
%>

<form method="post" action="register2_attachment.jsp?details_number=<%=details_number%>" ENCTYPE="multipart/form-data">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="70%" <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","登记成功，如有附件，请选择上传")%>(<%=file_type%>；<%=demo.getLang("erp","最大")%><%=d/1024%>KB)<input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file1" width="100%"></td>
	 <td width="10%" <%=TD_STYLE3%> class="TD_STYLE3"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","上传附件")%>"></td>
	 <td width="10%" <%=TD_STYLE3%> class="TD_STYLE3"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","上传照片")%>" onClick=location="register2_choose_picture.jsp?details_number=<%=details_number%>"></td>
	 <td width="10%" <%=TD_STYLE3%> class="TD_STYLE3"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回首页")%>" onClick=location="../index.jsp"></td>
 </tr>
 </table>
</form>
</td>
  </tr>
</table>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>

