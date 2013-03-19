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
import java.util.Iterator;
import java.util.List;

import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.nseer_cookie.GetWorkflow;

public class change_ok extends HttpServlet{

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
String min_amount=request.getParameter("min_amount") ;
String max_amount=request.getParameter("max_amount") ;
String stock_amount=request.getParameter("stock_amount") ;
String design_ID=request.getParameter("design_ID") ;
String product_ID=request.getParameter("product_ID") ;
int num=Integer.parseInt(stock_amount);
String bodyc = new String(request.getParameter("cell_describe").getBytes("UTF-8"),"UTF-8");
String cell_describe=exchange.toHtml(bodyc);
String change_time=request.getParameter("change_time") ;
String changer=request.getParameter("changer") ;
int p=0;
int q=0;
for(int i=1;i<num;i++){
	String tem_max_capacity_amount="max_capacity_amount"+i;
	String tem_nick_name="nick_name"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_stock_ID="stock_ID"+i;
String stock_ID=request.getParameter(tem_stock_ID) ;
String max_capacity_amount=request.getParameter(tem_max_capacity_amount) ;
String nick_name=request.getParameter(tem_nick_name) ;
String amount_unit=request.getParameter(tem_amount_unit) ;;
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
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_cell","design_ID",design_ID,"check_tag").equals("1")){

if(p==0&&q<num-1){
List rsList = GetWorkflow.getList(stock_db, "stock_config_workflow", "07");
	String[] elem=new String[3];
try{
	String sql = "update stock_cell set change_time='"+change_time+"',changer='"+changer+"',cell_describe='"+cell_describe+"',min_amount='"+min_amount+"',max_amount='"+max_amount+"',check_tag='0',change_tag='1' where design_ID='"+design_ID+"'" ;
	stock_db.executeUpdate(sql) ;
//**********************************************************
if(rsList.size()==0){
String sql77="update stock_cell set check_tag='1',change_tag='0' where design_ID='"+design_ID+"'";
stock_db.executeUpdate(sql77);
}else{
String nseer_sql1 = "delete from stock_workflow where object_ID='"+design_ID+"'";
stock_db.executeUpdate(nseer_sql1);
Iterator ite=rsList.iterator();
while(ite.hasNext()){
elem=(String[])ite.next();
nseer_sql1 = "insert into stock_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"')";
stock_db.executeUpdate(nseer_sql1);
}
}
//***************************************************
for(int i=1;i<num;i++){
	String tem_stock_name="stock_name"+i;
	String tem_stock_ID="stock_ID"+i;
	String tem_nick_name="nick_name"+i;
	String tem_max_capacity_amount="max_capacity_amount"+i;
	String tem_amount_unit="amount_unit"+i;
String stock_name=request.getParameter(tem_stock_name) ;
String stock_ID=request.getParameter(tem_stock_ID) ;
String nick_name=request.getParameter(tem_nick_name) ;
String max_capacity_amount=request.getParameter(tem_max_capacity_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
if(!max_capacity_amount.equals("")&&Double.parseDouble(max_capacity_amount)!=0){
String sql3="select * from stock_cell_details where design_ID='"+design_ID+"' and stock_name='"+stock_name+"'";
ResultSet rs3=stock_db.executeQuery(sql3) ;
if(rs3.next()){
	String sql1 = "update stock_cell_details set details_number='"+i+"',nick_name='"+nick_name+"',max_capacity_amount='"+max_capacity_amount+"',amount_unit='"+amount_unit+"' where design_ID='"+design_ID+"' and stock_name='"+stock_name+"'" ;
	stock_db.executeUpdate(sql1) ;
}else{
	String sql2 = "insert into stock_cell_details(design_ID,details_number,stock_ID,stock_name,nick_name,max_capacity_amount,amount_unit) values ('"+design_ID+"','"+i+"','"+stock_ID+"','"+stock_name+"','"+nick_name+"','"+max_capacity_amount+"','"+amount_unit+"')" ;
	stock_db.executeUpdate(sql2) ;
}

if(rsList.size()==0){
String sql31="update stock_balance_details set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
String sql5="update stock_pre_gathering set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
stock_db.executeUpdate(sql31) ;
stock_db.executeUpdate(sql5) ;
}

}else if(max_capacity_amount.equals("")||Double.parseDouble(max_capacity_amount)==0){
	String sql4 = "delete from stock_cell_details where design_ID='"+design_ID+"' and stock_ID='"+stock_ID+"'" ;
	stock_db.executeUpdate(sql4) ;
}
}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("stock/cell/change_ok_a.jsp");
}else{
response.sendRedirect("stock/cell/change_ok_b.jsp?design_ID="+design_ID+"");
}
}else{
response.sendRedirect("stock/cell/change_ok_c.jsp");
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