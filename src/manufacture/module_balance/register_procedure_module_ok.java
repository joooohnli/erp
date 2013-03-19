/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.module_balance;
 
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
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
import validata.ValidataRecord;

public class register_procedure_module_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

ValidataNumber validata=new ValidataNumber();
ValidataRecord vr=new ValidataRecord();
counter count=new counter(dbApplication);

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID") ;
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
 String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String procedure_name=request.getParameter("procedure_name") ;
String procedure_ID=request.getParameter("procedure_ID") ;
String register_time=request.getParameter("register_time") ;
String procedure_responsible_person=request.getParameter("procedure_responsible_person") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("reason").getBytes("UTF-8"),"UTF-8");
String reason=exchange.toHtml(bodyc);

int module_time=1;
String sql1="select module_time from manufacture_module_balance where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"'";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	module_time=rs1.getInt("module_time")+1;
}
	 sql1="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	 rs1=manufacture_db.executeQuery(sql1) ;
	if(rs1.next()){
	String sql = "insert into manufacture_module_balance(manufacture_ID,product_ID,product_name,procedure_ID,procedure_name,procedure_responsible_person,reason,module_time,register_time,register,check_tag,excel_tag) values ('"+manufacture_ID+"','"+rs1.getString("product_ID")+"','"+rs1.getString("product_name")+"','"+procedure_ID+"','"+procedure_name+"','"+procedure_responsible_person+"','"+reason+"','"+module_time+"','"+register_time+"','"+register+"','0','2')" ;
	manufacture_db.executeUpdate(sql) ;
	}
double cost_price_sum=0.0d;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	String sql2 = "insert into manufacture_module_balance_details(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,amount,cost_price,amount_unit,subtotal,register_time,module_time) values ('"+manufacture_ID+"','"+procedure_name+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+cost_price+"','"+amount_unit+"','"+subtotal+"','"+register_time+"','"+module_time+"')" ;
	manufacture_db.executeUpdate(sql2) ;
}
	String sql3 = "update manufacture_module_balance set module_cost_price_sum='"+cost_price_sum+"' ,module_time='"+module_time+"' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and check_tag='0'" ;
	manufacture_db.executeUpdate(sql3) ;

	List rsList = GetWorkflow.getList(manufacture_db, "manufacture_config_workflow", "05");
    String[] elem=new String[3];
    
   if(rsList.size()==0){
String sql33 = "update manufacture_module_balance set check_tag='1' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"'" ;
		manufacture_db.executeUpdate(sql33) ;
String pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
	 cost_price_sum=0.0d;
double demand_amount=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql2 = "update manufacture_module_balance_details set amount='"+amount+"',subtotal='"+subtotal+"' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and module_time='"+module_time+"' and details_number='"+i+"'" ;
	manufacture_db.executeUpdate(sql2) ;

	String sql8="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,cost_price,subtotal) values('"+pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+amount_unit+"','"+cost_price+"','"+subtotal+"')";
			stock_db.executeUpdate(sql8) ;

	String sql4="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and product_ID='"+product_ID+"'";
	ResultSet rs4=manufacture_db.executeQuery(sql4) ;
	if(rs4.next()){
		double extra_amount=rs4.getDouble("extra_amount")+Double.parseDouble(amount);
		String sql5="update manufacture_procedure_module set extra_amount='"+extra_amount+"' where id='"+rs4.getString("id")+"'";
		manufacture_db.executeUpdate(sql5) ;
	}else{
		String sql6="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' order by details_number desc";
		ResultSet rs6=manufacture_db.executeQuery(sql6) ;
		int details_number=1;
		if(rs6.next()){
		details_number=rs6.getInt("details_number")+1;
		}
		String sql7="insert into manufacture_procedure_module(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,extra_amount,cost_price,amount_unit,subtotal,register_time) values('"+manufacture_ID+"','"+procedure_name+"','"+details_number+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+cost_price+"','"+amount_unit+"','"+subtotal+"','"+register_time+"')";
		manufacture_db.executeUpdate(sql7) ;
		
	}
}
	 sql3 = "update manufacture_module_balance set procedure_responsible_person='"+procedure_responsible_person+"',checker='"+register+"',check_time='"+register_time+"',reason='"+reason+"',check_tag='1' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"'" ;
		manufacture_db.executeUpdate(sql3) ;
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","register_time",register_time)){
	String sql9="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+manufacture_ID+"','"+procedure_name+"','"+demand_amount+"','"+demand_amount+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql9) ;
}

}else{
Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		String sql = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id,procedure_ID,module_time) values ('"+elem[0]+"','"+manufacture_ID+"','"+elem[1]+"','"+elem[2]+"','05','"+procedure_ID+"','"+module_time+"')" ;
		manufacture_db.executeUpdate(sql);
}
}	response.sendRedirect("manufacture/module_balance/register_procedure_module_ok_a.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	
	response.sendRedirect("manufacture/module_balance/register_procedure_module_ok_b.jsp?manufacture_ID="+manufacture_ID+"");
	}
	manufacture_db.commit();
    stock_db.commit();
	stock_db.close();
	manufacture_db.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
	
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 