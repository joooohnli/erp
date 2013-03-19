/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.apply;
 
 
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
import validata.ValidataNumber;
import include.nseer_cookie.*;

public class newRegister_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

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

String reason=request.getParameter("reason") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_gather_time=request.getParameter("demand_gather_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

String apply_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

double real_cost_price_sum=0.0d;
double demand_amount=0.0d;

for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_real_cost_price="real_cost_price"+i;
		String tem_type="type"+i;

String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String real_cost_price2=request.getParameter(tem_real_cost_price) ;
String type=request.getParameter(tem_type) ;
StringTokenizer tokenTO3 = new StringTokenizer(real_cost_price2,",");        
String real_cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String real_cost_price1 = tokenTO3.nextToken();
		real_cost_price +=real_cost_price1;
		}
	if(!amount.equals("")&&Double.parseDouble(amount)!=0){
	double real_cost_price_subtotal=Double.parseDouble(real_cost_price)*Double.parseDouble(amount);
	real_cost_price_sum+=real_cost_price_subtotal;
	
	demand_amount+=Double.parseDouble(amount);
	String sql = "insert into purchase_apply(apply_ID,product_ID,product_name,product_describe,amount,remark,register,register_time,new_tag,check_tag,pay_ID_group) values('"+apply_ID+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+remark+"','"+register+"','"+register_time+"','1','5','新发生')";
	purchase_db.executeUpdate(sql) ;
	}
}

response.sendRedirect("purchase/apply/newRegister_draft_ok.jsp?finished_tag=0");
	}else{
response.sendRedirect("purchase/apply/newRegister_draft_ok.jsp?finished_tag=1");
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