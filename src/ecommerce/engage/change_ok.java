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

import include.get_sql.getInsertSql;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_cookie.getAttachmentLength;
import include.nseer_cookie.getAttachmentType;
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

import validata.ValidataNumber;
import validata.ValidataTag;

public class change_ok extends HttpServlet{

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

String bodyb = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodyb);
String bodyc = new String(request.getParameter("remark2").getBytes("UTF-8"),"UTF-8");
String remark2=exchange.toHtml(bodyc);
String human_amount=request.getParameter("human_amount") ;
String engage_type=request.getParameter("engage_type") ;
String deadline=request.getParameter("deadline") ;
String changer_ID=request.getParameter("changer_ID") ;
String changer=request.getParameter("changer") ;
String change_time=request.getParameter("change_time") ;

int j=0;

if(vt.validata((String)session.getAttribute("unit_db_name"),"hr_major_release","release_id",release_id,"check_tag").equals("1")){
if(j==0){
String sql1="select * from hr_major_release where release_id='"+release_id+"'";
ResultSet rs=ecommerce_db.executeQuery(sql1);
rs.next();
     String sql = "update hr_major_release set human_major_first_kind_ID='"+human_major_first_kind_ID+"',human_major_first_kind_name='"+human_major_first_kind_name+"',human_major_second_kind_ID='"+human_major_second_kind_ID+"',human_major_second_kind_name='"+human_major_second_kind_name+"',human_amount='"+human_amount+"',engage_type='"+engage_type+"',deadline='"+deadline+"',remark1='"+remark1+"',remark2='"+remark2+"',check_tag='0',changer_ID='"+changer_ID+"',changer='"+changer+"',change_time='"+change_time+"' where release_id='"+release_id+"'";
			ecommerce_db.executeUpdate(sql) ;
	sql = "update ecommerce_workflow set check_tag='0' where object_id='"+release_id+"'" ;
		ecommerce_db.executeUpdate(sql) ;	
response.sendRedirect("ecommerce/engage/change_ok_a.jsp");
}else{
response.sendRedirect("ecommerce/engage/change_ok_b.jsp?release_id="+release_id+"");
}
}else{
response.sendRedirect("ecommerce/engage/change_ok_c.jsp");
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