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
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;

import include.nseer_cookie.counter;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
String provider_ID=request.getParameter("provider_ID") ;
String contact_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String provider_name=request.getParameter("provider_name") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
	String sql = "insert into purchase_contact(contact_ID,reason,reasonexact,provider_ID,provider_name,person_contacted,person_contacted_tel,contact_person,contact_person_ID,contact_time,contact_type,contact_content,check_tag,excel_tag) values ('"+contact_ID+"','"+reason+"','"+reasonexact+"','"+provider_ID+"','"+provider_name+"','"+person_contacted+"','"+person_contacted_tel+"','"+contact_person+"','"+contact_person_ID+"','"+contact_time+"','"+contact_type+"','"+contact_content+"','0','2')" ;
	purchase_db.executeUpdate(sql) ;

    
List rsList = GetWorkflow.getList(purchase_db, "purchase_config_workflow", "04");


	if(rsList.size()==0){
		sql="update purchase_contact set check_tag='1' where contact_ID='"+contact_ID+"'";
		purchase_db.executeUpdate(sql) ;

        int contact_amount=0;
        String sql3="select * from purchase_file where provider_ID='"+provider_ID+"'";
        ResultSet rs3=purchase_db.executeQuery(sql3);
	    if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	    }
	    String sql4="update purchase_file set contact_amount='"+contact_amount+"',remind_contact_tag='0' where provider_ID='"+provider_ID+"'";
	    purchase_db.executeUpdate(sql4) ;

}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+contact_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		purchase_db.executeUpdate(sql);
		}
	}

    purchase_db.commit();
	purchase_db.close();
	response.sendRedirect("purchase/contact/register_ok_a.jsp");
	}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 