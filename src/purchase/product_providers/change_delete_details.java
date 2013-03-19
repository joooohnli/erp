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
import java.util.Iterator;
import java.util.List;

import include.nseer_cookie.GetWorkflow;
import include.nseer_db.*;

public class change_delete_details extends HttpServlet{

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


String id=request.getParameter("id");
String product_providers_recommend_ID=request.getParameter("product_providers_recommend_ID");
try{
	String sql="delete from purchase_product_providers_recommend_details where id='"+id+"'";
	purchase_db.executeUpdate(sql) ;
    sql = "update purchase_product_providers_recommend set check_tag='0',change_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'" ;
	purchase_db.executeUpdate(sql) ;
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
	purchase_db.commit();
	purchase_db.close();
}
catch (Exception ex) {
		ex.printStackTrace();
	}
	response.sendRedirect("purchase/product_providers/change.jsp?product_providers_recommend_ID="+product_providers_recommend_ID+"");


}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 