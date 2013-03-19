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
 
 
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;
import validata.ValidataRecordNumber;

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
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&purchase_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){


ValidataRecordNumber vrn=new ValidataRecordNumber();
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

String list_price=request.getParameter("list_price");
String amount=request.getParameter("amount");
String pay_ID_group=request.getParameter("pay_ID_group");
String choice_group=request.getParameter("choice_group");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String product_ID=request.getParameter("product_ID");
String demand_amount1=request.getParameter("amount");
String product_name=request.getParameter("product_name");
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] contact_person=request.getParameterValues("contact_person1") ;
String[] provider_tel=request.getParameterValues("provider_tel1") ;
String[] demand_gather_time=request.getParameterValues("demand_gather_time1") ;
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] demand_price=request.getParameterValues("demand_price") ;
double demand_amount8=0.0d;
double demand_cost_price_sum8=0.0d;
int n=0;
	StringTokenizer tokenTO2 = new StringTokenizer(choice_group,", ");        
	while(tokenTO2.hasMoreTokens()) {
        String sql5="select * from purchase_apply where purchase_tag='1' and id='"+tokenTO2.nextToken()+"'";
		ResultSet rs5=purchase_db.executeQuery(sql5) ;
		if(rs5.next()){
			n++;
		}
		}
if(n==0){

int p=0;
double demand_amount_sum=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")){
		if(!validata.validata(demand_amount[i])){
			p++;
		}else{
			demand_amount_sum+=Double.parseDouble(demand_amount[i]);
		}
	}
	if(!demand_price[i].equals("")){
		StringTokenizer tokenTO1 = new StringTokenizer(demand_price[i],",");        
		String demand_price2="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_price1 = tokenTO1.nextToken();
		demand_price2+=demand_price1;
		}
		if(!validata.validata(demand_price2)||Double.parseDouble(demand_price2)<0){
			p++;
		}	
	}
}
if(p==0){
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);


demand_amount_sum=0.0d;
double demand_cost_price_sum=0.0d;
int m=0;
int q=0;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&!demand_price[i].equals("")){
		if(Double.parseDouble(demand_amount[i])!=0){
		q++;
		}
	}
	if(!demand_amount[i].equals("")&&demand_price[i].equals("")){
		m++;
	}
}
if(q!=0&&m==0){
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")){
		if(Double.parseDouble(demand_amount[i])!=0){
		demand_amount_sum+=Double.parseDouble(demand_amount[i]);
		}
	}
}
if(demand_amount_sum==Double.parseDouble(amount)){
	StringTokenizer tokenTO = new StringTokenizer(choice_group,", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update purchase_apply set purchase_tag='1' where id='"+tokenTO.nextToken()+"'";
		purchase_db.executeUpdate(sql4) ;
		}
	
	String purchase_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
	 
	m=1;
demand_amount_sum=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&Double.parseDouble(demand_amount[i])!=0){
		StringTokenizer tokenTO1 = new StringTokenizer(demand_price[i],",");        
		String demand_price2="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_price1 = tokenTO1.nextToken();
		demand_price2+=demand_price1;
		}
		double amount8=Double.parseDouble(demand_amount[i]);
		demand_amount_sum+=amount8;
		double subtotal=amount8*Double.parseDouble(demand_price2);
		demand_cost_price_sum+=subtotal;
		String sql="insert into purchase_details(purchase_ID,details_number,provider_ID,provider_name,demand_contact_person,demand_contact_person_tel,demand_amount,demand_price,demand_cost_price_sum,demand_gather_time) values('"+purchase_ID+"','"+m+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+contact_person[i]+"','"+provider_tel[i]+"','"+amount8+"','"+demand_price2+"','"+subtotal+"','"+demand_gather_time[i]+"')";
		purchase_db.executeUpdate(sql);
		m++;
	}
}
double price=demand_cost_price_sum/demand_amount_sum;
String sql1="insert into purchase_purchase(purchase_ID,product_ID,product_name,register,register_time,demand_amount,demand_price,demand_cost_price_sum,pay_ID_group,apply_ID_group,check_tag) values('"+purchase_ID+"','"+product_ID+"','"+product_name+"','"+register+"','"+register_time+"','"+demand_amount_sum+"','"+price+"','"+demand_cost_price_sum+"','"+pay_ID_group+"','"+choice_group+"','1')";
purchase_db.executeUpdate(sql1);

List rsList = GetWorkflow.getList(purchase_db, "purchase_config_workflow", "06");

    if(rsList.size()==0){
		
	int record_number=0;
	String sql98="select count(*) from purchase_details where purchase_ID='"+purchase_ID+"'";
	ResultSet rs98=purchase_db.executeQuery(sql98) ;
	while(rs98.next()){
		record_number=rs98.getInt("count(*)");
	}
	double list_price_sum=Double.parseDouble(list_price)*Double.parseDouble(demand_amount1);
	String sql = "update purchase_purchase set list_price_sum='"+list_price_sum+"',list_price='"+list_price+"',checker='"+register+"',check_time='"+register_time+"',check_tag='2',purchase_tag='1',invoice_tag='1',gather_tag='1',stock_gather_tag='1',pay_tag='1' where purchase_ID='"+purchase_ID+"'" ;
	purchase_db.executeUpdate(sql) ;

    String sql9="select * from purchase_details where purchase_ID='"+purchase_ID+"'";
	ResultSet rs9=purchase_db.executeQuery(sql9) ;
	while(rs9.next()){
    if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",purchase_ID)<record_number){
    	String gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));	
 
		String sql5="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price,cost_price_sum,register,register_time) values('"+gather_ID+"','采购入库','"+purchase_ID+"','"+rs9.getString("provider_name")+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_price")+"','"+rs9.getString("demand_cost_price_sum")+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql5) ;
		String sql6="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,amount,ungather_amount,cost_price,subtotal) values('"+gather_ID+"','1','"+product_ID+"','"+product_name+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_price")+"','"+rs9.getString("demand_cost_price_sum")+"')";
		stock_db.executeUpdate(sql6) ;
	}
	}
	String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));
	
	String sql99="select * from purchase_details where purchase_ID='"+purchase_ID+"'";
	ResultSet rs99=purchase_db.executeQuery(sql99) ;
	while(rs99.next()){
		String chain_id="";
		String chain_name="";
		String purchaser_ID="";
		String purchaser="";
		String sql15="select * from purchase_file where provider_ID='"+rs99.getString("provider_ID")+"'";
		ResultSet rs15=purchase_db1.executeQuery(sql15);
		if(rs15.next()){
			chain_id=rs15.getString("chain_id");
			chain_name=rs15.getString("chain_name");
			purchaser_ID=rs15.getString("purchaser_ID");
			purchaser=rs15.getString("purchaser");
			if(rs99.getDouble("demand_cost_price_sum")>=0){
			double trade_amount=rs15.getDouble("trade_amount")+1;
			double trade_sum=rs15.getDouble("achievement_sum")+rs99.getDouble("demand_cost_price_sum");
			String sql90="update purchase_file set trade_amount='"+trade_amount+"',achievement_sum='"+trade_sum+"' where provider_ID='"+rs99.getString("provider_ID")+"'";
			purchase_db1.executeUpdate(sql90) ;
			}else{
			double return_amount=rs15.getDouble("return_amount")+1;
			double trade_sum=rs15.getDouble("achievement_sum")+rs99.getDouble("demand_cost_price_sum");
			double return_sum=rs15.getDouble("return_sum")+rs99.getDouble("demand_cost_price_sum");
			String sql90="update purchase_file set return_amount='"+return_amount+"',achievement_sum='"+trade_sum+"',return_sum='"+return_sum+"' where provider_ID='"+rs99.getString("provider_ID")+"'";
			purchase_db1.executeUpdate(sql90) ;
			}
		}
		if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",purchase_ID)<record_number){
		String sql12="insert into fund_fund(fund_ID,reason,reasonexact,chain_id,chain_name,funder,funder_ID,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register,register_time,sales_purchaser_ID,sales_purchaser_name,qcs_dealwith_tag) values('"+fund_ID+"','付款','"+purchase_ID+"','"+chain_id+"','"+chain_name+"','"+rs99.getString("provider_name")+"','"+rs99.getString("provider_ID")+"','2121','应付账款','"+rs99.getString("demand_cost_price_sum")+"','人民币','元','"+register+"','"+register_time+"','"+purchaser_ID+"','"+purchaser+"','0')";
		fund_db.executeUpdate(sql12);
		}
}
}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		String sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+purchase_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		purchase_db.executeUpdate(sql);
		}
	}
response.sendRedirect("purchase/purchase/register_choose.jsp?purchase_ID="+purchase_ID+"");
	}else{
	response.sendRedirect("purchase/purchase/register_ok_b.jsp");
	}
	}else{
		response.sendRedirect("purchase/purchase/register_ok_b.jsp");
		}
  }else{
		response.sendRedirect("purchase/purchase/register_ok_c.jsp");
	  }
}else{
	response.sendRedirect("purchase/purchase/register_ok_d.jsp");
}
	purchase_db.commit();
	stock_db.commit();
	purchase_db1.commit();
	fund_db.commit();
	purchase_db.close();
	stock_db.close();
	purchase_db1.close();
	fund_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 