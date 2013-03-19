/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.design_procedure;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import validata.ValidataNumber;
import include.nseer_cookie.counter;
import validata.ValidataTag;

public class check_ok extends HttpServlet{
public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db1 = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String procedure_amount=request.getParameter("procedure_amount") ;
int num=Integer.parseInt(procedure_amount);
String design_ID=request.getParameter("design_ID") ;
String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String designer=request.getParameter("designer") ;
String bodyc = new String(request.getParameter("procedure_describea").getBytes("UTF-8"),"UTF-8");
String procedure_describea=exchange.toHtml(bodyc);
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
int n=0;
for(int i=1;i<num;i++){
	String tem_labour_hour_amount="labour_hour_amount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i;
String labour_hour_amount=request.getParameter(tem_labour_hour_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
if(labour_hour_amount.equals("")) labour_hour_amount="0";
if(cost_price2.equals("")) cost_price2="0";
StringTokenizer tokenTO2 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO2.hasMoreTokens()) {
                String cost_price1 = tokenTO2.nextToken();
		cost_price +=cost_price1;
		}
		if(!validata.validata(labour_hour_amount)||!validata.validata(cost_price)){
			n++;
		}
		if(amount_unit.indexOf("'")!=-1||amount_unit.indexOf("\"")!=-1){
			n++;
		}
}
String sql6="select id from manufacture_workflow where object_ID='"+design_ID+"' and type_id='01' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=manufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"manufacture_design_procedure","design_ID",design_ID,"check_tag").equals("0")){

if(n==0){

try{
	String sql = "update manufacture_design_procedure set product_ID='"+product_ID+"',product_name='"+product_name+"',check_time='"+check_time+"',checker='"+checker+"',designer='"+designer+"',procedure_describe='"+procedure_describea+"',change_tag='0',design_module_tag='0' where design_ID='"+design_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
double cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_procedure_name="procedure_name"+i;
	String tem_procedure_ID="procedure_ID"+i;
	String tem_procedure_describe="procedure_describe"+i;
	String tem_labour_hour_amount="labour_hour_amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String procedure_name=request.getParameter(tem_procedure_name) ;
String procedure_ID=request.getParameter(tem_procedure_ID) ;
String procedure_describe=request.getParameter(tem_procedure_describe) ;
String labour_hour_amount=request.getParameter(tem_labour_hour_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
if(labour_hour_amount.equals("")) labour_hour_amount="0";
if(cost_price2.equals("")) cost_price2="0";
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(labour_hour_amount);
	cost_price_sum+=subtotal;
	String sql1 = "update manufacture_design_procedure_details set procedure_ID='"+procedure_ID+"',procedure_name='"+procedure_name+"',procedure_describe='"+procedure_describe+"',labour_hour_amount='"+labour_hour_amount+"',cost_price='"+cost_price+"',amount_unit='"+amount_unit+"',subtotal='"+subtotal+"' where design_ID='"+design_ID+"' and details_number='"+i+"'" ;
	manufacture_db.executeUpdate(sql1) ;
}

	 String sql2 = "update manufacture_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+design_ID+"' and config_id='"+config_id+"'" ;
	manufacture_db.executeUpdate(sql2);
	sql2="select id from manufacture_workflow where object_ID='"+design_ID+"' and check_tag='0'";
	ResultSet rset=manufacture_db.executeQuery(sql2);

	if(!rset.next()){

		String sql3="update manufacture_design_procedure_details set design_module_tag='0' where design_ID='"+design_ID+"'";
manufacture_db.executeUpdate(sql3) ;
String sql4="delete from manufacture_design_procedure_module_details where design_ID='"+design_ID+"'";
manufacture_db.executeUpdate(sql4) ;
String module_design_ID="";
String sql5="select * from design_module where product_ID='"+product_ID+"' and check_tag='1' and excel_tag='2'";
ResultSet rs5=design_db.executeQuery(sql5);
if(rs5.next()){
	module_design_ID=rs5.getString("design_ID");
}
String sql8="select * from design_module_details where design_ID='"+module_design_ID+"'";
ResultSet rs8=design_db1.executeQuery(sql6);
while(rs8.next()){
String sql7="update design_module_details set design_balance_amount='"+rs6.getString("amount")+"' where id='"+rs6.getString("id")+"'";
design_db.executeUpdate(sql7);
}
	 sql2="update manufacture_design_procedure set cost_price_sum='"+cost_price_sum+"',check_tag='1' where design_ID='"+design_ID+"'";
manufacture_db.executeUpdate(sql2) ;

	}else{
		sql2="update manufacture_design_procedure set cost_price_sum='"+cost_price_sum+"' where design_ID='"+design_ID+"'";
		manufacture_db.executeUpdate(sql2);
	}
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("manufacture/design_procedure/check_ok.jsp?finished_tag=0");
}else{			
	response.sendRedirect("manufacture/design_procedure/check_ok_a.jsp?design_ID="+design_ID+"");
}
}else{
	response.sendRedirect("manufacture/design_procedure/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("manufacture/design_procedure/check_ok.jsp?finished_tag=2");
}
  design_db.commit();
  manufacture_db.commit();
  design_db1.commit();
  design_db.close();
design_db1.close();
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