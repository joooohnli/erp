/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.intrmanufacture;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;
public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ValidataNumber  validata=new  ValidataNumber();
try{
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String intrmanufacture_id=request.getParameter("intrmanufacture_id");
String provider_id=request.getParameter("provider_id");
String provider_name=request.getParameter("provider_name");
String demand_price1=request.getParameter("demand_price");
String changer=request.getParameter("changer");
String changer_id=request.getParameter("changer_id");
String change_time=request.getParameter("change_time");
try{
int p=0;
if(!validata.validata(demand_price1)){
	p++;
}
if(p==0){
	double demand_price=Double.parseDouble(demand_price1);
	String sqll = "select demand_price,price_percent,demand_amount,demand_cost_price_sum from intrmanufacture_details where intrmanufacture_id='"+intrmanufacture_id+"' and provider_id='"+provider_id+"'" ;
	ResultSet rs=intrmanufacture_db.executeQuery(sqll);
	if(rs.next()){
		Double provider_price=rs.getDouble("demand_price");
		Double price_percent=rs.getDouble("price_percent");
		if(demand_price<=provider_price*price_percent){
			
		double demand_amount=rs.getDouble("demand_amount");
		double demand_cost_price_sum=rs.getDouble("demand_cost_price_sum");
		double price_sum_temp=demand_amount*demand_price;
		sqll = "update intrmanufacture_details set demand_price='"+demand_price+"',demand_cost_price_sum='"+price_sum_temp+"',changer='"+changer+"',changer_id='"+changer_id+"',change_time='"+change_time+"',change_tag='1' where intrmanufacture_id='"+intrmanufacture_id+"' and provider_id='"+provider_id+"'" ;
		intrmanufacture_db.executeUpdate(sqll);
		double post=price_sum_temp-demand_cost_price_sum;
		sqll = "select demand_cost_price_sum,demand_amount from intrmanufacture_intrmanufacture where intrmanufacture_id='"+intrmanufacture_id+"'";
		rs=intrmanufacture_db.executeQuery(sqll);
		if(rs.next()){
			double price_sum_main=rs.getDouble("demand_cost_price_sum");
			double demand_amount_main=rs.getDouble("demand_amount");
			double price_sum_main_temp=price_sum_main+post;
			double demand_price_main=price_sum_main_temp/demand_amount_main;
			sqll = "update intrmanufacture_intrmanufacture set demand_price='"+demand_price_main+"',demand_cost_price_sum='"+price_sum_main_temp+"' where intrmanufacture_id='"+intrmanufacture_id+"'" ;
			intrmanufacture_db.executeUpdate(sqll);
		}
		sqll="update stock_gather set cost_price='"+demand_price+"',cost_price_sum='"+price_sum_temp+"' where reasonexact='"+intrmanufacture_id+"' and reasonexact_details='"+provider_name+"'";
		intrmanufacture_db.executeUpdate(sqll);
		sqll="select gather_id from stock_gather where reasonexact='"+intrmanufacture_id+"' and reasonexact_details='"+provider_name+"'";
		rs=intrmanufacture_db.executeQuery(sqll);
		if(rs.next()){
			sqll="update stock_gather_details set cost_price='"+demand_price+"',subtotal='"+price_sum_temp+"' where gather_id='"+rs.getString("gather_id")+"'";
			intrmanufacture_db.executeUpdate(sqll);
		}
		sqll="update fund_fund set qcs_dealwith_tag='1',demand_cost_price_sum='"+price_sum_temp+"' where reasonexact='"+intrmanufacture_id+"' and funder_id='"+provider_id+"'";
		intrmanufacture_db.executeUpdate(sqll);
		
		response.sendRedirect("intrmanufacture/intrmanufacture/change_ok.jsp?finished_tag=0");
		}else{
			response.sendRedirect("intrmanufacture/intrmanufacture/change_ok_b.jsp?intrmanufacture_id="+intrmanufacture_id+"&provider_id="+provider_id);
		}
	}

}else{
	response.sendRedirect("intrmanufacture/intrmanufacture/change_ok_a.jsp?intrmanufacture_id="+intrmanufacture_id+"&provider_id="+provider_id);
}	
}catch(Exception ex){	
	ex.printStackTrace();
	response.sendRedirect("intrmanufacture/intrmanufacture/change_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("intrmanufacture/intrmanufacture/change_ok.jsp?finished_tag=2");
}

intrmanufacture_db.commit();
intrmanufacture_db.close();
}catch (Exception ex){
ex.printStackTrace();
}
}
} 