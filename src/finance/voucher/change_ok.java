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
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import java.sql.* ;
import java.text.*;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataFinanceTag;
import include.get_name_from_ID.getMultiNameFromID;
import include.get_name_from_ID.AccountPeriod;

public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataFinanceTag vt=new ValidataFinanceTag();
getMultiNameFromID getMultiNameFromID=new getMultiNameFromID();
AccountPeriod accountPeriod=new AccountPeriod();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String voucher_id=request.getParameter("voucher_id");
String register_time=request.getParameter("register_time");
if(vt.validata((String)session.getAttribute("unit_db_name"),"finance_voucher","voucher_in_month_id",voucher_id,"register_time",register_time,"check_tag").equals("0")||vt.validata((String)session.getAttribute("unit_db_name"),"finance_voucher","voucher_in_month_id",voucher_id,"register_time",register_time,"check_tag").equals("9")){
	String file_id="";
	String file_name1="";
	String details_number="";
	String cash_value="";
	String cash_valuea="";
	String sql="";
	String cash_temp="";
	String sum_temp="";
	int err_count=0;
String voucher_type=request.getParameter("voucher_type");
String attachment_amount=request.getParameter("attachment_amount");
if(attachment_amount.equals("")) attachment_amount="0";
String[] summary=request.getParameterValues("summary");
String[] file_name=request.getParameterValues("file_name1");
String[] debit=request.getParameterValues("debit");
String[] loan=request.getParameterValues("loan");
String debit_sum=request.getParameter("debit_sum");
String loan_sum=request.getParameter("loan_sum");
String accountant=request.getParameter("accountant");
String accounter=request.getParameter("accounter");
String cashier=request.getParameter("cashier");
String checker=request.getParameter("checker");
String register=request.getParameter("register");
String accountant_id=request.getParameter("accountant_id");
String accounter_id=request.getParameter("accounter_id");
String cashier_id=request.getParameter("cashier_id");
String checker_id=request.getParameter("checker_id");
String register_id=request.getParameter("register_id");

int rowCount=file_name.length;
for(int i=file_name.length-1;i>=0;i--){
	if(summary[i].equals("")&&file_name[i].equals("")&&debit[i].equals("")&&loan[i].equals("")){
		rowCount--;
	}else{
		break;
	}
}
String[] qty=new String[file_name.length];
String[] netPrice=new String[file_name.length];
String[] tax_rate=new String[file_name.length];
String[] sum=new String[file_name.length];
String[] currency=new String[file_name.length];
String[] cPrice=new String[file_name.length];
String[] currency_rate=new String[file_name.length];
String[] cSum=new String[file_name.length];
String[] department=new String[file_name.length];
String[] project=new String[file_name.length];
String[] attachment_id=new String[file_name.length];
String[] settle_way=new String[file_name.length];
String[] settle_time=new String[file_name.length];
String[] customer=new String[file_name.length];
String[] product=new String[file_name.length];
String[] order=new String[file_name.length];
String[] remark=new String[file_name.length];
String[] bank_tag=new String[file_name.length];
String[] cash_tag=new String[file_name.length];
String[] corr_stock_tag=new String[file_name.length];
String[] cash_item=new String[file_name.length];
String[] cash_itema=new String[file_name.length];
String[] cash_direct=new String[file_name.length];
String[] stock_direct=new String[file_name.length];
String[] cash_sum=new String[file_name.length];

String qty_arr=request.getParameter("qty_arr");
String netPrice_arr=request.getParameter("netPrice_arr");
String tax_rate_arr=request.getParameter("tax_rate_arr");
String sum_arr=request.getParameter("sum_arr");
String currency_arr=request.getParameter("currency_arr");
String cPrice_arr=request.getParameter("cPrice_arr");
String currency_rate_arr=request.getParameter("currency_rate_arr");
String cSum_arr=request.getParameter("cSum_arr");
String department_arr=request.getParameter("department_arr");
String project_arr=request.getParameter("project_arr");
String attachment_id_arr=request.getParameter("attachment_id_arr");
String settle_way_arr=request.getParameter("settle_way_arr");
String settle_time_arr=request.getParameter("settle_time_arr");
String customer_arr=request.getParameter("customer_arr");
String product_arr=request.getParameter("product_arr");
String order_arr=request.getParameter("order_arr");
String remark_arr=request.getParameter("remark_arr");
String bank_tag_arr=request.getParameter("bank_tag_arr");
String cash_tag_arr=request.getParameter("cash_tag_arr");
String corr_stock_tag_arr=request.getParameter("corr_stock_tag_arr");
String cash_item_arr=request.getParameter("cash_item_arr");
String cash_itema_arr=request.getParameter("cash_itema_arr");
String cash_direct_arr=request.getParameter("cash_direct_arr");
String stock_direct_arr=request.getParameter("stock_direct_arr");
String cash_sum_arr=request.getParameter("cash_sum_arr");

StringTokenizer tk1=new StringTokenizer(qty_arr,"◎");
StringTokenizer tk2=new StringTokenizer(netPrice_arr,"◎");
StringTokenizer tk3=new StringTokenizer(sum_arr,"◎");
StringTokenizer tk4=new StringTokenizer(currency_arr,"◎");
StringTokenizer tk5=new StringTokenizer(cPrice_arr,"◎");
StringTokenizer tk6=new StringTokenizer(currency_rate_arr,"◎");
StringTokenizer tk7=new StringTokenizer(cSum_arr,"◎");
StringTokenizer tk8=new StringTokenizer(department_arr,"◎");
StringTokenizer tk9=new StringTokenizer(project_arr,"◎");
StringTokenizer tk10=new StringTokenizer(attachment_id_arr,"◎");
StringTokenizer tk11=new StringTokenizer(settle_way_arr,"◎");
StringTokenizer tk12=new StringTokenizer(customer_arr,"◎");
StringTokenizer tk13=new StringTokenizer(product_arr,"◎");
StringTokenizer tk14=new StringTokenizer(order_arr,"◎");
StringTokenizer tk15=new StringTokenizer(remark_arr,"◎");
StringTokenizer tk16=new StringTokenizer(cash_item_arr,"◎");
StringTokenizer tk17=new StringTokenizer(cash_itema_arr,"◎");
StringTokenizer tk18=new StringTokenizer(tax_rate_arr,"◎");
StringTokenizer tk19=new StringTokenizer(bank_tag_arr,"◎");
StringTokenizer tk20=new StringTokenizer(cash_tag_arr,"◎");
StringTokenizer tk21=new StringTokenizer(corr_stock_tag_arr,"◎");
StringTokenizer tk22=new StringTokenizer(settle_time_arr,"◎");
StringTokenizer tk23=new StringTokenizer(cash_direct_arr,"◎");
StringTokenizer tk24=new StringTokenizer(stock_direct_arr,"◎");
StringTokenizer tk25=new StringTokenizer(cash_sum_arr,"◎");
if(!qty_arr.equals("⊙")&&!netPrice_arr.equals("⊙")&&!sum_arr.equals("⊙")&&!currency_arr.equals("⊙")&&!cPrice_arr.equals("⊙")&&!currency_rate_arr.equals("⊙")&&!cSum_arr.equals("⊙")&&!department_arr.equals("⊙")&&!project_arr.equals("⊙")&&!attachment_id_arr.equals("⊙")&&!settle_way_arr.equals("⊙")&&!customer_arr.equals("⊙")&&!product_arr.equals("⊙")&&!order_arr.equals("⊙")&&!remark_arr.equals("⊙")&&!cash_item_arr.equals("⊙")&&!cash_itema_arr.equals("⊙")&&!tax_rate_arr.equals("⊙")&&!bank_tag_arr.equals("⊙")&&!cash_tag_arr.equals("⊙")&&!corr_stock_tag_arr.equals("⊙")&&!settle_time_arr.equals("⊙")&&!cash_direct_arr.equals("⊙")&&!stock_direct_arr.equals("⊙")&&!cash_sum_arr.equals("⊙")){

for(int i=0;i<rowCount;i++){
	qty[i]=tk1.nextToken();
	qty[i]=qty[i].equals("⊙")?"0.00":qty[i];
	
	netPrice[i]=tk2.nextToken();
	netPrice[i]=netPrice[i].equals("⊙")?"0.00":netPrice[i];
	
	sum[i]=tk3.nextToken();
	sum[i]=sum[i].equals("⊙")?"0.00":sum[i];
	
	currency[i]=tk4.nextToken();
	currency[i]=currency[i].equals("⊙")?"":currency[i];
	
	cPrice[i]=tk5.nextToken();
	cPrice[i]=cPrice[i].equals("⊙")?"0.00":cPrice[i];
	
	currency_rate[i]=tk6.nextToken();
	currency_rate[i]=currency_rate[i].equals("⊙")?"0.00":currency_rate[i];
	
	cSum[i]=tk7.nextToken();
	cSum[i]=cSum[i].equals("⊙")?"0.00":cSum[i];
	
	department[i]=tk8.nextToken();
	department[i]=department[i].equals("⊙")?"":department[i];

	project[i]=tk9.nextToken();
	project[i]=project[i].equals("⊙")?"":project[i];
	
	attachment_id[i]=tk10.nextToken();
	attachment_id[i]=attachment_id[i].equals("⊙")?"":attachment_id[i];
	
	settle_way[i]=tk11.nextToken();
	settle_way[i]=settle_way[i].equals("⊙")?"":settle_way[i];

	settle_time[i]=tk22.nextToken();
	settle_time[i]=settle_time[i].equals("⊙")?"1800-01-01":settle_time[i];
	
	customer[i]=tk12.nextToken();
	customer[i]=customer[i].equals("⊙")?"":customer[i];
	
	product[i]=tk13.nextToken();
	product[i]=product[i].equals("⊙")?"":product[i];
	
	order[i]=tk14.nextToken();
	order[i]=order[i].equals("⊙")?"":order[i];
	
	remark[i]=tk15.nextToken();
	remark[i]=remark[i].equals("⊙")?"":remark[i];

	bank_tag[i]=tk19.nextToken();
	bank_tag[i]=bank_tag[i].equals("⊙")?"0":bank_tag[i];

	cash_tag[i]=tk20.nextToken();
	cash_tag[i]=cash_tag[i].equals("⊙")?"0":cash_tag[i];

	corr_stock_tag[i]=tk21.nextToken();
	corr_stock_tag[i]=corr_stock_tag[i].equals("⊙")?"":corr_stock_tag[i];

	cash_item[i]=tk16.nextToken();

	cash_itema[i]=tk17.nextToken();

	tax_rate[i]=tk18.nextToken();
	tax_rate[i]=tax_rate[i].equals("⊙")?"0.00":tax_rate[i];

	cash_direct[i]=tk23.nextToken();
	cash_direct[i]=cash_direct[i].equals("⊙")?"":cash_direct[i];

	stock_direct[i]=tk24.nextToken();
	stock_direct[i]=stock_direct[i].equals("⊙")?"":stock_direct[i];

	cash_sum[i]=tk25.nextToken();
	cash_sum[i]=cash_sum[i].equals("⊙")?"":cash_sum[i];
	
}
String debit_mate_id="";
String loan_mate_id="";
String account_period="";

sql="select account_period from finance_account_period where start_time<='"+register_time+"' and end_time>='"+register_time+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
  account_period=rs.getString("account_period");
}
String[] account_period1=accountPeriod.getAccountPeriod((String)session.getAttribute("unit_db_name"));
if(account_period1[0].equals(account_period)){

if(rowCount!=0){
	if(!debit_sum.equals("")&&Double.parseDouble(debit_sum)==Double.parseDouble(loan_sum)){
		for(int i=0;i<rowCount;i++){
			
			if(!debit[i].equals("")&&!validata.validata(debit[i])||!loan[i].equals("")&&!validata.validata(loan[i])){
				err_count=16;
				break;
			}
			cash_temp=i+"◇⊙";
			if(cash_tag[i].equals("1")&&cash_item[i].equals(cash_temp)&&cash_itema[i].equals(cash_temp)){
				err_count=3;
				break;
				}
			if(summary[i].equals("")){
				err_count=4;
				break;
			}
			if(file_name[i].equals("")||file_name[i].indexOf(" ")==-1){
				err_count=8;
				break;
			}

		sql="select category_name from finance_config_file_kind where file_id='"+file_name[i].substring(0,file_name[i].indexOf(" "))+"' and details_tag=0";
			rs=finance_db.executeQuery(sql);
			if(!rs.next()){
				err_count=8;
				break;
			}	

if(cash_tag[i].equals("1")&&(cash_direct[i].equals("0")&&(!cash_sum[i].equals(debit[i])||debit[i].equals(""))||(cash_direct[i].equals("1")&&(!cash_sum[i].equals(loan[i])||loan[i].equals(""))))){
				err_count=3;
				break;
				}
			sum_temp=sum[i].substring(0,sum[i].indexOf("."))+sum[i].substring(sum[i].indexOf(".")+1);
if(corr_stock_tag[i].equals("是")&&(qty[i].equals("")||stock_direct[i].equals("0")&&(!sum_temp.equals(debit[i])||debit[i].equals(""))||stock_direct[i].equals("1")&&(!sum_temp.equals(loan[i])||loan[i].equals("")))){
				err_count=9;
				break;
				}
			if(bank_tag[i].equals("1")&&settle_way[i].equals("")){
				err_count=10;
				break;
			}
			if(bank_tag[i].equals("1")&&attachment_id[i].equals("")){
				err_count=11;
				break;
			}
			if(bank_tag[i].equals("1")&&settle_time[i].equals("1800-01-01")){
				err_count=12;
				break;
			}
			if(formatter.parse(settle_time[i]).getTime()>formatter.parse(register_time).getTime()){
				err_count=13;
				break;
			}
			
		}
		if(err_count==0){

for(int i=0;i<rowCount;i++){
	StringTokenizer tk=new StringTokenizer(file_name[i]," ");
	while(tk.hasMoreTokens()){
		file_id=tk.nextToken();
		file_name1=tk.nextToken();
	}
	if(debit[i].equals("")){
		if(debit_mate_id.indexOf(file_id)==-1){
		debit_mate_id+=file_id+",";
		}
	}else{
		if(loan_mate_id.indexOf(file_id)==-1){
		loan_mate_id+=file_id+",";
		}
	}
}
debit_sum=debit_sum.substring(0,debit_sum.length()-2)+"."+debit_sum.substring(debit_sum.length()-2);
loan_sum=loan_sum.substring(0,loan_sum.length()-2)+"."+loan_sum.substring(loan_sum.length()-2);

debit_mate_id=debit_mate_id.substring(0,debit_mate_id.length()-1);
loan_mate_id=loan_mate_id.substring(0,loan_mate_id.length()-1);

sql="delete from finance_voucher where voucher_in_month_id='"+voucher_id+"' and register_time='"+register_time+"'";
finance_db.executeUpdate(sql);
sql="delete from finance_cash_table where voucher_in_month_id='"+voucher_id+"' and register_time='"+register_time+"'";
finance_db.executeUpdate(sql);

for(int i=0;i<rowCount;i++){
	StringTokenizer tk=new StringTokenizer(file_name[i]," ");
	while(tk.hasMoreTokens()){
		file_id=tk.nextToken();
		file_name1=tk.nextToken();
	}
	String[] name=getMultiNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),file_id);
	if(debit[i].equals("")){
		debit[i]="0.00";
	}else{
		debit[i]=debit[i].substring(0,debit[i].length()-2)+"."+debit[i].substring(debit[i].length()-2);
	}
	if(loan[i].equals("")){
		loan[i]="0.00";
	}else{
		loan[i]=loan[i].substring(0,loan[i].length()-2)+"."+loan[i].substring(loan[i].length()-2);
	}
	if(loan_mate_id.equals("3131")||debit_mate_id.equals("3131")){
        name[2]="";
		name[3]="";
		name[4]="";
		name[5]="";	
	}
	if(debit[i].equals("0.00")){
	sql="insert into finance_voucher(voucher_in_month_id,details_number,chain_id,chain_name,voucher_type,debit_sum,loan_sum,attachment_amount,attachment_id,summary,debit_subtotal,loan_subtotal,product_amount,product_price,settle_way,remark,currency,currency_rate,department,project,customer,product,order_id,accountant,accountant_id,accounter,accounter_id,cashier,cashier_id,checker,checker_id,register,register_id,register_time,chain_mate_id,tax_rate,account_period,profit_or_cost,itema_name,itemb_name,itemd_name,debit_or_loan,bank_tag,cash_tag,corr_stock_tag,settle_time,cash_direct,stock_direct,cash_sum,debit_subtotal_c,loan_subtotal_c) values('"+voucher_id+"','"+i+"','"+file_id+"','"+file_name1+"','"+voucher_type+"','"+debit_sum+"','"+loan_sum+"','"+attachment_amount+"','"+attachment_id[i]+"','"+summary[i]+"','"+debit[i]+"','"+loan[i]+"','"+qty[i]+"','"+netPrice[i]+"','"+settle_way[i]+"','"+remark[i]+"','"+currency[i]+"','"+currency_rate[i]+"','"+department[i]+"','"+project[i]+"','"+customer[i]+"','"+product[i]+"','"+order[i]+"','"+accountant+"','"+accountant_id+"','"+accounter+"','"+accounter_id+"','"+cashier+"','"+cashier_id+"','"+checker+"','"+checker_id+"','"+register+"','"+register_id+"','"+register_time+"','"+loan_mate_id+"','"+tax_rate[i]+"','"+account_period+"','"+name[5]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[1]+"','"+bank_tag[i]+"','"+cash_tag[i]+"','"+corr_stock_tag[i]+"','"+settle_time[i]+"','"+cash_direct[i]+"','"+stock_direct[i]+"','"+cash_sum[i]+"','0.00','"+cPrice[i]+"')";
	}else{
	sql="insert into finance_voucher(voucher_in_month_id,details_number,chain_id,chain_name,voucher_type,debit_sum,loan_sum,attachment_amount,attachment_id,summary,debit_subtotal,loan_subtotal,product_amount,product_price,settle_way,remark,currency,currency_rate,department,project,customer,product,order_id,accountant,accountant_id,accounter,accounter_id,cashier,cashier_id,checker,checker_id,register,register_id,register_time,chain_mate_id,tax_rate,account_period,profit_or_cost,itema_name,itemb_name,itemd_name,debit_or_loan,bank_tag,cash_tag,corr_stock_tag,settle_time,cash_direct,stock_direct,cash_sum,debit_subtotal_c,loan_subtotal_c) values('"+voucher_id+"','"+i+"','"+file_id+"','"+file_name1+"','"+voucher_type+"','"+debit_sum+"','"+loan_sum+"','"+attachment_amount+"','"+attachment_id[i]+"','"+summary[i]+"','"+debit[i]+"','"+loan[i]+"','"+qty[i]+"','"+netPrice[i]+"','"+settle_way[i]+"','"+remark[i]+"','"+currency[i]+"','"+currency_rate[i]+"','"+department[i]+"','"+project[i]+"','"+customer[i]+"','"+product[i]+"','"+order[i]+"','"+accountant+"','"+accountant_id+"','"+accounter+"','"+accounter_id+"','"+cashier+"','"+cashier_id+"','"+checker+"','"+checker_id+"','"+register+"','"+register_id+"','"+register_time+"','"+debit_mate_id+"','"+tax_rate[i]+"','"+account_period+"','"+name[5]+"','"+name[2]+"','"+name[3]+"','"+name[4]+"','"+name[1]+"','"+bank_tag[i]+"','"+cash_tag[i]+"','"+corr_stock_tag[i]+"','"+settle_time[i]+"','"+cash_direct[i]+"','"+stock_direct[i]+"','"+cash_sum[i]+"','"+cPrice[i]+"','0.00')";
	}
	finance_db.executeUpdate(sql);
	tk=new StringTokenizer(cash_item[i],"◇");
	while(tk.hasMoreTokens()){
		details_number=tk.nextToken();
		cash_value=tk.nextToken();
	}
	tk=new StringTokenizer(cash_itema[i],"◇");
	while(tk.hasMoreTokens()){
		details_number=tk.nextToken();
		cash_valuea=tk.nextToken();
	}
	if(cash_value.equals("⊙")&&!cash_valuea.equals("⊙")){
		cash_value="0.00";
		if(cash_valuea.indexOf("□")!=-1){
			tk=new StringTokenizer(cash_valuea,"□");
			while(tk.hasMoreTokens()){
				tk1=new StringTokenizer(tk.nextToken(),",");
				while(tk1.hasMoreTokens()){
				sql="insert into finance_cash_table(voucher_in_month_id,details_number,debit,number_in_cash_table,loan,register_time,account_period) values('"+voucher_id+"','"+details_number+"','"+cash_value+"','"+tk1.nextToken()+"','"+tk1.nextToken()+"','"+register_time+"','"+account_period+"')";
				finance_db.executeUpdate(sql);
				}
			}
		}else{
			tk1=new StringTokenizer(cash_valuea,",");
				while(tk1.hasMoreTokens()){
				sql="insert into finance_cash_table(voucher_in_month_id,details_number,debit,number_in_cash_table,loan,register_time,account_period) values('"+voucher_id+"','"+details_number+"','"+cash_value+"','"+tk1.nextToken()+"','"+tk1.nextToken()+"','"+register_time+"','"+account_period+"')";
				finance_db.executeUpdate(sql);
				}
		}
	}else if(!cash_value.equals("⊙")&&cash_valuea.equals("⊙")){
		cash_valuea="0.00";
		if(cash_value.indexOf("□")!=-1){
			tk=new StringTokenizer(cash_value,"□");
			while(tk.hasMoreTokens()){
				tk1=new StringTokenizer(tk.nextToken(),",");
				while(tk1.hasMoreTokens()){
				sql="insert into finance_cash_table(voucher_in_month_id,details_number,loan,number_in_cash_table,debit,register_time,account_period) values('"+voucher_id+"','"+details_number+"','"+cash_valuea+"','"+tk1.nextToken()+"','"+tk1.nextToken()+"','"+register_time+"','"+account_period+"')";
				finance_db.executeUpdate(sql);
				}
			}
		}else{
			tk1=new StringTokenizer(cash_value,",");
				while(tk1.hasMoreTokens()){
				sql="insert into finance_cash_table(voucher_in_month_id,details_number,loan,number_in_cash_table,debit,register_time,account_period) values('"+voucher_id+"','"+details_number+"','"+cash_valuea+"','"+tk1.nextToken()+"','"+tk1.nextToken()+"','"+register_time+"','"+account_period+"')";
				finance_db.executeUpdate(sql);
				}
		}
	}
}

	response.sendRedirect("finance/voucher/change_ok_a.jsp");
}else{
	response.sendRedirect("finance/voucher/change_ok_b.jsp?err_number="+err_count+"&voucher_in_month_id="+voucher_id+"&register_time="+register_time);
}
}else{
	response.sendRedirect("finance/voucher/change_ok_b.jsp?err_number=6&voucher_in_month_id="+voucher_id+"&register_time="+register_time);
}
}else{
	response.sendRedirect("finance/voucher/change_ok_b.jsp?err_number=14&voucher_in_month_id="+voucher_id+"&register_time="+register_time);
}
}else{
	response.sendRedirect("finance/voucher/change_ok_b.jsp?err_number=7&voucher_in_month_id="+voucher_id+"&register_time="+register_time);
}

}else{
	response.sendRedirect("finance/voucher/change_ok_b.jsp?err_number=15&voucher_in_month_id="+voucher_id+"&register_time="+register_time);
}
}else{
	response.sendRedirect("finance/voucher/change_ok_e.jsp");
}
finance_db.commit();
finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}