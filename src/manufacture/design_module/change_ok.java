/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.design_module;
 
 
import include.nseer_cookie.*;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String design_ID=request.getParameter("design_ID") ;
String product_ID=request.getParameter("product_ID") ;
String module_design_ID="";
	String sql0="select * from design_module where product_ID='"+product_ID+"' and check_tag='1'";
	ResultSet rs0=design_db.executeQuery(sql0);
	if(rs0.next()){
		module_design_ID=rs0.getString("design_ID");
	}
	String sql1="select * from design_module_details where design_ID='"+module_design_ID+"' and design_balance_amount!='0'";
	ResultSet rs2=design_db.executeQuery(sql1);
	if(rs2.next()){
	
	response.sendRedirect("manufacture/design_module/change_ok_a.jsp?design_ID="+design_ID+"");
}else{
	
List rsList = GetWorkflow.getList(manufacture_db, "manufacture_config_workflow", "02");
	String[] elem=new String[3];
	String sql2="";
	if(rsList.size()==0){
		sql2="update manufacture_design_procedure set design_module_tag='2',design_module_change_tag='0' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2) ;
		sql2="update manufacture_design_procedure_details set design_module_tag='1' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2) ;
	}else{
		sql2="delete from manufacture_workflow where object_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2) ;
		sql2="update manufacture_design_procedure set design_module_tag='1',design_module_change_tag='1' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2);
		sql2="update manufacture_design_procedure_details set design_module_change_tag='0' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2);
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql2 = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"','02')" ;
			manufacture_db.executeUpdate(sql2) ;
		}
	}
	response.sendRedirect("manufacture/design_module/change_ok_b.jsp");
}
  design_db.commit();
  manufacture_db.commit();
  design_db.close();
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