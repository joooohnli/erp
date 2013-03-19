<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*"%>
<%@include file="../top.jsp"%>
<%@include file="../include/head.jsp"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength"/>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#4c89b5,endColorStr=#FFFFFF)" >
<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>

    <td width="930" valign="top">
    <table width="930" border="0">
	<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","我要购买")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
	  <tr><td>
<%
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
String discussion_ID=request.getParameter("discussion_ID") ;
%>
<form method="post" action="register2_attachment.jsp?discussion_ID=<%=discussion_ID%>" ENCTYPE="multipart/form-data">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="80% <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","提交成功，如有附件，请选择上传")%>(<%=file_type%>；<%=demo.getLang("erp","最大")%><%=d/1024%>KB)<input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file1" width="100%"></td>
 <td width="20% <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","上传")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","完成")%>" onClick=location="../index.jsp"></div></td>
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

