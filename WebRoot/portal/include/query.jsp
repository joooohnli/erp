<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.get_name_from_ID.getNameFromID,include.nseer_cookie.*"%>
<jsp:useBean id="gb" scope="page" class="include.nseer_cookie.toGb2312String"/>
<%
getNameFromID getNameFromID=new getNameFromID();
String id = request.getParameter("id");
String tablename = request.getParameter("tablename");
String fieldname = request.getParameter("fieldname");
String filename=getNameFromID.getNameFromID((String)session.getAttribute("unit_db_name"),tablename,"id",id,fieldname);
filename="../file_attachments/"+toUtf8String.utf8String(filename);
%>
<meta http-equiv="refresh" content="0;url=<%=filename%>">