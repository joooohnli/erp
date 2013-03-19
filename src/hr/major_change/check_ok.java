/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.major_change;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.Divide1;
import include.nseer_db.*;
import include.get_sql.getInsertSql;

public class check_ok extends HttpServlet{//创建方法
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
getInsertSql  getInsertSql= new getInsertSql();
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db1 = new nseer_db_backup1(dbApplication);

if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String human_ID=request.getParameter("human_ID");
String config_id=request.getParameter("config_id");
String major_time=request.getParameter("major_time");
String sql6="select id from hr_workflow where object_ID='"+human_ID+"' and major_time='"+major_time+"' and type_id='04' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=hr_db.executeQuery(sql6);
if(!rs6.next()){
String kind_chain=request.getParameter("old_kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);
String new_kind_chain=request.getParameter("kind_chain");
String new_chain_id=Divide1.getId(new_kind_chain);
String new_chain_name=Divide1.getName(new_kind_chain);
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
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
String major_type=request.getParameter("major_type") ;
String salary_standard=request.getParameter("salary_standard");
StringTokenizer tokenTO6 = new StringTokenizer(salary_standard,"/");        
	while(tokenTO6.hasMoreTokens()) {
        salary_standard_ID = tokenTO6.nextToken();
		salary_standard_name = tokenTO6.nextToken();
		salary_sum = tokenTO6.nextToken();
		}
String bodyb = new String(request.getParameter("remark2").getBytes("UTF-8"),"UTF-8");
String remark2=exchange.toHtml(bodyb);
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
String checker_ID=request.getParameter("checker_ID") ;
int file_change_amount1=Integer.parseInt(file_change_amount)+1;
String major_change_amount=request.getParameter("major_change_amount") ;
int major_change_amount1=Integer.parseInt(major_change_amount)+1;
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"hr_file");
	String sql8 = "select * from hr_major_change where human_ID='"+human_ID+"' and check_tag='0'" ;
	ResultSet rs8 = hr_db.executeQuery(sql8) ;
	if(rs8.next()){
try{
	String sql2="update hr_major_change set new_human_major_first_kind_ID='"+major_first_kind_ID+"',new_human_major_first_kind_name='"+major_first_kind_name+"',new_human_major_second_kind_ID='"+major_second_kind_ID+"',new_human_major_second_kind_name='"+major_second_kind_name+"',new_major_type='"+major_type+"',new_salary_standard_ID='"+salary_standard_ID+"',new_salary_standard_name='"+salary_standard_name+"',new_salary_sum='"+salary_sum+"',new_chain_id='"+new_chain_id+"',new_chain_name='"+new_chain_name+"',checker='"+checker+"',check_time='"+check_time+"',remark2='"+remark2+"' where human_ID='"+human_ID+"' and check_tag='0'";
	hr_db.executeUpdate(sql2);
	String sql = "update hr_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+human_ID+"' and major_time='"+major_time+"' and config_id='"+config_id+"' and type_id='04'" ;
	hr_db.executeUpdate(sql);
	sql="select id from hr_workflow where object_ID='"+human_ID+"' and major_time='"+major_time+"' and check_tag='0' and type_id='04'";
	ResultSet rset=hr_db.executeQuery(sql);
	if(!rset.next()){
		sql="update hr_major_change set check_tag='1' where human_ID='"+human_ID+"' and check_tag='0'";
		hr_db.executeUpdate(sql);
	sql="select * from hr_file where human_ID='"+human_ID+"'";
	ResultSet rs=hr_db.executeQuery(sql);
	if(rs.next()){
		String sqll="insert into hr_file_dig(chain_id,chain_name,HUMAN_ID,HUMAN_NAME,HUMAN_ADDRESS,HUMAN_POSTCODE,HUMAN_TITLE_CLASS,HUMAN_MAJOR_FIRST_KIND_ID,HUMAN_MAJOR_FIRST_KIND_NAME,HUMAN_MAJOR_SECOND_KIND_ID,HUMAN_MAJOR_SECOND_KIND_NAME,HUMAN_BANK,HUMAN_ACCOUNT,HUMAN_TEL,HUMAN_HOME_TEL,HUMAN_CELLPHONE,HUMAN_EMAIL,HOBBY,SPECIALITY,SEX,RELIGION,PARTY,NATIONALITY,RACE,BIRTHDAY,BIRTHPLACE,AGE,EDUCATED_DEGREE,EDUCATED_YEARS,EDUCATED_MAJOR,SIN,IDCARD,MAJOR_TYPE,SALARY_STANDARD_ID,SALARY_STANDARD_NAME,SALARY_SUM,DEMAND_SALARY_SUM,PAID_SALARY_SUM,MAJOR_CHANGE_AMOUNT,BONUS_AMOUNT,TRAINING_AMOUNT,HISTORY_RECORDS,FAMILY_MEMBERSHIP,REMARK,PICTURE,ATTACHMENT_NAME,CHECK_TAG,FILE_CHANGE_AMOUNT,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,DELETE_TIME,RECOVERY_TIME,EXCEL_TAG,CHANGE_TAG,MAJOR_CHANGE_TAG,TRAINING_CHECK_TAG,BONUS_CHECK_TAG,LICENSE_TAG) values('"+rs.getString("chain_id")+"','"+rs.getString("chain_name")+"','"+rs.getString("HUMAN_ID")+"','"+rs.getString("HUMAN_NAME")+"','"+rs.getString("HUMAN_ADDRESS")+"','"+rs.getString("HUMAN_POSTCODE")+"','"+rs.getString("HUMAN_TITLE_CLASS")+"','"+rs.getString("HUMAN_MAJOR_FIRST_KIND_ID")+"','"+rs.getString("HUMAN_MAJOR_FIRST_KIND_NAME")+"','"+rs.getString("HUMAN_MAJOR_SECOND_KIND_ID")+"','"+rs.getString("HUMAN_MAJOR_SECOND_KIND_NAME")+"','"+rs.getString("HUMAN_BANK")+"','"+rs.getString("HUMAN_ACCOUNT")+"','"+rs.getString("HUMAN_TEL")+"','"+rs.getString("HUMAN_HOME_TEL")+"','"+rs.getString("HUMAN_CELLPHONE")+"','"+rs.getString("HUMAN_EMAIL")+"','"+rs.getString("HOBBY")+"','"+rs.getString("SPECIALITY")+"','"+rs.getString("SEX")+"','"+rs.getString("RELIGION")+"','"+rs.getString("PARTY")+"','"+rs.getString("NATIONALITY")+"','"+rs.getString("RACE")+"','"+rs.getString("BIRTHDAY")+"','"+rs.getString("BIRTHPLACE")+"','"+rs.getString("AGE")+"','"+rs.getString("EDUCATED_DEGREE")+"','"+rs.getString("EDUCATED_YEARS")+"','"+rs.getString("EDUCATED_MAJOR")+"','"+rs.getString("SIN")+"','"+rs.getString("IDCARD")+"','"+rs.getString("MAJOR_TYPE")+"','"+rs.getString("SALARY_STANDARD_ID")+"','"+rs.getString("SALARY_STANDARD_NAME")+"','"+rs.getString("SALARY_SUM")+"','"+rs.getString("DEMAND_SALARY_SUM")+"','"+rs.getString("PAID_SALARY_SUM")+"','"+rs.getString("MAJOR_CHANGE_AMOUNT")+"','"+rs.getString("BONUS_AMOUNT")+"','"+rs.getString("TRAINING_AMOUNT")+"','"+rs.getString("HISTORY_RECORDS")+"','"+rs.getString("FAMILY_MEMBERSHIP")+"','"+rs.getString("REMARK")+"','"+rs.getString("PICTURE")+"','"+rs.getString("ATTACHMENT_NAME")+"','"+rs.getString("CHECK_TAG")+"','"+rs.getString("FILE_CHANGE_AMOUNT")+"','"+rs.getString("REGISTER")+"','"+rs.getString("CHECKER")+"','"+rs.getString("CHANGER")+"','"+rs.getString("REGISTER_ID")+"','"+rs.getString("CHECKER_ID")+"','"+rs.getString("CHANGER_ID")+"','"+rs.getString("REGISTER_TIME")+"','"+rs.getString("CHECK_TIME")+"','"+rs.getString("CHANGE_TIME")+"','"+rs.getString("LATELY_CHANGE_TIME")+"','"+rs.getString("DELETE_TIME")+"','"+rs.getString("RECOVERY_TIME")+"','"+rs.getString("EXCEL_TAG")+"','"+rs.getString("CHANGE_TAG")+"','"+rs.getString("MAJOR_CHANGE_TAG")+"','"+rs.getString("TRAINING_CHECK_TAG")+"','"+rs.getString("BONUS_CHECK_TAG")+"','"+rs.getString("LICENSE_TAG")+"')";
		hr_db.executeUpdate(sqll) ;
	}
	String sql3="update hr_file set chain_id='"+new_chain_id+"',chain_name='"+new_chain_name+"',human_major_first_kind_ID='"+major_first_kind_ID+"',human_major_first_kind_name='"+major_first_kind_name+"',human_major_second_kind_ID='"+major_second_kind_ID+"',human_major_second_kind_name='"+major_second_kind_name+"',major_type='"+major_type+"',salary_standard_ID='"+salary_standard_ID+"',salary_standard_name='"+salary_standard_name+"',salary_sum='"+salary_sum+"',lately_change_time='"+lately_change_time+"',change_time='"+check_time+"',file_change_amount='"+file_change_amount1+"',major_change_amount='"+major_change_amount1+"',major_change_tag='0' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql3);

String sql7="update security_users set chain_id='"+new_chain_id+"',chain_name='"+new_chain_name+"',human_major_first_kind_ID='"+major_first_kind_ID+"',human_major_first_kind_name='"+major_first_kind_name+"',human_major_second_kind_ID='"+major_second_kind_ID+"',human_major_second_kind_name='"+major_second_kind_name+"' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql7);


if(major_first_kind_name.equals("销售")&& major_second_kind_name.equals("客户经理")){/*如果该人曾是销售-客户经理,查出他曾是哪些的责任人，去掉该人*/
	String sql11= "select describe1,id from hr_config_file_kind where describe1 like '%"+human_ID+"%'";
ResultSet rs11=hr_db.executeQuery(sql11);
while(rs11.next()){
	String describe1=rs11.getString("describe1").replaceAll(human_ID+", ", "").replaceAll(", "+human_ID, "").replaceAll(human_ID, "");
	String sql4= "update hr_config_file_kind set describe1='"+describe1+"' where id='"+rs11.getString("id")+"'";
	hr_db1.executeUpdate(sql4);
}
String sql111= "select describe1,id from crm_config_file_kind where describe1 like '%"+human_ID+"%'";
ResultSet rs111=crm_db.executeQuery(sql111);
while(rs111.next()){
	String describe1=rs11.getString("describe1").replaceAll(human_ID+", ", "").replaceAll(", "+human_ID, "").replaceAll(human_ID, "");
	String sqla= "update crm_config_file_kind set describe1='"+describe1+"' where id='"+rs111.getString("id")+"'";
	crm_db1.executeUpdate(sqla);
}
}		
	}
}
catch (Exception ex){
out.println("error"+ex);
}
response.sendRedirect("hr/major_change/check_ok_a.jsp");
}else{
response.sendRedirect("hr/major_change/check_ok_b.jsp");
}
	}else{
response.sendRedirect("hr/major_change/check_ok.jsp?finished_tag=0");
}
 hr_db.commit();
  hr_db1.commit();
   crm_db.commit();
    crm_db1.commit();
	hr_db.close();
	hr_db1.close();
	crm_db.close();
	crm_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}