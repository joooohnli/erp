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
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;

public class register_procedure_transfer_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID");
String procedure_name=request.getParameter("procedure_name");
String real_amount=request.getParameter("real_amount");
String details_number=request.getParameter("details_number");
if(validata.validata(real_amount)&&Double.parseDouble(real_amount)>0){
	String sql3="update manufacture_procedure set procedure_transfer_tag='3',real_amount='"+real_amount+"' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and details_number='"+details_number+"'";
	manufacture_db.executeUpdate(sql3);
	String sql4="update manufacture_manufacture set manufacture_procedure_check_tag='1' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql4);
		
		response.sendRedirect("manufacture/procedure/register_procedure_transfer_ok_a.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	
	response.sendRedirect("manufacture/procedure/register_procedure_transfer_ok_b.jsp?manufacture_ID="+manufacture_ID+"&&procedure_name="+procedure_name+"");
	}	
	manufacture_db.commit();
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