
/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.intrmanufacture;
  
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class compulsion_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 gar_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(gar_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
String intrmanufacture_id="";
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
for(int i=0;i<value1.length;i++){
	String id=value1[i];
	String sql="update "+tableName+" set check_tag='2',stock_gather_tag='3',gather_tag='3',invoice_tag='3',intrmanufacture_tag='2' where id='"+id+"'";
	gar_db.executeUpdate(sql);
	
	sql="select intrmanufacture_id from "+tableName+" where id='"+id+"'";
	ResultSet rs=gar_db.executeQuery(sql);
	if(rs.next()){
		intrmanufacture_id=rs.getString("intrmanufacture_id");
	}
	sql="update stock_gather set gather_tag='2',finish_time='"+time+"' where reasonexact='"+intrmanufacture_id+"'";
	gar_db.executeUpdate(sql);

	sql="update fund_fund set check_tag='1' where reasonexact='"+intrmanufacture_id+"'";
	gar_db.executeUpdate(sql);//制定付款执行单列表的记录
	
	sql="update fund_fund set fund_tag='1',finish_time='"+time+"' where apply_id_group like '%"+intrmanufacture_id+"%'";
	gar_db.executeUpdate(sql);//强制完成调度后的付款执行单(新生成)
}
out.println("1");
gar_db.commit();
gar_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}