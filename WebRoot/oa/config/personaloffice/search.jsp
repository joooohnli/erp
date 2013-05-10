<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db oa_db=new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db oa_db1=new nseer_db((String)session.getAttribute("unit_db_name"));%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=demo.getLang("erp","川大科技信息化平台")%></title>
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
 <font color="#1A98F1"><%=demo.getLang("erp","我的网上搜索器")%></td>
 </tr>
</table>
<form id="form1" method="post" action="search_ok.jsp">
<table>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td colspan="5"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="keyword"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td colspan="5"><input type="radio" name="tool" value="http://www.google.com/search?hl=zh-CN&ie=GB2312&oe=GB2312&q=">Google</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td colspan="5"><input type="radio" name="tool" value="http://www1.baidu.com/baidu?cl=3&ct=0&f=5&lm=0&word="><%=demo.getLang("erp","百度")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td colspan="5"><input type="radio" name="tool" value="http://search.iask.com/cgi-bin/search/search.cgi?_andor=and&_searchkey="><%=demo.getLang("erp","新浪")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td colspan="5"><input type="radio" name="tool" value="http://so.sohu.com/web?query="><%=demo.getLang("erp","搜狐")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td colspan="5"><input type="radio" name="tool" value="http://www.yahoo.com.cn/search?ei=UTF-8&p="><%=demo.getLang("erp","Yahoo")%></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","搜索")%>">&nbsp;&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></td>
 </tr>
</table>
</form>





