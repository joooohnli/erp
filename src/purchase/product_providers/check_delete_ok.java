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
import javax.servlet.*;
import java.io.* ;
import java.sql.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import validata.ValidataTag;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db1 = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&purchase_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataTag vt=new ValidataTag();

String product_providers_recommend_ID=request.getParameter("product_providers_recommend_ID") ;
String recommender=request.getParameter("recommender") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String product_ID=request.getParameter("product_ID") ;
String config_id=request.getParameter("config_id");
String choice=request.getParameter("choice");
String product_name=request.getParameter("product_name") ;
String sql6="select id from purchase_workflow where object_ID='"+product_providers_recommend_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=purchase_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_product_providers_recommend","product_providers_recommend_ID",product_providers_recommend_ID,"check_tag").equals("0")){
try{
	String sql2="update purchase_product_providers_recommend set check_time='"+check_time+"',checker='"+checker+"',recommender='"+recommender+"',recommend_describe='"+recommend_describe+"',change_tag='0' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
	purchase_db.executeUpdate(sql2) ;
	String sql1="update design_file set recommend_provider_tag='0' where product_ID='"+product_ID+"'";
	purchase_db1.executeUpdate(sql1) ;
if(choice!=null){
	if(choice.equals("")){
	String sql = "update purchase_product_providers_recommend set check_tag='9' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
	purchase_db.executeUpdate(sql) ;
    sql = "delete from purchase_workflow where object_ID='"+product_providers_recommend_ID+"'" ;
	purchase_db.executeUpdate(sql) ;
	}else{
    sql6="select id from purchase_workflow where object_ID='"+product_providers_recommend_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=purchase_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update purchase_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		purchase_db1.executeUpdate(sql) ;
	}
	}
    response.sendRedirect("purchase/product_providers/check_delete_ok.jsp?finished_tag=3");
}else{
	response.sendRedirect("purchase/product_providers/check_delete_ok.jsp?finished_tag=2");
	}
}
catch (Exception ex) {
		ex.printStackTrace();
	}
}else{
	response.sendRedirect("purchase/product_providers/check_delete_ok.jsp?finished_tag=0");
	}
}else{
	response.sendRedirect("purchase/product_providers/check_delete_ok.jsp?finished_tag=1");
	}

	purchase_db.commit();
    purchase_db1.commit();
	purchase_db.close();
    purchase_db1.close();

	}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 