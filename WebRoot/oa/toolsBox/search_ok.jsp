<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.*" import ="include.nseer_db.*,java.text.*"%>
<div id="nseerGround" class="nseerGround">
<%
toGb2312String change=new toGb2312String();
String keyword=request.getParameter("keyword");
String tool=request.getParameter("tool");
String url=tool+change.toGb2312String(keyword);
response.sendRedirect(url);
%>
</div>