/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.teller.checkup;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import java.util.* ;
import java.text.* ;
import include.nseer_db.*;
import validata.ValidataNumber;

public class bill_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ValidataNumber validata= new ValidataNumber();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String file_id=request.getParameter("file_id");
String cols_value=request.getParameter("cols_value");
String rows_init=request.getParameter("rows_init");
String sql="select type_name from finance_config_public_char where kind='账务初始时间'";
ResultSet rs=finance_db.executeQuery(sql);
	 String account_init_time="";
     if(rs.next()){
		 account_init_time=rs.getString("type_name"); 
	    }
int i=0;
int count=0;
String err_time="";
String temp_value="";
String flag="";
StringTokenizer tk1=new StringTokenizer(cols_value,"□");
while(tk1.hasMoreTokens()){

StringTokenizer tk=new StringTokenizer(tk1.nextToken(),"◇");
String[] value=new String[tk.countTokens()];
	while(tk.hasMoreTokens()){
      temp_value=tk.nextToken();
	  if(i==0){
		  value[i]=temp_value.equals("⊙")?"1800-01-01":temp_value;
	  }
	  if(i==3&&!temp_value.equals("⊙")&&!validata.validata(temp_value)){
		  flag="1";
	  }
	  if(i==4&&!temp_value.equals("⊙")&&!validata.validata(temp_value)){
		  flag="2";
	  }
	  i++;
	  
}
if(count>=Integer.parseInt(rows_init)-1){
if(formatter.parse(value[0]).getTime()<formatter.parse(account_init_time).getTime()) err_time+=(count+1)+",";
}
count++;
i=0;
}
if(!err_time.equals("")){
	err_time=err_time.substring(0,err_time.length()-1);
	out.println(err_time);
}else if(flag.equals("1")){ 
	out.println(flag);
}else if(flag.equals("2")){ 
	out.println(flag);
}else{
tk1=new StringTokenizer(cols_value,"□");
while(tk1.hasMoreTokens()){

StringTokenizer tk=new StringTokenizer(tk1.nextToken(),"◇");
String[] value=new String[tk.countTokens()];
	while(tk.hasMoreTokens()){
      temp_value=tk.nextToken();
	  if(i==0){
		  value[i]=temp_value.equals("⊙")?"1800-01-01":temp_value;
	  }
	  else{
		value[i]=temp_value.equals("⊙")?"":temp_value;
	  }
	  i++;
}
i=0;
String sql2="select id from finance_bill where id='"+value[6]+"'";
ResultSet rs2=finance_db.executeQuery(sql2);
if(rs2.next()){
	sql="update finance_bill set settle_time='"+value[0]+"',way='"+value[1]+"',attachment_id='"+value[2]+"',debit_subtotal='"+value[3]+"',loan_subtotal='"+value[4]+"',file_id='"+file_id+"' where id='"+value[6]+"'";
}else{

sql="insert into finance_bill(settle_time,way,attachment_id,debit_subtotal,loan_subtotal,file_id) values('"+value[0]+"','"+value[1]+"','"+value[2]+"','"+value[3]+"','"+value[4]+"','"+file_id+"')";
}
    finance_db.executeUpdate(sql);
}
out.println("123454321");
}
    finance_db.commit();
    finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}