/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.config.workflow;
 
 
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
nseer_db_backup1 fund_db=new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db1=new nseer_db_backup1(dbApplication);
if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String id=request.getParameter("id");
String type_id=request.getParameter("type_id");
String cols_number=request.getParameter("cols_number");
String[] chain_id_array=request.getParameterValues("chain_id");

if(chain_id_array==null){
  	response.sendRedirect("fund/config/workflow/pay_change_ok_a.jsp?id="+id+"&type_id="+type_id);
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
List fList = (List)new java.util.ArrayList();
List pList = (List)new java.util.ArrayList();
int f=0;
String sql="select fund_id,pay_time from fund_fund where check_tag='1' and fund_tag!='1' and reason='付款' and fund_execute_tag='1'";
ResultSet rs=fund_db1.executeQuery(sql);
while(rs.next()){
	String sql4="select * from fund_details where fund_ID='"+rs.getString("fund_ID")+"'";
	ResultSet rs4 = fund_db.executeQuery(sql4);
	while(rs4.next()){
		if(rs4.getString("execute_check_tag").equals("1")&&!rs4.getString("execute_details_tag").equals("2")){
			if(f==0){
				fList.add(rs4.getString("fund_ID"));
				pList.add(rs.getString("pay_time"));
				f++;
			}
			else if(!rs4.getString("fund_ID").equals(fList.get(f-1))){
				fList.add(rs4.getString("fund_ID"));
				pList.add(rs.getString("pay_time"));
				f++;
			}
		}		
	}
}
for(int i=0;i<fList.size();i++){
	sql="update fund_workflow set check_tag='0' where object_ID='"+fList.get(i)+"' and pay_time='"+pList.get(i)+"'";
	fund_db.executeUpdate(sql);
}

	String sql1="update fund_config_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where id='"+id+"'";
	fund_db.executeUpdate(sql1);
	sql1="update fund_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where config_id='"+id+"' and check_tag='0'";
	fund_db.executeUpdate(sql1);
response.sendRedirect("fund/config/workflow/pay_change_ok_b.jsp?id="+id+"&type_id="+type_id);
}
	fund_db.commit();
	fund_db1.commit();
	fund_db1.close();
	fund_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}