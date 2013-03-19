/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.crm;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;
import include.nseer_cookie.*;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
try{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();

if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String customer_ID=request.getParameter("customer_ID");
String choice=request.getParameter("choice");
String bodyd = new String(request.getParameter("opinion").getBytes("UTF-8"),"UTF-8");
String opinion=exchange.toHtml(bodyd);
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"crm_file");
String sql6="select * from ecommerce_workflow where object_ID='"+customer_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=crm_db.executeQuery(sql6);
if(!rs6.next()&&vt.validata((String)session.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID,"excel_tag").equals("1")){
if(choice!=null){
	sql6="select * from ecommerce_workflow where object_ID='"+customer_ID+"' and config_id<'"+config_id+"'";
	rs6=crm_db.executeQuery(sql6);
	if(!rs6.next()){
	String sqloo= "select * from crm_file where customer_ID='"+customer_ID+"'";
	 ResultSet rs8 = crm_db.executeQuery(sqloo);
	 if(rs8.next()){
	String sqll="insert into crm_file_dig(CHAIN_ID,CHAIN_NAME,CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_NICK,CUSTOMER_ADDRESS,CUSTOMER_CLASS,TYPE,CUSTOMER_BANK,CUSTOMER_ACCOUNT,CUSTOMER_WEB,CUSTOMER_TEL1,CUSTOMER_TEL2,CUSTOMER_EMAIL,CUSTOMER_FAX,CUSTOMER_POSTCODE,CONTACT_PERSON1,CONTACT_PERSON1_DEPARTMENT,CONTACT_PERSON1_DUTY,CONTACT_PERSON1_SEX,CONTACT_PERSON1_OFFICE_TEL,CONTACT_PERSON1_HOME_TEL,CONTACT_PERSON1_MOBILE,CONTACT_PERSON1_FAX,CONTACT_PERSON1_EMAIL,CONTACT_PERSON1_FAVORITE,CONTACT_PERSON2,CONTACT_PERSON2_DEPARTMENT,CONTACT_PERSON2_DUTY,CONTACT_PERSON2_SEX,CONTACT_PERSON2_OFFICE_TEL,CONTACT_PERSON2_HOME_TEL,CONTACT_PERSON2_MOBILE,CONTACT_PERSON2_FAX,CONTACT_PERSON2_EMAIL,CONTACT_PERSON2_FAVORITE,INVOICE_INFO,DEMAND,REMARK,CHECK_TAG,CONTACT_AMOUNT,ACHIEVEMENT_SUM,ATTACHMENT_NAME,TRADE_AMOUNT,RETURN_SUM,RETURN_AMOUNT,GATHER_PERIOD_SUM,GATHER_PERIOD_AVERAGE,FILE_CHANGE_AMOUNT,GATHER_PERIOD_LIMIT,GATHER_SUM_LIMIT,CONTACT_PERIOD_LIMIT,USED_CUSTOMER_NAME,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,LATELY_TRADE_TIME,LATELY_CONTACT_TIME,DELETE_TIME,RECOVERY_TIME,SALES_NAME,SALES_ID,MODIFY_TAG,EXCEL_TAG,REMIND_CONTACT_TAG,REMIND_GATHER_TAG,REMIND_RETURN_TAG,OPINION) values('"+rs8.getString("CHAIN_ID")+"','"+rs8.getString("CHAIN_NAME")+"','"+rs8.getString("CUSTOMER_ID")+"','"+rs8.getString("CUSTOMER_NAME")+"','"+rs8.getString("CUSTOMER_NICK")+"','"+rs8.getString("CUSTOMER_ADDRESS")+"','"+rs8.getString("CUSTOMER_CLASS")+"','"+rs8.getString("TYPE")+"','"+rs8.getString("CUSTOMER_BANK")+"','"+rs8.getString("CUSTOMER_ACCOUNT")+"','"+rs8.getString("CUSTOMER_WEB")+"','"+rs8.getString("CUSTOMER_TEL1")+"','"+rs8.getString("CUSTOMER_TEL2")+"','"+rs8.getString("CUSTOMER_EMAIL")+"','"+rs8.getString("CUSTOMER_FAX")+"','"+rs8.getString("CUSTOMER_POSTCODE")+"','"+rs8.getString("CONTACT_PERSON1")+"','"+rs8.getString("CONTACT_PERSON1_DEPARTMENT")+"','"+rs8.getString("CONTACT_PERSON1_DUTY")+"','"+rs8.getString("CONTACT_PERSON1_SEX")+"','"+rs8.getString("CONTACT_PERSON1_OFFICE_TEL")+"','"+rs8.getString("CONTACT_PERSON1_HOME_TEL")+"','"+rs8.getString("CONTACT_PERSON1_MOBILE")+"','"+rs8.getString("CONTACT_PERSON1_FAX")+"','"+rs8.getString("CONTACT_PERSON1_EMAIL")+"','"+rs8.getString("CONTACT_PERSON1_FAVORITE")+"','"+rs8.getString("CONTACT_PERSON2")+"','"+rs8.getString("CONTACT_PERSON2_DEPARTMENT")+"','"+rs8.getString("CONTACT_PERSON2_DUTY")+"','"+rs8.getString("CONTACT_PERSON2_SEX")+"','"+rs8.getString("CONTACT_PERSON2_OFFICE_TEL")+"','"+rs8.getString("CONTACT_PERSON2_HOME_TEL")+"','"+rs8.getString("CONTACT_PERSON2_MOBILE")+"','"+rs8.getString("CONTACT_PERSON2_FAX")+"','"+rs8.getString("CONTACT_PERSON2_EMAIL")+"','"+rs8.getString("CONTACT_PERSON2_FAVORITE")+"','"+rs8.getString("INVOICE_INFO")+"','"+rs8.getString("DEMAND")+"','"+rs8.getString("REMARK")+"','"+rs8.getString("CHECK_TAG")+"','"+rs8.getString("CONTACT_AMOUNT")+"','"+rs8.getString("ACHIEVEMENT_SUM")+"','"+rs8.getString("ATTACHMENT_NAME")+"','"+rs8.getString("TRADE_AMOUNT")+"','"+rs8.getString("RETURN_SUM")+"','"+rs8.getString("RETURN_AMOUNT")+"','"+rs8.getString("GATHER_PERIOD_SUM")+"','"+rs8.getString("GATHER_PERIOD_AVERAGE")+"','"+rs8.getString("FILE_CHANGE_AMOUNT")+"','"+rs8.getString("GATHER_PERIOD_LIMIT")+"','"+rs8.getString("GATHER_SUM_LIMIT")+"','"+rs8.getString("CONTACT_PERIOD_LIMIT")+"','"+rs8.getString("USED_CUSTOMER_NAME")+"','"+rs8.getString("REGISTER")+"','"+rs8.getString("CHECKER")+"','"+rs8.getString("CHANGER")+"','"+rs8.getString("REGISTER_ID")+"','"+rs8.getString("CHECKER_ID")+"','"+rs8.getString("CHANGER_ID")+"','"+rs8.getString("REGISTER_TIME")+"','"+rs8.getString("CHECK_TIME")+"','"+rs8.getString("CHANGE_TIME")+"','"+rs8.getString("LATELY_CHANGE_TIME")+"','"+rs8.getString("LATELY_TRADE_TIME")+"','"+rs8.getString("LATELY_CONTACT_TIME")+"','"+rs8.getString("DELETE_TIME")+"','"+rs8.getString("RECOVERY_TIME")+"','"+rs8.getString("SALES_NAME")+"','"+rs8.getString("SALES_ID")+"','"+rs8.getString("MODIFY_TAG")+"','"+rs8.getString("EXCEL_TAG")+"','"+rs8.getString("REMIND_CONTACT_TAG")+"','"+rs8.getString("REMIND_GATHER_TAG")+"','"+rs8.getString("REMIND_RETURN_TAG")+"','"+rs8.getString("OPINION")+"')";
	 
			crm_db.executeUpdate(sqll);
	 }
	}
	if(choice.equals("")){
	String sql = "update crm_file set opinion='"+opinion+"',excel_tag='9' where customer_ID='"+customer_ID+"'" ;
	crm_db.executeUpdate(sql) ;
	sql = "update ecommerce_workflow set check_tag='9',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"' where object_ID='"+customer_ID+"' and config_id='"+config_id+"'" ;
		crm_db.executeUpdate(sql) ;
	}else{

	sql6="select * from ecommerce_workflow where object_ID='"+customer_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=crm_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update ecommerce_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		crm_db1.executeUpdate(sql) ;
	}
	}	
response.sendRedirect("ecommerce/crm/check_delete_ok_a.jsp");
}else{
response.sendRedirect("ecommerce/crm/check_delete_ok_b.jsp?customer_ID="+customer_ID+"&config_id="+config_id+"");
}
}else{
response.sendRedirect("ecommerce/crm/check_delete_ok_c.jsp");
}
crm_db.commit();
crm_db1.commit();
crm_db.close();
crm_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}