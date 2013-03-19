/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.sales_manager;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*; 
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.text.*;
import include.nseer_cookie.counter;
import include.get_sql.getInsertSql;
import include.query.getRecordCount;
import validata.ValidataTag;


public class change_customer_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
	PrintWriter out=response.getWriter();

nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);

if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
counter  count= new  counter(dbApplication);
getInsertSql getInsertSql= new   getInsertSql();
getRecordCount query= new   getRecordCount();
ValidataTag vt= new  ValidataTag();


String sales_ID=request.getParameter("sales_ID");
String sales_name=exchange.unURL(request.getParameter("sales_name"));
String[] choice=request.getParameterValues("choice");
String time="";
String customer_ID_group=request.getParameter("customer_ID_group");
String changer=(String)session.getAttribute("realeditorc");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
String customer_ID_choice_group="";
try{
	if(choice!=null){
	for(int i=0;i<choice.length;i++){
		customer_ID_choice_group+=choice[i]+","	;
String sql8="select * from crm_file where customer_ID='"+choice[i]+"'";
ResultSet rs8=crm_db1.executeQuery(sql8) ;
if(rs8.next()){
	String sqll="insert into crm_file_dig(CHAIN_ID,CHAIN_NAME,CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_NICK,CUSTOMER_ADDRESS,CUSTOMER_CLASS,TYPE,CUSTOMER_BANK,CUSTOMER_ACCOUNT,CUSTOMER_WEB,CUSTOMER_TEL1,CUSTOMER_TEL2,CUSTOMER_EMAIL,CUSTOMER_FAX,CUSTOMER_POSTCODE,CONTACT_PERSON1,CONTACT_PERSON1_DEPARTMENT,CONTACT_PERSON1_DUTY,CONTACT_PERSON1_SEX,CONTACT_PERSON1_OFFICE_TEL,CONTACT_PERSON1_HOME_TEL,CONTACT_PERSON1_MOBILE,CONTACT_PERSON1_FAX,CONTACT_PERSON1_EMAIL,CONTACT_PERSON1_FAVORITE,CONTACT_PERSON2,CONTACT_PERSON2_DEPARTMENT,CONTACT_PERSON2_DUTY,CONTACT_PERSON2_SEX,CONTACT_PERSON2_OFFICE_TEL,CONTACT_PERSON2_HOME_TEL,CONTACT_PERSON2_MOBILE,CONTACT_PERSON2_FAX,CONTACT_PERSON2_EMAIL,CONTACT_PERSON2_FAVORITE,INVOICE_INFO,DEMAND,REMARK,CHECK_TAG,CONTACT_AMOUNT,ACHIEVEMENT_SUM,ATTACHMENT_NAME,TRADE_AMOUNT,RETURN_SUM,RETURN_AMOUNT,GATHER_PERIOD_SUM,GATHER_PERIOD_AVERAGE,FILE_CHANGE_AMOUNT,GATHER_PERIOD_LIMIT,GATHER_SUM_LIMIT,CONTACT_PERIOD_LIMIT,USED_CUSTOMER_NAME,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,LATELY_TRADE_TIME,LATELY_CONTACT_TIME,DELETE_TIME,RECOVERY_TIME,SALES_NAME,SALES_ID,MODIFY_TAG,EXCEL_TAG,REMIND_CONTACT_TAG,REMIND_GATHER_TAG,REMIND_RETURN_TAG) values('"+rs8.getString("CHAIN_ID")+"','"+rs8.getString("CHAIN_NAME")+"','"+rs8.getString("CUSTOMER_ID")+"','"+rs8.getString("CUSTOMER_NAME")+"','"+rs8.getString("CUSTOMER_NICK")+"','"+rs8.getString("CUSTOMER_ADDRESS")+"','"+rs8.getString("CUSTOMER_CLASS")+"','"+rs8.getString("TYPE")+"','"+rs8.getString("CUSTOMER_BANK")+"','"+rs8.getString("CUSTOMER_ACCOUNT")+"','"+rs8.getString("CUSTOMER_WEB")+"','"+rs8.getString("CUSTOMER_TEL1")+"','"+rs8.getString("CUSTOMER_TEL2")+"','"+rs8.getString("CUSTOMER_EMAIL")+"','"+rs8.getString("CUSTOMER_FAX")+"','"+rs8.getString("CUSTOMER_POSTCODE")+"','"+rs8.getString("CONTACT_PERSON1")+"','"+rs8.getString("CONTACT_PERSON1_DEPARTMENT")+"','"+rs8.getString("CONTACT_PERSON1_DUTY")+"','"+rs8.getString("CONTACT_PERSON1_SEX")+"','"+rs8.getString("CONTACT_PERSON1_OFFICE_TEL")+"','"+rs8.getString("CONTACT_PERSON1_HOME_TEL")+"','"+rs8.getString("CONTACT_PERSON1_MOBILE")+"','"+rs8.getString("CONTACT_PERSON1_FAX")+"','"+rs8.getString("CONTACT_PERSON1_EMAIL")+"','"+rs8.getString("CONTACT_PERSON1_FAVORITE")+"','"+rs8.getString("CONTACT_PERSON2")+"','"+rs8.getString("CONTACT_PERSON2_DEPARTMENT")+"','"+rs8.getString("CONTACT_PERSON2_DUTY")+"','"+rs8.getString("CONTACT_PERSON2_SEX")+"','"+rs8.getString("CONTACT_PERSON2_OFFICE_TEL")+"','"+rs8.getString("CONTACT_PERSON2_HOME_TEL")+"','"+rs8.getString("CONTACT_PERSON2_MOBILE")+"','"+rs8.getString("CONTACT_PERSON2_FAX")+"','"+rs8.getString("CONTACT_PERSON2_EMAIL")+"','"+rs8.getString("CONTACT_PERSON2_FAVORITE")+"','"+rs8.getString("INVOICE_INFO")+"','"+rs8.getString("DEMAND")+"','"+rs8.getString("REMARK")+"','"+rs8.getString("CHECK_TAG")+"','"+rs8.getString("CONTACT_AMOUNT")+"','"+rs8.getString("ACHIEVEMENT_SUM")+"','"+rs8.getString("ATTACHMENT_NAME")+"','"+rs8.getString("TRADE_AMOUNT")+"','"+rs8.getString("RETURN_SUM")+"','"+rs8.getString("RETURN_AMOUNT")+"','"+rs8.getString("GATHER_PERIOD_SUM")+"','"+rs8.getString("GATHER_PERIOD_AVERAGE")+"','"+rs8.getString("FILE_CHANGE_AMOUNT")+"','"+rs8.getString("GATHER_PERIOD_LIMIT")+"','"+rs8.getString("GATHER_SUM_LIMIT")+"','"+rs8.getString("CONTACT_PERIOD_LIMIT")+"','"+rs8.getString("USED_CUSTOMER_NAME")+"','"+rs8.getString("REGISTER")+"','"+rs8.getString("CHECKER")+"','"+rs8.getString("CHANGER")+"','"+rs8.getString("REGISTER_ID")+"','"+rs8.getString("CHECKER_ID")+"','"+rs8.getString("CHANGER_ID")+"','"+rs8.getString("REGISTER_TIME")+"','"+rs8.getString("CHECK_TIME")+"','"+rs8.getString("CHANGE_TIME")+"','"+rs8.getString("LATELY_CHANGE_TIME")+"','"+rs8.getString("LATELY_TRADE_TIME")+"','"+rs8.getString("LATELY_CONTACT_TIME")+"','"+rs8.getString("DELETE_TIME")+"','"+rs8.getString("RECOVERY_TIME")+"','"+rs8.getString("SALES_NAME")+"','"+rs8.getString("SALES_ID")+"','"+rs8.getString("MODIFY_TAG")+"','"+rs8.getString("EXCEL_TAG")+"','"+rs8.getString("REMIND_CONTACT_TAG")+"','"+rs8.getString("REMIND_GATHER_TAG")+"','"+rs8.getString("REMIND_RETURN_TAG")+"')";
	crm_db.executeUpdate(sqll) ;

int change_amount=rs8.getInt("file_change_amount")+1;

	String sql = "update crm_file set changer='"+changer+"',change_time='"+time+"',lately_change_time='"+rs8.getString("CHANGE_TIME")+"',file_change_amount='"+change_amount+"',sales_ID='"+sales_ID+"',sales_name='"+sales_name+"' where customer_ID='"+choice[i]+"'";
	crm_db.executeUpdate(sql) ;}
}}
	
}
catch (Exception ex){
out.println("error"+ex);
}
String sql9="select * from crm_file where sales_ID='"+sales_ID+"'";
ResultSet rs9=crm_db1.executeQuery(sql9) ;
while(rs9.next()){
	if(customer_ID_group.indexOf(rs9.getString("customer_ID")+",")!=-1&&customer_ID_choice_group.indexOf(rs9.getString("customer_ID")+",")==-1){
String sqll0="insert into crm_file_dig(CHAIN_ID,CHAIN_NAME,CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_NICK,CUSTOMER_ADDRESS,CUSTOMER_CLASS,TYPE,CUSTOMER_BANK,CUSTOMER_ACCOUNT,CUSTOMER_WEB,CUSTOMER_TEL1,CUSTOMER_TEL2,CUSTOMER_EMAIL,CUSTOMER_FAX,CUSTOMER_POSTCODE,CONTACT_PERSON1,CONTACT_PERSON1_DEPARTMENT,CONTACT_PERSON1_DUTY,CONTACT_PERSON1_SEX,CONTACT_PERSON1_OFFICE_TEL,CONTACT_PERSON1_HOME_TEL,CONTACT_PERSON1_MOBILE,CONTACT_PERSON1_FAX,CONTACT_PERSON1_EMAIL,CONTACT_PERSON1_FAVORITE,CONTACT_PERSON2,CONTACT_PERSON2_DEPARTMENT,CONTACT_PERSON2_DUTY,CONTACT_PERSON2_SEX,CONTACT_PERSON2_OFFICE_TEL,CONTACT_PERSON2_HOME_TEL,CONTACT_PERSON2_MOBILE,CONTACT_PERSON2_FAX,CONTACT_PERSON2_EMAIL,CONTACT_PERSON2_FAVORITE,INVOICE_INFO,DEMAND,REMARK,CHECK_TAG,CONTACT_AMOUNT,ACHIEVEMENT_SUM,ATTACHMENT_NAME,TRADE_AMOUNT,RETURN_SUM,RETURN_AMOUNT,GATHER_PERIOD_SUM,GATHER_PERIOD_AVERAGE,FILE_CHANGE_AMOUNT,GATHER_PERIOD_LIMIT,GATHER_SUM_LIMIT,CONTACT_PERIOD_LIMIT,USED_CUSTOMER_NAME,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,LATELY_TRADE_TIME,LATELY_CONTACT_TIME,DELETE_TIME,RECOVERY_TIME,SALES_NAME,SALES_ID,MODIFY_TAG,EXCEL_TAG,REMIND_CONTACT_TAG,REMIND_GATHER_TAG,REMIND_RETURN_TAG) values('"+rs9.getString("CHAIN_ID")+"','"+rs9.getString("CHAIN_NAME")+"','"+rs9.getString("CUSTOMER_ID")+"','"+rs9.getString("CUSTOMER_NAME")+"','"+rs9.getString("CUSTOMER_NICK")+"','"+rs9.getString("CUSTOMER_ADDRESS")+"','"+rs9.getString("CUSTOMER_CLASS")+"','"+rs9.getString("TYPE")+"','"+rs9.getString("CUSTOMER_BANK")+"','"+rs9.getString("CUSTOMER_ACCOUNT")+"','"+rs9.getString("CUSTOMER_WEB")+"','"+rs9.getString("CUSTOMER_TEL1")+"','"+rs9.getString("CUSTOMER_TEL2")+"','"+rs9.getString("CUSTOMER_EMAIL")+"','"+rs9.getString("CUSTOMER_FAX")+"','"+rs9.getString("CUSTOMER_POSTCODE")+"','"+rs9.getString("CONTACT_PERSON1")+"','"+rs9.getString("CONTACT_PERSON1_DEPARTMENT")+"','"+rs9.getString("CONTACT_PERSON1_DUTY")+"','"+rs9.getString("CONTACT_PERSON1_SEX")+"','"+rs9.getString("CONTACT_PERSON1_OFFICE_TEL")+"','"+rs9.getString("CONTACT_PERSON1_HOME_TEL")+"','"+rs9.getString("CONTACT_PERSON1_MOBILE")+"','"+rs9.getString("CONTACT_PERSON1_FAX")+"','"+rs9.getString("CONTACT_PERSON1_EMAIL")+"','"+rs9.getString("CONTACT_PERSON1_FAVORITE")+"','"+rs9.getString("CONTACT_PERSON2")+"','"+rs9.getString("CONTACT_PERSON2_DEPARTMENT")+"','"+rs9.getString("CONTACT_PERSON2_DUTY")+"','"+rs9.getString("CONTACT_PERSON2_SEX")+"','"+rs9.getString("CONTACT_PERSON2_OFFICE_TEL")+"','"+rs9.getString("CONTACT_PERSON2_HOME_TEL")+"','"+rs9.getString("CONTACT_PERSON2_MOBILE")+"','"+rs9.getString("CONTACT_PERSON2_FAX")+"','"+rs9.getString("CONTACT_PERSON2_EMAIL")+"','"+rs9.getString("CONTACT_PERSON2_FAVORITE")+"','"+rs9.getString("INVOICE_INFO")+"','"+rs9.getString("DEMAND")+"','"+rs9.getString("REMARK")+"','"+rs9.getString("CHECK_TAG")+"','"+rs9.getString("CONTACT_AMOUNT")+"','"+rs9.getString("ACHIEVEMENT_SUM")+"','"+rs9.getString("ATTACHMENT_NAME")+"','"+rs9.getString("TRADE_AMOUNT")+"','"+rs9.getString("RETURN_SUM")+"','"+rs9.getString("RETURN_AMOUNT")+"','"+rs9.getString("GATHER_PERIOD_SUM")+"','"+rs9.getString("GATHER_PERIOD_AVERAGE")+"','"+rs9.getString("FILE_CHANGE_AMOUNT")+"','"+rs9.getString("GATHER_PERIOD_LIMIT")+"','"+rs9.getString("GATHER_SUM_LIMIT")+"','"+rs9.getString("CONTACT_PERIOD_LIMIT")+"','"+rs9.getString("USED_CUSTOMER_NAME")+"','"+rs9.getString("REGISTER")+"','"+rs9.getString("CHECKER")+"','"+rs9.getString("CHANGER")+"','"+rs9.getString("REGISTER_ID")+"','"+rs9.getString("CHECKER_ID")+"','"+rs9.getString("CHANGER_ID")+"','"+rs9.getString("REGISTER_TIME")+"','"+rs9.getString("CHECK_TIME")+"','"+rs9.getString("CHANGE_TIME")+"','"+rs9.getString("LATELY_CHANGE_TIME")+"','"+rs9.getString("LATELY_TRADE_TIME")+"','"+rs9.getString("LATELY_CONTACT_TIME")+"','"+rs9.getString("DELETE_TIME")+"','"+rs9.getString("RECOVERY_TIME")+"','"+rs9.getString("SALES_NAME")+"','"+rs9.getString("SALES_ID")+"','"+rs9.getString("MODIFY_TAG")+"','"+rs9.getString("EXCEL_TAG")+"','"+rs9.getString("REMIND_CONTACT_TAG")+"','"+rs9.getString("REMIND_GATHER_TAG")+"','"+rs9.getString("REMIND_RETURN_TAG")+"')";
	crm_db.executeUpdate(sqll0) ;

int change_amount=rs9.getInt("file_change_amount")+1;

	String sql11 = "update crm_file set changer='"+changer+"',change_time='"+time+"',lately_change_time='"+rs9.getString("CHANGE_TIME")+"',file_change_amount='"+change_amount+"',sales_ID='',sales_name='' where customer_ID='"+rs9.getString("customer_ID")+"'";
	crm_db.executeUpdate(sql11) ;
	}
}
crm_db.commit();
crm_db1.commit();
String sql14="select * from hr_file where check_tag='1' and human_major_first_kind_name='销售'";
ResultSet rs14=hr_db.executeQuery(sql14);

while(rs14.next()){
String sql12="select count(*) from crm_file where sales_ID='"+rs14.getString("human_ID")+"' and check_tag='1'";
ResultSet rs15=hr_db1.executeQuery(sql12);
if(rs15.next()){
String sql13="update hr_file set personal_work_amount='"+rs15.getInt("count(*)")+"' where human_ID='"+rs14.getString("human_ID")+"'";
	hr_db1.executeUpdate(sql13) ;
}
}

hr_db.commit();
hr_db1.commit();	
	crm_db.close();
	crm_db1.close();
    hr_db.close();
	hr_db1.close();
	response.sendRedirect("crm/sales_manager/change_customer_ok_a.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){}

}
}
