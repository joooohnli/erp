<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<%    
demo.setPath(request);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><%=demo.getLang("erp","欢迎使用川大科技信息化平台")%></title>
</head>
<font color="green" size="2"><%=demo.getLang("erp","欢迎使用川大科技信息化平台")%></font>
<body>
</body>
</html>