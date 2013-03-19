/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.procedure;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;

public class register_procedure_details_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
response.setContentType("text/html;charset=UTF-8");
request.setCharacterEncoding("UTF-8");

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID");
String labour_hour_amount=request.getParameter("labour_hour_amount");
String[] product_name=request.getParameterValues("product_name");
String[] amount=request.getParameterValues("amount");
int module_amount=0;
if(product_name!=null) module_amount=product_name.length;
int p=0;
for(int i=0;i<module_amount;i++){
	if(!amount[i].equals("")){
		if(!validata.validata(amount[i])){
			p++;
		}
	}
}
		if(!labour_hour_amount.equals("")&&!validata.validata(labour_hour_amount)){
			p++;
		}
if(p==0){
String procedure_name=request.getParameter("procedure_name");
session.setAttribute("procedure_name",procedure_name);
String procedure_responsible_person=request.getParameter("procedure_responsible_person");
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String real_labour_hour_amount=request.getParameter("real_labour_hour_amount") ;
String details_number1=request.getParameter("details_number1") ;
String[] real_amount=request.getParameterValues("real_module_amount");
String[] extra_amount=request.getParameterValues("extra_amount");
String[] design_amount=request.getParameterValues("design_amount");
String[] details_number=request.getParameterValues("details_number");
String[] product_ID=request.getParameterValues("product_ID");
String[] product_describe=request.getParameterValues("product_describe");
String[] type=request.getParameterValues("type");
String[] amount_unit=request.getParameterValues("amount_unit");
String[] cost_price=request.getParameterValues("cost_price");
if(product_name!=null){
int n=0;
for(int i=0;i<product_name.length;i++){
	if(!amount[i].equals("")){	if(Double.parseDouble(real_amount[i])+Double.parseDouble(amount[i])>Double.parseDouble(design_amount[i])+Double.parseDouble(extra_amount[i])){
		n++;
	}
	}
}
if(n==0){
if(labour_hour_amount.equals("")) labour_hour_amount="0";
try{
String sql8="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
ResultSet rs8=manufacture_db.executeQuery(sql8);
if(rs8.next()){
String sql="insert into manufacture_proceduring(manufacture_ID,procedure_name,procedure_ID,details_number,procedure_describe,amount_unit,cost_price) values('"+rs8.getString("manufacture_ID")+"','"+rs8.getString("procedure_name")+"','"+rs8.getString("procedure_ID")+"','"+rs8.getString("details_number")+"','"+rs8.getString("procedure_describe")+"','"+rs8.getString("amount_unit")+"','"+rs8.getString("cost_price")+"')";
manufacture_db.executeUpdate(sql);
}
double subtotal=0.0d;
double labour_cost_price_sum=0.0d;
String sql1="select * from manufacture_proceduring where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"' order by id desc";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	subtotal=rs1.getDouble("cost_price")*Double.parseDouble(labour_hour_amount);
	double amount1=Double.parseDouble(labour_hour_amount)+Double.parseDouble(real_labour_hour_amount);
	double subtotal1=rs1.getDouble("cost_price")*amount1;
	String sql2="update manufacture_proceduring set labour_hour_amount='"+labour_hour_amount+"',subtotal='"+subtotal+"',register='"+register+"',register_time='"+register_time+"' where id='"+rs1.getString("id")+"'";
	manufacture_db.executeUpdate(sql2);
	String sql3="update manufacture_procedure set procedure_check_tag='1',procedure_finish_tag='1' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql3);
}
	String sql9="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs9=manufacture_db.executeQuery(sql9);
	if(rs9.next()){
		String sql10="update manufacture_manufacture set manufacture_procedure_tag='1',manufacture_procedure_check_tag='1' where manufacture_ID='"+manufacture_ID+"'";
		manufacture_db.executeUpdate(sql10);
	}
double module_cost_price_sum=0.0d;
for(int i=0;i<product_name.length;i++){
	if(!amount[i].equals("")){
	double module_subtotal=Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
	double amount2=Double.parseDouble(real_amount[i])+Double.parseDouble(amount[i]);
	double subtotal2=Double.parseDouble(cost_price[i])*amount2;
	module_cost_price_sum+=subtotal2;
		String sql4="insert into manufacture_procedure_moduling(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,type,amount,amount_unit,cost_price,subtotal,register,register_time) values('"+manufacture_ID+"','"+procedure_name+"','"+details_number[i]+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+type[i]+"','"+amount[i]+"','"+amount_unit[i]+"','"+cost_price[i]+"','"+module_subtotal+"','"+register+"','"+register_time+"')";
		manufacture_db.executeUpdate(sql4);
	}else{
	double subtotal3=Double.parseDouble(cost_price[i])*Double.parseDouble(real_amount[i]);
		module_cost_price_sum+=subtotal3;
		/*String sql11="insert into manufacture_procedure_moduling(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,type,amount,amount_unit,cost_price,subtotal,register,register_time) values('"+manufacture_ID+"','"+procedure_name+"','"+details_number[i]+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+type[i]+"','0','"+amount_unit[i]+"','"+cost_price[i]+"','0','"+register+"','"+register_time+"')";
		manufacture_db.executeUpdate(sql11);*/
	}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("manufacture/procedure/register_procedure_details_ok_a.jsp?manufacture_ID="+manufacture_ID+"&&procedure_name="+procedure_name+"");
	}else{
	response.sendRedirect("manufacture/procedure/register_procedure_details_ok_b.jsp?manufacture_ID="+manufacture_ID+"&&procedure_name="+procedure_name+"");
	}
  }else{
	  if(labour_hour_amount.equals("")) labour_hour_amount="0";
try{
String sql88="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
ResultSet rs88=manufacture_db.executeQuery(sql88);
if(rs88.next()){
String sql="insert into manufacture_proceduring(manufacture_ID,procedure_name,procedure_ID,details_number,procedure_describe,amount_unit,cost_price) values('"+rs88.getString("manufacture_ID")+"','"+rs88.getString("procedure_name")+"','"+rs88.getString("procedure_ID")+"','"+rs88.getString("details_number")+"','"+rs88.getString("procedure_describe")+"','"+rs88.getString("amount_unit")+"','"+rs88.getString("cost_price")+"')";
manufacture_db.executeUpdate(sql);
}
double subtotal=0.0d;
double labour_cost_price_sum=0.0d;
String sql1="select * from manufacture_proceduring where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"' order by id desc";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	subtotal=rs1.getDouble("cost_price")*Double.parseDouble(labour_hour_amount);
	double amount1=Double.parseDouble(labour_hour_amount)+Double.parseDouble(real_labour_hour_amount);
	double subtotal1=rs1.getDouble("cost_price")*amount1;
	String sql2="update manufacture_proceduring set labour_hour_amount='"+labour_hour_amount+"',subtotal='"+subtotal+"',register='"+register+"',register_time='"+register_time+"' where id='"+rs1.getString("id")+"'";
	manufacture_db.executeUpdate(sql2);
	String sql3="update manufacture_procedure set procedure_check_tag='1',procedure_finish_tag='1' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql3);
}
	String sql9="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs9=manufacture_db.executeQuery(sql9);
	if(rs9.next()){
		String sql10="update manufacture_manufacture set manufacture_procedure_tag='1',manufacture_procedure_check_tag='1' where manufacture_ID='"+manufacture_ID+"'";
		manufacture_db.executeUpdate(sql10);
	}
  }
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("manufacture/procedure/register_procedure_details_ok_c.jsp?manufacture_ID="+manufacture_ID+"&&procedure_name="+procedure_name+"");
	}	  
}else{
	
	response.sendRedirect("manufacture/procedure/register_procedure_details_ok_d.jsp?manufacture_ID="+manufacture_ID+"");
	}	
	manufacture_db.commit();
	manufacture_db.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 