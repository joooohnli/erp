/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.credit;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.util.*;
import java.io.*;
import include.nseer_cookie.* ;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import validata.ValidataRecord;

public class register_draft_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
PrintWriter out=response.getWriter();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
counter  count= new  counter(dbApplication);
ValidataNumber validata= new  ValidataNumber();
FileKind  FileKind= new  FileKind();
ValidataRecord vr= new   ValidataRecord();

String customer_ID=request.getParameter("customer_ID");
String customer_name=request.getParameter("customer_name");
String[] aaa1=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID);
String sales_name=request.getParameter("sales_name");
String sales_ID=request.getParameter("sales_ID");
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

int p=0;
for(int i=1;i<num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
	if(!validata.validata(amount)){
			p++;
		}
}

if(p==0){
String pay_ID=request.getParameter("pay_ID") ;
if(pay_ID.equals("")){
pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
}
String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
List rsList = GetWorkflow.getList(crm_db, "crm_config_workflow", "05");
String[] elem=new String[3];
String stock_pay_ID="";
stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
	String sql = "insert into stock_apply_pay(payer_chain_ID,payer_chain_name,sales_ID,sales_name,payer_type,pay_ID,payer_ID,payer_name,reason,register_time,demand_return_time,remark,register,check_tag,excel_tag,not_return_tag) values ('"+aaa1[0]+"','"+aaa1[1]+"','"+sales_ID+"','"+sales_name+"','销售赊货','"+pay_ID+"','"+customer_ID+"','"+customer_name+"','销售赊货','"+register_time+"','"+demand_return_time+"','"+remark+"','"+register+"','5','2','"+not_return_tag+"')" ;
	stock_db.executeUpdate(sql) ;
	
double list_price_sum=0.0d;
double cost_price_sum=0.0d;

double demand_amount=0.0d;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_list_price="list_price"+i;
		String tem_cost_price="cost_price"+i;
		String tem_type="type"+i;

	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String list_price2=request.getParameter(tem_list_price) ;
String cost_price=request.getParameter(tem_cost_price) ;
String type=request.getParameter(tem_type) ;
StringTokenizer tokenTO3 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO3.hasMoreTokens()) {
                String list_price1 = tokenTO3.nextToken();
		list_price +=list_price1;
		}
	if(!amount.equals("")&&Double.parseDouble(amount)!=0){
	double list_price_subtotal=Double.parseDouble(list_price)*Double.parseDouble(amount);
	list_price_sum+=list_price_subtotal;
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "insert into stock_apply_pay_details(payer_chain_ID,payer_chain_name,sales_ID,sales_name,payer_ID,payer_name,payer_type,pay_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,list_price,list_price_subtotal,cost_price,subtotal,type) values ('"+aaa1[0]+"','"+aaa1[1]+"','"+sales_ID+"','"+sales_name+"','"+customer_ID+"','"+customer_name+"','销售赊货','"+pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+amount_unit+"','"+list_price+"','"+list_price_subtotal+"','"+cost_price+"','"+subtotal+"','"+type+"')" ;
	stock_db.executeUpdate(sql1) ;
	}
}

if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",pay_ID)){
	String sql4="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,list_price_sum,cost_price_sum,register,register_time) values('"+stock_pay_ID+"','"+reason+"','"+pay_ID+"','"+customer_name+"','"+demand_amount+"','"+list_price_sum+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql4) ;
}

String sql2="update stock_apply_pay set list_price_sum='"+list_price_sum+"',cost_price_sum='"+cost_price_sum+"',demand_amount='"+demand_amount+"' where pay_ID='"+pay_ID+"'";
stock_db.executeUpdate(sql2) ;
response.sendRedirect("crm/credit/register_draft_ok.jsp?finished_tag=0");	
}else{
	response.sendRedirect("crm/credit/register_draft_ok.jsp?finished_tag=1");
}
stock_db.commit();
crm_db.commit();
crm_db.close();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}