/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.product_providers;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import java.util.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataTag;

public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
String product_ID=request.getParameter("product_ID") ;
String product_name=exchange.unURL(request.getParameter("product_name")) ;
String product_logistics_recommend_ID=request.getParameter("product_logistics_recommend_ID") ;
String[] provider_IDn=request.getParameterValues("provider_ID") ;
int m=0;
for(int j=1;j<provider_IDn.length;j++){
	String sql3="select * from logistics_product_providers_recommend_details where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' and provider_ID='"+provider_IDn[j]+"'";
	ResultSet rs3=logistics_db.executeQuery(sql3) ;
	if(rs3.next()){
		String provider_ID_repeat=rs3.getString("provider_ID");
		m++;
	}
}
String provider_amount=request.getParameter("provider_amount") ;
int num=Integer.parseInt(provider_amount);

if(m!=0){
response.sendRedirect("logistics/product_providers/change_ok_a.jsp?product_logistics_recommend_ID="+product_logistics_recommend_ID+"");
}else if(num==0&&provider_IDn.length==1){
	response.sendRedirect("logistics/product_providers/change_ok_b.jsp?product_logistics_recommend_ID="+product_logistics_recommend_ID+"");
	}else{
	String recommender=request.getParameter("recommender") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String change_time=request.getParameter("change_time") ;
String changer=request.getParameter("changer") ;
try{

	String sql = "update logistics_product_providers_recommend set change_time='"+change_time+"',changer='"+changer+"',recommender='"+recommender+"',recommend_describe='"+recommend_describe+"',change_tag='1' where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"'" ;
	logistics_db.executeUpdate(sql) ;
String provider_name="" ;
String provider_ID="" ;
for(int i=1;i<=num;i++){
	String tem_provider_name="provider_name"+i;
	String tem_provider_ID="provider_ID"+i;
		provider_name=request.getParameter(tem_provider_name) ;
		provider_ID=request.getParameter(tem_provider_ID) ;
	String sql1 = "update logistics_product_providers_recommend_details set details_number='"+i+"' where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' and provider_ID='"+provider_ID+"'" ;
	logistics_db.executeUpdate(sql1) ;
}
String[] provider_namen=request.getParameterValues("provider_name") ;
for(int j=1;j<provider_IDn.length;j++){
	int details_number=num+j;
	String sql4 = "insert into logistics_product_providers_recommend_details(product_logistics_recommend_ID,details_number,provider_ID,provider_name) values ('"+product_logistics_recommend_ID+"','"+details_number+"','"+provider_IDn[j]+"','"+provider_namen[j]+"')" ;
	logistics_db.executeUpdate(sql4) ;
}

List rsList = GetWorkflow.getList(logistics_db, "logistics_config_workflow", "03");
	String[] elem=new String[3];
	if(rsList.size()==0){
		sql="update logistics_product_providers_recommend set check_tag='1' where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"'";
		logistics_db.executeUpdate(sql);

	String provider_group="";
	for(int i=1;i<=num;i++){
String sql1="select * from logistics_file where provider_ID='"+provider_ID+"'";
ResultSet rs1=logistics_db.executeQuery(sql1);
if(rs1.next()){
	String recommend_products=rs1.getString("recommend_products");
	if(rs1.getString("recommend_products").indexOf(product_name)==-1){
		recommend_products+=product_name+", ";
	}
String sql2="update logistics_file set recommend_products='"+recommend_products+"' where provider_ID='"+provider_ID+"'";
logistics_db.executeUpdate(sql2) ;
}

provider_group=provider_group+provider_name+", ";
}
String sql3="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs3=logistics_db.executeQuery(sql3);
if(rs3.next()){
String sql4="update design_file set provider_group='"+provider_group+"' where product_ID='"+product_ID+"'";
logistics_db.executeUpdate(sql4) ;
}
}else{
        sql="delete from logistics_workflow where object_ID='"+product_logistics_recommend_ID+"'";
		logistics_db.executeUpdate(sql) ;
		sql="update logistics_product_providers_recommend set check_tag='0' where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"'";
		logistics_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into logistics_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_logistics_recommend_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		logistics_db.executeUpdate(sql) ;
		}
	}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("logistics/product_providers/change_ok_c.jsp");
}
		logistics_db.commit();	
logistics_db.close();

  }else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 