/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package portal.logistics;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

import java.sql.*;
import java.util.* ;
import java.io.* ;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange ;
import include.nseer_db.*;

import java.text.*;

import include.nseer_cookie.counter;
import validata.ValidataNumber;
import include.get_rate_from_ID.getRateFromID;


public class register2_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
	HttpSession dbSession=request.getSession();
	JspFactory _jspxFactory=JspFactory.getDefaultFactory();
	PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
	ServletContext dbApplication=dbSession.getServletContext(); 
	try{
		String provider_ID=request.getParameter("provider_ID") ;
	PrintWriter out=response.getWriter();
	session=request.getSession();
	nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
	if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	ValidataNumber validata= new ValidataNumber();
	getRateFromID getRateFromID= new getRateFromID();
	String register_ID=(String)session.getAttribute("human_IDD");
	String product_amount=request.getParameter("product_amount") ;
	int num=Integer.parseInt(product_amount);
	int n=0;
	for(int i=1;i<num;i++){
		String tem_amount="amount"+i;
		String tem_off_discount="off_discount"+i;
		String tem_list_price="list_price"+i;
	String amount=request.getParameter(tem_amount) ;
	String off_discount=request.getParameter(tem_off_discount) ;
	String list_price2=request.getParameter(tem_list_price) ;
	StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
	String list_price="";
	            while(tokenTO2.hasMoreTokens()) {
	                String list_price1 = tokenTO2.nextToken();
			list_price +=list_price1;
			}
			if(!validata.validata(amount)||!validata.validata(off_discount)||!validata.validata(list_price)){
				n++;
			}
	}
	if(n==0){
	String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);
	String discussion_ID=NseerId.getId("logistics/discussion",(String)dbSession.getAttribute("unit_db_name"));
	String provider_name=exchange.unURL(request.getParameter("provider_name")) ;
	String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
	String demand_pay_time=request.getParameter("demand_pay_time") ;
	String register_time=request.getParameter("register_time") ;
	String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
	String remark=exchange.toHtml(bodyc);
	try{
		String sql3="select * from logistics_file where provider_ID='"+provider_ID+"'";
		ResultSet rs=logistics_db.executeQuery(sql3);
		if(rs.next()){
		String sql = "insert into logistics_discussion(discussion_ID,chain_id,chain_name,provider_ID,provider_name,demand_contact_person_tel,demand_pay_time,register_time,remark,check_tag,excel_tag) values ('"+discussion_ID+"','"+rs.getString("chain_id")+"','"+rs.getString("chain_name")+"','"+provider_ID+"','"+rs.getString("provider_name")+"','"+demand_contact_person_tel+"','"+demand_pay_time+"','"+register_time+"','"+remark+"','0','2')" ;
		logistics_db.executeUpdate(sql) ;
		}
	String id="";
	String sqlb="select id from logistics_discussion where discussion_ID='"+discussion_ID+"'";
	rs=logistics_db.executeQuery(sqlb);
		if(rs.next()){
			id=rs.getString("id");
		}
	double sale_price_sum=0.0d;
	double cost_price_sum=0.0d;
	double real_cost_price_sum=0.0d;
	int pay_amount_sum=0;
	for(int i=1;i<num;i++){
		String tem_product_name="product_name"+i;
		String tem_product_ID="product_ID"+i;
		String tem_product_describe="product_describe"+i;
		String tem_amount="amount"+i;
		String tem_off_discount="off_discount"+i;
		String tem_list_price="list_price"+i;
		String tem_cost_price="cost_price"+i;
		String tem_real_cost_price="real_cost_price"+i;
		String tem_amount_unit="amount_unit"+i ;
	String product_name=request.getParameter(tem_product_name) ;
	String product_ID=request.getParameter(tem_product_ID) ;
	String product_describe=request.getParameter(tem_product_describe) ;
	String amount=request.getParameter(tem_amount) ;
	String amount_unit=request.getParameter(tem_amount_unit) ;
	String off_discount=request.getParameter(tem_off_discount) ;
	String list_price2=request.getParameter(tem_list_price) ;
	StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
	String list_price="";
	            while(tokenTO2.hasMoreTokens()) {
	                String list_price1 = tokenTO2.nextToken();
			list_price +=list_price1;
			}
	String cost_price2=request.getParameter(tem_cost_price) ;
	StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
	String cost_price="";
	            while(tokenTO3.hasMoreTokens()) {
	                String cost_price1 = tokenTO3.nextToken();
			cost_price +=cost_price1;
			}
	String real_cost_price2=request.getParameter(tem_real_cost_price) ;
	StringTokenizer tokenTO4 = new StringTokenizer(real_cost_price2,",");        
	String real_cost_price="";
	            while(tokenTO4.hasMoreTokens()) {
	                String real_cost_price1 = tokenTO4.nextToken();
			real_cost_price +=real_cost_price1;
			}
		double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount);
		double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount);
		double real_cost_price_after_discount_sum=Double.parseDouble(real_cost_price)*Double.parseDouble(amount);
		sale_price_sum+=subtotal;
		cost_price_sum+=cost_price_after_discount_sum;
		real_cost_price_sum+=real_cost_price_after_discount_sum;
		pay_amount_sum+=Double.parseDouble(amount);
		String sql1 = "insert into logistics_discussion_details(discussion_ID,details_number,product_ID,product_name,product_describe,list_price,amount,cost_price,real_cost_price,off_discount,subtotal,amount_unit) values ('"+discussion_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+list_price+"','"+amount+"','"+cost_price+"','"+real_cost_price+"','"+off_discount+"','"+subtotal+"','"+amount_unit+"')" ;
		logistics_db.executeUpdate(sql1) ;
	}
	List rsList = (List)new java.util.ArrayList();
		String[] elem=new String[3];
		String sql="select id,describe1,describe2 from logistics_config_workflow where type_id='02'";
		ResultSet rset=logistics_db.executeQuery(sql);
		while(rset.next()){
			elem=new String[3];
			elem[0]=rset.getString("id");
			elem[1]=rset.getString("describe1");
			elem[2]=rset.getString("describe2");
			rsList.add(elem);
		}
		if(rsList.size()==0){
			sql="update logistics_discussion set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"',check_tag='1' where discussion_ID='"+discussion_ID+"'";
			logistics_db.executeUpdate(sql) ;
		}else{
			sql="update logistics_discussion set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"' where discussion_ID='"+discussion_ID+"'";
			logistics_db.executeUpdate(sql) ;
			Iterator ite=rsList.iterator();
			while(ite.hasNext()){
			elem=(String[])ite.next();
			sql = "insert into logistics_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+discussion_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
			logistics_db.executeUpdate(sql) ;
	  
			}
		}
response.sendRedirect("portal/logistics/register2_choose_attachment.jsp?discussion_ID="+discussion_ID+"");	
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	
	response.sendRedirect("portal/logistics/register2_ok_a.jsp?provider_ID="+provider_ID);
	}
	logistics_db.commit();
	logistics_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}