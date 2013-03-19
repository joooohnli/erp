/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.engage;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
try{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();
getAttachmentLength getAttachmentLength=new getAttachmentLength();
getAttachmentType getAttachmentType=new getAttachmentType();

if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String release_id=request.getParameter("release_id");
String human_major_first_kind_ID="";
String human_major_first_kind_name="";
String human_major_second_kind_ID="";
String human_major_second_kind_name="";
String human_major_first_kind=request.getParameter("select4");
if(human_major_first_kind!=null&&!human_major_first_kind.equals("")){
StringTokenizer tokenTO4 = new StringTokenizer(human_major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        human_major_first_kind_ID = tokenTO4.nextToken();
		human_major_first_kind_name = tokenTO4.nextToken();
		}
}
String human_major_second_kind=request.getParameter("select5");
if(human_major_second_kind!=null&&!human_major_second_kind.equals("")){
StringTokenizer tokenTO5 = new StringTokenizer(human_major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        human_major_second_kind_ID = tokenTO5.nextToken();
		human_major_second_kind_name = tokenTO5.nextToken();
		}
}
String engage_type=request.getParameter("engage_type") ;
String human_amount=request.getParameter("human_amount") ;
String deadline=request.getParameter("deadline") ;
String bodyb = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodyb);
String bodyc = new String(request.getParameter("remark2").getBytes("UTF-8"),"UTF-8");
String remark2=exchange.toHtml(bodyc);
String bodyd = new String(request.getParameter("opinion").getBytes("UTF-8"),"UTF-8");
String opinion=exchange.toHtml(bodyd);
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
int j=0;

String sql6="select * from ecommerce_workflow where object_id='"+release_id+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=ecommerce_db.executeQuery(sql6);
if(!rs6.next()&&vt.validata((String)session.getAttribute("unit_db_name"),"hr_major_release","release_id",release_id,"check_tag").equals("0")){
if(j==0){
String sql1="select * from hr_major_release where release_id='"+release_id+"'";
ResultSet rs=ecommerce_db.executeQuery(sql1);
rs.next();
	
	String sqla = "update hr_major_release set human_major_first_kind_ID='"+human_major_first_kind_ID+"',human_major_first_kind_name='"+human_major_first_kind_name+"',human_major_second_kind_ID='"+human_major_second_kind_ID+"',human_major_second_kind_name='"+human_major_second_kind_name+"',human_amount='"+human_amount+"',engage_type='"+engage_type+"',deadline='"+deadline+"',remark1='"+remark1+"',remark2='"+remark2+"',opinion='"+opinion+"'";
	String sqlb = " where release_id='"+release_id+"'" ;
String sql=sqla+sqlb;
	ecommerce_db.executeUpdate(sql) ;
	sql = "update ecommerce_workflow set check_tag='1',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"' where object_id='"+release_id+"' and config_id='"+config_id+"'" ;
		ecommerce_db.executeUpdate(sql) ;
	sql6="select * from ecommerce_workflow where object_id='"+release_id+"' and check_tag='0'";
	rs6=ecommerce_db.executeQuery(sql6);
	if(!rs6.next()){
		sql = "update hr_major_release set check_tag='1',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"' where release_id='"+release_id+"'" ;
		ecommerce_db.executeUpdate(sql) ;
	}	
response.sendRedirect("ecommerce/engage/check_ok_a.jsp?release_id="+release_id+"");
}else{
response.sendRedirect("ecommerce/engage/check_ok_b.jsp");
}
}else{
response.sendRedirect("ecommerce/engage/check_ok_c.jsp");
}
ecommerce_db.commit();
ecommerce_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}