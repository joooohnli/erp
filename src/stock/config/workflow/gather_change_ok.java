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
 
 
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class gather_change_ok extends HttpServlet{

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
  	response.sendRedirect("stock/config/workflow/gather_change_ok_a.jsp?id="+id+"&type_id="+type_id);
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
String gather_ID="";
String gathering_time="";
	String sql = "select gather_ID,gathering_time from stock_gather where gather_pre_tag='1' and gather_tag!='2' order by register_time" ;
	ResultSet rs = stock_db1.executeQuery(sql) ;
	while(rs.next()){
		String sql4="select gather_check_tag,gather_tag,gather_ID from stock_pre_gathering where gather_ID='"+rs.getString("gather_ID")+"'";
		ResultSet rs4 = stock_db.executeQuery(sql4) ;
			while(rs4.next()){
		if(rs4.getString("gather_check_tag").equals("1")&&rs4.getString("gather_tag").equals("0")){
				gather_ID+=","+rs4.getString("gather_ID");
				gathering_time+=","+rs.getString("gathering_time");
			}
		}
	}
	String sql1="";
	if(!gather_ID.equals("")){
		 sql1="update stock_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where config_id='"+id+"' and check_tag='0'";
		stock_db.executeUpdate(sql1);
		
	gather_ID=gather_ID.substring(1);
	gathering_time=gathering_time.substring(1);
	String[] gather_ID_group=gather_ID.split(",");
	String[] gathering_time_group=gathering_time.split(",");
for(int i=0;i<gather_ID_group.length;i++){
	 sql1="update stock_workflow set check_tag='0' where object_ID='"+gather_ID_group[i]+"' and gathering_time='"+gathering_time_group[i]+"'";
	stock_db.executeUpdate(sql1);
}
	}
	
	 sql1="update stock_config_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where id='"+id+"'";
		stock_db.executeUpdate(sql1);
	
response.sendRedirect("stock/config/workflow/gather_change_ok_b.jsp?id="+id+"&type_id="+type_id);
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