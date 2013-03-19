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

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import validata.ValidataRecord;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
ValidataRecord vr=new ValidataRecord();

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String pay_ID=request.getParameter("pay_ID") ;
String product_amount=request.getParameter("product_amount") ;
String checker_ID=(String)session.getAttribute("human_IDD");
String config_id=request.getParameter("config_id");
int num=Integer.parseInt(product_amount);
String payer_name=request.getParameter("payer_name") ;
String payer_ID=request.getParameter("payer_ID") ;
String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String sql6="select id from stock_workflow where object_ID='"+pay_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=stock_db.executeQuery(sql6);
if(!rs6.next()){
int p=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
	if(!validata.validata(amount)){
			p++;
		}
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_apply_pay","pay_ID",pay_ID,"check_tag").equals("0")){

if(p==0){
try{
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

int n=0;
for(int i=1;i<=num;i++){
	String tem_available_amount="available_amount"+i;
	String tem_amount="amount"+i;
String available_amount=request.getParameter(tem_available_amount) ;
String amount=request.getParameter(tem_amount) ;
	if(Double.parseDouble(amount)>Double.parseDouble(available_amount)) n++;
}
//if(n==0){

String stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
/*
count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod1);
String mod2="/erp/stock_gather_register_ok";
int filenumber2=count.readTime((String)dbSession.getAttribute("unit_db_name"),mod2);
String gather_ID=time+filenumber2;
count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod2);*/
String gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));
double demand_amount=0.0d;
double cost_price_sum=0.0d;
/*
String main_code1="";
String first_code1="";
String second_code1="";
String main_code2="";
String first_code2="";
String second_code2="";
String sqla="select * from document_first where main_kind_name='stock' and first_kind_name='pay'";
ResultSet rsa=stock_db.executeQuery(sqla) ;
if(rsa.next()){
   main_code1=rsa.getString("main_code");
   first_code1=rsa.getString("first_code");
   second_code1=rsa.getString("second_code");
}
stock_pay_ID=main_code1+first_code1+second_code1+stock_pay_ID;

String sqlb="select * from document_first where main_kind_name='stock' and first_kind_name='gather'";
ResultSet rsb=stock_db.executeQuery(sqlb) ;
if(rsb.next()){
   main_code2=rsb.getString("main_code");
   first_code2=rsb.getString("first_code");
   second_code2=rsb.getString("second_code");
}
    gather_ID=main_code2+first_code2+second_code2+gather_ID;
*/
String sql = "update stock_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+pay_ID+"' and config_id='"+config_id+"'" ;
stock_db.executeUpdate(sql);
boolean flag=false;
sql="select id from stock_workflow where object_ID='"+pay_ID+"' and check_tag='0'";
ResultSet rset=stock_db.executeQuery(sql);
if(!rset.next()){
	flag=true;
}
//***********************************************************
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_available_amount="available_amount"+i;
	String tem_amount="amount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String available_amount=request.getParameter(tem_available_amount) ;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
        while(tokenTO3.hasMoreTokens()) {
        String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "update stock_apply_pay_details set product_ID='"+product_ID+"',product_name='"+product_name+"',amount='"+amount+"',cost_price='"+cost_price+"',subtotal='"+subtotal+"' where pay_ID='"+pay_ID+"' and details_number='"+i+"'" ;
	stock_db.executeUpdate(sql1) ;

	if(flag){//33333333333333333333333333333333333333333333333333333333333333
	String sql2="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,unpay_amount) values('"+stock_pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql2) ;
	if(not_return_tag.equals("0")){
	String sql3="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,ungather_amount) values('"+gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql3);
	}
	}
}
if(flag){
	sql = "update stock_apply_pay set reason='"+reason+"',register='"+register+"',register_time='"+register_time+"',demand_return_time='"+demand_return_time+"',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',cost_price_sum='"+cost_price_sum+"',not_return_tag='"+not_return_tag+"',check_tag='1' where pay_ID='"+pay_ID+"'" ;
	stock_db.executeUpdate(sql) ;

if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",pay_ID)){
	String sql4="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_pay_ID+"','"+reason+"','"+pay_ID+"','"+payer_name+"','"+demand_amount+"','"+cost_price_sum+"','"+checker+"','"+check_time+"')";
	stock_db.executeUpdate(sql4) ;
}
if(not_return_tag.equals("0")){
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",pay_ID)){
	String sql5="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+gather_ID+"','"+reason+"','"+pay_ID+"','"+payer_name+"','"+demand_amount+"','"+cost_price_sum+"','"+checker+"','"+check_time+"')";
	stock_db.executeUpdate(sql5) ;
}
}
}else{
sql = "update stock_apply_pay set reason='"+reason+"',register='"+register+"',register_time='"+register_time+"',demand_return_time='"+demand_return_time+"',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',cost_price_sum='"+cost_price_sum+"',not_return_tag='"+not_return_tag+"',check_tag='0' where pay_ID='"+pay_ID+"'" ;
stock_db.executeUpdate(sql) ;
}

response.sendRedirect("stock/apply_pay/check_ok.jsp?finished_tag=0");
//}else{
//response.sendRedirect("stock/apply_pay/check_ok_b.jsp?pay_ID="+pay_ID+"");
//}
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
response.sendRedirect("stock/apply_pay/check_ok.jsp?finished_tag=2");
}}else{
response.sendRedirect("stock/apply_pay/check_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("stock/apply_pay/check_ok.jsp?finished_tag=4");
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