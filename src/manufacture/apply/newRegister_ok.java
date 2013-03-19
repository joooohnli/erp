/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.apply;
 
 
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
import validata.ValidataNumber;
import include.nseer_cookie.counter;
public class newRegister_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
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

String reason=request.getParameter("reason") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_gather_time=request.getParameter("demand_gather_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
try{
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

String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
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
	String sql = "insert into manufacture_apply(apply_ID,product_ID,product_name,product_describe,amount,remark,register,register_time,type,pay_id_group) values('"+apply_ID+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+remark+"','"+register+"','"+register_time+"','"+type+"','"+reason+"')";
	manufacture_db.executeUpdate(sql) ;
	}
}
List rsList = GetWorkflow.getList(manufacture_db, "manufacture_config_workflow", "03");
String[] elem=new String[3];
	if(rsList.size()==0){
		String pay_ID_group="";
		String sql = "update manufacture_apply set check_tag='1' where apply_ID='"+apply_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
		 sql="select * from manufacture_apply where apply_ID='"+apply_ID+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql) ;
	if(rs1.next()){
		pay_ID_group=rs1.getString("pay_ID_group");
	}
StringTokenizer tokenTO = new StringTokenizer(pay_ID_group,", ");        
        while(tokenTO.hasMoreTokens()) {
		 sql="select * from stock_pay where pay_ID='"+tokenTO.nextToken()+"'";
		 rs1=manufacture_db.executeQuery(sql) ;
		if(rs1.next()){
			 sql = "update crm_order set manufacture_tag='2' where order_ID='"+rs1.getString("reasonexact")+"'" ;
			manufacture_db.executeUpdate(sql) ;
		}
		}
		 
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		String sql = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+apply_ID+"','"+elem[1]+"','"+elem[2]+"','03')" ;
		manufacture_db.executeUpdate(sql) ;
  
		}
	}

}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("manufacture/apply/newRegister_ok_a.jsp");
}else{
	
	response.sendRedirect("manufacture/apply/newRegister_ok_b.jsp");
}

manufacture_db.commit();
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