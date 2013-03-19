/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.credit;
 
 
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
import include.nseer_cookie.FileKind;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
FileKind FileKind=new FileKind();
ValidataRecord vr=new ValidataRecord();
ValidataTag vt=new ValidataTag();


String gather_ID=request.getParameter("gather_ID") ;
String config_ID=request.getParameter("config_ID");
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String gatherer_name=request.getParameter("gatherer_name") ;
String gatherer_ID=request.getParameter("gatherer_ID") ;
String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
int p=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
	if(!validata.validata(amount)){
			p++;
		}
}


String sql6="select id from purchase_workflow where object_ID='"+gather_ID+"' and ((check_tag='0' and config_ID<'"+config_ID+"') or (check_tag='1' and config_ID='"+config_ID+"'))";
ResultSet rs6=purchase_db.executeQuery(sql6);
if(!rs6.next()){

if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_apply_gather","gather_ID",gather_ID,"check_tag").equals("0")){

if(p==0){

int n=0;

if(n==0){
	
String sql9 = "update purchase_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+gather_ID+"' and config_ID='"+config_ID+"'" ;
	purchase_db.executeUpdate(sql9);
	sql9="select id from purchase_workflow where object_ID='"+gather_ID+"' and check_tag='0'";
	ResultSet rset=purchase_db.executeQuery(sql9);
	if(!rset.next()){
		sql9="update stock_apply_gather set check_tag='1' where gather_ID='"+gather_ID+"'";
		purchase_db.executeUpdate(sql9);
	}
String[] aaa1=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"purchase_file","provider_ID",gatherer_ID);


String stock_gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));	


double demand_amount=0.0d;
double cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_available_amount="available_amount"+i;
	String tem_amount="amount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_type="type"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String available_amount=request.getParameter(tem_available_amount) ;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
String cost_price2=request.getParameter(tem_cost_price) ;
String type=request.getParameter(tem_type) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
	
	double cost_price_subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=cost_price_subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "update stock_apply_gather_details set amount='"+amount+"',cost_price='"+cost_price+"',subtotal='"+cost_price_subtotal+"' where gather_ID='"+gather_ID+"' and details_number='"+i+"'" ;
	purchase_db.executeUpdate(sql1) ;

	if(type.equals("物料")||type.equals("外购商品")){
	String sql2="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,type,cost_price,subtotal,amount,ungather_amount) values('"+stock_gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+type+"','"+cost_price+"','"+cost_price_subtotal+"','"+amount+"','"+amount+"')";
	purchase_db.executeUpdate(sql2);
}else if(type.equals("商品")||type.equals("部件")||type.equals("委外部件")){
	String sql2="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,type,cost_price,subtotal,amount,ungather_amount) values('"+stock_gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+type+"','"+cost_price+"','"+cost_price_subtotal+"','"+amount+"','"+amount+"')";
	purchase_db.executeUpdate(sql2);
}
	
	String sql97="select * from purchase_purchasecredit_balance_details where crediter_ID='"+gatherer_ID+"' and product_ID='"+product_ID+"'";
	ResultSet rs97=purchase_db.executeQuery(sql97);
	if(rs97.next()){
		double balance_amount=rs97.getDouble("amount")+Double.parseDouble(amount);
				double balance_cost_price_subtotal=rs97.getDouble("subtotal")+cost_price_subtotal;

String sql96 = "update purchase_purchasecredit_balance_details set check_tag='1',amount='"+balance_amount+"',subtotal='"+balance_cost_price_subtotal+"' where crediter_ID='"+gatherer_ID+"' and product_ID='"+product_ID+"'" ;
	purchase_db.executeUpdate(sql96);
	}else{
		String[] aaa=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID);
		String sql95="insert into purchase_purchasecredit_balance_details(chain_id,chain_name,crediter_chain_id,crediter_chain_name,product_ID,product_name,cost_price,subtotal,amount,crediter_ID,crediter_name) values('"+aaa[0]+"','"+aaa[1]+"','"+aaa1[0]+"','"+aaa1[1]+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+cost_price_subtotal+"','"+amount+"','"+gatherer_ID+"','"+gatherer_name+"')";
		purchase_db.executeUpdate(sql95);
	}

}
	String sql = "update stock_apply_gather set reason='"+reason+"',register='"+register+"',register_time='"+register_time+"',demand_return_time='"+demand_return_time+"',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',cost_price_sum='"+cost_price_sum+"',not_return_tag='"+not_return_tag+"' where gather_ID='"+gather_ID+"'" ;
	purchase_db.executeUpdate(sql) ;
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",gather_ID)){
	String sql4="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_gather_ID+"','"+reason+"','"+gather_ID+"','"+gatherer_name+"','"+demand_amount+"','"+cost_price_sum+"','"+checker+"','"+check_time+"')";
	purchase_db.executeUpdate(sql4) ;
}

String sql98="select * from purchase_file where provider_ID='"+gatherer_ID+"'";
ResultSet rs98=purchase_db.executeQuery(sql98);
if(rs98.next()){
	double purchasecredit_cost_price_sum=rs98.getDouble("purchasecredit_cost_price_sum")+cost_price_sum;
		
String sql99 = "update purchase_file set CREDIT_YES_OR_NOT_TAG='1',PURCHASECREDIT_COST_PRICE_SUM='"+purchasecredit_cost_price_sum+"' where provider_ID='"+gatherer_ID+"' " ;
	purchase_db.executeUpdate(sql99) ;
	}

response.sendRedirect("purchase/credit/check_ok.jsp?finished_tag=0");
	}else{
	response.sendRedirect("purchase/credit/check_ok_b.jsp?gather_ID="+gather_ID+"");
	}
	}else{
	response.sendRedirect("purchase/credit/check_ok_c.jsp?gather_ID="+gather_ID+"");
	}
	}else{
	response.sendRedirect("purchase/credit/check_ok.jsp?finished_tag=1");
    }
	}else{
	response.sendRedirect("purchase/credit/check_ok.jsp?finished_tag=2");
    }

	purchase_db.commit();
	purchase_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 