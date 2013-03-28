<%@page contentType="application/vnd.ms-excel; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="com.jspsmart.upload.*" import="java.util.*" import="java.io.*" import="java.text.*" import="javax.servlet.*,javax.servlet.http.*"%><%
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
SmartUpload mySmartUpload = new SmartUpload();
mySmartUpload.initialize(pageContext);
mySmartUpload.setContentDisposition(null);
mySmartUpload.downloadFile(path+"excel_files/stock_report_data.xls");
%>