/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.file;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_cookie.*;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import include.operateDB.CdefineUpdate;

public class register_draft extends HttpServlet{//创建方法
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
counter count= new  counter(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String salary_standard_ID="";
String salary_standard_name="";
String salary_sum="";
String major_second_kind=request.getParameter("select5");
String major_first_kind=request.getParameter("select4");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String kind_chain=request.getParameter("kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);

if(!chain_id.equals("")){
String human_name=request.getParameter("human_name") ;
String human_address=request.getParameter("human_address") ;
String major_type=request.getParameter("major_type") ;
String human_title_class=request.getParameter("human_title_class") ;
String salary_standard=request.getParameter("salary_standard");
StringTokenizer tokenTO6 = new StringTokenizer(salary_standard,"/");        
	while(tokenTO6.hasMoreTokens()) {
        salary_standard_ID = tokenTO6.nextToken();
		salary_standard_name = tokenTO6.nextToken();
		salary_sum = tokenTO6.nextToken();
		}
String human_bank=request.getParameter("human_bank") ;
String human_account=request.getParameter("human_account") ;
String human_tel=request.getParameter("human_tel") ;
String human_home_tel=request.getParameter("human_home_tel") ;
String human_postcode=request.getParameter("human_postcode") ;
String register=request.getParameter("register") ;
String human_cellphone=request.getParameter("human_cellphone") ;
String idcard=request.getParameter("idcard") ;
String SIN=request.getParameter("SIN") ;
String religion=request.getParameter("religion") ;
String party=request.getParameter("party") ;
String race=request.getParameter("race") ;
String nationality=request.getParameter("nationality");
String age=request.getParameter("age") ;
String sex=request.getParameter("sex") ;
String speciality=request.getParameter("speciality") ;
String hobby=request.getParameter("hobby") ;
String birthday=request.getParameter("birthday");

if(birthday.equals("")){
   birthday = "1800-01-01";}
String birthplace=request.getParameter("birthplace") ;
String human_email=request.getParameter("human_email") ;
String educated_degree=request.getParameter("educated_degree") ;
String educated_years=request.getParameter("educated_years") ;
String educated_major=request.getParameter("educated_major") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("history_records").getBytes("UTF-8"),"UTF-8");
String history_records=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("family_membership").getBytes("UTF-8"),"UTF-8");
String family_membership=exchange.toHtml(bodyb);
try{
	
	String human_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

	String sqll="select * from hr_file where human_ID='"+human_ID+"' and human_name='"+human_name+"'";
	ResultSet rset=hr_db.executeQuery(sqll) ;
if(rset.next()){
response.sendRedirect("hr/file/register_picture_a.jsp");
}else{
	String sql = "insert into hr_file(chain_id,chain_name,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,human_ID,human_name,human_address,human_title_class,major_type,human_bank,human_account,human_tel,human_home_tel,human_postcode,salary_standard_ID,salary_standard_name,salary_sum,educated_degree,educated_years,educated_major,register,register_time,family_membership,history_records,remark,human_cellphone,idcard,SIN,religion,race,nationality,party,age,birthday,birthplace,sex,speciality,hobby,human_email,check_tag) values ('"+chain_id+"','"+chain_name+"','"+major_first_kind_ID+"','"+major_first_kind_name+"','"+major_second_kind_ID+"','"+major_second_kind_name+"','"+human_ID+"','"+human_name+"','"+human_address+"','"+human_title_class+"','"+major_type+"','"+human_bank+"','"+human_account+"','"+human_tel+"','"+human_home_tel+"','"+human_postcode+"','"+salary_standard_ID+"','"+salary_standard_name+"','"+salary_sum+"','"+educated_degree+"','"+educated_years+"','"+educated_major+"','"+register+"','"+register_time+"','"+family_membership+"','"+history_records+"','"+remark+"','"+human_cellphone+"','"+idcard+"','"+SIN+"','"+religion+"','"+race+"','"+nationality+"','"+party+"','"+age+"','"+birthday+"','"+birthplace+"','"+sex+"','"+speciality+"','"+hobby+"','"+human_email+"','5')" ;
	hr_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("hr_file","human_ID",human_ID,request);
	hr_db.executeUpdate(sql) ;
	/*****************************************************/
	String sql1="update hr_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
	hr_db.executeUpdate(sql1);//delete_tag为1说明机构被使用	

response.sendRedirect("hr/file/register_choose_picture.jsp?human_ID="+human_ID+"");

}
}
catch (Exception ex){
	ex.printStackTrace();
}


}else{

response.sendRedirect("hr/file/register_picture_b.jsp");

}
 hr_db.commit();
 hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}

