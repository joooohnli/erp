/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.procedure;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String product_describe=request.getParameter("product_describe");
String amount=request.getParameter("amount");
String pay_ID_group=request.getParameter("pay_ID_group");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String design_ID=request.getParameter("design_ID") ;
String choice_group=request.getParameter("choice_group");
String[] procedure_ID=request.getParameterValues("procedure_ID");
String[] procedure_name=request.getParameterValues("procedure_name");
String[] procedure_describe=request.getParameterValues("procedure_describe");
String[] labour_hour_amount=request.getParameterValues("labour_hour_amount");
String[] amount_unit=request.getParameterValues("amount_unit");
String[] cost_price=request.getParameterValues("cost_price");
String[] subtotal=request.getParameterValues("subtotal");
double module_cost_price_sum=0.0d;
double labour_cost_price_sum=0.0d;
for(int i=0;i<procedure_name.length;i++){
	int j=i+1;
	double module_subtotal=0.0d;
	labour_cost_price_sum+=Double.parseDouble(subtotal[i]);
	
	String sql1="select * from manufacture_design_procedure_module_details where design_ID='"+design_ID+"' and procedure_name='"+procedure_name[i]+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql1);
	while(rs1.next()){
		double module_amount=rs1.getDouble("amount")*Double.parseDouble(amount);
		double subtotal1=rs1.getDouble("cost_price")*module_amount;
		module_subtotal+=subtotal1;
		module_cost_price_sum+=subtotal1;
		String sql2="insert into manufacture_procedure_module(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,type,amount,amount_unit,cost_price,subtotal) values('"+manufacture_ID+"','"+procedure_name[i]+"','"+rs1.getString("details_number")+"','"+rs1.getString("product_ID")+"','"+rs1.getString("product_name")+"','"+rs1.getString("product_describe")+"','"+rs1.getString("type")+"','"+module_amount+"','"+rs1.getString("amount_unit")+"','"+rs1.getString("cost_price")+"','"+subtotal1+"')";
		manufacture_db.executeUpdate(sql2);
	}

	String sql="insert into manufacture_procedure(manufacture_ID,details_number,procedure_ID,procedure_name,procedure_describe,labour_hour_amount,amount_unit,cost_price,subtotal,module_subtotal) values('"+manufacture_ID+"','"+j+"','"+procedure_ID[i]+"','"+procedure_name[i]+"','"+procedure_describe[i]+"','"+labour_hour_amount[i]+"','"+amount_unit[i]+"','"+cost_price[i]+"','"+subtotal[i]+"','"+module_subtotal+"')";
	manufacture_db.executeUpdate(sql);
}

	String sql3="insert into manufacture_manufacture(manufacture_ID,product_ID,product_name,product_describe,amount,pay_ID_group,apply_id_group,module_cost_price_sum,labour_cost_price_sum,register_time,designer,register,remark,check_tag,excel_tag) values('"+manufacture_ID+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+pay_ID_group+"','"+choice_group+"','"+module_cost_price_sum+"','"+labour_cost_price_sum+"','"+register_time+"','"+designer+"','"+register+"','"+remark+"','0','2')";
	manufacture_db.executeUpdate(sql3);
	
	StringTokenizer tokenTO = new StringTokenizer(choice_group,",");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update manufacture_apply set manufacture_tag='1' where id='"+tokenTO.nextToken()+"'";
		manufacture_db.executeUpdate(sql4) ;
		}
int num=count.read((String)dbSession.getAttribute("unit_db_name"),"manufacturecount");
count.write((String)dbSession.getAttribute("unit_db_name"),"manufacturecount",num);
    manufacture_db.commit();
	manufacture_db.close();
	response.sendRedirect("manufacture/procedure/register_ok_a.jsp?manufacture_ID="+manufacture_ID+"");
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 