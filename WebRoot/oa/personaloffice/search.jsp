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
<%@include file="../include/head1.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% 
demo.setPath(request);
%>

<title><%=demo.getLang("erp","川大科技信息化平台")%></title>
<div id="nseerGround" class="nseerGround">
<form id="form1" class="x-form" method="post" action="search_ok.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=demo.getLang("erp","我的搜索")%></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="5"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="keyword" style="width:19%" value="川大科技"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="5"><input <%=RADIO_STYLE1%> class="RADIO_STYLE1" type="radio" name="tool" value="http://www.google.com/search?hl=zh-CN&ie=UTF-8&oe=UTF-8&q=" checked>Google</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="5"><input <%=RADIO_STYLE1%> class="RADIO_STYLE1" type="radio" name="tool" value="http://www.yahoo.com.cn/search?ie=UTF-8&ei=UTF-8&p="><%=demo.getLang("erp","Yahoo")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="5"><input <%=RADIO_STYLE1%> class="RADIO_STYLE1" type="radio" name="tool" value="http://cnweb.search.live.com/results.aspx?ie=UTF-8&go=%E6%90%9C%E7%B4%A2&mkt=zh-cn&scope=&FORM=LIVSOP&q="><%=demo.getLang("erp","Live Search")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="5"><input <%=RADIO_STYLE1%> class="RADIO_STYLE1" type="radio" name="tool" value="http://www1.baidu.com/baidu?ie=UTF-8&cl=3&ct=0&f=5&lm=0&word="><%=demo.getLang("erp","百度")%></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","搜索")%>">&nbsp;&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></td>
 </tr>
</table>
</form>
</div>