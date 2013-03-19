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
import java.util.*;
import java.io.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;


public class register_draft_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ValidataTag vt = new ValidataTag();
String reasonexact=request.getParameter("reasonexact");
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_order","order_ID",reasonexact,"invoice_check_tag").equals("0")){
counter  count=new counter(dbApplication);
ValidataNumber validata=new  ValidataNumber();
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int p=0;
int pp=0;

for(int i=1;i<=num;i++){
	String tem_invoice_sum="invoice_sum"+i;
	String tem_remark="remark"+i;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
String remark=request.getParameter(tem_remark) ;
if(invoice_sum2==null||invoice_sum2.equals("")){
	invoice_sum2="0";
	pp++;
}
if(remark==null) remark="";
StringTokenizer tokenTO2 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO2.hasMoreTokens()) {
                String invoice_sum1 = tokenTO2.nextToken();
		invoice_sum +=invoice_sum1;
		}
		if(!validata.validata(invoice_sum)){
			p++;
		}
		if(remark.indexOf("'")!=-1||remark.indexOf("\"")!=-1){
			p++;
		}
}


if(p==0&&pp!=num){
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
String register_time=request.getParameter("register_time") ;
String invoice_group=request.getParameter("invoice_group") ;
double invoiced_subtotal_sum=0;
int n=0;
if(n!=0){
	
response.sendRedirect("crm/invoice/register_ok.jsp?order_ID="+reasonexact+"&finished_tag=0");
}else{
	int which_time=0;
	String sql="select which_time from crm_order where order_ID='"+reasonexact+"'";
	ResultSet rset=crm_db.executeQuery(sql);
	if(rset.next()){
		which_time=rset.getInt("which_time")+1;
	}	
double invoiced_subtotal_sum_all=0.0d;
for(int j=1;j<=num;j++){
	invoiced_subtotal_sum=0;
	String tem_details_number="details_number"+j;
	String tem_product_name="product_name"+j;
	String tem_product_ID="product_ID"+j;
	String tem_subtotal="subtotal"+j;
	String tem_invoice_sum="invoice_sum"+j;
	String tem_invoiced_subtotal="invoiced_subtotal"+j;
	String tem_remark="remark"+j;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String details_number=request.getParameter(tem_details_number) ;
String subtotal=request.getParameter(tem_subtotal) ;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
String remark=request.getParameter(tem_remark) ;
if(invoice_sum2!=null&&!invoice_sum2.equals("")){
StringTokenizer tokenTO1 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO1.hasMoreTokens()){
                String invoice_sum1 = tokenTO1.nextToken();
		invoice_sum +=invoice_sum1;
		}
invoiced_subtotal_sum_all+=Double.parseDouble(invoice_sum);
	String sql1 = "insert into crm_ordering(reason,reasonexact,customer_ID,customer_name,real_customer_mailing_address,real_contact_person,real_contact_person_tel,real_contact_person_fax,real_invoice_time,real_invoice_type,register,register_ID,details_number,product_ID,product_name,subtotal,invoice_sum,remark,invoice_group,invoice_dra_tag,which_time) values ('"+reason+"','"+reasonexact+"','"+customer_ID+"','"+customer_name+"','"+real_customer_mailing_address+"','"+real_contact_person+"','"+real_contact_person_tel+"','"+real_contact_person_fax+"','"+real_invoice_time+"','"+real_invoice_type+"','"+register+"','"+register_ID+"','"+details_number+"','"+product_ID+"','"+product_name+"','"+subtotal+"','"+invoice_sum+"','"+remark+"','"+invoice_group+"','1','"+which_time+"')";
	
	crm_db.executeUpdate(sql1);
}
}
String sql1 = "update crm_order set invoice_check_tag='5',which_time='"+which_time+"' where order_id='"+reasonexact+"'" ;
crm_db.executeUpdate(sql1) ;
response.sendRedirect("crm/invoice/register_ok.jsp?finished_tag=4");
}

}else{
response.sendRedirect("crm/invoice/register_ok_b.jsp?order_ID="+reasonexact+"");
}
}else{
response.sendRedirect("crm/invoice/register_ok.jsp?order_ID="+reasonexact+"&finished_tag=3");
}
crm_db.commit();
crm_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}