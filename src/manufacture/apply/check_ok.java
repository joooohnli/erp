/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.apply;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import validata.ValidataNumber;
import include.nseer_cookie.counter;
import validata.ValidataTag;

public class check_ok extends HttpServlet{
public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String apply_ID=request.getParameter("apply_ID");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String sql6="select id from manufacture_workflow where object_ID='"+apply_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=manufacture_db.executeQuery(sql6);
if(!rs6.next()){					
	if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"manufacture_apply","apply_ID",apply_ID,"check_tag").equals("0")){
	String pay_ID_group="";
	String sql = "update manufacture_apply set designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"' where apply_ID='"+apply_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;

	 String sql2 = "update manufacture_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+apply_ID+"' and config_id='"+config_id+"'" ;
	manufacture_db.executeUpdate(sql2);
	sql2="select id from manufacture_workflow where object_ID='"+apply_ID+"' and check_tag='0'";
	ResultSet rset=manufacture_db.executeQuery(sql2);
	if(!rset.next()){
		 sql = "update manufacture_apply set check_tag='1' where apply_ID='"+apply_ID+"'" ;
				manufacture_db.executeUpdate(sql) ;
		 String sql1="select * from manufacture_apply where apply_ID='"+apply_ID+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql1) ;
	if(rs1.next()){
		pay_ID_group=rs1.getString("pay_ID_group");
	}
	StringTokenizer tokenTO = new StringTokenizer(pay_ID_group,", ");        
        while(tokenTO.hasMoreTokens()) {
		 sql2="select * from stock_pay where pay_ID='"+tokenTO.nextToken()+"'";
		ResultSet rs2=stock_db.executeQuery(sql2) ;
		if(rs2.next()){
			String sql3 = "update crm_order set manufacture_tag='2' where order_ID='"+rs2.getString("reasonexact")+"'" ;
			crm_db.executeUpdate(sql3) ;
		}
		}
	}
	response.sendRedirect("manufacture/apply/check_ok.jsp?finished_tag=0");

}else{
	response.sendRedirect("manufacture/apply/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("manufacture/apply/check_ok.jsp?finished_tag=2");
}
manufacture_db.commit();
stock_db.commit();
crm_db.commit();

manufacture_db.close();
stock_db.close();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 