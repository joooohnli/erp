/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.invoice;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import  validata.ValidataNumber;
import include.nseer_cookie.counter;

public class check_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ValidataNumber validata = new  ValidataNumber();
   nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
   counter  count= new   counter(dbApplication);
	PrintWriter out=response.getWriter();
String product_amount=request.getParameter("product_amount") ;
String reasonexact=request.getParameter("reasonexact") ;
String config_id=request.getParameter("config_id");
String which_time=request.getParameter("which_time");
int num=Integer.parseInt(product_amount);
String reason=request.getParameter("reason") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String real_customer_mailing_address=request.getParameter("real_customer_mailing_address") ;
String real_contact_person=request.getParameter("real_contact_person") ;
String real_contact_person_tel=request.getParameter("real_contact_person_tel") ;
String real_contact_person_fax=request.getParameter("real_contact_person_fax") ;
String real_invoice_time=request.getParameter("real_invoice_time") ;
String real_invoice_type=request.getParameter("real_invoice_type") ;
String register=request.getParameter("register") ;
String register_ID=request.getParameter("register_ID") ;
String invoice_group=request.getParameter("invoice_group") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
double invoiced_subtotal_sum=0.0d;
double invoiced_subtotal_sum_all=0.0d;
String sql6="select id from crm_workflow where object_ID='"+reasonexact+"' and which_time='"+which_time+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=crm_db.executeQuery(sql6);
if(!rs6.next()){
int p=0;
for(int i=1;i<=num;i++){
	String tem_invoice_sum="invoice_sum"+i;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
if(invoice_sum2.equals("")) invoice_sum2="0";
StringTokenizer tokenTO2 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO2.hasMoreTokens()) {
                String invoice_sum1 = tokenTO2.nextToken();
		invoice_sum +=invoice_sum1;
		}
		if(!validata.validata(invoice_sum)){
			p++;
		}
}
if(p==0){
	int n=0;
/*	String product_ID_control=request.getParameter("product_ID1") ;
	double invoice_control=0.0d;

for(int i=1;i<=num;i++){
	String tem_details_number="details_number"+i;
	String tem_id="id"+i;
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_subtotal="subtotal"+i;
	String tem_invoice_sum="invoice_sum"+i;
	String tem_invoiced_subtotal="invoiced_subtotal"+i;
	String tem_remark="remark"+i;
	//String tem_unit="unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String details_number=request.getParameter(tem_details_number) ;
String id=request.getParameter(tem_id) ;
String subtotal=request.getParameter(tem_subtotal) ;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
if(invoice_sum2.equals("")) invoice_sum2="0";
StringTokenizer tokenTO1 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String invoice_sum1 = tokenTO1.nextToken();
		invoice_sum +=invoice_sum1;
		}
String invoiced_subtotal=request.getParameter(tem_invoiced_subtotal) ;
String remark=request.getParameter(tem_remark) ;
//String tem_unit=request.getParameter(tem_unit) ;
if(invoice_sum!=null&&!invoice_sum.equals("")){
invoiced_subtotal_sum=Double.parseDouble(invoiced_subtotal)+Double.parseDouble(invoice_sum);
if(Math.abs(invoiced_subtotal_sum)>Math.abs(Double.parseDouble(subtotal))){
	n++;
}
}
invoiced_subtotal_sum=0;
	if(product_ID.equals(product_ID_control)){
		invoice_control+=Double.parseDouble(invoice_sum);
		if(Math.abs(invoice_control+Double.parseDouble(invoiced_subtotal))>Math.abs(Double.parseDouble(subtotal))){
		n++;
		}
	}else{
		product_ID_control=product_ID;
		invoice_control=Double.parseDouble(invoice_sum);
	}
}*/
if(n==0){
String sql8="select * from crm_ordering where reasonexact='"+reasonexact+"' and check_tag='0' and which_time='"+which_time+"'";
ResultSet rs8=crm_db.executeQuery(sql8);
if(rs8.next()){
boolean flag=false; 
sql8 = "update crm_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+reasonexact+"' and config_id='"+config_id+"' and which_time='"+which_time+"'" ;
	crm_db.executeUpdate(sql8);
sql8="select id from crm_workflow where object_ID='"+reasonexact+"' and which_time='"+which_time+"' and check_tag='0'";
	rs8=crm_db.executeQuery(sql8);
	if(!rs8.next()){
		flag=true;
for(int j=1;j<=num;j++){
	String tem_details_number="details_number"+j;
	String tem_id="id"+j;
String id=request.getParameter(tem_id) ;
String details_number=request.getParameter(tem_details_number) ;
	String sql1 = "update crm_ordering set check_tag='1' where id='"+id+"' and check_tag='0' and which_time='"+which_time+"'" ;
	crm_db.executeUpdate(sql1) ;
}
	}
	String product_ID_control1=request.getParameter("product_ID1") ;
	String subtotal_control1=request.getParameter("invoiced_subtotal1") ;
	double subtotal_control=Double.parseDouble(subtotal_control1);
for(int j=1;j<=num;j++){
	invoiced_subtotal_sum=0;
	String tem_details_number="details_number"+j;
	String tem_product_name="product_name"+j;
	String tem_product_ID="product_ID"+j;
	String tem_subtotal="subtotal"+j;
	String tem_invoice_sum="invoice_sum"+j;
	String tem_invoiced_subtotal="invoiced_subtotal"+j;
	String tem_remark="remark"+j;
	//String tem_unit="unit"+j ;
	String tem_id="id"+j;
String id=request.getParameter(tem_id) ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String details_number=request.getParameter(tem_details_number) ;
String subtotal=request.getParameter(tem_subtotal) ;
String invoiced_subtotal=request.getParameter(tem_invoiced_subtotal) ;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
if(invoice_sum2.equals("")) invoice_sum2="0";
StringTokenizer tokenTO1 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String invoice_sum1 = tokenTO1.nextToken();
		invoice_sum +=invoice_sum1;
		}
String remark=request.getParameter(tem_remark) ;
//String tem_unit=request.getParameter(tem_unit) ;
if(product_ID.equals(product_ID_control1)){
if(invoice_sum!=null&&Double.parseDouble(invoice_sum)!=0){
subtotal_control+=Double.parseDouble(invoice_sum);
invoiced_subtotal_sum_all+=Double.parseDouble(invoice_sum);
	String sql1 = "update crm_ordering set reason='"+reason+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',real_customer_mailing_address='"+real_customer_mailing_address+"',real_contact_person='"+real_contact_person+"',real_contact_person_tel='"+real_contact_person_tel+"',real_contact_person_fax='"+real_contact_person_fax+"',real_invoice_type='"+real_invoice_type+"',register='"+register+"',register_ID='"+register_ID+"',checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',product_ID='"+product_ID+"',product_name='"+product_name+"',invoice_sum='"+invoice_sum+"',remark='"+remark+"',invoice_group='"+invoice_group+"' where id='"+id+"'" ;
	
	crm_db.executeUpdate(sql1) ;
	if(flag){
	if(subtotal_control==Double.parseDouble(subtotal)){
	String sql2="update crm_order_details set invoiced_subtotal='"+subtotal_control+"',invoice_tag='1' where order_ID='"+reasonexact+"' and details_number='"+details_number+"'";
	crm_db.executeUpdate(sql2) ;
	}else{		
	String sql3="update crm_order_details set invoiced_subtotal='"+subtotal_control+"' where order_ID='"+reasonexact+"' and details_number='"+details_number+"'";
	crm_db.executeUpdate(sql3) ;
	}
	}
}else if(Double.parseDouble(invoice_sum)==0){
	String sql7 = "delete from crm_ordering where id='"+id+"'" ;	
	crm_db.executeUpdate(sql7) ;
}
}else{
if(invoice_sum!=null&&Double.parseDouble(invoice_sum)!=0){
product_ID_control1=product_ID;
subtotal_control=Double.parseDouble(invoiced_subtotal)+Double.parseDouble(invoice_sum);
invoiced_subtotal_sum_all+=Double.parseDouble(invoice_sum);
	String sql1 = "update crm_ordering set reason='"+reason+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',real_customer_mailing_address='"+real_customer_mailing_address+"',real_contact_person='"+real_contact_person+"',real_contact_person_tel='"+real_contact_person_tel+"',real_contact_person_fax='"+real_contact_person_fax+"',real_invoice_time='"+real_invoice_time+"',real_invoice_type='"+real_invoice_type+"',register='"+register+"',register_ID='"+register_ID+"',checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',product_ID='"+product_ID+"',product_name='"+product_name+"',invoice_sum='"+invoice_sum+"',remark='"+remark+"',invoice_group='"+invoice_group+"' where id='"+id+"'" ;
	
	crm_db.executeUpdate(sql1) ;
	if(flag){
	if(subtotal_control==Double.parseDouble(subtotal)){
	String sql2="update crm_order_details set invoiced_subtotal='"+subtotal_control+"',invoice_tag='1' where order_ID='"+reasonexact+"' and details_number='"+details_number+"'";
	crm_db.executeUpdate(sql2) ;
	}else{		
	String sql3="update crm_order_details set invoiced_subtotal='"+subtotal_control+"' where order_ID='"+reasonexact+"' and details_number='"+details_number+"'";
	crm_db.executeUpdate(sql3) ;
	}
	}
}else if(Double.parseDouble(invoice_sum)==0){
	String sql7 = "delete from crm_ordering where id='"+id+"'" ;	
	crm_db.executeUpdate(sql7) ;
	out.println(sql7);
}
}
}
if(flag){
int m=0;
double sale_price_sum=0.0d;
double invoiced_sum=0.0d;
double uninvoice_sum=0.0d;
String sql4="select id from crm_order_details where order_ID='"+reasonexact+"' and invoice_tag='0'";
ResultSet rs4=crm_db.executeQuery(sql4);
if(!rs4.next()){
sql6="select sale_price_sum from crm_order where order_ID='"+reasonexact+"'";
rs6=crm_db.executeQuery(sql6);
if(rs6.next()){
	sale_price_sum=rs6.getDouble("sale_price_sum");
}
String sql5="update crm_order set invoiced_sum='"+sale_price_sum+"',uninvoice_sum='0',invoice_tag='3' where order_ID='"+reasonexact+"'";
	crm_db.executeUpdate(sql5) ;
	String sql21="select * from crm_order where gather_tag='3' and logistics_tag='3' and receive_tag='3' and invoice_tag='3' and pay_tag='3' and check_tag='1' and order_ID='"+reasonexact+"'";
		ResultSet rs21=crm_db.executeQuery(sql21);
		if(rs21.next()){
		String sql22="update crm_order set order_tag='2',order_status='完成',accomplish_time='"+check_time+"' where order_ID='"+reasonexact+"'";
		crm_db.executeUpdate(sql22);
		}
	response.sendRedirect("crm/invoice/check_ok.jsp?finished_tag=6");
}else{
sql6="select sale_price_sum,invoiced_sum from crm_order where order_ID='"+reasonexact+"'";
rs6=crm_db.executeQuery(sql6);
if(rs6.next()){
	sale_price_sum=rs6.getDouble("sale_price_sum");
	invoiced_sum=rs6.getDouble("invoiced_sum")+invoiced_subtotal_sum_all;
}
uninvoice_sum=sale_price_sum-invoiced_sum;
String sql5="update crm_order set invoiced_sum='"+invoiced_sum+"',uninvoice_sum='"+uninvoice_sum+"',invoice_check_tag='0' where order_ID='"+reasonexact+"'";
	crm_db.executeUpdate(sql5) ;
	response.sendRedirect("crm/invoice/check_ok.jsp?finished_tag=5");
}
	}else{
response.sendRedirect("crm/invoice/check_ok.jsp?finished_tag=0");
	}
	}else{

response.sendRedirect("crm/invoice/check_ok.jsp?finished_tag=1");
}
	}else{
		
response.sendRedirect("crm/invoice/check_ok.jsp?finished_tag=3");
}
	}else{
	
	response.sendRedirect("crm/invoice/check_ok.jsp?finished_tag=4");
	}
}else{
response.sendRedirect("crm/invoice/check_ok.jsp?finished_tag=2");
}
crm_db.commit();
crm_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}