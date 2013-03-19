/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.account;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import include.get_name_from_ID.getNameFromID;

public class yearBegin_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 financedb = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validta=new ValidataNumber();
getNameFromID getNameFromID=new getNameFromID();

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))&&financedb.conn((String)dbSession.getAttribute("unit_db_name"))){

String sql1="select * from finance_account ";
ResultSet rs1=finance_db.executeQuery(sql1);
while(rs1.next()){


String sql2="insert into finance_history_account(FIRST_KIND_ID,FIRST_KIND_NAME,SECOND_KIND_ID,SECOND_KIND_NAME,THIRD_KIND_ID,THIRD_KIND_NAME,DEBIT_OR_LOAN,GROUP_NAME,ITEMA_NAME,ITEMB_NAME,ITEMC_NAME,DEBIT_YEAR_SUM,LOAN_YEAR_SUM,DEBIT_MONTH_SUM,LOAN_MONTH_SUM,LAST_YEAR_BALANCE_SUM,LAST_MONTH_BALANCE_SUM,CURRENT_BALANCE_SUM,FINANCE_TIME,REMARK,EXPENSE_ITEM1,EXPENSE_ITEM2,EXPENSE_ITEM3,EXPENSE_ITEM4,EXPENSE_ITEM5,EXPENSE_ITEM6,EXPENSE_ITEM7,EXPENSE_ITEM8,EXPENSE_ITEM9,EXPENSE_ITEM10,EXPENSE_ITEM11,EXPENSE_ITEM12,EXPENSE_ITEM13,EXPENSE_ITEM14,EXPENSE_ITEM15,EXPENSE_ITEM16,EXPENSE_ITEM17,EXPENSE_ITEM18,EXPENSE_ITEM19,EXPENSE_ITEM20,TAX_ITEM1,TAX_ITEM2,TAX_ITEM3,TAX_ITEM4,TAX_ITEM5,TAX_ITEM6,TAX_ITEM7,TAX_ITEM8,TAX_ITEM9,TAX_ITEM10)values('"+rs1.getString("FIRST_KIND_ID")+"','"+rs1.getString("FIRST_KIND_NAME")+"','"+rs1.getString("SECOND_KIND_ID")+"','"+rs1.getString("SECOND_KIND_NAME")+"','"+rs1.getString("THIRD_KIND_ID")+"','"+rs1.getString("THIRD_KIND_NAME")+"','"+rs1.getString("DEBIT_OR_LOAN")+"','"+rs1.getString("GROUP_NAME")+"','"+rs1.getString("ITEMA_NAME")+"','"+rs1.getString("ITEMB_NAME")+"','"+rs1.getString("ITEMC_NAME")+"','"+rs1.getString("DEBIT_YEAR_SUM")+"','"+rs1.getString("LOAN_YEAR_SUM")+"','"+rs1.getString("DEBIT_MONTH_SUM")+"','"+rs1.getString("LOAN_MONTH_SUM")+"','"+rs1.getString("LAST_YEAR_BALANCE_SUM")+"','"+rs1.getString("LAST_MONTH_BALANCE_SUM")+"','"+rs1.getString("CURRENT_BALANCE_SUM")+"','"+rs1.getString("FINANCE_TIME")+"','"+rs1.getString("REMARK")+"','"+rs1.getString("EXPENSE_ITEM1")+"','"+rs1.getString("EXPENSE_ITEM2")+"','"+rs1.getString("EXPENSE_ITEM3")+"','"+rs1.getString("EXPENSE_ITEM4")+"','"+rs1.getString("EXPENSE_ITEM5")+"','"+rs1.getString("EXPENSE_ITEM6")+"','"+rs1.getString("EXPENSE_ITEM7")+"','"+rs1.getString("EXPENSE_ITEM8")+"','"+rs1.getString("EXPENSE_ITEM9")+"','"+rs1.getString("EXPENSE_ITEM10")+"','"+rs1.getString("EXPENSE_ITEM11")+"','"+rs1.getString("EXPENSE_ITEM12")+"','"+rs1.getString("EXPENSE_ITEM13")+"','"+rs1.getString("EXPENSE_ITEM14")+"','"+rs1.getString("EXPENSE_ITEM15")+"','"+rs1.getString("EXPENSE_ITEM16")+"','"+rs1.getString("EXPENSE_ITEM17")+"','"+rs1.getString("EXPENSE_ITEM18")+"','"+rs1.getString("EXPENSE_ITEM19")+"','"+rs1.getString("EXPENSE_ITEM20")+"','"+rs1.getString("TAX_ITEM1")+"','"+rs1.getString("TAX_ITEM2")+"','"+rs1.getString("TAX_ITEM3")+"','"+rs1.getString("TAX_ITEM4")+"','"+rs1.getString("TAX_ITEM5")+"','"+rs1.getString("TAX_ITEM6")+"','"+rs1.getString("TAX_ITEM7")+"','"+rs1.getString("TAX_ITEM8")+"','"+rs1.getString("TAX_ITEM9")+"','"+rs1.getString("TAX_ITEM10")+"' ) ";

financedb.executeUpdate(sql2);
}

String sql3="select * from finance_account_details";
ResultSet rs3=finance_db.executeQuery(sql3);
while(rs3.next()){

String sql4="insert into finance_history_account_details(FIRST_KIND_ID,FIRST_KIND_NAME,SECOND_KIND_ID,SECOND_KIND_NAME,THIRD_KIND_ID,THIRD_KIND_NAME,GROUP_NAME,ITEMA_NAME,ITEMB_NAME,ITEMC_NAME,SUMMARY_TYPE,SUMMARY_CONTENT,DEBIT_OR_LOAN,VOUCHER_IN_MONTH_ID,VOUCHER_TYPE,DEBIT_PRICE,LOAN_PRICE,DEBIT_YEAR_SUM,LOAN_YEAR_SUM,DEBIT_MONTH_SUM,LOAN_MONTH_SUM,LAST_YEAR_BALANCE_SUM,LAST_MONTH_BALANCE_SUM,CURRENT_BALANCE_SUM,REMARK,REGISTER,FINANCE_TIME,CURRENT_BALANCE_AMOUNT,CURRENT_BALANCE_PRICE,DEBIT_MONTH_AMOUNT,LOAN_MONTH_AMOUNT,DEBIT_YEAR_AMOUNT,LAST_YEAR_BALANCE_AMOUNT,LAST_MONTH_BALANCE_AMOUNT,LOAN_YEAR_AMOUNT,NUMBER_IN_CASH_TABLE,CHAIN_KIND_ID,CHAIN_KIND_NAME,EXPENSE_ITEM1,EXPENSE_ITEM2,EXPENSE_ITEM3,EXPENSE_ITEM4,EXPENSE_ITEM5,EXPENSE_ITEM6,EXPENSE_ITEM7,EXPENSE_ITEM8,EXPENSE_ITEM9,EXPENSE_ITEM10,EXPENSE_ITEM11,EXPENSE_ITEM12,EXPENSE_ITEM13,EXPENSE_ITEM14,EXPENSE_ITEM15,EXPENSE_ITEM16,EXPENSE_ITEM17,EXPENSE_ITEM18,EXPENSE_ITEM19,EXPENSE_ITEM20,TAX_ITEM1,TAX_ITEM2,TAX_ITEM3,TAX_ITEM4,TAX_ITEM5,TAX_ITEM6,TAX_ITEM7,TAX_ITEM8,TAX_ITEM9,TAX_ITEM10,PROFIT_OR_COST,NEWEST_TAG,DEBIT_MONTH_SUM_SUM,LOAN_MONTH_SUM_SUM,DEBIT_MONTH_AMOUNT_SUM,LOAN_MONTH_AMOUNT_SUM,DEBIT_YEAR_AMOUNT_SUM,LOAN_YEAR_AMOUNT_SUM,NUMBER_IN_CASH1_TABLE,ITEMD_NAME,CALCULATE_PROFIT_TAG,CALCULATE_COST_TAG) values('"+rs3.getString("FIRST_KIND_ID")+"','"+rs3.getString("FIRST_KIND_NAME")+"','"+rs3.getString("SECOND_KIND_ID")+"','"+rs3.getString("SECOND_KIND_NAME")+"','"+rs3.getString("THIRD_KIND_ID")+"','"+rs3.getString("THIRD_KIND_NAME")+"','"+rs3.getString("GROUP_NAME")+"','"+rs3.getString("ITEMA_NAME")+"','"+rs3.getString("ITEMB_NAME")+"','"+rs3.getString("ITEMC_NAME")+"','"+rs3.getString("SUMMARY_TYPE")+"','"+rs3.getString("SUMMARY_CONTENT")+"','"+rs3.getString("DEBIT_OR_LOAN")+"','"+rs3.getString("VOUCHER_IN_MONTH_ID")+"','"+rs3.getString("VOUCHER_TYPE")+"','"+rs3.getString("DEBIT_PRICE")+"','"+rs3.getString("LOAN_PRICE")+"','"+rs3.getString("DEBIT_YEAR_SUM")+"','"+rs3.getString("LOAN_YEAR_SUM")+"','"+rs3.getString("DEBIT_MONTH_SUM")+"','"+rs3.getString("LOAN_MONTH_SUM")+"','"+rs3.getString("LAST_YEAR_BALANCE_SUM")+"','"+rs3.getString("LAST_MONTH_BALANCE_SUM")+"','"+rs3.getString("CURRENT_BALANCE_SUM")+"','"+rs3.getString("REMARK")+"','"+rs3.getString("REGISTER")+"','"+rs3.getString("FINANCE_TIME")+"','"+rs3.getString("CURRENT_BALANCE_AMOUNT")+"','"+rs3.getString("CURRENT_BALANCE_PRICE")+"','"+rs3.getString("DEBIT_MONTH_AMOUNT")+"','"+rs3.getString("LOAN_MONTH_AMOUNT")+"','"+rs3.getString("DEBIT_YEAR_AMOUNT")+"','"+rs3.getString("LAST_YEAR_BALANCE_AMOUNT")+"','"+rs3.getString("LAST_MONTH_BALANCE_AMOUNT")+"','"+rs3.getString("LOAN_YEAR_AMOUNT")+"','"+rs3.getString("NUMBER_IN_CASH_TABLE")+"','"+rs3.getString("CHAIN_KIND_ID")+"','"+rs3.getString("CHAIN_KIND_NAME")+"','"+rs3.getString("EXPENSE_ITEM1")+"','"+rs3.getString("EXPENSE_ITEM2")+"','"+rs3.getString("EXPENSE_ITEM3")+"','"+rs3.getString("EXPENSE_ITEM4")+"','"+rs3.getString("EXPENSE_ITEM5")+"','"+rs3.getString("EXPENSE_ITEM6")+"','"+rs3.getString("EXPENSE_ITEM7")+"','"+rs3.getString("EXPENSE_ITEM8")+"','"+rs3.getString("EXPENSE_ITEM9")+"','"+rs3.getString("EXPENSE_ITEM10")+"','"+rs3.getString("EXPENSE_ITEM11")+"','"+rs3.getString("EXPENSE_ITEM12")+"','"+rs3.getString("EXPENSE_ITEM13")+"','"+rs3.getString("EXPENSE_ITEM14")+"','"+rs3.getString("EXPENSE_ITEM15")+"','"+rs3.getString("EXPENSE_ITEM16")+"','"+rs3.getString("EXPENSE_ITEM17")+"','"+rs3.getString("EXPENSE_ITEM18")+"','"+rs3.getString("EXPENSE_ITEM19")+"','"+rs3.getString("EXPENSE_ITEM20")+"','"+rs3.getString("TAX_ITEM1")+"','"+rs3.getString("TAX_ITEM2")+"','"+rs3.getString("TAX_ITEM3")+"','"+rs3.getString("TAX_ITEM4")+"','"+rs3.getString("TAX_ITEM5")+"','"+rs3.getString("TAX_ITEM6")+"','"+rs3.getString("TAX_ITEM7")+"','"+rs3.getString("TAX_ITEM8")+"','"+rs3.getString("TAX_ITEM9")+"','"+rs3.getString("TAX_ITEM10")+"','"+rs3.getString("PROFIT_OR_COST")+"','"+rs3.getString("NEWEST_TAG")+"','"+rs3.getString("DEBIT_MONTH_SUM_SUM")+"','"+rs3.getString("LOAN_MONTH_SUM_SUM")+"','"+rs3.getString("DEBIT_MONTH_AMOUNT_SUM")+"','"+rs3.getString("LOAN_MONTH_AMOUNT_SUM")+"','"+rs3.getString("DEBIT_YEAR_AMOUNT_SUM")+"','"+rs3.getString("LOAN_YEAR_AMOUNT_SUM")+"','"+rs3.getString("NUMBER_IN_CASH1_TABLE")+"','"+rs3.getString("ITEMD_NAME")+"','"+rs3.getString("CALCULATE_PROFIT_TAG")+"','"+rs3.getString("CALCULATE_COST_TAG")+"')";
financedb.executeUpdate(sql4);
}
String sql5="select * from finance_voucher ";
ResultSet rs5=finance_db.executeQuery(sql5);
while(rs5.next()){

	String sql6="insert into finance_history_voucher(VOUCHER_IN_MONTH_ID,VOUCHER_TYPE,DEBIT_SUM,LOAN_SUM,ACCOUNTANT,ACCOUNTANT_ID,ACCOUNTER,ACCOUNTER_ID,CASHIER,CASHIER_ID,CHECKER,CHECKER_ID,REGISTER,REGISTER_ID,ATTACHMENT_AMOUNT,REMARK,CHECK_TAG,CHANGE_TAG,ACCOUNT_TAG,REGISTER_TIME,ACCOUNT_TIME,CHECK_TIME ) values('"+rs5.getString("VOUCHER_IN_MONTH_ID")+"','"+rs5.getString("VOUCHER_TYPE")+"','"+rs5.getString("DEBIT_SUM")+"','"+rs5.getString("LOAN_SUM")+"','"+rs5.getString("ACCOUNTANT")+"','"+rs5.getString("ACCOUNTANT_ID")+"','"+rs5.getString("ACCOUNTER")+"','"+rs5.getString("ACCOUNTER_ID")+"','"+rs5.getString("CASHIER")+"','"+rs5.getString("CASHIER_ID")+"','"+rs5.getString("CHECKER")+"','"+rs5.getString("CHECKER_ID")+"','"+rs5.getString("REGISTER")+"','"+rs5.getString("REGISTER_ID")+"','"+rs5.getString("ATTACHMENT_AMOUNT")+"','"+rs5.getString("REMARK")+"','"+rs5.getString("CHECK_TAG")+"','"+rs5.getString("CHANGE_TAG")+"','"+rs5.getString("ACCOUNT_TAG")+"','"+rs5.getString("REGISTER_TIME")+"','"+rs5.getString("ACCOUNT_TIME")+"','"+rs5.getString("CHECK_TIME")+"' )";
	financedb.executeUpdate(sql6);
}
String sql7="select * from finance_voucher_details ";
ResultSet rs7=finance_db.executeQuery(sql7);
while(rs7.next()){

	String sql8="insert into finance_history_voucher_details(VOUCHER_ID,FIRST_KIND_ID,FIRST_KIND_NAME,SECOND_KIND_ID,SECOND_KIND_NAME,THIRD_KIND_ID,THIRD_KIND_NAME,SUMMARY_TYPE,SUMMARY_CONTENT,VOUCHER_IN_MONTH_ID,ATTACHMENT_ID,PRODUCT_AMOUNT,PRODUCT_PRICE,DEBIT_SUBTOTAL,LOAN_SUBTOTAL,REMARK,GROUP_NAME,DEBIT_OR_LOAN,ITEMA_NAME,ITEMB_NAME,ITEMC_NAME,BALANCE_SUM,BALANCE_AMOUNT,DEBIT_AMOUNT,LOAN_AMOUNT,REGISTER_TIME,CHECK_TIME,DEBIT_PRICE,LOAN_PRICE,NUMBER_IN_CASH_TABLE,CHAIN_KIND_ID,CHAIN_KIND_NAME ) values('"+rs7.getString("VOUCHER_ID")+"','"+rs7.getString("FIRST_KIND_ID")+"','"+rs7.getString("FIRST_KIND_NAME")+"','"+rs7.getString("SECOND_KIND_ID")+"','"+rs7.getString("SECOND_KIND_NAME")+"','"+rs7.getString("THIRD_KIND_ID")+"','"+rs7.getString("THIRD_KIND_NAME")+"','"+rs7.getString("SUMMARY_TYPE")+"','"+rs7.getString("SUMMARY_CONTENT")+"','"+rs7.getString("VOUCHER_IN_MONTH_ID")+"','"+rs7.getString("ATTACHMENT_ID")+"','"+rs7.getString("PRODUCT_AMOUNT")+"','"+rs7.getString("PRODUCT_PRICE")+"','"+rs7.getString("DEBIT_SUBTOTAL")+"','"+rs7.getString("LOAN_SUBTOTAL")+"','"+rs7.getString("REMARK")+"','"+rs7.getString("GROUP_NAME")+"','"+rs7.getString("DEBIT_OR_LOAN")+"','"+rs7.getString("ITEMA_NAME")+"','"+rs7.getString("ITEMB_NAME")+"','"+rs7.getString("ITEMC_NAME")+"','"+rs7.getString("BALANCE_SUM")+"','"+rs7.getString("BALANCE_AMOUNT")+"','"+rs7.getString("DEBIT_AMOUNT")+"','"+rs7.getString("LOAN_AMOUNT")+"','"+rs7.getString("REGISTER_TIME")+"','"+rs7.getString("CHECK_TIME")+"','"+rs7.getString("DEBIT_PRICE")+"','"+rs7.getString("LOAN_PRICE")+"','"+rs7.getString("NUMBER_IN_CASH_TABLE")+"','"+rs7.getString("CHAIN_KIND_ID")+"','"+rs7.getString("CHAIN_KIND_NAME")+"' )";
	financedb.executeUpdate(sql8);
}
String sql9="delete from finance_account";
financedb.executeUpdate(sql9);
String sql10="delete from finance_account_details";
financedb.executeUpdate(sql10);

String sql11="delete from finance_voucher";
financedb.executeUpdate(sql11);

String sql12="delete from finance_voucher_details";
financedb.executeUpdate(sql12);

String sql13="select * from finance_account_finished order by id desc";
ResultSet rs13=financedb.executeQuery(sql13);
rs13.next();
String account_finished_finance_time=rs13.getString("account_finished_finance_time");
String year=(Integer.parseInt(account_finished_finance_time.substring(0,4))+1)+"";
String month="-01";
String day="-01"; 
String finance_time11=year+month+day;
String finance_time22=year+month;

	String ssql="select * from finance_history_account_details where newest_tag='1' ";	

	ResultSet rrs=financedb.executeQuery(ssql);
	while(rrs.next()){

String ssql4="insert into finance_account_details(voucher_in_month_ID,first_kind_ID,first_kind_name,second_kind_ID,second_kind_name,third_kind_ID,third_kind_name,group_name,itema_name,itemb_name,itemc_name,debit_or_loan,summary_content,debit_month_sum,loan_month_sum,last_year_balance_sum,current_balance_sum,debit_month_amount,loan_month_amount,last_year_balance_amount,current_balance_amount,current_balance_price,debit_price,loan_price,register,finance_time,number_in_cash_table,chain_kind_ID,chain_kind_name,profit_or_cost,newest_tag,debit_month_sum_sum,debit_month_amount_sum,debit_year_sum,debit_year_amount,loan_month_sum_sum,loan_month_amount_sum,loan_year_sum,loan_year_amount) values('','"+rrs.getString("first_kind_ID")+"','"+rrs.getString("first_kind_name")+"','"+rrs.getString("second_kind_ID")+"','"+rrs.getString("second_kind_name")+"','"+rrs.getString("third_kind_ID")+"','"+rrs.getString("third_kind_name")+"','"+rrs.getString("group_name")+"','"+rrs.getString("itema_name")+"','"+rrs.getString("itemb_name")+"','"+rrs.getString("itemc_name")+"','"+rrs.getString("debit_or_loan")+"','上年结转','0','0','"+rrs.getDouble("current_balance_sum")+"','"+rrs.getDouble("current_balance_sum")+"','0','0','"+rrs.getDouble("current_balance_amount")+"','"+rrs.getDouble("current_balance_amount")+"','"+rrs.getDouble("current_balance_price")+"','0','0','','"+finance_time11+"','"+rrs.getString("number_in_cash_table")+"','"+rrs.getString("chain_kind_ID")+"','"+rrs.getString("chain_kind_name")+"','"+rrs.getString("profit_or_cost")+"','1','0','0','0','0','0','0','0','0')";
				finance_db.executeUpdate(ssql4);
	
}


String ssql5="select * from finance_history_account where finance_time='"+account_finished_finance_time+"' order by first_kind_ID";
ResultSet rrs5=financedb.executeQuery(ssql5);
while(rrs5.next()){

String ssql6 = "insert into finance_account(first_kind_ID,first_kind_name,second_kind_ID,second_kind_name,third_kind_ID,third_kind_name,group_name,debit_or_loan,itema_name,itemb_name,itemc_name,last_year_balance_sum,last_month_balance_sum,debit_year_sum,loan_year_sum,debit_month_sum,loan_month_sum,current_balance_sum,finance_time) values('"+rrs5.getString("first_kind_ID")+"','"+rrs5.getString("first_kind_name")+"','"+rrs5.getString("second_kind_ID")+"','"+rrs5.getString("second_kind_name")+"','"+rrs5.getString("third_kind_ID")+"','"+rrs5.getString("third_kind_name")+"','"+rrs5.getString("group_name")+"','"+rrs5.getString("debit_or_loan")+"','"+rrs5.getString("itema_name")+"','"+rrs5.getString("itemb_name")+"','"+rrs5.getString("itemc_name")+"','"+rrs5.getDouble("current_balance_sum")+"','0','0','0','0','0','"+rs5.getDouble("current_balance_sum")+"','"+finance_time22+"')" ;
    	finance_db.executeUpdate(ssql6) ;


}


String ssql8="insert into finance_account_finished(account_finished_finance_time,account_finished_tag) values('"+finance_time11+"','0')";
finance_db.executeUpdate(ssql8);
financedb.commit();
finance_db.commit();
financedb.close();
finance_db.close();
response.sendRedirect("finance/account/yearBegin_ok_a.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}