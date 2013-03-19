/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.contact;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

import validata.ValidataTag;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataTag vt=new ValidataTag();

String id=request.getParameter("id");
String contact_ID=request.getParameter("contact_ID") ;
String config_ID=request.getParameter("config_ID") ;
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
String sql6="select id from purchase_workflow where object_ID='"+contact_ID+"' and ((check_tag='0' and config_ID<'"+config_ID+"') or (check_tag='1' and config_ID='"+config_ID+"'))";
ResultSet rs6=purchase_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_contact","contact_ID",contact_ID,"check_tag").equals("0")){
	String sql = "update purchase_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_ID='"+contact_person_ID+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"',checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"' where id="+id+"" ;
	purchase_db.executeUpdate(sql) ;

   String sql9 = "update purchase_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+contact_ID+"' and config_ID='"+config_ID+"'" ;
	purchase_db.executeUpdate(sql9);
	sql9="select id from purchase_workflow where object_ID='"+contact_ID+"' and check_tag='0'";
	ResultSet rset=purchase_db.executeQuery(sql9);
	if(!rset.next()){
		sql9="update purchase_contact set reason='"+reason+"',check_tag='1' where contact_ID='"+contact_ID+"'";
		purchase_db.executeUpdate(sql9);
	int contact_amount=0;
        String sql3="select * from purchase_file where provider_ID='"+provider_ID+"'";
        ResultSet rs3=purchase_db.executeQuery(sql3);
	    if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}
	String sql4="update purchase_file set contact_amount='"+contact_amount+"',lately_contact_time='"+check_time+"',remind_contact_tag='0' where provider_ID='"+provider_ID+"'";
	purchase_db.executeUpdate(sql4) ;

	}else{
		sql9="update purchase_contact set reason='"+reason+"' where contact_ID='"+contact_ID+"'";
		purchase_db.executeUpdate(sql9);
	}


response.sendRedirect("purchase/contact/check_ok.jsp?finished_tag=0");
	}else{
	response.sendRedirect("purchase/contact/check_ok.jsp?finished_tag=1");
	}
	}else{
	response.sendRedirect("purchase/contact/check_ok.jsp?finished_tag=2");
	}
	purchase_db.commit();
	purchase_db.close();


	}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 