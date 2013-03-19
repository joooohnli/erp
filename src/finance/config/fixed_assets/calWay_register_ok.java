/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.config.fixed_assets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;
import include.nseer_db.nseer_db_backup1;

public class calWay_register_ok extends HttpServlet{

ServletContext application;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
HttpSession session=request.getSession();

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ResultSet rs=null;
String sql="";
String name=request.getParameter("name");
if(name.equals("")){
	out.println('1');
}else{
String rate_formula=request.getParameter("rate_formula").replace("⊙", "+");
String formula=request.getParameter("formula").replace("⊙", "+");
String tag=request.getParameter("tag");
String id=request.getParameter("id");

if(tag.equals("0")){
	sql = "select name from finance_config_calway where name='"+name+"'";
	rs=finance_db.executeQuery(sql);
	    if(rs.next()){
	    	out.println("1");
	    }else{
	    	 sql = "insert into finance_config_calway(name,rate_formula,formula) values('"+name+"','"+rate_formula+"','"+formula+"')" ;
	    	finance_db.executeUpdate(sql);
	    	out.println("0");
	    }
	}else{
		sql = "select name from finance_config_calway where name='"+name+"' and id!="+id;
		rs=finance_db.executeQuery(sql);
		    if(rs.next()){
		    	out.println("1");
		    }else{
		sql = "update finance_config_calway set name='"+name+"',rate_formula='"+rate_formula+"',formula='"+formula+"' where id="+id;
		finance_db.executeUpdate(sql);
		out.println("2");
		    }
	}
	    finance_db.commit();
		finance_db.close();
	}
	}else{
		response.sendRedirect("error_conn.htm");
	}
	}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	}
