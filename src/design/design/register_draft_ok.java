/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.design;
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;

import java.text.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import validata.ValidataTag;

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();

counter count=new counter(dbApplication);

try{
	if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_IDa=request.getParameter("product_IDa") ;
String product_namea=request.getParameter("product_namea") ;
String product_amount=request.getParameter("product_amount") ;
String register_time=request.getParameter("register_time") ;
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("module_describe").getBytes("UTF-8"),"UTF-8");
String module_describe=exchange.toHtml(bodyc);

int num=Integer.parseInt(product_amount);
int n=0;
for(int i=1;i<num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
		if(!validata.validata(amount)){
			n++;
		}
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_IDa,"design_module_tag").equals("0")){

if(n==0){
	
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String sql3="update design_file set design_module_tag='1' where product_ID='"+product_IDa+"'";
design_db.executeUpdate(sql3) ;	
String design_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));	
try{   
    String sqll="select * from design_file where product_ID='"+product_IDa+"'";
	ResultSet rs=design_db.executeQuery(sqll);
	if(rs.next()){
				
	String sql = "insert into design_module(design_ID,chain_ID,chain_name,product_ID,product_name,module_describe,register_time,designer,register,check_tag,excel_tag) values ('"+design_ID+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+product_IDa+"','"+product_namea+"','"+module_describe+"','"+register_time+"','"+designer+"','"+register+"','5','2')" ;
	
	design_db.executeUpdate(sql) ;
	}

double cost_price_sum=0.0d;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_type="type"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String type=request.getParameter(tem_type) ;
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
	
	
	
	String sql1 = "insert into design_module_details(design_ID,details_number,product_ID,product_name,type,product_describe,amount,cost_price,amount_unit,subtotal) values ('"+design_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+type+"','"+product_describe+"','"+amount+"','"+cost_price+"','"+amount_unit+"','"+subtotal+"')" ;
	design_db.executeUpdate(sql1) ;
}


String sql2="update design_module set cost_price_sum='"+cost_price_sum+"' where design_ID='"+design_ID+"'";
design_db.executeUpdate(sql2) ;

   
   
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("design/design/register_draft_ok.jsp?finished_tag=0");
}else{
	
	response.sendRedirect("design/design/register_draft_ok.jsp?finished_tag=1");
	}
}else{
	
response.sendRedirect("design/design/register_draft_ok.jsp?finished_tag=2");
}
design_db.commit();
manufacture_db.commit();
manufacture_db.close();
design_db.close();


}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}