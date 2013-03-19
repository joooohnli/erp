/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.price_change;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();

nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);

try{
if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String checker_ID=request.getParameter("checker_ID") ;
String config_id=request.getParameter("config_id");
String product_ID=request.getParameter("product_ID");
String list_price2=request.getParameter("list_price") ;
String id=request.getParameter("id");
String responsible_person_ID="";
String responsible_person_name="";
String product_name=request.getParameter("product_name") ;
String factory_name=request.getParameter("factory_name") ;
String type=request.getParameter("type") ;
String product_class=request.getParameter("product_class") ;
String product_nick=request.getParameter("product_nick") ;
String twin_name=request.getParameter("twin_name") ;
String twin_ID=request.getParameter("twin_ID") ;
String personal_unit=request.getParameter("personal_unit") ;
String personal_value=request.getParameter("personal_value") ;
String warranty=request.getParameter("warranty") ;
String lifecycle=request.getParameter("lifecycle") ;
String amount_unit=request.getParameter("amount_unit") ;
String register=request.getParameter("register") ;
String bodya = new String(request.getParameter("product_describe").getBytes("UTF-8"),"UTF-8");
String product_describe=exchange.toHtml(bodya);
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
StringTokenizer tokenTO4 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO4.hasMoreTokens()) {
                String list_price1 = tokenTO4.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter("cost_price") ;
StringTokenizer tokenTO5 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO5.hasMoreTokens()) {
                String cost_price1 = tokenTO5.nextToken();
		cost_price +=cost_price1;
		}
int n=0;
		if(!validata.validata(list_price)||Double.parseDouble(list_price)<0){
			n++;
		}
		if(!validata.validata(cost_price)||Double.parseDouble(cost_price)<0){
			n++;
		}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"price_change_tag").equals("1")){

if(n==0){

if(true){
try{
	String sql = "update design_file set product_ID='"+product_ID+"',product_name='"+product_name+"',factory_name='"+factory_name+"',product_class='"+product_class+"',type='"+type+"',twin_name='"+twin_name+"',twin_ID='"+twin_ID+"',personal_unit='"+personal_unit+"',personal_value='"+personal_value+"',warranty='"+warranty+"',lifecycle='"+lifecycle+"',product_nick='"+product_nick+"',list_price='"+list_price+"',cost_price='"+cost_price+"',product_describe='"+product_describe+"',responsible_person_name='"+responsible_person_name+"',responsible_person_ID='"+responsible_person_ID+"',amount_unit='"+amount_unit+"',price_alarm_tag='0',checker='"+checker+"',check_time='"+check_time+"' where product_ID='"+product_ID+"' and price_change_tag='1'" ;
	design_db.executeUpdate(sql) ;

    sql = "update design_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where  object_ID='"+product_ID+"' and config_id='"+config_id+"' and type_id='02'" ;
	 design_db.executeUpdate(sql) ;

    sql="select id from design_workflow where object_ID='"+product_ID+"' and check_tag='0' and type_id='02'";
	ResultSet rset=design_db.executeQuery(sql) ;
	if(!rset.next()){
		sql="update design_file set price_change_tag='0' where product_ID='"+product_ID+"'";
		design_db.executeUpdate(sql) ;
		sql="delete from design_workflow where object_ID='"+product_ID+"' and type_id='02'";
		design_db.executeUpdate(sql) ;


	String sql4="select * from design_module_details where product_ID='"+product_ID+"'";
	ResultSet rs4=design_db.executeQuery(sql4);
	while(rs4.next()){
		double subtotal1=Double.parseDouble(cost_price)*rs4.getDouble("amount");
		double subtotal3=subtotal1-rs4.getDouble("subtotal");
		String sql6="select * from design_module where design_ID='"+rs4.getString("design_ID")+"'";
		ResultSet rs6=design_db1.executeQuery(sql6);
		if(rs6.next()){
			double subtotal5=rs6.getDouble("cost_price_sum")+subtotal3;
			String sql8="update design_module set cost_price_sum='"+subtotal5+"' where design_ID='"+rs4.getString("design_ID")+"'";
			design_db1.executeUpdate(sql8);
		}
	String sql1="update design_module_details set cost_price='"+cost_price+"',subtotal='"+subtotal1+"' where product_ID='"+product_ID+"'";
	design_db1.executeUpdate(sql1);
	}
	String sql5="select * from manufacture_design_procedure_module_details where product_ID='"+product_ID+"'";
	ResultSet rs5=manufacture_db.executeQuery(sql5);
	while(rs5.next()){
		double subtotal2=Double.parseDouble(cost_price)*rs5.getDouble("amount");
		double subtotal4=subtotal2-rs5.getDouble("subtotal");
		String sql7="select * from manufacture_design_procedure_details where design_ID='"+rs5.getString("design_ID")+"' and procedure_name='"+rs5.getString("procedure_name")+"'";
		ResultSet rs7=manufacture_db1.executeQuery(sql7);
		if(rs7.next()){
			double subtotal6=rs7.getDouble("module_subtotal")+subtotal4;
			String sql9="update manufacture_design_procedure_details set module_subtotal='"+subtotal6+"' where design_ID='"+rs5.getString("design_ID")+"' and procedure_name='"+rs5.getString("procedure_name")+"'";
			manufacture_db1.executeUpdate(sql9);
		}
		String sql11="select * from manufacture_design_procedure where design_ID='"+rs5.getString("design_ID")+"'";
		ResultSet rs11=manufacture_db1.executeQuery(sql11);
		if(rs11.next()){
			double subtotal8=rs11.getDouble("module_cost_price_sum")+subtotal4;
			String sql13="update manufacture_design_procedure set module_cost_price_sum='"+subtotal8+"' where design_ID='"+rs5.getString("design_ID")+"'";
			manufacture_db1.executeUpdate(sql13);
		}
	String sql3="update manufacture_design_procedure_module_details set cost_price='"+cost_price+"',subtotal='"+subtotal2+"' where product_ID='"+product_ID+"'";
	manufacture_db1.executeUpdate(sql3) ;
	}

	}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("design/price_change/check_ok_a.jsp");
}else{
	
	response.sendRedirect("design/price_change/check_ok_b.jsp?product_ID="+product_ID+"");
	}
}else{
	
response.sendRedirect("design/price_change/check_ok_c.jsp?product_ID="+product_ID+"");
}
}else{
	
response.sendRedirect("design/price_change/check_ok_d.jsp");
}
design_db.commit();
design_db1.commit();
manufacture_db1.commit();
manufacture_db.commit();

design_db.close();
	design_db1.close();
manufacture_db1.close();
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