<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="filetree.*"%>
<%
String strPage=request.getParameter("page");
String pageSize_temp=request.getParameter("pageSize");
int intRowCount=0;
int pageSize=25;
if(pageSize_temp!=null&&!pageSize_temp.equals("")){pageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(pageSize).toString());
try{
nseer_db db=new nseer_db((String)session.getAttribute("unit_db_name"));
if(sql_search.indexOf("select ")!=-1){
String search_fields="*";
if(sql_search.indexOf("*")==-1){search_fields=sql_search.split("select ")[1].split(" from")[0];}
String sql_search1=sql_search.replace(search_fields,"count(id)");
ResultSet rs_search=db.executeQuery(sql_search1);
if(rs_search.next()){
	intRowCount=rs_search.getInt("count(id)");
}
}else{
ResultSet rs_search=db.executeQuery(sql_search);
if(rs_search.next()){
rs_search.last();
intRowCount=rs_search.getRow();
}
}
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&strPage.equals("")&&!validata.validata(strPage)){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
db.close();
sql_search=sql_search+" limit "+(Integer.parseInt(strPage)-1)*pageSize+","+pageSize;
strPage=strPage+"⊙"+maxPage;
}catch(Exception e){
	e.printStackTrace();
}

%>