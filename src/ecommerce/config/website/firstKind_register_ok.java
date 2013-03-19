/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.config.website;
  
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class firstKind_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
try{
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String first_kind_ID=request.getParameter("first_kind_ID");
String first_kind_name=request.getParameter("first_kind_name");
String list=request.getParameter("list");
String sqll="select * from ecommerce_config_cols_first where first_kind_ID='"+first_kind_ID+"' or first_kind_name='"+first_kind_name+"'";
ResultSet rs=ecommerce_db.executeQuery(sqll);
if(rs.next()){
response.sendRedirect("ecommerce/config/website/firstKind_register_ok_a.jsp");
}else{
      String sql = "insert into ecommerce_config_cols_first(first_kind_ID,first_kind_name,list_tag,describe1,describe2,describe3,describe4) values('"+first_kind_ID+"','"+first_kind_name+"','"+list+"','ecommerce_other','check_tag=\\'1\\' and excel_tag=\\'3\\'','topic,register_time','other')" ;
    	ecommerce_db.executeUpdate(sql) ;
	  String sql2="insert into ecommerce_config_cols_second(first_kind_ID,first_kind_name,second_kind_ID) values('"+first_kind_ID+"','"+first_kind_name+"','2')";
	  ecommerce_db.executeUpdate(sql2) ;
	  
	  int m=0;
	  sql="select category_id from ecommerce_config_other_kind";
	  rs=ecommerce_db.executeQuery(sql);
	  if(rs.next()){	  
		  rs.last();
		  m=rs.getInt("category_id");
		  m++;
	  }
	  String first_kind_group=first_kind_ID+" "+first_kind_name;
	  sql2="insert into ecommerce_config_other_kind(category_id,parent_category_id,category_name,file_id,file_name,list_tag,chain_id,chain_name) values('"+m+"','0','"+first_kind_group+"','"+first_kind_ID+"','"+first_kind_name+"','1','"+first_kind_ID+"','"+first_kind_name+"')";
	  ecommerce_db.executeUpdate(sql2) ;
	    
int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"ecommerceOtherFirstKindcount");
count.write((String)dbSession.getAttribute("unit_db_name"),"ecommerceOtherFirstKindcount",filenum);
response.sendRedirect("ecommerce/config/website/firstKind_register_ok_b.jsp");
}
ecommerce_db.commit();
ecommerce_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}	
}catch (Exception ex) {
		ex.printStackTrace();
	}
}
}