/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.config.cost_calculate;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class costCalculate_change_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String cost_calculate_type=request.getParameter("cost_calculate_type");
try{
	if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

	String sql2="update design_file set cost_calculate_type='"+cost_calculate_type+"' where product_ID='"+product_ID+"'";
	design_db.executeUpdate(sql2);
	if(cost_calculate_type.equals("移动加权平均")){
		String sqlc2="select * from stock_balance where product_ID='"+product_ID+"'";
		ResultSet rsc2=stock_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID+"'";
			design_db.executeUpdate(sqlc3);
		}
	}else if(cost_calculate_type.equals("计划价格")){
		String sqlc2="select * from design_file where product_ID='"+product_ID+"'";
		ResultSet rsc2=design_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID+"'";
			design_db.executeUpdate(sqlc3);
		}
	}else if(cost_calculate_type.equals("先进先出")){
		String sqlc2="select * from stock_balance_details_details where product_ID='"+product_ID+"' order by register_time";
		ResultSet rsc2=stock_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID+"'";
			design_db.executeUpdate(sqlc3);
		}
	}else if(cost_calculate_type.equals("后进先出")){
		String sqlc2="select * from stock_balance_details_details where product_ID='"+product_ID+"' order by register_time desc";
		ResultSet rsc2=stock_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID+"'";
			design_db.executeUpdate(sqlc3);
		}
	}
	design_db.commit();
    stock_db.commit();
	design_db.close();
    stock_db.close();
	}
	else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception e){}

response.sendRedirect("design/config/cost_calculate/costCalculate_change_ok_a.jsp");


}
}