<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>


<%
String filename=request.getParameter("filename");
filename="../human_pictures/"+filename;
%>
<jsp:forward page="<%=filename%>"/>
