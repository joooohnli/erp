/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.credit;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import validata.ValidataRecord;
import include.nseer_cookie.*;

public class register_draft_ok extends HttpServlet{

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
FileKind FileKind=new FileKind();
ValidataRecord vr=new ValidataRecord();

String provider_ID=request.getParameter("provider_ID");
String gatherer_ID=request.getParameter("gatherer_ID");
String provider_name=request.getParameter("provider_name");
String[] aaa1=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"purchase_file","provider_ID",provider_ID);
String purchaser=request.getParameter("purchaser");
String purchaser_ID=request.getParameter("purchaser_ID");
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
	
	
	
	
	String gather_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));


String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String gatherer_name=request.getParameter("gatherer_name") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

	   

	String sql = "insert into stock_apply_gather(gatherer_chain_id,gatherer_chain_name,purchaser_ID,purchaser,gatherer_type,gather_ID,gatherer_ID,gatherer_name,reason,register_time,demand_return_time,remark,register,check_tag,excel_tag,not_return_tag) values ('"+aaa1[0]+"','"+aaa1[1]+"','"+purchaser_ID+"','"+purchaser+"','采购放货','"+gather_ID+"','"+provider_ID+"','"+provider_name+"','采购放货','"+register_time+"','"+demand_return_time+"','"+remark+"','"+register+"','5','2','"+not_return_tag+"')" ;
	purchase_db.executeUpdate(sql) ;
	
double cost_price_sum=0.0d;

double demand_amount=0.0d;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;

	String tem_cost_price="cost_price"+i;
		String tem_type="type"+i;

	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
String type=request.getParameter(tem_type) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	if(!amount.equals("")&&Double.parseDouble(amount)!=0){
	double cost_price_subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=cost_price_subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "insert into stock_apply_gather_details(gatherer_chain_id,gatherer_chain_name,purchaser_ID,purchaser,gatherer_ID,gatherer_name,gatherer_type,gather_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,cost_price,subtotal,type) values ('"+aaa1[0]+"','"+aaa1[1]+"','"+purchaser_ID+"','"+purchaser+"','"+provider_ID+"','"+provider_name+"','采购放货','"+gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+amount_unit+"','"+cost_price+"','"+cost_price_subtotal+"','"+type+"')" ;
	purchase_db.executeUpdate(sql1) ;
	}
}




String stock_gather_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));


   sql = "update stock_apply_gather set reason='"+reason+"',register='"+register+"',register_time='"+register_time+"',demand_return_time='"+demand_return_time+"',check_time='"+register_time+"',checker='"+register+"',remark='"+remark+"',demand_amount='"+demand_amount+"',cost_price_sum='"+cost_price_sum+"',not_return_tag='"+not_return_tag+"' where gather_ID='"+gather_ID+"'" ;
   purchase_db.executeUpdate(sql) ;
   if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",gather_ID)){
   String sql4="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_gather_ID+"','"+reason+"','"+gather_ID+"','"+gatherer_name+"','"+demand_amount+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
   purchase_db.executeUpdate(sql4) ;
   }
   
   
   
response.sendRedirect("purchase/credit/register_draft_ok.jsp?finished_tag=0");
	}else{
	response.sendRedirect("purchase/credit/register_draft_ok.jsp?finished_tag=1");
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