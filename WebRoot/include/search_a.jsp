<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="filetree.*,include.operateXML.*"%>
<%
ServletContext context_s=session.getServletContext();
String path_s=context_s.getRealPath("/");
String userName_s=(String)session.getAttribute("userName");
String xmlFile_s="xml/include/listPage/"+userName_s+session.getId()+".xml";
String url_s=request.getRequestURI();
String sql_xml="";
String strPage_xml="";
Reading reader=new Reading(xmlFile_s);
boolean flag_search=false;
String inputTextId1="keyword";
String inputTextId2="keyword_chain";
String inputTextId3="div_keyword";
String searchTag="searchTag";
String sql_search="";
String keyword="";
String otherButtons="";
int search_init=0;
String strPage="";
int intRowCount=0;
int pageSize=25;
String pageSize_temp=request.getParameter("pageSize");
String readXml=request.getParameter("readXml");
if(pageSize_temp!=null&&!pageSize_temp.equals("")){pageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(pageSize).toString());
%>