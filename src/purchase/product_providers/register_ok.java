/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.product_providers;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;
import validata.ValidataTag;
import include.nseer_cookie.*;
import include.nseer_cookie.NseerId;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);


String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String chain_id=request.getParameter("chain_id") ;
String chain_name=request.getParameter("chain_name") ;
String register_time=request.getParameter("register_time") ;
String recommender=request.getParameter("recommender") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);

String product_providers_recommend_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
 
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] provider_class=request.getParameterValues("provider_class") ;
String[] provider_web=request.getParameterValues("provider_web") ;
String[] provider_tel1=request.getParameterValues("provider_tel1") ;
String[] type=request.getParameterValues("type") ;
String[] contact_person1=request.getParameterValues("contact_person1") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"recommend_provider_tag").equals("0")){
if(provider_ID.length>1){
try{
    

String sql3="update design_file set recommend_provider_tag='1' where product_ID='"+product_ID+"'";
design_db.executeUpdate(sql3) ;
	String sql = "insert into purchase_product_providers_recommend(product_providers_recommend_ID,chain_id,chain_name,product_ID,product_name,recommend_describe,register_time,recommender,register,check_tag,excel_tag) values ('"+product_providers_recommend_ID+"','"+chain_id+"','"+chain_name+"','"+product_ID+"','"+product_name+"','"+recommend_describe+"','"+register_time+"','"+recommender+"','"+register+"','0','2')" ;
	purchase_db.executeUpdate(sql) ;
for(int i=1;i<provider_ID.length;i++){
	String sql1 = "insert into purchase_product_providers_recommend_details(product_providers_recommend_ID,details_number,provider_ID,provider_name,provider_class,provider_tel,provider_web,type,contact_person) values ('"+product_providers_recommend_ID+"','"+i+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+provider_class[i]+"','"+provider_tel1[i]+"','"+provider_web[i]+"','"+type[i]+"','"+contact_person1[i]+"')" ;
	purchase_db.executeUpdate(sql1) ;
}


List rsList = GetWorkflow.getList(purchase_db, "purchase_config_workflow", "03");


	if(rsList.size()==0){
		sql="update purchase_product_providers_recommend set check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
		purchase_db.executeUpdate(sql) ;
       String sql1="select * from purchase_file where provider_ID='"+provider_ID+"'";
       ResultSet rs1=purchase_db.executeQuery(sql1);
       if(rs1.next()){
	   String recommend_products=rs1.getString("recommend_products");
	   if(rs1.getString("recommend_products").indexOf(product_name)==-1){
		recommend_products+=product_name+", ";
	   }
       String sql2="update purchase_file set recommend_products='"+recommend_products+"' where provider_ID='"+provider_ID+"'";
       purchase_db.executeUpdate(sql2) ;
       }

}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_providers_recommend_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		purchase_db.executeUpdate(sql);
		}
	}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("purchase/product_providers/register_ok_a.jsp");
}else{
	response.sendRedirect("purchase/product_providers/register_ok_b.jsp?product_ID="+product_ID+"&&product_name="+toUtf8String.utf8String(exchange.toURL(product_name))+"");
	}
	}else{
	response.sendRedirect("purchase/product_providers/register_ok_c.jsp");
	}
		purchase_db.commit();	
	design_db.commit();
	purchase_db.close();
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