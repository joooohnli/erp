/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.config.account_init;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import java.util.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import include.get_name_from_ID.getMultiNameFromID;
import include.nseer_cookie.exchangeString;
import validata.ValidataNumbers;

public class register_init_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
getMultiNameFromID getNameFromID=new getMultiNameFromID();

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String[] data_arr=new String[4];
int j=0;
String data=request.getParameter("data");
String amount_tag=request.getParameter("amount_tag");
String start_tag=request.getParameter("start_tag");
String[] account_period=new String[12];
String sql1="select account_period from finance_account_period order by account_period";
ResultSet rs1=finance_db.executeQuery(sql1);
while(rs1.next()){
	account_period[j]=rs1.getString("account_period");
	j++;
}
if(start_tag.equals("1")){
if(amount_tag.equals("0")){
StringTokenizer token=new StringTokenizer(data,"♀");
while(token.hasMoreTokens()){
	StringTokenizer token1=new StringTokenizer(token.nextToken(),"㊣");
	while(token1.hasMoreTokens()){
		String file_ID=token1.nextToken();
		String[] name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),file_ID);
		StringTokenizer token2=new StringTokenizer(token1.nextToken(),"◎");
		while(token2.hasMoreTokens()){
			for(int i=0;i<4;i++){
				data_arr[i]=token2.nextToken();
			}
			String sql="select * from finance_gl where file_id='"+file_ID+"'";
			ResultSet rs=finance_db.executeQuery(sql);
			if(rs.next()){
				sql="update finance_gl set last_year_balance_sum='"+data_arr[0]+"',debit_year_sum='"+data_arr[1]+"',loan_year_sum='"+data_arr[2]+"',current_balance_sum='"+data_arr[3]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[0]+"'";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="update finance_gl set last_year_balance_sum='"+data_arr[3]+"',current_balance_sum='"+data_arr[3]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[i]+"'";
					finance_db.executeUpdate(sql);
				}
			}else{
				sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[0]+"','"+data_arr[1]+"','"+data_arr[2]+"','"+data_arr[3]+"','"+account_period[0]+"')";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[3]+"','0.00','0.00','"+data_arr[3]+"','"+account_period[i]+"')";
					finance_db.executeUpdate(sql);
				}
			}
		}
	}
}
}else{
StringTokenizer token=new StringTokenizer(data,"♀");
while(token.hasMoreTokens()){
	StringTokenizer token1=new StringTokenizer(token.nextToken(),"㊣");
	while(token1.hasMoreTokens()){
		String file_ID=token1.nextToken();
		file_ID=file_ID.substring(0,file_ID.indexOf("Amount"));
		String[] name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),file_ID);
		StringTokenizer token2=new StringTokenizer(token1.nextToken(),"◎");
		while(token2.hasMoreTokens()){
			for(int i=0;i<4;i++){
				data_arr[i]=token2.nextToken();
			}
			String sql="select * from finance_gl where file_id='"+file_ID+"'";
			ResultSet rs=finance_db.executeQuery(sql);
			if(rs.next()){
				sql="update finance_gl set last_year_balance_amount='"+data_arr[0]+"',debit_year_amount='"+data_arr[1]+"',loan_year_amount='"+data_arr[2]+"',current_balance_amount='"+data_arr[3]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[0]+"'";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="update finance_gl set last_year_balance_amount='"+data_arr[3]+"',current_balance_amount='"+data_arr[3]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[i]+"'";
					finance_db.executeUpdate(sql);
				}
			}else{
				sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[0]+"','"+data_arr[1]+"','"+data_arr[2]+"','"+data_arr[3]+"','"+account_period[0]+"')";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[3]+"','0.00','0.00','"+data_arr[3]+"','"+account_period[i]+"')";
					finance_db.executeUpdate(sql);
				}
			}
		}
	}
}
}

}else{
if(amount_tag.equals("0")){
StringTokenizer token=new StringTokenizer(data,"♀");
while(token.hasMoreTokens()){
	StringTokenizer token1=new StringTokenizer(token.nextToken(),"㊣");
	while(token1.hasMoreTokens()){
		String file_ID=token1.nextToken();
		data_arr[0]=token1.nextToken();
		String[] name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),file_ID);	
			String sql="select * from finance_gl where file_id='"+file_ID+"'";
			ResultSet rs=finance_db.executeQuery(sql);
			if(rs.next()){
				sql="update finance_gl set last_year_balance_sum='"+data_arr[0]+"',current_balance_sum='"+data_arr[0]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[0]+"'";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="update finance_gl set last_year_balance_sum='"+data_arr[0]+"',current_balance_sum='"+data_arr[0]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[i]+"'";
					finance_db.executeUpdate(sql);
				}
			}else{
				sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[0]+"','0.00','0.00','"+data_arr[0]+"','"+account_period[0]+"')";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[0]+"','0.00','0.00','"+data_arr[0]+"','"+account_period[i]+"')";
					finance_db.executeUpdate(sql);
				}
			}
		}
	}
}else{
StringTokenizer token=new StringTokenizer(data,"♀");
while(token.hasMoreTokens()){
	StringTokenizer token1=new StringTokenizer(token.nextToken(),"㊣");
	while(token1.hasMoreTokens()){
		String file_ID=token1.nextToken();
		file_ID=file_ID.substring(0,file_ID.indexOf("Amount"));
		data_arr[0]=token1.nextToken();
		String[] name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),file_ID);
			String sql="select * from finance_gl where file_id='"+file_ID+"'";
			ResultSet rs=finance_db.executeQuery(sql);
			if(rs.next()){
				sql="update finance_gl set last_year_balance_amount='"+data_arr[0]+"',debit_year_amount='0.00',loan_year_amount='0.00',current_balance_amount='"+data_arr[0]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[0]+"'";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="update finance_gl set last_year_balance_amount='"+data_arr[0]+"',current_balance_amount='"+data_arr[0]+"' where file_ID='"+file_ID+"' and account_period='"+account_period[i]+"'";
					finance_db.executeUpdate(sql);
				}
			}else{
				sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[0]+"','0.00','0.00','"+data_arr[0]+"','"+account_period[0]+"')";
				finance_db.executeUpdate(sql);
				for(int i=1;i<12;i++){
					sql="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,corr_stock_tag,last_year_balance_amount,debit_year_amount,loan_year_amount,current_balance_amount,account_period) values('"+file_ID+"','"+name[0]+"','"+name[1]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[7]+"','"+data_arr[0]+"','0.00','0.00','"+data_arr[0]+"','"+account_period[i]+"')";
					finance_db.executeUpdate(sql);
				}
			}
		}
	}
}
}
finance_db.commit();
finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception e) {
		e.printStackTrace();
	}
}
}