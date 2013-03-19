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
import java.text.*;
import validata.ValidataNumber;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;

public class check_procedure_transfer_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);

try{
String timea="";
java.util.Date now1 = new java.util.Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
timea=formatter1.format(now1);

if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String register=(String)session.getAttribute("realeditorc");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String manufacture_ID=request.getParameter("manufacture_ID");
String procedure_ID=request.getParameter("procedure_ID");
String details_number1=request.getParameter("details_number");
String sql88="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_ID='"+procedure_ID+"' and procedure_finish_tag!='2' and details_number='"+details_number1+"'";
ResultSet rs88=manufacture_db.executeQuery(sql88);
if(rs88.next()){
String real_amount=request.getParameter("real_amount");
if(validata.validata(real_amount)&&Double.parseDouble(real_amount)>0){
String sql3="update manufacture_procedure set procedure_transfer_tag='4',procedure_finish_tag='2',real_amount='"+real_amount+"' where manufacture_ID='"+manufacture_ID+"' and procedure_ID='"+procedure_ID+"' and details_number='"+details_number1+"'";
	manufacture_db.executeUpdate(sql3);

try{
	
	String sql2="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_ID='"+procedure_ID+"' and details_number='"+details_number1+"'";
	ResultSet rs2=manufacture_db.executeQuery(sql2);
	if(rs2.next()){
		int details_number=rs2.getInt("details_number")+1;
		String sql4="update manufacture_procedure set demand_amount='"+real_amount+"' where manufacture_ID='"+manufacture_ID+"' and details_number='"+details_number+"'";
	manufacture_db.executeUpdate(sql4);
	}

String sql5="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_finish_tag!='2'";
	ResultSet rs5=manufacture_db.executeQuery(sql5);
		if(!rs5.next()){
			String sql6="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' order by details_number desc";
			ResultSet rs6=manufacture_db.executeQuery(sql6);
			if(rs6.next()){
				String sql1="update manufacture_manufacture set manufacture_procedure_tag='2',manufacture_tag='1',tested_amount='"+rs6.getString("real_amount")+"' where manufacture_ID='"+manufacture_ID+"'";
				manufacture_db.executeUpdate(sql1);
			}

String sql7="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
			ResultSet rs7=manufacture_db.executeQuery(sql7);
			if(rs7.next()){  
String gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));
				double cost_price_sum=rs7.getDouble("real_module_cost_price_sum")+rs7.getDouble("real_labour_cost_price_sum");
				double cost_price=cost_price_sum/rs7.getDouble("tested_amount");
String sql8="insert into stock_gather(gather_ID,reason,reasonexact,demand_amount,cost_price,cost_price_sum,register,register_time) values('"+gather_ID+"','生产入库','"+manufacture_ID+"','"+rs7.getString("tested_amount")+"','"+cost_price+"','"+cost_price_sum+"','"+register+"','"+time+"')";
		stock_db.executeUpdate(sql8) ;
		String sql9="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,product_describe,amount,ungather_amount,cost_price,subtotal) values('"+gather_ID+"','1','"+rs7.getString("product_ID")+"','"+rs7.getString("product_name")+"','"+rs7.getString("product_describe")+"','"+rs7.getString("tested_amount")+"','"+rs7.getString("tested_amount")+"','"+cost_price+"','"+cost_price_sum+"')";
		stock_db.executeUpdate(sql9) ;
			}
		
		String sql98="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and (procedure_check_tag='1' or  procedure_transfer_tag='3') and procedure_finish_tag!='2'";
	ResultSet rs98=manufacture_db.executeQuery(sql98);
	if(rs98.next()){
		
		response.sendRedirect("manufacture/procedure/check.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	String sql99="update manufacture_manufacture set manufacture_procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql99);
	
	response.sendRedirect("manufacture/procedure/check_list.jsp");
	}
	}else{
	
	String sql98="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and (procedure_check_tag='1' or  procedure_transfer_tag='3') and procedure_finish_tag!='2'";
	ResultSet rs98=manufacture_db.executeQuery(sql98);
	if(rs98.next()){
		
		response.sendRedirect("manufacture/procedure/check.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	String sql99="update manufacture_manufacture set manufacture_procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql99);
	
	response.sendRedirect("manufacture/procedure/check_list.jsp");
	}
}
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
response.sendRedirect("manufacture/procedure/check_procedure_transfer_ok_c.jsp?manufacture_ID="+manufacture_ID+"&&procedure_ID="+procedure_ID+"");
}
}else{


response.sendRedirect("manufacture/procedure/check_procedure_transfer_ok_d.jsp?manufacture_ID="+manufacture_ID+"");
	}
	manufacture_db.commit();
	stock_db.commit();
	stock_db.close();
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