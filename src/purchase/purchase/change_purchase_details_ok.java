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
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;
import stock.getAvailable;

public class change_purchase_details_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataRecord vr=new ValidataRecord();
getAvailable available=new getAvailable();


java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
double amount1=0.0d;
double cost_price_sum=0.0d;
String purchase_ID=request.getParameter("purchase_ID") ;
String demand_gather_shipFee_sum2=request.getParameter("demand_gather_shipFee_sum") ;
String demand_amount=request.getParameter("demand_amount") ;
if(demand_gather_shipFee_sum2.equals("")) demand_gather_shipFee_sum2="0";
int n=0;
if(!validata.validata(demand_amount)){
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
String demand_old_amount="" ;
String demand_old_cost_price_sum="";
String sql18="select * from purchase_details where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID+"'";
ResultSet rs18=purchase_db.executeQuery(sql18) ;
if(rs18.next()){
	demand_old_amount=rs18.getString("demand_amount");
	demand_old_cost_price_sum=rs18.getString("demand_cost_price_sum");
}
String gathered_amount=request.getParameter("gathered_amount") ;
String demand_price2=request.getParameter("demand_price") ;
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
String sql1="select sum(demand_amount) as sum1,sum(demand_cost_price_sum) as sum2 from purchase_details where purchase_ID='"+purchase_ID+"' and provider_ID!='"+provider_ID+"'";
ResultSet rs1=purchase_db.executeQuery(sql1) ;
while(rs1.next()){
	amount1=rs1.getDouble("sum1");
	cost_price_sum=rs1.getDouble("sum2");
}
double amount2=amount1+Double.parseDouble(demand_amount);
double amount3=Double.parseDouble(demand_old_amount)-Double.parseDouble(demand_amount);
double amount33=amount3;
	String gather_ID="";
String sql22="select * from stock_gather where reasonexact='"+purchase_ID+"'";
	ResultSet rs22=stock_db.executeQuery(sql22) ;
	while(rs22.next()){
		gather_ID=rs22.getString("gather_ID");
	}
String sql16="select * from stock_pre_gathering where gather_ID='"+gather_ID+"' order by details_number";
	ResultSet rs16=stock_db.executeQuery(sql16) ;
	while(rs16.next()&&amount33>0){
		double amount10=new Double(rs16.getDouble("max_capacity_amount")*available.available((String)dbSession.getAttribute("unit_db_name"),rs16.getString("stock_name"))).intValue();
		double amount8=rs16.getDouble("ungather_amount")-amount33;
		if(amount8<=amount10){
		amount33=0;
		}else{
		amount33=amount33+amount10-rs16.getDouble("ungather_amount");
		}
	}
	double aaa=Double.parseDouble(demand_amount)-Double.parseDouble(gathered_amount);
if((Double.parseDouble(demand_old_amount)>=0&&Double.parseDouble(demand_amount)>=Double.parseDouble(gathered_amount)&&Double.parseDouble(demand_amount)<=Double.parseDouble(demand_old_amount))||(Double.parseDouble(demand_old_amount)<0&&Double.parseDouble(demand_amount)<=Double.parseDouble(gathered_amount))){

	String sql = "update purchase_details set designer='"+designer+"',demand_contact_person='"+contact_person+"',demand_contact_person_tel='"+provider_tel+"',demand_gather_time='"+demand_gather_time+"',demand_gather_type='"+demand_gather_type+"',demand_gather_shipFee_type='"+demand_gather_shipFee_type+"',demand_gather_shipFee_sum='"+demand_gather_shipFee_sum+"',demand_pay_type='"+demand_pay_type+"',demand_pay_method='"+demand_pay_method+"',demand_invoice_type='"+demand_invoice_type+"',demand_amount='"+demand_amount+"',demand_price='"+demand_price+"',demand_cost_price_sum='"+demand_cost_price_sum+"',credit_period='"+credit_period+"',remark='"+remark+"',check_tag='0',invoice_tag='0',invoice_check_tag='0',gather_tag='0',gather_check_tag='0' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID+"'";
	purchase_db.executeUpdate(sql) ;
	String sql45 = "update purchase_purchasing set demand_cost_price_sum='"+demand_cost_price_sum+"' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID+"' and kind='发票' and check_tag='0'";
	purchase_db.executeUpdate(sql45) ;
	String sql44 = "update purchase_purchasing set demand_amount='"+demand_amount+"' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID+"' and kind='质检' and check_tag='0'";
	purchase_db.executeUpdate(sql44) ;
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","register_time",time)){
	if(Double.parseDouble(demand_old_cost_price_sum)!=demand_cost_price_sum){
	double sale_price_sum_new=demand_cost_price_sum-Double.parseDouble(demand_old_cost_price_sum);
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"fundfundcount");
	String fund_ID="L"+filenum;
	count.write((String)dbSession.getAttribute("unit_db_name"),"fundfundcount",filenum);
		String chain_id="";
		String chain_name="";		
		String purchaser_ID="";
		String purchaser="";
		String sql15="select * from purchase_file where provider_ID='"+provider_ID+"'";
		ResultSet rs15=purchase_db.executeQuery(sql15);
		if(rs15.next()){
			chain_id=rs15.getString("chain_id");
			chain_name=rs15.getString("chain_name");
			purchaser_ID=rs15.getString("purchaser_ID");
			purchaser=rs15.getString("purchaser");
		}
	String sql12="insert into fund_fund(fund_ID,reason,reasonexact,chain_id,chain_name,funder,funder_ID,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register_time,sales_purchaser_ID,sales_purchaser_name) values('"+fund_ID+"','付款','"+purchase_ID+"','"+chain_id+"','"+chain_name+"','"+provider_name+"','"+provider_ID+"','2121','应付账款','"+sale_price_sum_new+"','人民币','元','"+time+"','"+purchaser_ID+"','"+purchaser+"')";
	fund_db.executeUpdate(sql12) ;
	}
/*}else if(Double.parseDouble(demand_old_cost_price_sum)>sale_price_sum){
	double sale_price_sum_new=Double.parseDouble(demand_old_cost_price_sum)-demand_cost_price_sum;
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"fundfundcount");
	String fund_ID="B"+filenum;
	count.write((String)dbSession.getAttribute("unit_db_name"),"fundfundcount",filenum);
	String sql14="insert into fund(fund_ID,reason,reasonexact,funder,funder_ID,file_first_kind_ID,file_first_kind_name,file_second_kind_ID,file_second_kind_name,demand_cost_price_sum,currency_name,personal_unit,register_time) values('"+fund_ID+"','收款','"+purchase_ID+"','"+provider_name+"','"+provider_ID+"','1131','应收账款','113102','采购退款','"+sale_price_sum_new+"','人民币','元','"+time+"')";
	fund_db.executeUpdate(sql14) ;
}*/
}
	
	cost_price_sum=cost_price_sum+demand_cost_price_sum;
String sql19="select * from purchase_purchase where purchase_ID='"+purchase_ID+"'";
ResultSet rs19=purchase_db.executeQuery(sql19) ;
	if(rs19.next()){
		double amount7=rs19.getDouble("demand_amount")-amount3;
		double list_price_sum=rs19.getDouble("list_price")*amount7;
	String sql9 = "update purchase_purchase set demand_amount='"+amount7+"',list_price_sum='"+list_price_sum+"',demand_cost_price_sum='"+cost_price_sum+"' where purchase_ID='"+purchase_ID+"'"; 
	purchase_db.executeUpdate(sql9) ;
}
	String sql2="select * from stock_gather where reasonexact='"+purchase_ID+"' and reasonexact_details='"+provider_name+"'";
	ResultSet rs2=stock_db.executeQuery(sql2) ;
	if(rs2.next()){
		gather_ID=rs2.getString("gather_ID");
		double amount4=rs2.getDouble("demand_amount")-amount3;
		double cost_price_sum4=rs2.getDouble("cost_price_sum")-Double.parseDouble(demand_price)*amount3;
		String sql3="update stock_gather set demand_amount='"+amount4+"',cost_price_sum='"+cost_price_sum4+"' where reasonexact='"+purchase_ID+"' and reasonexact_details='"+provider_name+"'";
		stock_db.executeUpdate(sql3) ;
	}
	String sql4="select * from stock_gather_details where gather_ID='"+gather_ID+"'";
	ResultSet rs4=stock_db.executeQuery(sql4) ;
	if(rs4.next()){
		double amount5=rs4.getDouble("amount")-amount3;
		String sql5="update stock_gather_details set amount='"+amount5+"' where gather_ID='"+gather_ID+"'";
		stock_db.executeUpdate(sql5) ;
	}
try{
	String sql6="select * from stock_pre_gathering where gather_ID='"+gather_ID+"' order by details_number";
	ResultSet rs6=stock_db.executeQuery(sql6) ;
	while(rs6.next()&&amount3!=0){
		if(amount3>0){//数量减少时，循环减少库房应入库数量，直到变化数量(amount3)为0
		double amount6=rs6.getDouble("ungather_amount")-amount3;
		if(amount6>=0){
			double amount11=rs6.getDouble("amount")-amount3;
		String sql7="update stock_pre_gathering set amount='"+amount11+"',ungather_amount='"+amount6+"' where gather_ID='"+gather_ID+"' and details_number='"+rs6.getString("details_number")+"'";
		stock_db1.executeUpdate(sql7) ;
		amount3=0;
		}else{
			double amount12=rs6.getDouble("amount")-rs6.getDouble("ungather_amount");
		String sql8="update stock_pre_gathering set amount='"+amount12+"',ungather_amount='0' where gather_ID='"+gather_ID+"' and details_number='"+rs6.getString("details_number")+"'";
		stock_db1.executeUpdate(sql8) ;
		amount3=amount3-rs6.getDouble("amount");
		}
		}else{//数量增加时（amount3<0），循环增加库房应入库数量，增加时判断是否超过当前可存放数量，直到变化数量(amount3)为0
		double amount10=new Double(rs6.getDouble("max_capacity_amount")*available.available((String)dbSession.getAttribute("unit_db_name"),rs6.getString("stock_name"))).intValue();
		double amount8=rs6.getDouble("ungather_amount")-amount3;
		if(amount8<=amount10){
			double amount13=rs6.getDouble("amount")-amount3;
		String sql7="update stock_pre_gathering set amount='"+amount13+"',ungather_amount='"+amount8+"' where gather_ID='"+gather_ID+"' and details_number='"+rs6.getString("details_number")+"'";
		stock_db1.executeUpdate(sql7) ;
		amount3=0;
		}else{
			double amount14=rs6.getDouble("amount")+amount10-rs6.getDouble("ungather_amount");
		String sql8="update stock_pre_gathering set amount='"+amount14+"',ungather_amount='"+amount10+"' where gather_ID='"+gather_ID+"' and details_number='"+rs6.getString("details_number")+"'";
		stock_db1.executeUpdate(sql8) ;
		amount3=amount3+amount10-rs6.getDouble("ungather_amount");
		}
		}
	}
		
		response.sendRedirect("purchase/purchase/change_choose_attachment.jsp?provider_ID="+provider_ID+"&&purchase_ID="+purchase_ID+"");
}
catch (Exception ex){
	ex.printStackTrace();
}
	}else{
	response.sendRedirect("purchase/purchase/change_purchase_details_ok_b.jsp?purchase_ID="+purchase_ID+"");
}
}else{
	response.sendRedirect("purchase/purchase/change_purchase_details_ok_c.jsp?purchase_ID="+purchase_ID+"");
}
	purchase_db.commit();	
	stock_db.commit();
		fund_db.commit();
		stock_db1.commit();
		purchase_db.close();
		stock_db.close();
		fund_db.close();
		stock_db1.close();

}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 