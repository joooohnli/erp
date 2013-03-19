<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java"%>
<%@ page info="database handler"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="include.nseer_cookie.exchange"%>
<%@ page import="include.operateXML.*"%>
<html>
<head>
</head>
<body>
<%
try{
String bodyb = new String(request.getParameter("cont").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

remark=remark.replace("<br>","⊙");

String name=request.getParameter("name");
String cont=request.getParameter("cont");
String filename=request.getParameter("filename");
String from_name=request.getParameter("from_name");
from_name=from_name.substring(0,from_name.length()-1);
for(int i=0;i<from_name.split(",").length;i++){
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
TtoXml.createMsgXml(path+"xml\\include\\msg\\"+from_name.split(",")[i]+".xml","1",name,remark,filename);
}
}catch(Exception ex){ex.printStackTrace();}
%>

