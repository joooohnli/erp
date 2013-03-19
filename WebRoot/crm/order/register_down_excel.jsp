<%@page contentType="application/pdf; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import="javax.servlet.*,javax.servlet.http.*"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="downfile" scope="session" class="include.nseer_cookie.downfile"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String filename=(String)session.getAttribute("excelname");
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
downfile.download(response,path+"excel_files\\"+filename);
%>