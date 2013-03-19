/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.pay;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import java.util.* ;
import java.text.*;
import include.get_rate_from_ID.getRateFromID;
import include.nseer_cookie.GetWorkflow;
import include.nseer_db.*;
import validata.ValidataNumber;
import stock.getLength;
import include.nseer_cookie.FileKind;

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
getLength length=new getLength();
getRateFromID getRateFromID=new getRateFromID();
FileKind FileKind=new FileKind();
try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String pay_ID=request.getParameter("pay_ID");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String[] stock_name=request.getParameterValues("stock_name");
String[] amount=request.getParameterValues("amount");
String[] serial_number_group=request.getParameterValues("serial_number");
String[] amount_number_group=request.getParameterValues("amount_number");
String[] serial_number=new String[stock_name.length];
String[] product_ID=request.getParameterValues("product_ID");
String[] product_name=request.getParameterValues("product_name");
String[] cost_price=request.getParameterValues("cost_price");
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] paid_amount=request.getParameterValues("paid_amount1") ;
String[] paid_subtotal=request.getParameterValues("paid_subtotal");
String[] stock_ID=request.getParameterValues("stock_ID");
int lll=0;
int p=0;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		if(!validata.validata(amount[i])){
			p++;
		}
	}else{
		amount[i]="0";
	}
	int serial_number_tag=0;
	String sql6="select * from stock_cell where product_ID='"+product_ID[i]+"' and check_tag='1'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		serial_number_tag=rs6.getInt("serial_number_tag");
	}
	if(serial_number_tag==1){
		lll=length.getLength((String)dbSession.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)dbSession.getAttribute("unit_db_name"));
			}
	serial_number[i]="";
	if(serial_number_tag!=0&&Double.parseDouble(amount[i])!=0&&serial_number_group[i].equals("")){
		p++;
	}else if(serial_number_tag==0&&Double.parseDouble(amount[i])!=0&&!serial_number_group[i].equals("")){
		p++;
	}
	if(!serial_number_group[i].equals("")){
	if(serial_number_group[i].length()%lll==0){
	
		if(serial_number_tag==1&&serial_number_group[i].length()/lll!=Double.parseDouble(amount[i])){
			p++;
		}
	}else{
		p++;
	}
	if(p==0){
	int j=0;
	
	while(j<serial_number_group[i].length()){
		serial_number[i]+=serial_number_group[i].substring(j,j+lll)+", ";
		String sql3="select * from stock_balance_details_details where serial_number='"+serial_number_group[i].substring(j,j+lll)+"' and stock_ID='"+stock_ID[i]+"' and product_ID='"+product_ID[i]+"'";
		ResultSet rs3=stock_db.executeQuery(sql3);
		if(!rs3.next()){
			p++;
		}
		if(serial_number_tag==1){
		String sql="insert into stock_serial_number_temp(serial_number) values('"+serial_number_group[i].substring(j,j+lll)+"')";
		stock_db.executeUpdate(sql);
		}
		j+=lll;
	}
	//serial_number[i]=serial_number[i].substring(0,serial_number[i].length()-2);
	if(serial_number_tag==1){
	String sql1="select distinct serial_number from stock_serial_number_temp";
	ResultSet rs1=stock_db.executeQuery(sql1);
	rs1.last();
	if(rs1.getRow()!=Double.parseDouble(amount[i])){
		p++;
	}
	String sql2="delete from stock_serial_number_temp";
	stock_db.executeUpdate(sql2);
	}
	}
	}
}
if(p==0){
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact");
String[] nick_name=request.getParameterValues("nick_name");
String[] details_number=request.getParameterValues("details_number");
String[] available_amount=request.getParameterValues("available_amount");
int n=0;
double amount_sum=0.0d;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		amount_sum+=Double.parseDouble(amount[i]);
		if(Double.parseDouble(amount[i])>Double.parseDouble(available_amount[i])){
		n++;
	}else if(Math.abs(Double.parseDouble(amount[i])+Double.parseDouble(paid_amount[i]))>Math.abs(Double.parseDouble(demand_amount[i]))){
		n++;
	}
	}
}
if(n==0){
List rsList = GetWorkflow.getList(stock_db, "stock_config_workflow", "06");
int paying_time=0;
String sqq="select paying_time from stock_pay where pay_ID='"+pay_ID+"'";
ResultSet rsq=stock_db.executeQuery(sqq);
if(rsq.next()){
	paying_time=rsq.getInt("paying_time")+1;
}
sqq="update stock_pay set paying_time='"+paying_time+"' where pay_ID='"+pay_ID+"'";
stock_db.executeUpdate(sqq);
try{
double amount4=0.0d;
double cost_price_sum=0.0d;
	for(int i=0;i<stock_name.length;i++){
	int serial_number_tag=0;
	String sql6="select * from stock_cell where product_ID='"+product_ID[i]+"' and check_tag='1'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		serial_number_tag=rs6.getInt("serial_number_tag");
	}
	if(serial_number_tag==1){
		lll=length.getLength((String)dbSession.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)dbSession.getAttribute("unit_db_name"));
			}
	if(!amount[i].equals("")&&Double.parseDouble(amount[i])!=0){
	double subtotal=Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
	amount_number_group[i]=amount[i]+", ";
	double amount22=Double.parseDouble(amount[i])+Double.parseDouble(paid_amount[i]);
	if(rsList.size()==0){
		String sql4="insert into stock_paying_gathering(pay_ID,product_ID,details_number,product_name,amount,demand_amount,paid_amount,cost_price,subtotal,paid_subtotal,register,register_time,stock_ID,stock_name,nick_name,serial_number,amount_number,check_tag,paying_time) values('"+pay_ID+"','"+product_ID[i]+"','"+details_number[i]+"','"+product_name[i]+"','"+amount[i]+"','"+demand_amount[i]+"','"+amount22+"','"+cost_price[i]+"','"+subtotal+"','"+paid_subtotal[i]+"','"+register+"','"+register_time+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+nick_name[i]+"','"+serial_number[i]+"','"+amount_number_group[i]+"','1','"+paying_time+"')";
		//out.println(sql4);
		stock_db.executeUpdate(sql4);
		sql6="delete from stock_paying_temp where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql6);
		String sql="update stock_pre_paying set pay_check_tag='0' where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
		stock_db.executeUpdate(sql);
	}else{
		String sql4="insert into stock_paying_gathering(pay_ID,product_ID,details_number,product_name,amount,demand_amount,paid_amount,cost_price,subtotal,paid_subtotal,register,register_time,stock_ID,stock_name,nick_name,serial_number,amount_number,check_tag,paying_time) values('"+pay_ID+"','"+product_ID[i]+"','"+details_number[i]+"','"+product_name[i]+"','"+amount[i]+"','"+demand_amount[i]+"','"+paid_amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+paid_subtotal[i]+"','"+register+"','"+register_time+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+nick_name[i]+"','"+serial_number[i]+"','"+amount_number_group[i]+"','0','"+paying_time+"')";
		//out.println(sql4);
		stock_db.executeUpdate(sql4);
		sql6="delete from stock_paying_temp where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql6);
		String sql="update stock_pre_paying set pay_check_tag='1' where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
		stock_db.executeUpdate(sql);
	}
//**************************
if(rsList.size()==0){
        String chain_id="";
		String chain_name="";
	
		String sql22="select * from stock_cell where product_ID='"+product_ID[i]+"'";
		ResultSet rs22=stock_db.executeQuery(sql22);
		if(rs22.next()){
			chain_id=rs22.getString("chain_id");
			chain_name=rs22.getString("chain_name");
			
		}
		String address_group="";
		String sql8="select * from stock_balance where product_ID='"+product_ID[i]+"'"; 
		ResultSet rs8=stock_db.executeQuery(sql8);
		if(rs8.next()){
			address_group=rs8.getString("address_group");
		}
		String address=stock_name[i];
		if(address_group.indexOf(address)== -1){
			address_group+=address+",";
		}
	amount4+=Double.parseDouble(amount[i]);
	cost_price_sum+=subtotal;
	double balance_amount11=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"stock_balance","product_ID",product_ID[i],"amount")-Double.parseDouble(amount[i]);

	if(serial_number_tag==1){
	if(!serial_number[i].equals("")){
	StringTokenizer tokenTO1 = new StringTokenizer(serial_number[i],", ");        
	while(tokenTO1.hasMoreTokens()) {
		String serial_number1=tokenTO1.nextToken();
		String sql10="delete from  stock_balance_details_details where serial_number='"+serial_number1+"' and stock_ID='"+stock_ID[i]+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql10);
		if(!reason.equals("生产入库")&&!reason.equals("委外入库")&&!reason.equals("采购入库")&&!reason.equals("生产领料")&&!reason.equals("销售出库")){
			String sql444="select * from stock_balance_details_details where serial_number='"+serial_number1+"' and stock_name='"+reason+"' and product_ID='"+product_ID[i]+"'";
			ResultSet rs444=stock_db.executeQuery(sql444);

			if(rs444.next()){
				String sql555="delete from stock_balance_details_details where serial_number='"+serial_number1+"' and stock_name='"+reason+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql555);
			}else{

			String sql100="insert into stock_balance_details_details(product_ID,product_name,cost_price,subtotal,stock_ID,stock_name,serial_number,register_time) values('"+product_ID[i]+"','"+product_name[i]+"','"+cost_price[i]+"','"+subtotal+"','','"+reason+"','"+serial_number1+"','"+time+"')";
			stock_db.executeUpdate(sql100);
			}

		}
		
		}
	}
	}else{
		if(!serial_number[i].equals("")){
	StringTokenizer tokenTO2 = new StringTokenizer(serial_number[i],", ");
	StringTokenizer tokenTO3 = new StringTokenizer(amount_number_group[i],", ");
	while(tokenTO2.hasMoreTokens()&&tokenTO3.hasMoreTokens()) {
		String serial_number2=tokenTO2.nextToken();
		String amount_number=tokenTO3.nextToken();
		String sqla10="select * from stock_balance_details_details where serial_number='"+serial_number2+"' and stock_ID='"+stock_ID[i]+"' and product_ID='"+product_ID[i]+"'";
		ResultSet rsa10=stock_db.executeQuery(sqla10);
		double cost_price_details=0.0d;
		double subtotal_details=0.0d;
		if(rsa10.next()){
			cost_price_details=rsa10.getDouble("cost_price");
			subtotal_details=rsa10.getDouble("cost_price")*Double.parseDouble(amount_number);
			double balance_amount=rsa10.getDouble("amount")-Double.parseDouble(amount_number);
		String sql10="update stock_balance_details_details set amount='"+balance_amount+"' where serial_number='"+serial_number2+"' and stock_ID='"+stock_ID[i]+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql10);
		}
		if(!reason.equals("生产入库")&&!reason.equals("委外入库")&&!reason.equals("采购入库")&&!reason.equals("生产领料")&&!reason.equals("销售出库")){
			String sql444="select * from stock_balance_details_details where serial_number='"+serial_number2+"' and stock_name='"+reason+"' and product_ID='"+product_ID[i]+"'";
			ResultSet rs444=stock_db.executeQuery(sql444);

			if(rs444.next()){
				double balance_amount1=rs444.getDouble("amount")-Double.parseDouble(amount_number);
				String sql555="update stock_balance_details_details set amount='"+balance_amount1+"' where serial_number='"+serial_number2+"' and stock_name='"+reason+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql555);
			}else{

			String sql100="insert into stock_balance_details_details(product_ID,product_name,cost_price,subtotal,stock_ID,stock_name,serial_number,register_time,amount) values('"+product_ID[i]+"','"+product_name[i]+"','"+cost_price_details+"','"+subtotal_details+"','','"+reason+"','"+serial_number2+"','"+time+"','"+amount_number+"')";
			stock_db.executeUpdate(sql100);
			}

		}
		}
	}
	}
	String sql2="select * from stock_balance_details where product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'"; 
	ResultSet rs2=stock_db.executeQuery(sql2);
	if(rs2.next()){
		double cost_price2=rs2.getDouble("cost_price");
		double amount2=rs2.getDouble("amount")-Double.parseDouble(amount[i]);
		double subtotal2=rs2.getDouble("subtotal")-Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
		if(amount2!=0){
		cost_price2=subtotal2/amount2;
		}
		String sql3="update stock_balance_details set amount='"+amount2+"',subtotal='"+subtotal2+"',cost_price='"+cost_price2+"' where id='"+rs2.getString("id")+"'";
		//out.println(sql3);
		stock_db.executeUpdate(sql3);
	}else{
		double amount2=0-Double.parseDouble(amount[i]);
		String sql10="insert into stock_balance_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,nick_name) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount2+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+nick_name[i]+"')";
		stock_db.executeUpdate(sql10);
	}
	if(!reason.equals("生产入库")&&!reason.equals("委外入库")&&!reason.equals("采购入库")&&!reason.equals("生产领料")&&!reason.equals("销售出库")){
		String sql222="select * from stock_balance_details where product_ID='"+product_ID[i]+"' and stock_name='"+reason+"' "; 
	ResultSet rs222=stock_db.executeQuery(sql222);
	if(rs222.next()){
		double cost_price222=rs222.getDouble("cost_price");
		double amount222=rs222.getDouble("amount")+Double.parseDouble(amount[i]);
		double subtotal222=rs222.getDouble("subtotal")+Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
		if(amount222!=0){
		cost_price222=subtotal222/amount222;
		}
		String sql333="update stock_balance_details set amount='"+amount222+"',subtotal='"+subtotal222+"',cost_price='"+cost_price222+"' where id='"+rs222.getString("id")+"'";
		//out.println(sql3);
		stock_db.executeUpdate(sql333);
	}else{
		String[] aaa=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID[i]);

		String sql10="insert into stock_balance_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name) values('"+aaa[0]+"','"+aaa[1]+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','','"+reason+"')";
		stock_db.executeUpdate(sql10);
	}

	}
	double amount333=0.0d;
	double cost_price_sum333=0.0d;

	String sql333="select * from stock_balance_details where product_ID='"+product_ID[i]+"'";
	ResultSet rs333=stock_db.executeQuery(sql333);
	while(rs333.next()){amount333+=rs333.getDouble("amount");
	                     cost_price_sum333+=rs333.getDouble("subtotal");
	}
	double cost_price333=0.0d;
		
		if(amount333!=0){
		cost_price333=cost_price_sum333/amount333;
		}
String sql5="select * from stock_balance where product_ID='"+product_ID[i]+"'"; 
	ResultSet rs5=stock_db.executeQuery(sql5);
	if(rs5.next()){
		
		String sql6a="update stock_balance set amount='"+amount333+"',cost_price_sum='"+cost_price_sum333+"',cost_price='"+cost_price333+"',address_group='"+address_group+"' where id='"+rs5.getString("id")+"'";
		//out.println(sql6);
		stock_db.executeUpdate(sql6a);
	}else{
		String sql7="insert into stock_balance(chain_id,chain_name,product_ID,product_name,amount,cost_price,cost_price_sum,address_group) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount333+"','"+cost_price333+"','"+cost_price_sum333+"','"+address_group+"')";
		stock_db.executeUpdate(sql7);
	}
String sql11="select * from stock_pre_paying where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
	ResultSet rs11=stock_db.executeQuery(sql11);
	if(rs11.next()){
		double amount1=Double.parseDouble(amount[i])+rs11.getDouble("paid_amount");
		double subtotal5=rs11.getDouble("paid_subtotal")+Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
		if(rs11.getDouble("amount")==amount1){
			String sql="update stock_pre_paying set paid_amount='"+amount1+"',unpay_amount='0',paid_subtotal='"+subtotal5+"',pay_tag='1',pay_check_tag='0' where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
			stock_db.executeUpdate(sql);
		}else{
			double amount5=rs11.getDouble("amount")-amount1;
			String sql12="update stock_pre_paying set paid_amount='"+amount1+"',unpay_amount='"+amount5+"',paid_subtotal='"+subtotal5+"',pay_check_tag='0' where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
			
			stock_db.executeUpdate(sql12);
		}
	}
	double amount6=0.0;
String sql20="select * from stock_pay_details where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"'"; 
	ResultSet rs20=stock_db.executeQuery(sql20);
	if(rs20.next()){
		amount6=rs20.getDouble("paid_amount")+Double.parseDouble(amount[i]);
		double subtotal6=rs20.getDouble("paid_subtotal")+Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
		String sql21="update stock_pay_details set paid_amount='"+amount6+"',paid_subtotal='"+subtotal6+"' where pay_ID='"+pay_ID+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql21);
	}
	if(reason.equals("销售出库")){
		String sql19="update crm_order_details set paid_amount='"+amount6+"' where order_ID='"+reasonexact+"' and product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql19);
		String sql23="select * from crm_order where order_ID='"+reasonexact+"'";
		ResultSet rs23=stock_db.executeQuery(sql23);
		if(rs23.next()){
		double paid_amount_sum=rs23.getDouble("paid_amount_sum")+Double.parseDouble(amount[i]);
		String sql24="update crm_order set paid_amount_sum='"+paid_amount_sum+"' where order_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql24);
		}
		}


String cost_calculate_type="";
	String sqlc1="select * from design_file where product_ID='"+product_ID[i]+"'";
	ResultSet rsc1=stock_db.executeQuery(sqlc1);
	if(rsc1.next()){
		cost_calculate_type=rsc1.getString("cost_calculate_type");
	}
}
//*****************************	
	}

	}

	if(reason.equals("销售出库")){
		String sql5="update crm_order set pay_tag='2' where order_ID='"+reasonexact+"'"; 
		stock_db.executeUpdate(sql5);
	}

if(rsList.size()==0){
String sql18="select * from stock_pay where pay_ID='"+pay_ID+"'"; 
	ResultSet rs18=stock_db.executeQuery(sql18);
	if(rs18.next()){
		double amount5=rs18.getDouble("paid_amount")+amount4;
		double subtotal5=rs18.getDouble("paid_cost_price_sum")+cost_price_sum;
		double cost_price5=subtotal5/amount5;
		String sql19="update stock_pay set paid_amount='"+amount5+"',paid_cost_price_sum='"+subtotal5+"',cost_price='"+cost_price5+"',checker='"+register+"',check_time='"+register_time+"' where pay_ID='"+pay_ID+"'";
		stock_db.executeUpdate(sql19);
	}

	String sql16="select * from stock_pre_paying where pay_ID='"+pay_ID+"' and pay_tag!='1'";
	ResultSet rs16=stock_db.executeQuery(sql16);
	if(!rs16.next()){
		String sql17="update stock_pay set finish_time='"+time+"',pay_tag='2' where pay_ID='"+pay_ID+"'";
		stock_db.executeUpdate(sql17);
		if(reason.equals("销售出库")){
		String sql19="update crm_order set pay_tag='3' where order_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql19);
		String sql23="select * from crm_order where gather_tag='3' and logistics_tag='3' and receive_tag='3' and invoice_tag='3' and pay_tag='3' and check_tag='1' and order_ID='"+reasonexact+"'";
		ResultSet rs23=stock_db.executeQuery(sql23);
		if(rs23.next()){
		String sql24="update crm_order set order_tag='2',order_status='完成',accomplish_time='"+register_time+"' where order_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql24);
		}
		}
		if(reason.equals("内部调出")){
		String sql19="update stock_transfer_pay set transfer_pay_tag='1',pay_tag='2' where pay_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql19);
			}
		if(reason.equals("销售赊货")){
		String sql19a="update stock_apply_pay set pay_tag='2' where pay_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql19a);
			}
}
}else{
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		String sql = "insert into stock_workflow(config_id,object_ID,describe1,describe2,paying_time) values ('"+elem[0]+"','"+pay_ID+"','"+elem[1]+"','"+elem[2]+"','"+paying_time+"')" ;
		stock_db.executeUpdate(sql);
	}
}

response.sendRedirect("stock/pay/register_ok.jsp?finished_tag=0");
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
response.sendRedirect("stock/pay/register_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("stock/pay/register_ok.jsp?finished_tag=2");
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