/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.cell;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
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
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String checker_ID=(String)session.getAttribute("human_IDD");//**************
String config_id=request.getParameter("config_id");//****************
String min_amount=request.getParameter("min_amount");
String max_amount=request.getParameter("max_amount");
String stock_amount=request.getParameter("stock_amount");
String design_ID=request.getParameter("design_ID");
String product_ID=request.getParameter("product_ID");
int num=Integer.parseInt(stock_amount);
String designer=request.getParameter("designer") ;
String bodyc = new String(request.getParameter("cell_describe").getBytes("UTF-8"),"UTF-8");
String cell_describe=exchange.toHtml(bodyc);
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String serial_number_tag=request.getParameter("serial_number_tag");
int p=0;
int q=0;
String sql6="select id from stock_workflow where object_ID='"+design_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=stock_db.executeQuery(sql6);
if(!rs6.next()){
//***********************************************************
String sql = "update stock_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+design_ID+"' and config_id='"+config_id+"'" ;
stock_db.executeUpdate(sql);
//***********************************************************

for(int i=1;i<num;i++){
String tem_max_capacity_amount="max_capacity_amount"+i;
String tem_nick_name="nick_name"+i;
String tem_amount_unit="amount_unit"+i;
String tem_stock_ID="stock_ID"+i;
String stock_ID=request.getParameter(tem_stock_ID) ;
String max_capacity_amount=request.getParameter(tem_max_capacity_amount) ;
String nick_name=request.getParameter(tem_nick_name) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
if(max_capacity_amount.equals("")) max_capacity_amount="0";
		if(!validata.validata(max_capacity_amount)){
			p++;
		}else if(Double.parseDouble(max_capacity_amount)==0){
			q++;
			String sql5="select * from stock_balance_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"'";
			ResultSet rs5=stock_db.executeQuery(sql5);
			if(rs5.next()){
				p++;
			}
		}else if(Double.parseDouble(max_capacity_amount)<0){
			p++;
		}
		if(nick_name.indexOf("'")!=-1||nick_name.indexOf("\"")!=-1||nick_name.indexOf(",")!=-1||amount_unit.indexOf("'")!=-1||amount_unit.indexOf("\"")!=-1||amount_unit.indexOf(",")!=-1){
			p++;
		}
}
if(!validata.validata(min_amount)||!validata.validata(max_amount)){
p++;
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_cell","design_ID",design_ID,"check_tag").equals("0")){

if(p==0&&q<num-1){

try{

sql="select id from stock_workflow where object_ID='"+design_ID+"' and check_tag='0'";
ResultSet rset=stock_db.executeQuery(sql);
if(!rset.next()){//33333333333333333333333333333333333333333333333333333333333333


sql = "update stock_cell set check_time='"+check_time+"',checker='"+checker+"',designer='"+designer+"',cell_describe='"+cell_describe+"',min_amount='"+min_amount+"',max_amount='"+max_amount+"',check_tag='1',change_tag='0',serial_number_tag='"+serial_number_tag+"' where design_ID='"+design_ID+"'" ;
stock_db.executeUpdate(sql) ;
}else{

sql = "update stock_cell set check_time='"+check_time+"',checker='"+checker+"',designer='"+designer+"',cell_describe='"+cell_describe+"',min_amount='"+min_amount+"',max_amount='"+max_amount+"',check_tag='0',change_tag='0',serial_number_tag='"+serial_number_tag+"' where design_ID='"+design_ID+"'" ;
stock_db.executeUpdate(sql) ;


}





	String sql4="select * from stock_cell where design_ID='"+design_ID+"'";
	ResultSet rs4=stock_db.executeQuery(sql4);
	if(rs4.next()){
		product_ID=rs4.getString("product_ID");
	}
for(int i=1;i<num;i++){
String tem_nick_name="nick_name"+i;
String tem_max_capacity_amount="max_capacity_amount"+i;
String tem_amount_unit="amount_unit"+i;
String nick_name=request.getParameter(tem_nick_name) ;
String max_capacity_amount=request.getParameter(tem_max_capacity_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
if(max_capacity_amount.equals("")) max_capacity_amount="0";
String sql1 = "update stock_cell_details set nick_name='"+nick_name+"',max_capacity_amount='"+max_capacity_amount+"',amount_unit='"+amount_unit+"' where design_ID='"+design_ID+"' and details_number='"+i+"'" ;
stock_db.executeUpdate(sql1) ;



sql="select id from stock_workflow where object_ID='"+design_ID+"' and check_tag='0'";
ResultSet rset1=stock_db.executeQuery(sql);
if(!rset1.next()){//33333333333333333333333333333333333333333333333333333333333333
//
String sql2="select * from stock_cell_details where design_ID='"+design_ID+"' and details_number='"+i+"'";
ResultSet rs2=stock_db.executeQuery(sql2);
if(rs2.next()){
String sql3="update stock_balance_details set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+rs2.getString("stock_ID")+"'";
String sql5="update stock_pre_gathering set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+rs2.getString("stock_ID")+"'";
stock_db.executeUpdate(sql3) ;
stock_db.executeUpdate(sql5) ;
}
//
}

}

//
String sql77="update design_file set serial_number_tag='"+serial_number_tag+"' where product_ID='"+product_ID+"'";
stock_db.executeUpdate(sql77);
//
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("stock/cell/check_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("stock/cell/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("stock/cell/check_ok.jsp?finished_tag=2");
}
}else{
response.sendRedirect("stock/cell/check_ok.jsp?finished_tag=3");
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