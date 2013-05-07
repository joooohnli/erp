<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="org.json.simple.JSONObject" import="org.json.simple.JSONArray"%>
<%
    JSONObject obj=new JSONObject();
    JSONArray array = new JSONArray();

	for (int i=0;i<3;i++){
		JSONArray temp=new JSONArray();
		temp.add("test"+i);
		
		array.add(temp);
	}
    
    
    out.print(array);
    
    out.flush();
    out.close();
%>

