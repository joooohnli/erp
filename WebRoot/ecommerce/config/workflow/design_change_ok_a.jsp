<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="java.text.*"%>
<%@include file="../../include/head.jsp"%>
 <%
 String id=request.getParameter("id");
 String type_id=request.getParameter("type_id");
 String locate_file="design_change_locate.jsp";
 %>
<%@include file="../../../include/workflow_change_ok_a.jsp"%>