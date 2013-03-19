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
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML"/>
<%
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String nickName="客户档案";
String file=path+"WEB-INF/classes/conf/xml/crm/data.xml";
String file1=path+"crm/file/input_control/validation-config.xml";
String currentPage="defineProp.jsp";
%>
<%@include file="../../../include/cDefineConf3_ok.jsp"%>