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
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import validata.ValidataNumber;
import include.nseer_cookie.counter;
import validata.ValidataTag;
import include.nseer_cookie.*;

public class register_ok extends HttpServlet{

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
String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String procedure_amount=request.getParameter("procedure_amount") ;
int num=Integer.parseInt(procedure_amount);
String register_time=request.getParameter("register_time") ;
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("procedure_describea").getBytes("UTF-8"),"UTF-8");
String procedure_describea=exchange.toHtml(bodyc);
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
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"design_procedure_tag").equals("0")){

if(n==0){
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String sql3="update design_file set design_procedure_tag='1' where product_ID='"+product_ID+"'";
design_db.executeUpdate(sql3) ;

try{
	String design_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
	String sqll="select * from design_file where product_ID='"+product_ID+"'";
	ResultSet rs=design_db.executeQuery(sqll);
	if(rs.next()){
	 String sql = "insert into manufacture_design_procedure(design_ID,chain_ID,chain_name,product_ID,product_name,procedure_describe,register_time,designer,register,check_tag,excel_tag) values ('"+design_ID+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+product_ID+"','"+product_name+"','"+procedure_describea+"','"+register_time+"','"+designer+"','"+register+"','0','2')" ;
	manufacture_db.executeUpdate(sql) ;
	}

double cost_price_sum=0.0d;
for(int i=1;i<num;i++){
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
if(!labour_hour_amount.equals("")&&Double.parseDouble(labour_hour_amount)!=0){
if(cost_price2.equals("")) cost_price2="0";
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(labour_hour_amount);
	cost_price_sum+=subtotal;
	String sql1 = "insert into manufacture_design_procedure_details(design_ID,details_number,procedure_ID,procedure_name,procedure_describe,labour_hour_amount,cost_price,amount_unit,subtotal) values ('"+design_ID+"','"+i+"','"+procedure_ID+"','"+procedure_name+"','"+procedure_describe+"','"+labour_hour_amount+"','"+cost_price+"','"+amount_unit+"','"+subtotal+"')" ;
	manufacture_db.executeUpdate(sql1) ;
}
}

    List rsList = GetWorkflow.getList(manufacture_db, "manufacture_config_workflow", "01");
    String[] elem=new String[3];


	if(rsList.size()==0){
		String sql="update manufacture_design_procedure set cost_price_sum='"+cost_price_sum+"',check_tag='1' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql) ;

		String sql4="delete from manufacture_design_procedure_module_details where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql4) ;
		String module_design_ID="";
		String sql5="select * from design_module where product_ID='"+product_ID+"' and check_tag='1' and excel_tag='2'";
		ResultSet rs5=design_db.executeQuery(sql5);
			if(rs5.next()){
				module_design_ID=rs5.getString("design_ID");
			}
		String sql6="select * from design_module_details where design_ID='"+module_design_ID+"'";
		ResultSet rs6=design_db1.executeQuery(sql6);
			while(rs6.next()){
		String sql7="update design_module_details set design_balance_amount='"+rs6.getString("amount")+"' where id='"+rs6.getString("id")+"'";
			design_db.executeUpdate(sql7);
}
String sql2="update manufacture_design_procedure set cost_price_sum='"+cost_price_sum+"' where design_ID='"+design_ID+"'";
manufacture_db.executeUpdate(sql2) ;
	}else{
		String sql="update manufacture_design_procedure set cost_price_sum='"+cost_price_sum+"' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"','01')" ;
		manufacture_db.executeUpdate(sql) ;
  
		}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("manufacture/design_procedure/register_ok_a.jsp");
}else{

	response.sendRedirect("manufacture/design_procedure/register_ok_b.jsp?product_ID="+product_ID+"&&product_name="+product_name+"");
}
}else{

response.sendRedirect("manufacture/design_procedure/register_ok_c.jsp");
}
  design_db.commit();
  manufacture_db.commit();
  design_db1.commit();
  design_db.close();
  manufacture_db.close();
  design_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 