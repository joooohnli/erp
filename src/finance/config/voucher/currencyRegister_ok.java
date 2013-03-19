/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.config.voucher;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class currencyRegister_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
try{
if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String currency_id=request.getParameter("currency_id");
String currency_name=request.getParameter("currency_name");
String currency_mark=request.getParameter("currency_mark");
String conversion_way=request.getParameter("conversion_way");
String way_tag=request.getParameter("way_tag");
String currency_decimal=request.getParameter("currency_decimal");
String currency_time=request.getParameter("currency_time");
String tag=request.getParameter("tag");

String sql="";
ResultSet rs=null;

	if(tag.equals("1")){
		sql="update finance_config_currency set currency_mark='"+currency_mark+"',currency_rate='"+conversion_way+"',way_tag='"+way_tag+"',currency_decimal='"+currency_decimal+"',currency_time='"+currency_time+"' where currency_id='"+currency_id+"'";
		finance_db.executeUpdate(sql);
		out.println("2");
	}else{
		sql="select currency_id,currency_name from finance_config_currency where currency_id='"+currency_id+"' or currency_name='"+currency_name+"'";
		rs=finance_db.executeQuery(sql);
		if(rs.next()){
			out.println("1");
		}else{
			sql = "insert into finance_config_currency(currency_id,currency_name,currency_mark,currency_rate,way_tag,currency_decimal,currency_time) values('"+currency_id+"','"+currency_name+"','"+currency_mark+"','"+conversion_way+"','"+way_tag+"','"+currency_decimal+"','"+currency_time+"')";
			finance_db.executeUpdate(sql);

			out.println("0");
		}
	}
finance_db.commit();
finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}