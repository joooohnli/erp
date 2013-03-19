/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.apply;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class register_change_order_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);


if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);

String id=request.getParameter("id") ;
String order_ID=request.getParameter("order_ID") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
for(int i=1;i<=num;i++){
	String tem_apply_manufacture_amount="apply_manufacture_amount"+i;
String apply_manufacture_amount=request.getParameter(tem_apply_manufacture_amount) ;
if(apply_manufacture_amount.equals("")) apply_manufacture_amount="0";
	String sql1 = "update crm_order_details set apply_manufacture_amount='"+apply_manufacture_amount+"' where order_ID='"+order_ID+"' and details_number='"+i+"'" ;
	crm_db.executeUpdate(sql1) ;
}
crm_db.commit();
	crm_db.close();
	response.sendRedirect("purchase/contact/register_change_order_ok_a.jsp");
	}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 