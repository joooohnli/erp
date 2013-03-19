/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.invoice;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import java.sql.* ;

import include.nseer_cookie.GetWorkflow;
import include.nseer_db.*;
import validata.ValidataNumber;

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String demand_cost_price_sum_all=request.getParameter("demand_cost_price_sum_all") ;
String real_invoiced_sum1=request.getParameter("real_invoiced_sum") ;
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] real_contact_person=request.getParameterValues("real_contact_person") ;
String[] real_contact_person_tel=request.getParameterValues("real_contact_person_tel") ;
String[] demand_cost_price_sum=request.getParameterValues("demand_cost_price_sum1") ;
String[] invoiced_sum=request.getParameterValues("invoiced_sum1") ;
String[] invoicing_sum=request.getParameterValues("invoicing_sum") ;
String[] remark=request.getParameterValues("remark") ;
int p=0;
for(int i=0;i<provider_ID.length;i++){
	if(!invoicing_sum[i].equals("")){
		StringTokenizer tokenTO1 = new StringTokenizer(invoicing_sum[i],",");        
		String invoicing_sum2="";
            while(tokenTO1.hasMoreTokens()) {
                String invoicing_sum1 = tokenTO1.nextToken();
		invoicing_sum2+=invoicing_sum1;
		}
		if(!validata.validata(invoicing_sum2)){
		p++;
		}
		if(real_contact_person[i].indexOf("'")!=-1||real_contact_person[i].indexOf("\"")!=-1||real_contact_person[i].indexOf(",")!=-1||real_contact_person_tel[i].indexOf("'")!=-1||real_contact_person_tel[i].indexOf("\"")!=-1||real_contact_person_tel[i].indexOf(",")!=-1||remark[i].indexOf("'")!=-1||remark[i].indexOf("\"")!=-1||remark[i].indexOf(",")!=-1||real_contact_person[i].length()>30||real_contact_person_tel[i].length()>30){
		p++;
		}
	}
}
if(p==0){
int n=0;
for(int i=0;i<provider_ID.length;i++){
	if(!invoicing_sum[i].equals("")){
		n++;
	}
}
if(n!=0){

int invoice_time=0;
String sql="select invoice_time from intrmanufacture_intrmanufacture where intrmanufacture_ID='"+intrmanufacture_ID+"'";
ResultSet rset=intrmanufacture_db.executeQuery(sql);
if(rset.next()){
	invoice_time=rset.getInt("invoice_time")+1;
}

for(int i=0;i<provider_ID.length;i++){
	if(!invoicing_sum[i].equals("")){
		StringTokenizer tokenTO = new StringTokenizer(invoicing_sum[i],",");        
		String invoicing_sum2="";
            while(tokenTO.hasMoreTokens()) {
                String invoicing_sum1 = tokenTO.nextToken();
		invoicing_sum2+=invoicing_sum1;
		}
		if(Double.parseDouble(invoicing_sum2)!=0){
		sql="insert into intrmanufacture_purchasing(intrmanufacture_ID,provider_ID,provider_name,real_contact_person,real_contact_person_tel,invoicing_sum,demand_cost_price_sum,invoiced_sum,register,register_time,remark,kind,invoice_time) values('"+intrmanufacture_ID+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+real_contact_person[i]+"','"+real_contact_person_tel[i]+"','"+invoicing_sum2+"','"+demand_cost_price_sum[i]+"','"+invoiced_sum[i]+"','"+register+"','"+register_time+"','"+remark[i]+"','发票','"+invoice_time+"')";
		intrmanufacture_db.executeUpdate(sql);
		String sql1="update intrmanufacture_details set invoice_check_tag='1' where intrmanufacture_ID='"+intrmanufacture_ID+"' and provider_ID='"+provider_ID[i]+"'";
		intrmanufacture_db.executeUpdate(sql1);
		}
	}
}

	String sql2="update intrmanufacture_intrmanufacture set invoice_check_tag='5',invoice_tag='2',invoice_time='"+invoice_time+"' where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	intrmanufacture_db.executeUpdate(sql2);

	response.sendRedirect("intrmanufacture/invoice/register_draft_ok.jsp?finished_tag=0");
	}else{
	response.sendRedirect("intrmanufacture/invoice/register_draft_ok.jsp?finished_tag=1");
}
	}else{
		
	response.sendRedirect("intrmanufacture/invoice/register_draft_ok.jsp?finished_tag=2");
	}
intrmanufacture_db.commit();
intrmanufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 