<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@include file="../../include/head.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>无标题文档</title>
<style type="text/css">
<!--
body {

	background-color: #FFFFFF;
}
a:link {
	color: #000000;
}
a:visited {
	color: #000000;
}
a:hover {
	color: #0066CC;
}
a:active {
	color: #000000;
}
body,td,th {
	font-size: 12px;
	color: #000000;
}
.style2 {color: #000000}
-->
</style></head>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <font color="#1A98F1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">
<img src="/erp/images/nseer_extend.gif" width="100" height="100" hspace="1">
</td>
<td <%=TD_STYLE3%> class="TD_STYLE3">
这是您所设置的初始文件，具体功能需要您自行实现！如有任何问题请联系川大科技<A HREF="http://www.nseer.com">www.nseer.com</A>
</td>
</table>






