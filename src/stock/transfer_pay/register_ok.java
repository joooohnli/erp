/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.transfer_pay;
 
 
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

public class register_ok extends HttpServlet{

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
ValidataRecord vr=new ValidataRecord();

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

String reasonexact=request.getParameter("reasonexact") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

String stock_gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));
String stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));

StringTokenizer tokenTO =null;
String stock_ID ="";
String stock_name="";
if(!reasonexact.equals("  /")){
tokenTO = new StringTokenizer(reasonexact,"/");        

            while(tokenTO.hasMoreTokens()) {
                stock_ID = tokenTO.nextToken();
				stock_name = tokenTO.nextToken();
		}
}else{
   tokenTO = new StringTokenizer(reasonexact,"/");        
     if(tokenTO.hasMoreTokens()) {
         stock_ID = tokenTO.nextToken();}
}

int n=0;
double cost_price_sum=0.0d;
double demand_amount=0.0d;

List rsList = GetWorkflow.getList(stock_db, "stock_config_workflow", "04");
String[] elem=new String[3];

for(int i=1;i<num;i++){
	String tem_amount="amount"+i;
	String tem_balance_amount="balance_amount"+i;
	String amount=request.getParameter(tem_amount) ;
	String balance_amount=request.getParameter(tem_balance_amount) ;
	if(Double.parseDouble(amount)>Double.parseDouble(balance_amount)){
		n++;
	}
}
if(n==0){
	try{
	
	String pay_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

	String sql = "insert into stock_transfer_pay(pay_ID,reason,reasonexact,register_time,remark,register,check_tag,excel_tag) values ('"+pay_ID+"','内部调出','"+reasonexact+"','"+register_time+"','"+remark+"','"+register+"','0','2')" ;
	stock_db.executeUpdate(sql) ;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_amount="amount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String amount=request.getParameter(tem_amount) ;
String product_describe=request.getParameter(tem_product_describe) ;
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
	String sql1 = "insert into stock_transfer_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,amount_unit,amount,cost_price,subtotal) values ('"+pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount_unit+"','"+amount+"','"+cost_price+"','"+subtotal+"')" ;
	stock_db.executeUpdate(sql1) ;

	if(rsList.size()==0){
	String sql2="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,unpay_amount) values('"+stock_pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql2) ;
	String sql5="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,ungather_amount) values('"+stock_gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql5) ;

	}

	}

}

if(rsList.size()==0){
	String nseer_sql="update stock_transfer_pay set cost_price_sum='"+cost_price_sum+"',demand_amount='"+demand_amount+"',check_tag='1' where pay_ID='"+pay_ID+"'";
	stock_db.executeUpdate(nseer_sql) ;

if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",pay_ID)){
	String sql4="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_pay_ID+"','内部调出','"+pay_ID+"','"+stock_name+"','"+demand_amount+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql4) ;
}
	if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",pay_ID)){
	String sql4="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_gather_ID+"','内部调出','"+pay_ID+"','"+stock_name+"','"+demand_amount+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql4) ;
}


}else{
		String nseer_sql="update stock_transfer_pay set cost_price_sum='"+cost_price_sum+"',demand_amount='"+demand_amount+"',check_tag='0' where pay_ID='"+pay_ID+"'";
		stock_db.executeUpdate(nseer_sql);
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		nseer_sql = "insert into stock_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+pay_ID+"','"+elem[1]+"','"+elem[2]+"')";
		stock_db.executeUpdate(nseer_sql);
		}
}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("stock/transfer_pay/register_ok_a.jsp");
}else{
response.sendRedirect("stock/transfer_pay/register_ok_b.jsp");
}
}else{
response.sendRedirect("stock/transfer_pay/register_ok_c.jsp");
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