/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.gather;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import stock.getLength;
import include.get_rate_from_ID.getRateFromID;

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
getLength length=new getLength();
getRateFromID getRateFromID=new getRateFromID();

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String gather_ID=request.getParameter("gather_ID");
String config_id=request.getParameter("config_id");
String gathering_time=request.getParameter("gathering_time");
String[] stock_name=request.getParameterValues("stock_name");
String[] amount=request.getParameterValues("amount");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_id") ;
String check_time=request.getParameter("check_time") ;
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact");
String reasonexact_details=request.getParameter("reasonexact_details");
String[] id=request.getParameterValues("id");
String[] product_ID=request.getParameterValues("product_ID");
String[] product_name=request.getParameterValues("product_name");
String[] cost_price=request.getParameterValues("cost_price");
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] gathered_amount=request.getParameterValues("gathered_amount") ;
String[] gathered_subtotal=request.getParameterValues("gathered_subtotal");
String[] stock_ID=request.getParameterValues("stock_ID");
String[] nick_name=request.getParameterValues("nick_name");
String[] max_capacity_amount=request.getParameterValues("max_capacity_amount");
String[] details_number=request.getParameterValues("details_number");
String[] available_amount=request.getParameterValues("available_amount");
String[] serial_number_group=request.getParameterValues("serial_number_group");
String sql6="select id from stock_workflow where object_ID='"+gather_ID+"' and gathering_time='"+gathering_time+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=stock_db.executeQuery(sql6);
if(!rs6.next()){
	String stock_name_control=stock_name[0];
	String product_ID_control=product_ID[0];
	double amount_control=0.0d;
int p=0;
int lll=0;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		if(!validata.validata(amount[i])){
			p++;
		}
	}else{
		amount[i]="0";
	}
	int serial_number_tag=0;
	sql6="select * from stock_cell where product_ID='"+product_ID[i]+"' and check_tag='1'";
	rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		serial_number_tag=rs6.getInt("serial_number_tag");
	}
	if(serial_number_tag==1){
		lll=length.getLength((String)dbSession.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)dbSession.getAttribute("unit_db_name"));
			}
	if(serial_number_tag!=0&&Double.parseDouble(amount[i])!=0&&serial_number_group[i].equals("")){
		p++;
	}else if(serial_number_tag==0&&Double.parseDouble(amount[i])!=0&&!serial_number_group[i].equals("")){
		p++;
	}

	if(!serial_number_group[i].equals("")){
	StringTokenizer tokenTO = new StringTokenizer(serial_number_group[i],", ");        
	while(tokenTO.hasMoreTokens()) {
		String serial_number_temp=tokenTO.nextToken();
		if(serial_number_temp.length()!=lll){
			p++;
		}

		if(serial_number_tag==1){
		String sql3="select * from stock_balance_details_details where serial_number='"+serial_number_temp+"' and stock_name!='内部调入' and stock_name!='内部调出'";
		ResultSet rs3=stock_db.executeQuery(sql3);
		if(rs3.next()){
			p++;
		}
		}
		String sql="insert into stock_serial_number_temp(serial_number) values('"+serial_number_temp+"')";
		stock_db.executeUpdate(sql);
		}
	if(serial_number_tag==1){
	String sql1="select distinct serial_number from stock_serial_number_temp";
	ResultSet rs1=stock_db.executeQuery(sql1);
	rs1.last();
	if(rs1.getRow()!=Double.parseDouble(amount[i])){
		p++;
	}
	String sql2="delete from stock_serial_number_temp";
	stock_db.executeUpdate(sql2);
	}else{
	String sql1="select distinct serial_number from stock_serial_number_temp";
	ResultSet rs1=stock_db.executeQuery(sql1);
	rs1.last();
	if(rs1.getRow()!=1){
		p++;
	}
	String sql2="delete from stock_serial_number_temp";
	stock_db.executeUpdate(sql2);
	}
	}
}
String sql88="select * from stock_paying_gathering where gather_ID='"+gather_ID+"' and check_tag='0' and gathering_time='"+gathering_time+"' order by details_number";
	ResultSet rs88=stock_db.executeQuery(sql88);
	if(rs88.next()){
if(p==0){

int n=0;
double amount_sum=0.0d;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		if(Double.parseDouble(demand_amount[i])>=0){
		amount_sum+=Double.parseDouble(amount[i]);
		if(Double.parseDouble(amount[i])>Double.parseDouble(available_amount[i])){
		n++;
	}else if(Math.abs(Double.parseDouble(amount[i])+Double.parseDouble(gathered_amount[i]))>Math.abs(Double.parseDouble(demand_amount[i]))){
		n++;
	}
		}
	}
	if(stock_name[i].equals(stock_name_control)&&product_ID[i].equals(product_ID_control)){
		amount_control+=Double.parseDouble(amount[i]);
		if(Math.abs(amount_control+Double.parseDouble(gathered_amount[i]))>Math.abs(Double.parseDouble(demand_amount[i]))){
		n++;
		}
	}else{
		stock_name_control=stock_name[i];
		product_ID_control=product_ID[i];
		amount_control=0;
	}
}
if(n==0){
boolean flag=false; 
String sql8 = "update stock_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+gather_ID+"' and config_id='"+config_id+"' and gathering_time='"+gathering_time+"'" ;
	stock_db.executeUpdate(sql8);
sql8="select id from stock_workflow where object_ID='"+gather_ID+"' and gathering_time='"+gathering_time+"' and check_tag='0'";
	ResultSet rs8=stock_db.executeQuery(sql8);
	if(!rs8.next()){
		flag=true;
	}
if(flag){
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")&&Double.parseDouble(amount[i])!=0){
		String sql4="update stock_paying_gathering set check_tag='1' where id='"+id[i]+"'";
		stock_db.executeUpdate(sql4);
	}else{
		String sql56="delete from stock_paying_gathering where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"' and check_tag='0'";
		stock_db.executeUpdate(sql56);
		String sql57="update stock_pre_gathering set gather_check_tag='0' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
			stock_db.executeUpdate(sql57);
	}
}
}
double amount4=0.0d;
double cost_price_sum=0.0d;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")&&Double.parseDouble(amount[i])!=0){
		String chain_id="";
		String chain_name="";
		
		String sql22="select * from stock_cell where product_ID='"+product_ID[i]+"'";
		ResultSet rs22=stock_db.executeQuery(sql22);
		if(rs22.next()){
			chain_id=rs22.getString("chain_id");
			chain_name=rs22.getString("chain_name");
			
		}
		String address_group="";
		sql8="select * from stock_balance where product_ID='"+product_ID[i]+"'"; 
		rs8=stock_db.executeQuery(sql8);
		if(rs8.next()){
			address_group=rs8.getString("address_group");
		}
		String address=stock_name[i];
		if(address_group.indexOf(address)== -1){
			address_group+=address+",";
		}
	double subtotal=Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
	amount4+=Double.parseDouble(amount[i]);
	cost_price_sum+=subtotal;

	double balance_amount11=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"stock_balance","product_ID",product_ID[i],"amount")+Double.parseDouble(amount[i]);
	double amount22=Double.parseDouble(amount[i])+Double.parseDouble(gathered_amount[i]);
	if(flag){
		String sql4="update stock_paying_gathering set amount='"+amount[i]+"',gathered_amount='"+amount22+"',balance_amount='"+balance_amount11+"',subtotal='"+subtotal+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='1',serial_number='"+serial_number_group[i]+"',paying_or_gathering='入库' where id='"+id[i]+"'";
		stock_db.executeUpdate(sql4);
	}else{
		String sql4="update stock_paying_gathering set amount='"+amount[i]+"',gathered_amount='"+gathered_amount[i]+"',balance_amount='"+balance_amount11+"',subtotal='"+subtotal+"',checker='"+checker+"',check_time='"+check_time+"',serial_number='"+serial_number_group[i]+"',paying_or_gathering='入库' where id='"+id[i]+"'";
		stock_db.executeUpdate(sql4);
	}


//**************************
if(flag){
	if(!serial_number_group[i].equals("")){
	StringTokenizer tokenTO1 = new StringTokenizer(serial_number_group[i],", ");        
	while(tokenTO1.hasMoreTokens()) {
		String serial_number=tokenTO1.nextToken();

		int serial_number_tag=0;
	sql6="select * from stock_cell where product_ID='"+product_ID[i]+"' and check_tag='1'";
	rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		serial_number_tag=rs6.getInt("serial_number_tag");
	}

	if(serial_number_tag==1){
String sql10="insert into stock_balance_details_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,max_capacity_amount,nick_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"','"+serial_number+"','"+time+"')";
		stock_db.executeUpdate(sql10);
String sqlh10="insert into stock_balance_details_details_for_cost(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,max_capacity_amount,nick_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"','"+serial_number+"','"+time+"')";
		stock_db.executeUpdate(sqlh10);
		}else{


String sql10="select * from stock_balance_details_details where stock_name='"+stock_name[i]+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
ResultSet rs10=stock_db.executeQuery(sql10);
if(rs10.next()){double amount1=Double.parseDouble(amount[i])+rs10.getDouble("amount");

String sql101="update stock_balance_details_details set amount='"+amount1+"' where stock_name='"+stock_name[i]+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
		stock_db.executeUpdate(sql101);

}else{

String sqla10="insert into stock_balance_details_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,max_capacity_amount,nick_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"','"+serial_number+"','"+time+"')";
		stock_db.executeUpdate(sqla10);

}
String sqli10="select * from stock_balance_details_details_for_cost where stock_name='"+stock_name[i]+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
ResultSet rsi10=stock_db.executeQuery(sql10);
if(rsi10.next()){double amount1=Double.parseDouble(amount[i])+rsi10.getDouble("amount");

String sqli101="update stock_balance_details_details_for_cost set amount='"+amount1+"' where stock_name='"+stock_name[i]+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
		stock_db.executeUpdate(sqli101);

}else{

String sqlk10="insert into stock_balance_details_details_for_cost(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,max_capacity_amount,nick_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"','"+serial_number+"','"+time+"')";
		stock_db.executeUpdate(sqlk10);

}

}
		
		if(!reason.equals("生产入库")&&!reason.equals("委外入库")&&!reason.equals("采购入库")&&!reason.equals("生产领料")&&!reason.equals("销售出库")&&!reason.equals("库存初始")){
if(serial_number_tag==1){
			String sql100="insert into stock_balance_details_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','','"+reason+"','"+serial_number+"','"+time+"')";
			stock_db.executeUpdate(sql100);
			String sqll100="insert into stock_balance_details_details_for_cost(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','','"+reason+"','"+serial_number+"','"+time+"')";
			stock_db.executeUpdate(sqll100);

			}else{


String sql10="select * from stock_balance_details_details where stock_name='"+reason+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
ResultSet rs10=stock_db.executeQuery(sql10);
if(rs10.next()){
	double amount1=Double.parseDouble(amount[i])+rs10.getDouble("amount");

String sql101="update stock_balance_details_details set amount='"+amount1+"' where stock_name='"+reason+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
		stock_db.executeUpdate(sql101);

}else{

String sqlb10="insert into stock_balance_details_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,max_capacity_amount,nick_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+reason+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"','"+serial_number+"','"+time+"')";
		stock_db.executeUpdate(sqlb10);

}
String sqlm10="select * from stock_balance_details_details_for_cost where stock_name='"+reason+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
ResultSet rsm10=stock_db.executeQuery(sqlm10);
if(rsm10.next()){
	double amount1=Double.parseDouble(amount[i])+rsm10.getDouble("amount");

String sqlm101="update stock_balance_details_details_for_cost set amount='"+amount1+"' where stock_name='"+reason+"' and product_ID='"+product_ID[i]+"' and serial_number='"+serial_number+"'";
		stock_db.executeUpdate(sqlm101);

}else{

String sqln10="insert into stock_balance_details_details_for_cost(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,max_capacity_amount,nick_name,serial_number,register_time) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+reason+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"','"+serial_number+"','"+time+"')";
		stock_db.executeUpdate(sqln10);

}
}
		}
		}
	}
	String sql2="select * from stock_balance_details where product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'"; 
	ResultSet rs2=stock_db.executeQuery(sql2);
	if(rs2.next()){
		double amount2=rs2.getDouble("amount")+Double.parseDouble(amount[i]);
		double subtotal2=rs2.getDouble("subtotal")+Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
		double cost_price2=rs2.getDouble("cost_price");
		if(amount2!=0){
			cost_price2=subtotal2/amount2;
		}
		String sql3="update stock_balance_details set amount='"+amount2+"',subtotal='"+subtotal2+"',cost_price='"+cost_price2+"' where id='"+rs2.getString("id")+"'";
		stock_db.executeUpdate(sql3);
	}else{
		
		String sql10="insert into stock_balance_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name,max_capacity_amount,nick_name) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"')";
		stock_db.executeUpdate(sql10);
	}
	if(!reason.equals("生产入库")&&!reason.equals("委外入库")&&!reason.equals("采购入库")&&!reason.equals("生产领料")&&!reason.equals("销售出库")&&!reason.equals("库存初始")){
		String sql222="select * from stock_balance_details where product_ID='"+product_ID[i]+"' and stock_name='"+reason+"'"; 
	ResultSet rs222=stock_db.executeQuery(sql222);
	if(rs222.next()){
		double amount222=rs222.getDouble("amount")-Double.parseDouble(amount[i]);
		double subtotal222=rs222.getDouble("subtotal")+Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
		double cost_price222=rs222.getDouble("cost_price");
		if(amount222!=0){
			cost_price222=subtotal222/amount222;
		}
		String sql3="update stock_balance_details set amount='"+amount222+"',subtotal='"+subtotal222+"',cost_price='"+cost_price222+"' where id='"+rs222.getString("id")+"'";
		stock_db.executeUpdate(sql3);
	}else{
		double virtual_amount=-Double.parseDouble(amount[i]);
		double virtual_subtotal=-subtotal;
		String sql10="insert into stock_balance_details(chain_id,chain_name,product_ID,product_name,amount,cost_price,subtotal,stock_ID,stock_name) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+virtual_amount+"','"+cost_price[i]+"','"+virtual_subtotal+"','','"+reason+"')";
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
		
		sql6="update stock_balance set amount='"+amount333+"',cost_price_sum='"+cost_price_sum333+"',cost_price='"+cost_price333+"',address_group='"+address_group+"' where id='"+rs5.getString("id")+"'";
		stock_db.executeUpdate(sql6);
		String sql24="update design_file set real_cost_price='"+cost_price333+"' where product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql24);
		String sql44 = "select * from design_config_public_char where kind='priceAlarm'";
 		ResultSet rs44=stock_db.executeQuery(sql44);
 		double rate=0.0d;
 		if(rs44.next()){
			rate=Double.parseDouble(rs44.getString("type_name"))/100;
		}
 		String sql45 = "select * from design_file where product_ID='"+product_ID[i]+"'";
 		ResultSet rs45=stock_db.executeQuery(sql45);
 		if(rs45.next()){
		 double price_odds=rs45.getDouble("cost_price")-cost_price333;
		 if(Math.abs(price_odds/rs45.getDouble("cost_price"))>=rate){
 		String sql46 = "update design_file set price_alarm_tag='1' where product_ID='"+product_ID[i]+"'";
 		stock_db.executeUpdate(sql46);
			}
					}
	}else{
		String sql7="insert into stock_balance(chain_id,chain_name,product_ID,product_name,amount,cost_price,cost_price_sum,address_group) values('"+chain_id+"','"+chain_name+"','"+product_ID[i]+"','"+product_name[i]+"','"+amount333+"','"+cost_price333+"','"+cost_price_sum333+"','"+address_group+"')";
		stock_db.executeUpdate(sql7);
		String sql25="update design_file set real_cost_price='"+cost_price333+"' where product_ID='"+product_ID[i]+"'";
		stock_db.executeUpdate(sql25);
		String sql44 = "select * from design_config_public_char where kind='priceAlarm'";
 		ResultSet rs44=stock_db.executeQuery(sql44);
 		double rate=0.0d;
 		if(rs44.next()){
			rate=Double.parseDouble(rs44.getString("type_name"))/100;
		}
 		String sql45 = "select * from design_file where product_ID='"+product_ID[i]+"'";
 		ResultSet rs45=stock_db.executeQuery(sql45);
 		if(rs45.next()){
		 double price_odds=rs45.getDouble("cost_price")-cost_price333;
		 if(Math.abs(price_odds/rs45.getDouble("cost_price"))>=rate){
 		String sql46 = "update design_file set price_alarm_tag='1' where product_ID='"+product_ID[i]+"'";
 		stock_db.executeUpdate(sql46);
			}
					}
	}
String sql11="select * from stock_pre_gathering where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
	ResultSet rs11=stock_db.executeQuery(sql11);
	if(rs11.next()){
		double amount1=Double.parseDouble(amount[i])+rs11.getDouble("gathered_amount");
		double subtotal5=rs11.getDouble("gathered_subtotal")+Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
		if(rs11.getDouble("amount")==amount1){
			String sql="update stock_pre_gathering set gathered_amount='"+amount1+"',ungather_amount='0',gathered_subtotal='"+subtotal5+"',gather_tag='1',gather_check_tag='0' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
			stock_db.executeUpdate(sql);
		}else{
			double amount5=rs11.getDouble("amount")-amount1;
			String sql12="update stock_pre_gathering set gathered_amount='"+amount1+"',ungather_amount='"+amount5+"',gathered_subtotal='"+subtotal5+"',gather_check_tag='0' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
			stock_db.executeUpdate(sql12);
		}
	}
	}
	}
if(flag){
	String cost_calculate_type="";
	String sqlc1="select * from design_file where product_ID='"+product_ID[i]+"'";
	ResultSet rsc1=stock_db.executeQuery(sqlc1);
	if(rsc1.next()){
		cost_calculate_type=rsc1.getString("cost_calculate_type");
	}
	if(cost_calculate_type.equals("移动加权平均")){
		String sqlc2="select * from stock_balance where product_ID='"+product_ID[i]+"'";
		ResultSet rsc2=stock_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID[i]+"'";
			stock_db.executeUpdate(sqlc3);
		}
	}else if(cost_calculate_type.equals("计划价格")){
		String sqlc2="select * from design_file where product_ID='"+product_ID[i]+"'";
		ResultSet rsc2=stock_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID[i]+"'";
			stock_db.executeUpdate(sqlc3);
		}
	}else if(cost_calculate_type.equals("先进先出")){
		String sqlc2="select * from stock_balance_details_details where product_ID='"+product_ID[i]+"' order by register_time";
		ResultSet rsc2=stock_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID[i]+"'";
			stock_db.executeUpdate(sqlc3);
		}
	}else if(cost_calculate_type.equals("后进先出")){
		String sqlc2="select * from stock_balance_details_details where product_ID='"+product_ID[i]+"' order by register_time desc";
		ResultSet rsc2=stock_db.executeQuery(sqlc2);
		if(rsc2.next()){
			String sqlc3="update design_file set real_cost_price='"+rsc2.getDouble("cost_price")+"' where product_ID='"+product_ID[i]+"'";
			stock_db.executeUpdate(sqlc3);
		}
	}
}
	}
if(flag){
if(reason.equals("采购入库")){
String sql5="select * from purchase_details where purchase_ID='"+reasonexact+"' and provider_name='"+reasonexact_details+"'"; 
	ResultSet rs5=stock_db.executeQuery(sql5);
	if(rs5.next()){
		double amount3=rs5.getDouble("stock_gathered_amount")+amount4;
		double subtotal3=rs5.getDouble("gathered_cost_price_sum")+cost_price_sum;
		double cost_price3=subtotal3/amount3;
		sql6="update purchase_details set stock_gathered_amount='"+amount3+"',gathered_cost_price_sum='"+subtotal3+"' where purchase_ID='"+reasonexact+"' and provider_name='"+reasonexact_details+"'";
		stock_db.executeUpdate(sql6);
	}
}
String sql18="select * from stock_gather where gather_ID='"+gather_ID+"'"; 
	ResultSet rs18=stock_db.executeQuery(sql18);
	if(rs18.next()){
		double amount5=rs18.getDouble("gathered_amount")+amount4;
		double subtotal5=rs18.getDouble("gathered_cost_price_sum")+cost_price_sum;
		double cost_price5=subtotal5/amount5;
		String sql19="update stock_gather set gathered_amount='"+amount5+"',gathered_cost_price_sum='"+subtotal5+"',cost_price='"+cost_price5+"',checker='"+checker+"',check_time='"+check_time+"' where gather_ID='"+gather_ID+"'";
		stock_db.executeUpdate(sql19);
	}
if(reason.equals("采购入库")){
String sql55="select * from purchase_purchase where purchase_ID='"+reasonexact+"'"; 
	ResultSet rs55=stock_db.executeQuery(sql55);
	if(rs55.next()){
		double amount33=rs55.getDouble("stock_gathered_amount")+amount4;
		double subtotal33=rs55.getDouble("real_cost_price_sum")+cost_price_sum;
		//double cost_price3=subtotal3/amount3;
		String sql66="update purchase_purchase set stock_gathered_amount='"+amount33+"',real_cost_price_sum='"+subtotal33+"' where purchase_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql66);
	}
}
	String sql16="select * from stock_pre_gathering where gather_ID='"+gather_ID+"' and gather_tag!='1'";
	ResultSet rs16=stock_db.executeQuery(sql16);
	if(!rs16.next()){
		String sql17="update stock_gather set finish_time='"+time+"',gather_tag='2' where gather_ID='"+gather_ID+"'";
		stock_db.executeUpdate(sql17);
		
		String sql28="select * from stock_gather where reasonexact='"+reasonexact+"' and gather_tag!='2'"; 
		ResultSet rs28=stock_db.executeQuery(sql28);
		if(!rs28.next()){
			if(reason.equals("采购入库")){
		String sql19="update purchase_purchase set stock_gather_tag='3' where purchase_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql19);
		String sql21="select * from purchase_purchase where stock_gather_tag='3' and invoice_tag='3' and gather_tag='3' and check_tag='2' and purchase_ID='"+reasonexact+"'";
		ResultSet rs21=stock_db.executeQuery(sql21);
		if(rs21.next()){
		String sql23="update purchase_purchase set purchase_tag='2' where purchase_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql23);
		}
			}
			if(reason.equals("委外入库")){
		String sql19="update intrmanufacture_intrmanufacture set stock_gather_tag='3' where intrmanufacture_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql19);
		String sql21="select * from intrmanufacture_intrmanufacture where stock_gather_tag='3' and invoice_tag='3' and gather_tag='3' and check_tag='2' and intrmanufacture_ID='"+reasonexact+"'";
		ResultSet rs21=stock_db.executeQuery(sql21);
		if(rs21.next()){
		String sql23="update intrmanufacture_intrmanufacture set intrmanufacture_tag='2' where intrmanufacture_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql23);
		}
			}
		if(reason.equals("内部调入")){
		String sql19="update stock_transfer_gather set transfer_gather_tag='1',gather_tag='2' where gather_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql19);
			}
		if(reason.equals("采购放货")||reason.equals("赠送")||reason.equals("内部借领")||reason.equals("其他借领")){
		String sql19a="update stock_apply_gather set gather_tag='2' where gather_ID='"+reasonexact+"'";
		stock_db.executeUpdate(sql19a);
			}
		}
response.sendRedirect("stock/gather/check_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("stock/gather/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("stock/gather/check_ok.jsp?finished_tag=6");
}
}else{
response.sendRedirect("stock/gather/check_ok.jsp?finished_tag=2");
}
}else{
response.sendRedirect("stock/gather/check_ok.jsp?finished_tag=3");
}
}else{
response.sendRedirect("stock/gather/check_ok.jsp?finished_tag=4");
}
}else{
response.sendRedirect("stock/gather/check_ok.jsp?finished_tag=5");
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