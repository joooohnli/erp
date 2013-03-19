/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.purchase;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;
import validata.ValidataTag;

public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ValidataNumber  validata=new  ValidataNumber();
try{
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String purchase_id=request.getParameter("purchase_id");
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
		Double demand_price=Double.parseDouble(demand_price1);
	String sqll = "select demand_price,price_percent,demand_amount,demand_cost_price_sum from purchase_details where purchase_id='"+purchase_id+"' and provider_id='"+provider_id+"'" ;
	ResultSet rs=purchase_db.executeQuery(sqll);
	if(rs.next()){
		Double provider_price=rs.getDouble("demand_price");
		Double price_percent=rs.getDouble("price_percent");
		if(demand_price<=provider_price*price_percent){
		
		Double demand_amount=rs.getDouble("demand_amount");
		Double demand_cost_price_sum=rs.getDouble("demand_cost_price_sum");
		Double price_sum_temp=demand_amount*demand_price;
		sqll = "update purchase_details set demand_price='"+demand_price+"',demand_cost_price_sum='"+price_sum_temp+"',changer='"+changer+"',changer_id='"+changer_id+"',change_time='"+change_time+"',change_tag='1' where purchase_id='"+purchase_id+"' and provider_id='"+provider_id+"'" ;
		purchase_db.executeUpdate(sqll);
		Double post=price_sum_temp-demand_cost_price_sum;
		sqll = "select demand_cost_price_sum,demand_amount from purchase_purchase where purchase_id='"+purchase_id+"'";
		rs=purchase_db.executeQuery(sqll);
		if(rs.next()){
			Double price_sum_main=rs.getDouble("demand_cost_price_sum");
			Double demand_amount_main=rs.getDouble("demand_amount");
			Double price_sum_main_temp=price_sum_main+post;
			Double demand_price_main=price_sum_main_temp/demand_amount_main;
			sqll = "update purchase_purchase set demand_price='"+demand_price_main+"',demand_cost_price_sum='"+price_sum_main_temp+"' where purchase_id='"+purchase_id+"'" ;
			purchase_db.executeUpdate(sqll);
		}
		sqll="update stock_gather set cost_price='"+demand_price+"',cost_price_sum='"+price_sum_temp+"' where reasonexact='"+purchase_id+"' and reasonexact_details='"+provider_name+"'";
		purchase_db.executeUpdate(sqll);
		sqll="select gather_id from stock_gather where reasonexact='"+purchase_id+"' and reasonexact_details='"+provider_name+"'";
		rs=purchase_db.executeQuery(sqll);
		if(rs.next()){
			sqll="update stock_gather_details set cost_price='"+demand_price+"',subtotal='"+price_sum_temp+"' where gather_id='"+rs.getString("gather_id")+"'";
			purchase_db.executeUpdate(sqll);
		}
		sqll="update fund_fund set qcs_dealwith_tag='1',demand_cost_price_sum='"+price_sum_temp+"' where reasonexact='"+purchase_id+"' and funder_id='"+provider_id+"'";
		purchase_db.executeUpdate(sqll);
		response.sendRedirect("purchase/purchase/change_ok.jsp?finished_tag=0");
	}else{
		response.sendRedirect("purchase/purchase/change_ok_b.jsp?purchase_id="+purchase_id+"&provider_id="+provider_id);
	}
	}

}else{
	response.sendRedirect("purchase/purchase/change_ok_a.jsp?purchase_id="+purchase_id+"&provider_id="+provider_id);
}	
}catch(Exception ex){	
	ex.printStackTrace();
	response.sendRedirect("purchase/purchase/change_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("purchase/purchase/change_ok.jsp?finished_tag=2");
}

purchase_db.commit();
purchase_db.close();
}catch (Exception ex){
ex.printStackTrace();
}
}
} 