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
import include.nseer_db.*;
import java.text.* ;
import validata.ValidataNumber;

public class registerInit_ok1 extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata= new ValidataNumber();
try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String account_init_time=request.getParameter("account_init_time");
String file_id=request.getParameter("file_id");
String cols_value=request.getParameter("cols_value");
int i=0;
int count=0;
String temp_value="";
String err_time="";
String err_time1="";
String flag="";
StringTokenizer tk1=new StringTokenizer(cols_value,"□");
while(tk1.hasMoreTokens()){

StringTokenizer tk=new StringTokenizer(tk1.nextToken(),"◇");
String[] value=new String[tk.countTokens()];//
while(tk.hasMoreTokens()){
      temp_value=tk.nextToken();
	  if(i==0|| i==7){
		  value[i]=temp_value.equals("⊙")?"1800-01-01":temp_value;
	  }
	  if(i==5&&!temp_value.equals("⊙")&&!validata.validata(temp_value)){
		  flag="1";

	  }
	  if(i==6&&!temp_value.equals("⊙")&&!validata.validata(temp_value)){
		  flag="2";
	  }
	  i++;
	}
	if(formatter.parse(value[0]).getTime()>=formatter.parse(account_init_time).getTime()) err_time+=(count+1)+",";
	if(formatter.parse(value[0]).getTime()<formatter.parse(value[7]).getTime()) err_time1+=(count+1)+",";
count++;
i=0;	  
}
if(!err_time.equals("")||!err_time1.equals("")){
	err_time=err_time.equals("")?"□□":err_time;
	err_time1=err_time1.equals("")?"□□":err_time1;
	err_time=err_time.substring(0,err_time.length()-1)+"◇"+err_time1.substring(0,err_time1.length()-1);
	out.println(err_time);
}else if(flag.equals("1")){ 
	out.println(flag);
}else if(flag.equals("2")){ 
	out.println(flag);
}else{
tk1=new StringTokenizer(cols_value,"□");
while(tk1.hasMoreTokens()){

StringTokenizer tk=new StringTokenizer(tk1.nextToken(),"◇");
String[] value=new String[tk.countTokens()];//
	while(tk.hasMoreTokens()){
      temp_value=tk.nextToken();
	  if(i==0|| i==7){
		  value[i]=temp_value.equals("⊙")?"1800-01-01":temp_value;
	  }
	  else{
		value[i]=temp_value.equals("⊙")?"":temp_value;
	  }
	  i++;
}
i=0;
String sql2="select id from finance_voucher where id='"+value[9]+"'";
ResultSet rs2=finance_db.executeQuery(sql2);
String sql="";
if(rs2.next()){
	sql="update finance_voucher set register_time='"+value[0]+"',voucher_type='"+value[1]+"',voucher_in_month_id='"+value[2]+"',settle_way='"+value[3]+"',attachment_id='"+value[4]+"',debit_subtotal='"+value[5]+"',loan_subtotal='"+value[6]+"',attachment_time='"+value[7]+"',summary='"+value[8]+"',chain_id='"+file_id+"' where id='"+value[9]+"'";
}else{

sql="insert into finance_voucher(register_time,voucher_type,voucher_in_month_id,settle_way,attachment_id,debit_subtotal,loan_subtotal,attachment_time,summary,chain_id,account_period) values('"+value[0]+"','"+value[1]+"','"+value[2]+"','"+value[3]+"','"+value[4]+"','"+value[5]+"','"+value[6]+"','"+value[7]+"','"+value[8]+"','"+file_id+"','19')";
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