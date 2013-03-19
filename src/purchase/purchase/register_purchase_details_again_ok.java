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
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;

public class register_purchase_details_again_ok extends HttpServlet{

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

counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

String purchase_ID=request.getParameter("purchase_ID") ;
String demand_gather_shipFee_sum2=request.getParameter("demand_gather_shipFee_sum") ;
String demand_price2=request.getParameter("demand_price") ;
String demand_amount=request.getParameter("demand_amount") ;
if(demand_gather_shipFee_sum2.equals("")) demand_gather_shipFee_sum2="0";
int n=0;		
if(!validata.validata(demand_price2)||!validata.validata(demand_amount)){
			n++;
		}
if(n==0){
String details_number=request.getParameter("details_number") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String designer=request.getParameter("designer") ;
String contact_person=request.getParameter("contact_person") ;
String provider_tel=request.getParameter("provider_tel") ;
String provider_fax=request.getParameter("provider_fax") ;
String demand_gather_time=request.getParameter("demand_gather_time") ;
String demand_gather_type=request.getParameter("demand_gather_type") ;
String demand_gather_shipFee_type=request.getParameter("demand_gather_shipFee_type") ;
StringTokenizer tokenTO1 = new StringTokenizer(demand_gather_shipFee_sum2,",");        
String demand_gather_shipFee_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_gather_shipFee_sum1 = tokenTO1.nextToken();
		demand_gather_shipFee_sum +=demand_gather_shipFee_sum1;
		}
String demand_pay_time=request.getParameter("demand_pay_time") ;
String demand_pay_type=request.getParameter("demand_pay_type") ;
String demand_pay_method=request.getParameter("demand_pay_method") ;
String demand_invoice_type=request.getParameter("demand_invoice_type") ;
String amount=request.getParameter("amount") ;
StringTokenizer tokenTO2 = new StringTokenizer(demand_price2,",");        
String demand_price="";
            while(tokenTO2.hasMoreTokens()) {
                String demand_price1 = tokenTO2.nextToken();
		demand_price +=demand_price1;
		}
double demand_cost_price_sum=Double.parseDouble(demand_price)*Double.parseDouble(demand_amount);
String credit_period=request.getParameter("credit_period") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
if(Double.parseDouble(demand_amount)<=Double.parseDouble(amount)||Double.parseDouble(demand_amount)>=Double.parseDouble(amount)){
	String sql = "update purchase_details set designer='"+designer+"',demand_contact_person='"+contact_person+"',demand_contact_person_tel='"+provider_tel+"',demand_gather_time='"+demand_gather_time+"',demand_gather_type='"+demand_gather_type+"',demand_gather_shipFee_type='"+demand_gather_shipFee_type+"',demand_gather_shipFee_sum='"+demand_gather_shipFee_sum+"',demand_pay_time='"+demand_pay_time+"',demand_pay_type='"+demand_pay_type+"',demand_pay_method='"+demand_pay_method+"',demand_invoice_type='"+demand_invoice_type+"',demand_amount='"+demand_amount+"',demand_price='"+demand_price+"',demand_cost_price_sum='"+demand_cost_price_sum+"',credit_period='"+credit_period+"',remark='"+remark+"',check_tag='0' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID+"'"; 
	purchase_db.executeUpdate(sql) ;
		response.sendRedirect("register_choose_attachment.jsp?provider_ID="+provider_ID+"&&purchase_ID="+purchase_ID+"");
	}else{
	response.sendRedirect("purchase/purchase/register_purchase_details_ok_b.jsp?purchase_ID="+purchase_ID+"");
	}}else{
		response.sendRedirect("purchase/purchase/register_purchase_details_ok_c.jsp?purchase_ID="+purchase_ID+"");
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