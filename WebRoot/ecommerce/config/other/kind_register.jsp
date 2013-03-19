<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
try{
String file_name=request.getParameter("file_name");
String tag=request.getParameter("tag");
if(tag.equals("0")){
counter count=new counter(application);
String stock_ID=count.read((String)session.getAttribute("unit_db_name"),"stockstockcount")+"";
stock_ID=stock_ID.substring(1,3);
int filenum=count.read((String)session.getAttribute("unit_db_name"),"stockstockcount");
count.write((String)session.getAttribute("unit_db_name"),"stockstockcount",filenum);
String stock_name=file_name+"库房";
String sql = "insert into ecommerce_config_cols_first(stock_ID,stock_name,describe1) values('"+stock_ID+"','"+stock_name+"','库房')" ;
hr_db.executeUpdate(sql) ;

String sql = "insert into ecommerce_config_cols_first(first_kind_id,stock_name,describe1) values('"+stock_ID+"','"+stock_name+"','库房')" ;
hr_db.executeUpdate(sql) ;
}else if(tag.equals("1")){
String sql = "delete from ecommerce_config_cols_first where stock_name='"+file_name+"库房' and describe1='库房'" ;
hr_db.executeUpdate(sql) ;
}
hr_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>