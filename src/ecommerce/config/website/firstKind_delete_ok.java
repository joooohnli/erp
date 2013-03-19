/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.config.website;
  
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class firstKind_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session= request.getSession(true);
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
try{
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
int i;
int intRowCount=0;
String sqll = "select * from ecommerce_config_cols_first" ;
ResultSet rs=ecommerce_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
String[] first_kind_ID=new String[intRowCount];
String[] first_kind_name=new String[intRowCount];
String[] real_del=new String[intRowCount];
int m=0;
int n=0;
if(del!=null){
for(i=1;i<=intRowCount;i++){
	if(del[i-1]!=null){
		real_del[n]=del[i-1];
		n++;	
	String sql2="select * from ecommerce_config_cols_first where id='"+del[i-1]+"'" ;
ResultSet rs2=ecommerce_db.executeQuery(sql2) ;
if(rs2.next()){
	first_kind_ID[i-1]=rs2.getString("first_kind_ID");
	first_kind_name[i-1]=rs2.getString("first_kind_name");
}
int col=0;
String sql3="select id from ecommerce_cols_bottom where first_kind_ID='"+first_kind_ID[i-1]+"'" ;
ResultSet rs3=ecommerce_db.executeQuery(sql3) ;
if(rs3.next()){
	col++;
}
sql3="select id from ecommerce_cols_top where first_kind_ID='"+first_kind_ID[i-1]+"'" ;
rs3=ecommerce_db.executeQuery(sql3) ;
if(rs3.next()){
	col++;
}
sql3="select id from ecommerce_colsa where first_kind_ID='"+first_kind_ID[i-1]+"'" ;
rs3=ecommerce_db.executeQuery(sql3) ;
if(rs3.next()){
	col++;
}
sql3="select * from ecommerce_config_cols_second where first_kind_ID='"+first_kind_ID[i-1]+"' and second_kind_name!=''" ;
rs3=ecommerce_db.executeQuery(sql3) ;
if(rs3.next()){
	col++;
}
sql3="select * from ecommerce_other where chain_id='"+first_kind_ID[i-1]+"'" ;
rs3=ecommerce_db.executeQuery(sql3) ;
if(rs3.next()){
	col++;
}
if(col==0){
	String sql = "delete from ecommerce_config_cols_first where id='"+del[i-1]+"'" ;
    ecommerce_db.executeUpdate(sql) ;
	String sql4 = "delete from ecommerce_config_cols_second where first_kind_ID='"+first_kind_ID[i-1]+"'" ;
    ecommerce_db.executeUpdate(sql4) ;
	sql = "delete from ecommerce_config_other_first where first_kind_ID='"+first_kind_ID[i-1]+"'" ;
    ecommerce_db.executeUpdate(sql) ;
	sql4 = "delete from ecommerce_config_other_second where first_kind_ID='"+first_kind_ID[i-1]+"'" ;
    ecommerce_db.executeUpdate(sql4) ;
	}else{
	first_kind_ID[m]=first_kind_ID[i-1];
	first_kind_name[m]=first_kind_name[i-1];
	m++;
}
	}
}
}
ecommerce_db.commit();
ecommerce_db.close();
if(n==0){
	response.sendRedirect("ecommerce/config/website/firstKind.jsp");
}else{
if(m<n&&m!=0){
	session.setAttribute("first_kind_ID",first_kind_ID);
	session.setAttribute("first_kind_name",first_kind_name);
	session.setAttribute("first_kind_count",m+"");
response.sendRedirect("ecommerce/config/website/firstKind_delete_ok_a.jsp");
}else if(m==n){
response.sendRedirect("ecommerce/config/website/firstKind_delete_ok_b.jsp");
}else if(m==0){
response.sendRedirect("ecommerce/config/website/firstKind_delete_ok_c.jsp");
}
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch (Exception ex) {
		ex.printStackTrace();
}
	}
}