<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<jsp:useBean id="GetImg" class="include.ajax.GetImg" scope="page"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<jsp:useBean id="browercheck" scope="session" class="include.nseer_cookie.BrowerVer"/>
<%
		String strhead = request.getHeader("User-Agent");
		if(strhead.indexOf(browercheck.IE)!=-1){
		 
			 	double ver = Double.parseDouble(strhead.substring(strhead.indexOf("MSIE ")+5,strhead.indexOf(";",strhead.indexOf("MSIE "))));
			 	if(ver <browercheck.IEVer){
			RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/alarm.html");
  dispatcher.include(request,response);
				}
		}
%>
<style type="text/css"> 
.spanstyle{ 
border-bottom:1px solid #12D608;
} 
.spanstyle1{ 
border-top:2px solid #ffffff;
border-right:1px solid #12D608;
} 
</style>

<%
demo.setPath(request);
nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));
if(session.getAttribute("human_IDD")==null) response.sendRedirect("../../home/login.jsp");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<title><%=demo.getLang("erp","欢迎进入川大科技ERP系统")%></title>

<%
String human_ID=(String)session.getAttribute("human_IDD");
String tree_view_name=exchange.unURL(request.getParameter("tree_view_name")) ;
String category=exchange.unURL(request.getParameter("category")) ;
%>

<frameset rows="6%,94%" framespacing="0" border="1">
<frame src="workspace_div_top.jsp" name="top" frameborder="no" scrolling="no" marginwidth="1" marginheight="1" class="spanstyle">
     <frameset cols="17%,*"  framespacing="0" border="1"  id="indexFrm">
     <frame src="../../security_workspace_workspace_left?human_ID=<%=human_ID%>&&tree_view_name=<%=tree_view_name%>&&category=<%=category%>" name="a" frameborder="no" marginwidth="1" marginheight="1" class="spanstyle1">
     <frame src="workspace_div_right.jsp?human_ID=<%=human_ID%>&&tree_view_name=<%=tree_view_name%>&&category=<%=category%>" name="content" frameborder="no" marginwidth="1" marginheight="1">
     </frameset>
</frameset>