/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.purchase;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import java.util.*;

import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class dealwith_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
counter count=new counter(dbApplication);
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);

if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
try{
String qcs_id = request.getParameter("qcs_id");
String dealwith_tag = request.getParameter("dealwith_tag");
String apply_id = request.getParameter("apply_id");
String qualified_amount = request.getParameter("qualified");
String unqualified_amount = request.getParameter("unqualified");
String qcs_amount = request.getParameter("qcs_amount");

String sql="";
sql="select id from qcs_purchase where qcs_id='"+qcs_id+"' and dealwith_tag='0'";
ResultSet rs=qcs_db.executeQuery(sql);
if(rs.next()){
sql="select purchase_id,provider_id,provider_name from qcs_apply where apply_id='"+apply_id+"'";
rs=qcs_db.executeQuery(sql);
if(rs.next()){
	String purchase_id=rs.getString("purchase_id");
	String provider_id=rs.getString("provider_id");	
	String provider_name=rs.getString("provider_name");	
	sql="update qcs_purchase set dealwith_tag='"+dealwith_tag+"' where qcs_id='"+qcs_id+"'";
	qcs_db.executeUpdate(sql);
	sql="update stock_gather set qcs_dealwith_tag='"+dealwith_tag+"' where reasonexact='"+purchase_id+"' and reasonexact_details='"+provider_name+"'";
	qcs_db.executeUpdate(sql);
	switch(Integer.parseInt(dealwith_tag)){
		case 1:
			{	
				sql="update fund_fund set qcs_dealwith_tag='"+dealwith_tag+"' where reasonexact='"+purchase_id+"' and funder_id='"+provider_id+"'";
				qcs_db.executeUpdate(sql);
				sql="update purchase_details set qcs_dealwith_tag='"+dealwith_tag+"' where purchase_id='"+purchase_id+"' and provider_id='"+provider_id+"'";
				qcs_db.executeUpdate(sql);
				break;
			}
		case 2:
		{
			String price_percent = request.getParameter("price_percent");
			sql="update purchase_details set qcs_dealwith_tag='"+dealwith_tag+"',price_percent='"+price_percent+"' where purchase_id='"+purchase_id+"' and provider_id='"+provider_id+"'";
			qcs_db.executeUpdate(sql);
			break;
		}
		case 3:
		{	
			double executing_cost_price_sum=0.0d;
			sql="select demand_cost_price_sum from fund_fund where reasonexact='"+purchase_id+"' and funder_id='"+provider_id+"'";
			rs=qcs_db.executeQuery(sql);
			if(rs.next()){
				executing_cost_price_sum=rs.getDouble("demand_cost_price_sum")*Double.parseDouble(qualified_amount)/Double.parseDouble(qcs_amount);
			}
			sql="select qualified_amount from stock_gather where reasonexact='"+purchase_id+"' and reasonexact_details='"+provider_name+"'";
			rs=qcs_db.executeQuery(sql);
			if(rs.next()){
			Double qualified_amount_temp=Double.parseDouble(qualified_amount)+rs.getDouble("qualified_amount");
			sql="update stock_gather set qualified_amount='"+qualified_amount_temp+"' where reasonexact='"+purchase_id+"' and reasonexact_details='"+provider_name+"'";
			qcs_db.executeUpdate(sql);
			unqualified_amount=unqualified_amount.equals("0")?"":unqualified_amount;
			sql="update qcs_apply_details set qcs_tag='0',demand_amount='"+unqualified_amount+"',limit_tag='1' where apply_id='"+apply_id+"'";
			qcs_db.executeUpdate(sql);//回写
			if(unqualified_amount.equals("")){
				sql="update fund_fund set qcs_dealwith_tag='1',executing_cost_price_sum='"+executing_cost_price_sum+"' where reasonexact='"+purchase_id+"' and funder_id='"+provider_id+"'";
				qcs_db.executeUpdate(sql);
				sql="update purchase_details set qcs_dealwith_tag='"+dealwith_tag+"' where purchase_id='"+purchase_id+"' and provider_id='"+provider_id+"'";
				qcs_db.executeUpdate(sql);
			}
			}
			break;
		}
		case 4:
		{
			sql="update qcs_apply_details set qcs_tag='0' where apply_id='"+apply_id+"'";
			qcs_db.executeUpdate(sql);
			break;
		}
	}
	sql="select id from purchase_details where purchase_id='"+purchase_id+"' and qcs_dealwith_tag='0'";
	rs=qcs_db.executeQuery(sql);
	if(!rs.next()){
		sql="update purchase_purchase set gather_tag='3' where purchase_id='"+purchase_id+"'";
		qcs_db.executeUpdate(sql);
	}
}

response.sendRedirect("qcs/purchase/dealwith_ok.jsp?finished_tag=0");
}else{
	response.sendRedirect("qcs/purchase/dealwith_ok.jsp?finished_tag=2");
}
qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
	response.sendRedirect("qcs/purchase/dealwith_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
