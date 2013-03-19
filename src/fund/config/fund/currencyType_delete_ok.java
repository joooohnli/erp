/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.config.fund;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;

public class currencyType_delete_ok extends HttpServlet{
//创建方法

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);

if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){

int i;
int intRowCount;
String sqll = "select * from fund_config_fund_currency" ;
ResultSet rs=fund_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
String[] currency_ID=new String[intRowCount];
String[] currency_name=new String[intRowCount];
String[] real_del=new String[intRowCount];
int m=0;
int n=0;
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	if(del[i-1]!=null){
		real_del[n]=del[i-1];
		n++;
	String sql2="select * from fund_config_fund_currency where id='"+del[i-1]+"'" ;
ResultSet rs2=fund_db.executeQuery(sql2) ;
if(rs2.next()){
	currency_ID[i-1]=rs2.getString("currency_ID");
	currency_name[i-1]=rs2.getString("currency_name");
}
	String sql3="select * from fund_config_fund_kind where currency_name='"+currency_name[i-1]+"'" ;
ResultSet rs3=fund_db.executeQuery(sql3) ;
if(!rs3.next()){
	String sql = "delete from fund_config_fund_currency where id='"+del[i-1]+"'" ;
    fund_db.executeUpdate(sql) ;
	}else{
	currency_name[m]=currency_name[i-1];
	m++;
}
	}
}
	catch (Exception ex) {
		out.println("error"+ex);
	}
	}
}

if(n==0){
	response.sendRedirect("fund/config/fund/currencyType.jsp");
}else{
if(m<n&&m!=0){
    session.setAttribute("currency_name",currency_name);
	session.setAttribute("currency_count",m+"");
response.sendRedirect("fund/config/fund/currencyType_delete_ok_a.jsp");
}else if(m==n){
response.sendRedirect("fund/config/fund/currencyType_delete_ok_b.jsp");

	}else if(m==0){
response.sendRedirect("fund/config/fund/currencyType_delete_ok_c.jsp");

}
}
fund_db.commit();
fund_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}