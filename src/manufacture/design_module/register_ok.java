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
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.Iterator;
import java.util.List;

import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.counter;

public class register_ok extends HttpServlet{

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
String sql="";
	String sql0="select * from design_module where product_ID='"+product_ID+"' and check_tag='1'";
	ResultSet rs0=design_db.executeQuery(sql0);
	if(rs0.next()){
		module_design_ID=rs0.getString("design_ID");
	}
	String sqll="select * from manufacture_design_procedure_details where design_ID='"+design_ID+"' and design_module_tag='0'";
	ResultSet rs1=manufacture_db.executeQuery(sqll);
	String sql2="select * from design_module_details where design_ID='"+module_design_ID+"' and design_balance_amount!='0'";
	ResultSet rs2=design_db.executeQuery(sql2);
	if(rs1.next()){
	response.sendRedirect("manufacture/design_module/register_ok_a.jsp?design_ID="+design_ID+"");
}else if(rs2.next()){
	response.sendRedirect("manufacture/design_module/register_ok_b.jsp?design_ID="+design_ID+"");
}else{
	String sql3="select * from design_module where design_ID='"+module_design_ID+"' and check_tag='1'";
	ResultSet rs3=design_db.executeQuery(sql3);
	if(rs3.next()){
String sql4="update manufacture_design_procedure set design_module_tag='1',module_cost_price_sum='"+rs3.getString("cost_price_sum")+"' where design_ID='"+design_ID+"'";
manufacture_db.executeUpdate(sql4) ;
}
	List rsList = GetWorkflow.getList(manufacture_db, "manufacture_config_workflow", "02");
    String[] elem=new String[3];
	if(rsList.size()==0){
		 sql = "update manufacture_design_procedure set design_module_tag='2',design_module_change_tag='0' where design_ID='"+design_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
		sql="update manufacture_design_procedure_details set design_module_tag='1' where design_ID='"+design_ID+"'";
	manufacture_db.executeUpdate(sql) ;	 
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"','02')" ;
		manufacture_db.executeUpdate(sql) ;
		}
	}
response.sendRedirect("manufacture/design_module/register_ok_c.jsp");
}
  design_db.commit();
  manufacture_db.commit();
  manufacture_db.close();
  design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 