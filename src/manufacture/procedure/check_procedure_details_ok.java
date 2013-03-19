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

public class check_procedure_details_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID");
String procedure_name=request.getParameter("procedure_name");
String details_number1=request.getParameter("details_number1");

String labour_hour_amount=request.getParameter("labour_hour_amount");
if(labour_hour_amount.equals("")) labour_hour_amount="0";
String[] product_name=request.getParameterValues("product_name");
String[] amount=request.getParameterValues("amount");
int p=0;
int module_amount=0;
if(product_name!=null) module_amount=product_name.length;
for(int i=0;i<module_amount;i++){
	if(!amount[i].equals("")){
		if(!validata.validata(amount[i])){
			p++;
		}
	}
}
		if(!validata.validata(labour_hour_amount)){
			p++;
		}
String sql88="select * from manufacture_proceduring where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and check_tag='0' and details_number='"+details_number1+"'";
ResultSet rs88=manufacture_db.executeQuery(sql88);
if(rs88.next()){
if(p==0){
String procedure_responsible_person=request.getParameter("procedure_responsible_person");
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String real_labour_hour_amount=request.getParameter("real_labour_hour_amount") ;
String[] real_amount=request.getParameterValues("real_module_amount");
String[] extra_amount=request.getParameterValues("extra_amount");
String[] design_amount=request.getParameterValues("design_amount");
String[] details_number=request.getParameterValues("details_number");
String[] product_ID=request.getParameterValues("product_ID");
String[] product_describe=request.getParameterValues("product_describe");
String[] type=request.getParameterValues("type");
String[] amount_unit=request.getParameterValues("amount_unit");
String[] cost_price=request.getParameterValues("cost_price");
if(product_name!=null){//有物料的情况
int n=0;
for(int i=0;i<product_name.length;i++){
	if(!amount[i].equals("")){	if(Double.parseDouble(real_amount[i])+Double.parseDouble(amount[i])>Double.parseDouble(design_amount[i])+Double.parseDouble(extra_amount[i])){
		n++;
	}
	}
}
if(n==0){
try{
double subtotal=0.0d;
double labour_cost_price_sum=0.0d;
String sql1="select * from manufacture_proceduring where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and check_tag='0' and details_number='"+details_number1+"'";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	subtotal=rs1.getDouble("cost_price")*Double.parseDouble(labour_hour_amount);
	double amount1=Double.parseDouble(labour_hour_amount)+Double.parseDouble(real_labour_hour_amount);
	double subtotal1=rs1.getDouble("cost_price")*amount1;
	String sql2="update manufacture_proceduring set labour_hour_amount='"+labour_hour_amount+"',subtotal='"+subtotal+"',procedure_responsible_person='"+procedure_responsible_person+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='1' where id='"+rs1.getString("id")+"'";
	manufacture_db.executeUpdate(sql2);
	String sql3="update manufacture_procedure set real_labour_hour_amount='"+amount1+"',real_subtotal='"+subtotal1+"',procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql3);
}
	String sql9="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs9=manufacture_db.executeQuery(sql9);
	if(rs9.next()){
		labour_cost_price_sum=subtotal+rs9.getDouble("real_labour_cost_price_sum");
		String sql10="update manufacture_manufacture set real_labour_cost_price_sum='"+labour_cost_price_sum+"' where manufacture_ID='"+manufacture_ID+"'";
		manufacture_db.executeUpdate(sql10);
	}


double module_cost_price_sum=0.0d;
double module_cost_price_sum1=0.0d;
for(int i=0;i<product_name.length;i++){
	if(!amount[i].equals("")){
	double module_subtotal=Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
	double amount2=Double.parseDouble(real_amount[i])+Double.parseDouble(amount[i]);
	double subtotal2=Double.parseDouble(cost_price[i])*amount2;
	module_cost_price_sum+=subtotal2;
	module_cost_price_sum1+=module_subtotal;
		String sql4="update manufacture_procedure_moduling set amount='"+amount[i]+"',subtotal='"+module_subtotal+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='1' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and product_ID='"+product_ID[i]+"' and check_tag='0'";
		manufacture_db.executeUpdate(sql4);
		String sql5="update manufacture_procedure_module set real_amount='"+amount2+"',real_subtotal='"+subtotal2+"' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and product_ID='"+product_ID[i]+"'";
		manufacture_db.executeUpdate(sql5);
       
	}else{
		double subtotal3=Double.parseDouble(cost_price[i])*Double.parseDouble(real_amount[i]);
		module_cost_price_sum+=subtotal3;
	}

	String sql6="update manufacture_procedure set real_module_subtotal='"+module_cost_price_sum+"' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql6);
}
manufacture_db.commit();
	String sql7="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs7=manufacture_db.executeQuery(sql7);
	if(rs7.next()){
		double real_module_cost_price_sum=rs7.getDouble("real_module_cost_price_sum")+module_cost_price_sum1;
		String sql8="update manufacture_manufacture set real_module_cost_price_sum='"+real_module_cost_price_sum+"' where manufacture_ID='"+manufacture_ID+"'";
		manufacture_db.executeUpdate(sql8);
	}
String sql14="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and procedure_transfer_tag='1' and details_number='"+details_number1+"'";
	ResultSet rs14=manufacture_db.executeQuery(sql14);
	if(rs14.next()){
		String sql17="update manufacture_procedure set procedure_transfer_tag='2',procedure_details_tag='2' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql17);
int m=0;
double balance_module_cost_price_sum=0.0d;
String sql55="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"'";
ResultSet rs55=manufacture_db1.executeQuery(sql55);
while(rs55.next()){
	double balance_amount=rs55.getDouble("real_amount")-rs55.getDouble("amount")-rs55.getDouble("extra_amount");
	if(balance_amount!=0){
		double balance_subtotal=rs55.getDouble("cost_price")*balance_amount;
		balance_module_cost_price_sum+=balance_subtotal;
		m++;
		String sql66 = "insert into manufacture_module_balance_details(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,amount,cost_price,amount_unit,subtotal,register_time) values ('"+manufacture_ID+"','"+procedure_name+"','"+m+"','"+rs55.getString("product_ID")+"','"+rs55.getString("product_name")+"','"+rs55.getString("product_describe")+"','"+balance_amount+"','"+rs55.getString("cost_price")+"','"+rs55.getString("amount_unit")+"','"+balance_subtotal+"','"+check_time+"')" ;
		manufacture_db.executeUpdate(sql66) ;
	}
}
if(m!=0){
	String sql77="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs77=manufacture_db.executeQuery(sql77) ;
	if(rs77.next()){
	String sql78 = "insert into manufacture_module_balance(manufacture_ID,product_ID,product_name,procedure_name,procedure_responsible_person,reason,register_time,register,check_tag,excel_tag,module_cost_price_sum) values ('"+manufacture_ID+"','"+rs77.getString("product_ID")+"','"+rs77.getString("product_name")+"','"+procedure_name+"','"+procedure_responsible_person+"','物料退回','"+check_time+"','"+checker+"','0','2','"+balance_module_cost_price_sum+"')" ;
	manufacture_db.executeUpdate(sql78) ;
	}
}


	String sql98="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and (procedure_check_tag='1' or  procedure_transfer_tag='3') and procedure_finish_tag!='2' and details_number='"+details_number1+"'";
	ResultSet rs98=manufacture_db.executeQuery(sql98);
	if(rs98.next()){
		
		response.sendRedirect("manufacture/procedure/check.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	String sql99="update manufacture_manufacture set manufacture_procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql99);

	response.sendRedirect("manufacture/procedure/check_list.jsp");
	}

	}else{
	String sql13="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and (procedure_check_tag='1' or  procedure_transfer_tag='3') and procedure_finish_tag!='2' and details_number='"+details_number1+"'";
	ResultSet rs13=manufacture_db.executeQuery(sql13);
	if(rs13.next()){

		response.sendRedirect("manufacture/procedure/check.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	String sql16="update manufacture_manufacture set manufacture_procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql16);

	response.sendRedirect("manufacture/procedure/check_list.jsp");
	}
}	
}
catch (Exception ex){
ex.printStackTrace();
}

}else{

response.sendRedirect("manufacture/procedure/check_procedure_details_ok_c.jsp?manufacture_ID="+manufacture_ID+"&&procedure_name="+procedure_name+"");
}
}else{
try{
double subtotal=0.0d;
double labour_cost_price_sum=0.0d;
String sql1="select * from manufacture_proceduring where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and check_tag='0' and details_number='"+details_number1+"'";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	subtotal=rs1.getDouble("cost_price")*Double.parseDouble(labour_hour_amount);
	double amount1=Double.parseDouble(labour_hour_amount)+Double.parseDouble(real_labour_hour_amount);
	double subtotal1=rs1.getDouble("cost_price")*amount1;
	String sql2="update manufacture_proceduring set labour_hour_amount='"+labour_hour_amount+"',subtotal='"+subtotal+"',procedure_responsible_person='"+procedure_responsible_person+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='1' where id='"+rs1.getString("id")+"'";
	manufacture_db.executeUpdate(sql2);
	String sql3="update manufacture_procedure set real_labour_hour_amount='"+amount1+"',real_subtotal='"+subtotal1+"',procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql3);
}
	String sql9="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs9=manufacture_db.executeQuery(sql9);
	if(rs9.next()){
		labour_cost_price_sum=subtotal+rs9.getDouble("real_labour_cost_price_sum");
		String sql10="update manufacture_manufacture set real_labour_cost_price_sum='"+labour_cost_price_sum+"' where manufacture_ID='"+manufacture_ID+"'";
		manufacture_db.executeUpdate(sql10);
	}
String sql14="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and procedure_transfer_tag='1' and details_number='"+details_number1+"'";
	ResultSet rs14=manufacture_db.executeQuery(sql14);
	if(rs14.next()){
		String sql17="update manufacture_procedure set procedure_transfer_tag='2',procedure_details_tag='2' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql17);
	String sql98="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and (procedure_check_tag='1' or  procedure_transfer_tag='3') and procedure_finish_tag!='2' and details_number='"+details_number1+"'";
	ResultSet rs98=manufacture_db.executeQuery(sql98);
	if(rs98.next()){	
		response.sendRedirect("manufacture/procedure/check.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	String sql99="update manufacture_manufacture set manufacture_procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql99);

	response.sendRedirect("manufacture/procedure/check_list.jsp");
	}
}else{
	String sql13="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and (procedure_check_tag='1' or  procedure_transfer_tag='3') and procedure_finish_tag!='2' and details_number='"+details_number1+"'";
	ResultSet rs13=manufacture_db.executeQuery(sql13);
	if(rs13.next()){

		response.sendRedirect("manufacture/procedure/check.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	String sql16="update manufacture_manufacture set manufacture_procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql16);

	response.sendRedirect("manufacture/procedure/check_list.jsp");
	}
}
}
catch (Exception ex){
ex.printStackTrace();
}
  
  }
}else{
	
response.sendRedirect("manufacture/procedure/check_procedure_details_ok_e.jsp?manufacture_ID="+manufacture_ID+"");
}
}else{

response.sendRedirect("manufacture/procedure/check_procedure_details_ok_f.jsp?manufacture_ID="+manufacture_ID+"");
	}
	manufacture_db.commit();
	manufacture_db1.commit();
	manufacture_db.close();
manufacture_db1.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 