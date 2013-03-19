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
<%nseer_db db = new nseer_db("ondemand1");%>
<%
String column=request.getParameter("column");

String sql="select * from ecommerce_other where chain_name='"+column+"'";
ResultSet rs=db.executeQuery(sql);
if(rs.next()){
%>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#4c89b5,endColorStr=#FFFFFF)" >
<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="200" bgcolor="#ebf3fb">&nbsp;</td>
    <td width="600" valign="top"><table width="600" border="0">
	<tr>
        <td width="600" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp",column)%></td>
      </tr>
      <tr>
        <td><img src="../images/list.jpg" width="700" height="2" /></td>
      </tr>
	  <tr><td>

<%=rs.getString("content")%>
<%}
db.close();
%>
</td>
  </tr>
</table>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>

</body>