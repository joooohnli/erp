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
<%@ page import="include.anti_repeat_submit.Globals"%>
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength"/>

<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="930" valign="top"><table width="930" border="0">
	<tr>
        <td width="660" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","我能配送")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
	  <tr><td>
<%
String customer_ID=request.getParameter("customer_ID");
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <%=demo.getLang("erp","数量、单价、折扣必须是数字，折扣必须在权限范围内，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1">
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50;" onClick=location="register2.jsp?provider_ID=<%=provider_ID%>"></div></td>
 </tr>
 </table>
</td>
  </tr>
</table>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>

