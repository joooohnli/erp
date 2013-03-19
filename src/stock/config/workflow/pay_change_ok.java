/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.config.workflow;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;

public class pay_change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

ServletContext application;
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 stock_db=new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db1=new nseer_db_backup1(dbApplication);
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String id=request.getParameter("id");
String type_id=request.getParameter("type_id");
String cols_number=request.getParameter("cols_number");

String[] chain_id_array=request.getParameterValues("chain_id");
if(chain_id_array==null){//判断数组是否为空
  	response.sendRedirect("stock/config/workflow/pay_change_ok_a.jsp?id="+id+"&type_id="+type_id);
}else{
String describe1="";
String describe2="";
for(int j=0;j<chain_id_array.length;j++){
	
		if(!chain_id_array[j].equals("")){
				StringTokenizer token=new StringTokenizer(chain_id_array[j],"/");
					while(token.hasMoreTokens()){
						String human_ID=token.nextToken();
						String human_name=token.nextToken();
						describe1+=human_ID+", ";
						describe2+=human_name+", ";
					}
		}
	
}
String pay_ID="";
String paying_time="";
	String sql = "select pay_ID,paying_time from stock_pay where pay_pre_tag='1' and pay_tag!='2' order by register_time" ;
	ResultSet rs = stock_db1.executeQuery(sql) ;
	while(rs.next()){
		String sql4="select pay_check_tag,pay_tag,pay_ID from stock_pre_paying where pay_ID='"+rs.getString("pay_ID")+"'";
		ResultSet rs4 = stock_db.executeQuery(sql4) ;
		while(rs4.next()){
			if(rs4.getString("pay_check_tag").equals("1")&&rs4.getString("pay_tag").equals("0")){
				pay_ID+=","+rs4.getString("pay_ID");
				paying_time+=","+rs.getString("paying_time");
			}
		}
	}
	String sql1="";
	if(!pay_ID.equals("")){
		sql1="update stock_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where config_id='"+id+"' and check_tag='0'";
		stock_db.executeUpdate(sql1);	
	pay_ID=pay_ID.substring(1);
	paying_time=paying_time.substring(1);
	String[] pay_ID_group=pay_ID.split(",");
	String[] paying_time_group=paying_time.split(",");
for(int i=0;i<pay_ID_group.length;i++){
	 sql1="update stock_workflow set check_tag='0' where object_ID='"+pay_ID_group[i]+"' and paying_time='"+paying_time_group[i]+"'";
	stock_db.executeUpdate(sql1);
}
	}
	 sql1="update stock_config_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where id='"+id+"'";
	stock_db.executeUpdate(sql1);
	
response.sendRedirect("stock/config/workflow/pay_change_ok_b.jsp?id="+id+"&type_id="+type_id);
}
	stock_db.commit();
	stock_db1.commit();
	stock_db1.close();
	stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}