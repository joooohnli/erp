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
import java.util.*;
import java.io.*;

import include.nseer_cookie.Divide1;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import validata.ValidataTag;
import include.nseer_cookie.counter;
import java.sql.*;
import include.operateDB.CdefineUpdate;

public class check_picture extends HttpServlet{//创建方法
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
counter count= new  counter(dbApplication);
ValidataTag  vt=new  ValidataTag();

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){	
String human_ID=request.getParameter("human_ID");
String config_id=request.getParameter("config_id");
String sql6="select id from hr_workflow where object_ID='"+human_ID+"' and type_id='01' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=hr_db.executeQuery(sql6);
if(!rs6.next()){

String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String salary_standard_ID="";
String salary_standard_name="";
String salary_sum="";
String major_first_kind=request.getParameter("select4");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
String major_second_kind=request.getParameter("select5");
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String id=request.getParameter("id") ;
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
String kind_chain=request.getParameter("kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);
String oldKind_chain=request.getParameter("oldKind_chain");

String oldChain_id="";
if(!oldKind_chain.equals(" ")){
	oldChain_id=Divide1.getId(oldKind_chain);
}

String human_bank=request.getParameter("human_bank") ;
String human_account=request.getParameter("human_account") ;
String human_tel=request.getParameter("human_tel") ;
String human_home_tel=request.getParameter("human_home_tel") ;
String human_postcode=request.getParameter("human_postcode") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
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
if(birthday.equals("")){
   birthday = "1800-01-01";}
String birthplace=request.getParameter("birthplace") ;
String human_email=request.getParameter("human_email") ;
String educated_degree=request.getParameter("educated_degree") ;
String educated_years=request.getParameter("educated_years") ;
String educated_major=request.getParameter("educated_major") ;
String check_time=request.getParameter("check_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("history_records").getBytes("UTF-8"),"UTF-8");
String history_records=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("family_membership").getBytes("UTF-8"),"UTF-8");
String family_membership=exchange.toHtml(bodyb);
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",human_ID,"check_tag").equals("0")){
if(human_ID==null||human_ID.equals("")||human_ID.indexOf("0000000000")!=-1){
	human_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

}
try{
	String sql = "update hr_file set chain_name='"+chain_name+"',chain_id='"+chain_id+"',human_major_first_kind_ID='"+major_first_kind_ID+"',human_major_first_kind_name='"+major_first_kind_name+"',human_major_second_kind_ID='"+major_second_kind_ID+"',human_major_second_kind_name='"+major_second_kind_name+"',human_ID='"+human_ID+"',human_name='"+human_name+"',human_address='"+human_address+"',human_title_class='"+human_title_class+"',major_type='"+major_type+"',human_bank='"+human_bank+"',human_account='"+human_account+"',human_tel='"+human_tel+"',human_home_tel='"+human_home_tel+"',human_postcode='"+human_postcode+"',salary_standard_ID='"+salary_standard_ID+"',salary_standard_name='"+salary_standard_name+"',salary_sum='"+salary_sum+"',checker='"+checker+"',educated_degree='"+educated_degree+"',educated_years='"+educated_years+"',educated_major='"+educated_major+"',check_time='"+check_time+"',family_membership='"+family_membership+"',history_records='"+history_records+"',remark='"+remark+"',human_cellphone='"+human_cellphone+"',idcard='"+idcard+"',SIN='"+SIN+"',religion='"+religion+"',race='"+race+"',nationality='"+nationality+"',party='"+party+"',age='"+age+"',birthday='"+birthday+"',birthplace='"+birthplace+"',sex='"+sex+"',speciality='"+speciality+"',hobby='"+hobby+"',human_email='"+human_email+"' where id='"+id+"' and check_tag='0'" ;
	hr_db.executeUpdate(sql);
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("hr_file","human_ID",human_ID,request);
	hr_db.executeUpdate(sql) ;

		sql="update hr_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
			hr_db.executeUpdate(sql);//delete_tag为1说明机构被使用	
	
	sql = "update hr_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+human_ID+"' and config_id='"+config_id+"' and type_id='01'" ;
	hr_db.executeUpdate(sql);
	sql="select id from hr_workflow where object_ID='"+human_ID+"' and check_tag='0' and type_id='01'";
	ResultSet rset=hr_db.executeQuery(sql);
	if(!rset.next()){
		sql="update hr_file set check_tag='1' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql);
	}	
response.sendRedirect("hr/file/check_choose_picture.jsp?human_ID="+human_ID+"");
}
catch (Exception ex){
ex.printStackTrace();
}
}else{ 
response.sendRedirect("hr/file/check_picture_a.jsp");
}
}else{
response.sendRedirect("hr/file/check_ok.jsp?finished_tag=0");
}
 hr_db.commit();
 hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}

