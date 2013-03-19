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
import java.io.* ;
import java.util.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataTag;
import include.nseer_cookie.*;

public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
String product_providers_recommend_ID=request.getParameter("product_providers_recommend_ID") ;
String[] provider_IDn=request.getParameterValues("provider_ID") ;
int m=0;
for(int j=1;j<provider_IDn.length;j++){
	String sql3="select * from purchase_product_providers_recommend_details where product_providers_recommend_ID='"+product_providers_recommend_ID+"' and provider_ID='"+provider_IDn[j]+"'";
	ResultSet rs3=purchase_db.executeQuery(sql3) ;
	if(rs3.next()){
		String provider_ID_repeat=rs3.getString("provider_ID");
		m++;
	}
}
String provider_amount=request.getParameter("provider_amount") ;
int num=Integer.parseInt(provider_amount);

if(m!=0){
response.sendRedirect("purchase/product_providers/change_ok_a.jsp?product_providers_recommend_ID="+product_providers_recommend_ID+"");
}else if(num==0&&provider_IDn.length==1){
	response.sendRedirect("purchase/product_providers/change_ok_b.jsp?product_providers_recommend_ID="+product_providers_recommend_ID+"");
	}else{
	String recommender=request.getParameter("recommender") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String change_time=request.getParameter("change_time") ;
String changer=request.getParameter("changer") ;
try{
	String sql = "update purchase_product_providers_recommend set change_time='"+change_time+"',changer='"+changer+"',recommender='"+recommender+"',recommend_describe='"+recommend_describe+"',check_tag='0',change_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'" ;
	purchase_db.executeUpdate(sql) ;
for(int i=1;i<=num;i++){
	String tem_provider_name="provider_name"+i;
	String tem_provider_ID="provider_ID"+i;
String provider_name=request.getParameter(tem_provider_name) ;
String provider_ID=request.getParameter(tem_provider_ID) ;
	String sql1 = "update purchase_product_providers_recommend_details set details_number='"+i+"' where product_providers_recommend_ID='"+product_providers_recommend_ID+"' and provider_ID='"+provider_ID+"'" ;
	purchase_db.executeUpdate(sql1) ;
}
String[] provider_namen=request.getParameterValues("provider_name") ;
for(int j=1;j<provider_IDn.length;j++){
	int details_number=num+j;
	String sql4 = "insert into purchase_product_providers_recommend_details(product_providers_recommend_ID,details_number,provider_ID,provider_name) values ('"+product_providers_recommend_ID+"','"+details_number+"','"+provider_IDn[j]+"','"+provider_namen[j]+"')" ;
	purchase_db.executeUpdate(sql4) ;
}
List rsList = GetWorkflow.getList(purchase_db, "purchase_config_workflow", "03");

	if(rsList.size()==0){
		sql="update purchase_product_providers_recommend set check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
		purchase_db.executeUpdate(sql);
}else{
        sql="delete from purchase_workflow where object_ID='"+product_providers_recommend_ID+"'";
		purchase_db.executeUpdate(sql) ;
		sql="update purchase_product_providers_recommend set check_tag='0' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
		purchase_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_providers_recommend_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		purchase_db.executeUpdate(sql) ;
		}
	}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("purchase/product_providers/change_ok_c.jsp");
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