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
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import validata.ValidataTag;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db1 = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&purchase_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataTag vt=new ValidataTag();

String purchase_ID=request.getParameter("purchase_ID");
String choice=request.getParameter("choice");
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_purchase","purchase_ID",purchase_ID,"check_tag").equals("1")){

try{
	String sql = "update purchase_purchase set remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='9' where purchase_ID='"+purchase_ID+"'" ;
	purchase_db.executeUpdate(sql) ;

	String sql1="select * from purchase_purchase where purchase_ID='"+purchase_ID+"'";
	ResultSet rs1=purchase_db.executeQuery(sql1);
	while(rs1.next()){
		StringTokenizer tokenTO = new StringTokenizer(rs1.getString("apply_id_group"),", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update purchase_apply set purchase_tag='0' where id='"+tokenTO.nextToken()+"'";
		purchase_db1.executeUpdate(sql4) ;
		}
	}
}
catch (Exception ex) {
		ex.printStackTrace();
	}
	response.sendRedirect("purchase/purchase/check_list.jsp");
	}else{
	response.sendRedirect("purchase/purchase/check_delete_ok_b.jsp");
}
	purchase_db.commit();
	purchase_db1.commit();
	purchase_db.close();
	purchase_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 