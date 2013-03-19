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
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;

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
counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();

try{
    String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);
	
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String min_amount=request.getParameter("min_amount") ;
String max_amount=request.getParameter("max_amount") ;
String stock_amount=request.getParameter("stock_amount") ;
String serial_number_tag=request.getParameter("serial_number_tag") ;

List rsList = GetWorkflow.getList(stock_db, "stock_config_workflow", "07");
	String[] elem=new String[3];

if(serial_number_tag.equals("否")) {
	serial_number_tag="0";}else{
if(serial_number_tag.equals("设置B/N")) {
	serial_number_tag="2";}else{
	serial_number_tag="1";
	}  
}

int num=Integer.parseInt(stock_amount);
int p=0;
int q=0;
for(int i=1;i<num;i++){
	String tem_max_capacity_amount="max_capacity_amount"+i;
	String tem_nick_name="nick_name"+i;
	String tem_amount_unit="amount_unit"+i;
String max_capacity_amount=request.getParameter(tem_max_capacity_amount) ;
String nick_name=request.getParameter(tem_nick_name) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
if(max_capacity_amount.equals("")) max_capacity_amount="0";
		if(!validata.validata(max_capacity_amount)){
			p++;
		}else if(Double.parseDouble(max_capacity_amount)==0){
			q++;
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
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"design_cell_tag").equals("0")){

if(p==0&&q<num-1){
String sql3="update design_file set design_cell_tag='1' where product_ID='"+product_ID+"'";
stock_db.executeUpdate(sql3) ;

String register_time=request.getParameter("register_time") ;
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String type=request.getParameter("type") ;
String bodyc = new String(request.getParameter("describe").getBytes("UTF-8"),"UTF-8");
String describe=exchange.toHtml(bodyc);
String design_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));	
	
if(rsList.size()==0){


String sqll="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs=stock_db.executeQuery(sqll);
if(rs.next()){
String sql = "insert into stock_cell(design_ID,chain_ID,chain_name,product_ID,product_name,type,cell_describe,register_time,designer,register,min_amount,max_amount,excel_tag,serial_number_tag,check_tag) values ('"+design_ID+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+product_ID+"','"+product_name+"','"+type+"','"+describe+"','"+register_time+"','"+designer+"','"+register+"','"+min_amount+"','"+max_amount+"','2','"+serial_number_tag+"','1')" ;
stock_db.executeUpdate(sql) ;
}

String sql77="update design_file set serial_number_tag='"+serial_number_tag+"' where product_ID='"+product_ID+"'";
stock_db.executeUpdate(sql77);

}else{

String sqll="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs=stock_db.executeQuery(sqll);
if(rs.next()){
String sql = "insert into stock_cell(design_ID,chain_ID,chain_name,product_ID,product_name,type,cell_describe,register_time,designer,register,min_amount,max_amount,check_tag,excel_tag,serial_number_tag) values ('"+design_ID+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+product_ID+"','"+product_name+"','"+type+"','"+describe+"','"+register_time+"','"+designer+"','"+register+"','"+min_amount+"','"+max_amount+"','0','2','"+serial_number_tag+"')" ;
stock_db.executeUpdate(sql) ;
}

Iterator ite=rsList.iterator();
while(ite.hasNext()){
elem=(String[])ite.next();
String nseer_sql1 = "insert into stock_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"')";
stock_db.executeUpdate(nseer_sql1);
}
}

int j=1;
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

if(rsList.size()==0){
String sql2="select * from stock_cell_details where design_ID='"+design_ID+"' and details_number='"+i+"'";
ResultSet rs2=stock_db.executeQuery(sql2);
if(rs2.next()){
String sql31="update stock_balance_details set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+rs2.getString("stock_ID")+"'";
String sql5="update stock_pre_gathering set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+rs2.getString("stock_ID")+"'";
stock_db.executeUpdate(sql31) ;
stock_db.executeUpdate(sql5) ;
}

}else{

if(!max_capacity_amount.equals("")){
	String sql1 = "insert into stock_cell_details(design_ID,details_number,stock_ID,stock_name,nick_name,max_capacity_amount,amount_unit) values ('"+design_ID+"','"+j+"','"+stock_ID+"','"+stock_name+"','"+nick_name+"','"+max_capacity_amount+"','"+amount_unit+"')" ;
	stock_db.executeUpdate(sql1) ;
	j++;
}
}
}
response.sendRedirect("stock/cell/register_ok_a.jsp");
}else{
	session.setAttribute("product_name",product_name);
response.sendRedirect("stock/cell/register_ok_b.jsp?product_ID="+product_ID+"");
}
}else{
response.sendRedirect("stock/cell/register_ok_c.jsp");
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