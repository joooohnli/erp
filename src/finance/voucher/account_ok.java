/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.voucher;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.exchange;
import validata.ValidataFinanceTag;
import validata.ValidataTag;
import include.get_name_from_ID.*;

public class account_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 financedb = new nseer_db_backup1(dbApplication);
ValidataTag vt=new ValidataTag();
ValidataFinanceTag vft=new ValidataFinanceTag();
getMultiNameFromID getNameFromID=new getMultiNameFromID();
try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))&&financedb.conn((String)dbSession.getAttribute("unit_db_name"))){
double debit=0.0d;
double loan=0.0d;
double current_balance_sum=0.0d;
double debit_amount=0.0d;
double loan_amount=0.0d;
double current_balance_amount=0.0d;
int file_count=0;
int step=7;
String file_id="";
String sql1="";
String sql3="";
String debit_or_loan="";
String corr_stock_tag="";
int start=0;
int end=13;
int account_period=0;
String[] file_id_group=new String[1];
String voucher_in_month_id=request.getParameter("voucher_in_month_ID") ;
String register_time=exchange.unURL(request.getParameter("register_time"));
String account_period1=exchange.unURL(request.getParameter("account_period"));

String register=(String)session.getAttribute("realeditorc");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String check_time=formatter.format(now);
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"finance_account_period","account_period",account_period1,"account_finished_tag").equals("0")){

if(!vft.validata((String)dbSession.getAttribute("unit_db_name"),"finance_voucher","voucher_in_month_id",voucher_in_month_id,"register_time",register_time,"account_tag").equals("1")){
	String sql="select * from finance_voucher where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"' order by details_number";
	ResultSet rs=finance_db.executeQuery(sql);
	while(rs.next()){
		file_id=rs.getString("chain_id").substring(4);
		file_count=file_id.length()/3;
		file_id_group=new String[file_count+1];
		file_id_group[0]=rs.getString("chain_id").substring(0,4);
		start=0;
		end=13;
		for(int i=1;i<=file_count;i++){
			file_id_group[i]=rs.getString("chain_id").substring(0,step);
			step+=3;
		}
		step=7;
		for(int i=0;i<file_id_group.length;i++){
		sql3="select debit_or_loan,corr_stock_tag from finance_config_file_kind where file_id='"+file_id_group[i]+"'";
		ResultSet rs3=financedb.executeQuery(sql3);
		if(rs3.next()){
			debit_or_loan=rs3.getString("debit_or_loan");
			corr_stock_tag=rs3.getString("corr_stock_tag");
		}
		String[] name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),file_id_group[i]);
		sql3="select * from finance_gl where file_id='"+file_id_group[i]+"' and account_period='"+rs.getString("account_period")+"'";
		rs3=financedb.executeQuery(sql3);
		
		if(rs3.next()){	if(rs3.getString("debit_or_loan").equals("借")&&rs3.getString("corr_stock_tag").equals("是")){
				debit=rs3.getDouble("debit_year_sum")+rs.getDouble("debit_subtotal");
				loan=rs3.getDouble("loan_year_sum")+rs.getDouble("loan_subtotal");
				current_balance_sum=rs3.getDouble("last_year_balance_sum")+debit-loan;
				if(rs.getDouble("debit_subtotal")!=0){
					debit_amount=rs3.getDouble("debit_year_amount")+rs.getDouble("product_amount");
					loan_amount=rs3.getDouble("loan_year_amount");
				}else{
					debit_amount=rs3.getDouble("debit_year_amount");
					loan_amount=rs3.getDouble("loan_year_amount")+rs.getDouble("product_amount");
				}
				current_balance_amount=rs3.getDouble("last_year_balance_amount")+debit_amount-loan_amount;
				if(current_balance_sum<0){
					current_balance_amount=-current_balance_amount;
				}
				sql1="update finance_gl set debit_year_sum='"+debit+"',loan_year_sum='"+loan+"',current_balance_sum='"+current_balance_sum+"',debit_year_amount='"+debit_amount+"',loan_year_amount='"+loan_amount+"',current_balance_amount='"+current_balance_amount+"' where file_id='"+file_id_group[i]+"' and account_period='"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
				sql1="update finance_gl set last_year_balance_sum='"+current_balance_sum+"',current_balance_sum='"+current_balance_sum+"',last_year_balance_amount='"+current_balance_amount+"',current_balance_amount='"+current_balance_amount+"' where file_id='"+file_id_group[i]+"' and account_period>'"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
			}else if(rs3.getString("debit_or_loan").equals("借")&&rs3.getString("corr_stock_tag").equals("否")){
				debit=rs3.getDouble("debit_year_sum")+rs.getDouble("debit_subtotal");
				loan=rs3.getDouble("loan_year_sum")+rs.getDouble("loan_subtotal");
				current_balance_sum=rs3.getDouble("last_year_balance_sum")+debit-loan;
				sql1="update finance_gl set debit_year_sum='"+debit+"',loan_year_sum='"+loan+"',current_balance_sum='"+current_balance_sum+"' where file_id='"+file_id_group[i]+"' and account_period='"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
				sql1="update finance_gl set last_year_balance_sum='"+current_balance_sum+"',current_balance_sum='"+current_balance_sum+"' where file_id='"+file_id_group[i]+"' and account_period>'"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
			}else if(rs3.getString("debit_or_loan").equals("贷")&&rs3.getString("corr_stock_tag").equals("是")){
				debit=rs3.getDouble("debit_year_sum")+rs.getDouble("debit_subtotal");
				loan=rs3.getDouble("loan_year_sum")+rs.getDouble("loan_subtotal");
				current_balance_sum=rs3.getDouble("last_year_balance_sum")+loan-debit;
				if(rs.getDouble("debit_subtotal")!=0){
					debit_amount=rs3.getDouble("debit_year_amount")+rs.getDouble("product_amount");
					loan_amount=rs3.getDouble("loan_year_amount");
				}else{
					debit_amount=rs3.getDouble("debit_year_amount");
					loan_amount=rs3.getDouble("loan_year_amount")+rs.getDouble("product_amount");
				}
				current_balance_amount=rs3.getDouble("last_year_balance_amount")+loan_amount-debit_amount;
				if(current_balance_sum<0){
					current_balance_amount=-current_balance_amount;
				}
				sql1="update finance_gl set debit_year_sum='"+debit+"',loan_year_sum='"+loan+"',current_balance_sum='"+current_balance_sum+"',debit_year_amount='"+debit_amount+"',loan_year_amount='"+loan_amount+"',current_balance_amount='"+current_balance_amount+"' where file_id='"+file_id_group[i]+"' and account_period='"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
				sql1="update finance_gl set last_year_balance_sum='"+current_balance_sum+"',current_balance_sum='"+current_balance_sum+"',last_year_balance_amount='"+current_balance_amount+"',current_balance_amount='"+current_balance_amount+"' where file_id='"+file_id_group[i]+"' and account_period>'"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
			}else if(rs3.getString("debit_or_loan").equals("贷")&&rs3.getString("corr_stock_tag").equals("否")){
				debit=rs3.getDouble("debit_year_sum")+rs.getDouble("debit_subtotal");
				loan=rs3.getDouble("loan_year_sum")+rs.getDouble("loan_subtotal");
				current_balance_sum=rs3.getDouble("last_year_balance_sum")+loan-debit;
				sql1="update finance_gl set debit_year_sum='"+debit+"',loan_year_sum='"+loan+"',current_balance_sum='"+current_balance_sum+"' where file_id='"+file_id_group[i]+"' and account_period='"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
				sql1="update finance_gl set last_year_balance_sum='"+current_balance_sum+"',current_balance_sum='"+current_balance_sum+"' where file_id='"+file_id_group[i]+"' and account_period>'"+rs.getString("account_period")+"'";
				financedb.executeUpdate(sql1);
			}
			}else{
				if(debit_or_loan.equals("借")&&corr_stock_tag.equals("是")){
				debit=rs.getDouble("debit_subtotal");
				loan=rs.getDouble("loan_subtotal");
				current_balance_sum=debit-loan;
				if(rs.getDouble("debit_subtotal")!=0){
					debit_amount=rs.getDouble("product_amount");
					loan_amount=0.0d;
				}else{
					debit_amount=0.0d;
					loan_amount=rs.getDouble("product_amount");
				}
				current_balance_amount=debit_amount-loan_amount;
				if(current_balance_sum<0){
					current_balance_amount=-current_balance_amount;
				}
				account_period=start;
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==rs.getInt("account_period")) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','0.00','0.00','0.00','0.00','0.00','0.00','0.00','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}
				sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','"+debit+"','"+loan+"','"+current_balance_sum+"','0.00','"+debit_amount+"','"+loan_amount+"','"+current_balance_amount+"','"+rs.getString("account_period")+"','"+corr_stock_tag+"')";
				financedb.executeUpdate(sql1);
				account_period=rs.getInt("account_period");
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==end) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+current_balance_sum+"','0.00','0.00','"+current_balance_sum+"','"+current_balance_amount+"','0.00','0.00','"+current_balance_amount+"','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}
			}else if(debit_or_loan.equals("借")&&corr_stock_tag.equals("否")){
				debit=rs.getDouble("debit_subtotal");
				loan=rs.getDouble("loan_subtotal");
				current_balance_sum=debit-loan;
				account_period=start;
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==rs.getInt("account_period")) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','0.00','0.00','0.00','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}
				sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','"+debit+"','"+loan+"','"+current_balance_sum+"','"+rs.getString("account_period")+"','"+corr_stock_tag+"')";
				financedb.executeUpdate(sql1);
				account_period=rs.getInt("account_period");
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==end) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+current_balance_sum+"','0.00','0.00','"+current_balance_sum+"','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}

			}else if(debit_or_loan.equals("贷")&&corr_stock_tag.equals("是")){
				debit=rs.getDouble("debit_subtotal");
				loan=rs.getDouble("loan_subtotal");
				current_balance_sum=loan-debit;
				if(rs.getDouble("debit_subtotal")!=0){
					debit_amount=rs.getDouble("product_amount");
					loan_amount=0.0d;
				}else{
					debit_amount=0.0d;
					loan_amount=rs.getDouble("product_amount");
				}
				current_balance_amount=loan_amount-debit_amount;
				if(current_balance_sum<0){
					current_balance_amount=-current_balance_amount;
				}
				account_period=start;
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==rs.getInt("account_period")) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','0.00','0.00','0.00','0.00','0.00','0.00','0.00','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}
				sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','"+debit+"','"+loan+"','"+current_balance_sum+"','0.00','"+debit_amount+"','"+loan_amount+"','"+current_balance_amount+"','"+rs.getString("account_period")+"','"+corr_stock_tag+"')";
				financedb.executeUpdate(sql1);
				account_period=rs.getInt("account_period");
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==end) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+current_balance_sum+"','0.00','0.00','"+current_balance_sum+"','"+current_balance_amount+"','0.00','0.00','"+current_balance_amount+"','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}

			}else if(debit_or_loan.equals("贷")&&corr_stock_tag.equals("否")){
				debit=rs.getDouble("debit_subtotal");
				loan=rs.getDouble("loan_subtotal");
				current_balance_sum=loan-debit;
				account_period=start;
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==rs.getInt("account_period")) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','0.00','0.00','0.00','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}
				sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','0.00','"+debit+"','"+loan+"','"+current_balance_sum+"','"+rs.getString("account_period")+"','"+corr_stock_tag+"')";
				financedb.executeUpdate(sql1);
				account_period=rs.getInt("account_period");
				for(int j=0;j<12;j++){
					account_period=account_period+1;
					if(account_period==end) break;
					sql1="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period,corr_stock_tag) values('"+file_id_group[i]+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+current_balance_sum+"','0.00','0.00','"+current_balance_sum+"','"+account_period+"','"+corr_stock_tag+"')";
					financedb.executeUpdate(sql1);
				}
			}
		}
	}
}

sql3 = "update finance_voucher set accounter='"+register+"',account_time='"+check_time+"',account_tag='1' where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"'" ;
	financedb.executeUpdate(sql3) ;
	sql3 = "update finance_cash_table set account_tag='1' where voucher_in_month_id='"+voucher_in_month_id+"' and register_time='"+register_time+"'" ;
	financedb.executeUpdate(sql3) ;

response.sendRedirect("finance/voucher/account_ok_a.jsp");
}else{
response.sendRedirect("finance/voucher/account_ok_b.jsp");
}
}else{
response.sendRedirect("finance/voucher/account_ok_c.jsp");
}

financedb.commit();
finance_db.commit();
finance_db.close();
financedb.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch (Exception ex){
ex.printStackTrace();
}
}
}