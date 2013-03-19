 /*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.resume;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;  
import java.io.*;
import include.get_sql.getInsertSql;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;


public class change_picture extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;
getInsertSql getInsertSql=new getInsertSql();

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
counter count=new counter(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
try{
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String human_ID=request.getParameter("human_ID") ;
String human_name=request.getParameter("human_name") ;
String human_address=request.getParameter("human_address") ;
String human_title_class=request.getParameter("human_title_class") ;
String human_bank=request.getParameter("human_bank") ;
String human_account=request.getParameter("human_account") ;
String human_tel=request.getParameter("human_tel") ;
String human_home_tel=request.getParameter("human_home_tel") ;
String human_postcode=request.getParameter("human_postcode") ;
String changer=request.getParameter("changer") ;
String human_cellphone=request.getParameter("human_cellphone") ;
String idcard=request.getParameter("idcard") ;
String SIN=request.getParameter("SIN") ;
String religion=request.getParameter("religion") ;
String party=request.getParameter("party") ;
String race=request.getParameter("race") ;
String nationality=request.getParameter("nationality") ;
String age=request.getParameter("age") ;
String sex=request.getParameter("sex") ;
String speciality=request.getParameter("speciality") ;
String hobby=request.getParameter("hobby") ;
String birthday=request.getParameter("birthday") ;
String birthplace=request.getParameter("birthplace") ;
String human_email=request.getParameter("human_email") ;
String educated_degree=request.getParameter("educated_degree") ;
String educated_years=request.getParameter("educated_years") ;
String educated_major=request.getParameter("educated_major") ;
String change_time=request.getParameter("change_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("history_records").getBytes("UTF-8"),"UTF-8");
String history_records=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("family_membership").getBytes("UTF-8"),"UTF-8");
String family_membership=exchange.toHtml(bodyb);
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
if(birthday.equals("")) birthday="1800-01-01";
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"hr_file");
	String sqll="insert into hr_file_dig("+column_group+") select "+column_group+" from hr_file where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sqll) ;
	String sql = "update hr_file set human_name='"+human_name+"',human_address='"+human_address+"',human_title_class='"+human_title_class+"',human_bank='"+human_bank+"',human_account='"+human_account+"',human_tel='"+human_tel+"',human_home_tel='"+human_home_tel+"',human_postcode='"+human_postcode+"',changer='"+changer+"',educated_degree='"+educated_degree+"',educated_years='"+educated_years+"',educated_major='"+educated_major+"',change_time='"+change_time+"',family_membership='"+family_membership+"',history_records='"+history_records+"',remark='"+remark+"',human_cellphone='"+human_cellphone+"',idcard='"+idcard+"',SIN='"+SIN+"',religion='"+religion+"',race='"+race+"',nationality='"+nationality+"',party='"+party+"',age='"+age+"',birthday='"+birthday+"',birthplace='"+birthplace+"',sex='"+sex+"',speciality='"+speciality+"',hobby='"+hobby+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',human_email='"+human_email+"',check_tag='0',change_tag='1' where human_ID='"+human_ID+"'" ;
	hr_db.executeUpdate(sql) ;
	hr_db.commit();
	hr_db.close();
	response.sendRedirect("hr/engage/resume/change_picture_a.jsp?human_ID="+human_ID+"");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}