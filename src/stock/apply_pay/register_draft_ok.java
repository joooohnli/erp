/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.apply_pay;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ValidataRecord vr=new ValidataRecord();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);

try{
	String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);
		
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int p=0;
for(int i=1;i<num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
	if(!validata.validata(amount)){
			p++;
		}
}

if(p==0){
String pay_ID=request.getParameter("pay_ID") ;
String payer_name=request.getParameter("payer_name") ;
String payer_ID=request.getParameter("payer_ID") ;
if(pay_ID.equals("")){
}

String stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));

String gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));

String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String new_apply=request.getParameter("new_apply") ;
try{
		
	pay_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));	
	
	String sql3 = "delete from stock_apply_pay where pay_ID='"+pay_ID+"'" ;
	stock_db.executeUpdate(sql3) ;
	String sql4 = "delete from stock_apply_pay_details where pay_ID='"+pay_ID+"'" ;
	stock_db.executeUpdate(sql4) ;
	String sql = "insert into stock_apply_pay(pay_ID,payer_name,payer_ID,reason,register_time,demand_return_time,remark,register,check_tag,excel_tag,not_return_tag) values ('"+pay_ID+"','"+payer_name+"','"+payer_ID+"','"+reason+"','"+register_time+"','"+demand_return_time+"','"+remark+"','"+register+"','5','2','"+not_return_tag+"')" ;
	stock_db.executeUpdate(sql) ;
double cost_price_sum=0.0d;
double demand_amount=0.0d;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	if(!amount.equals("")&&Double.parseDouble(amount)!=0){
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "insert into stock_apply_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,cost_price,subtotal) values ('"+pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+amount_unit+"','"+cost_price+"','"+subtotal+"')" ;
	stock_db.executeUpdate(sql1) ;


	String sql2="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,unpay_amount) values('"+stock_pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql2) ;
	if(not_return_tag.equals("0")){
	 sql3="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,ungather_amount) values('"+gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql3) ;
	}
	
	}
}


	String nseer_sql="update stock_apply_pay set cost_price_sum='"+cost_price_sum+"',demand_amount='"+demand_amount+"' where pay_ID='"+pay_ID+"'";
   stock_db.executeUpdate(nseer_sql);

if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",pay_ID)){
	sql4="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_pay_ID+"','"+reason+"','"+pay_ID+"','"+payer_name+"','"+demand_amount+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql4) ;
}
if(not_return_tag.equals("0")){
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",pay_ID)){
	String sql5="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+gather_ID+"','"+reason+"','"+pay_ID+"','"+payer_name+"','"+demand_amount+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql5) ;
}
}



}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("stock/apply_pay/register_draft_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("stock/apply_pay/register_draft_ok.jsp?finished_tag=1");
}
stock_db.commit();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}