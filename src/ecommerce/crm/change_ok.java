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
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;
import include.nseer_cookie.*;

public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();
try{
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String responsible_person_ID="";
String responsible_person_name="";
String customer_ID=request.getParameter("customer_ID");

String sql2="select * from crm_config_file_kind where file_id='"+chain_id+"'";

String customer_name=request.getParameter("customer_name") ;
String customer_address=request.getParameter("customer_address") ;
String type=request.getParameter("type") ;
String customer_class=request.getParameter("class") ;
String gather_sum_limit=request.getParameter("gather_sum_limit") ;
String gather_period_limit=request.getParameter("gather_period_limit") ;
String contact_period_limit=request.getParameter("contact_period_limit") ;
String used_customer_name=request.getParameter("used_customer_name") ;
String customer_bank=request.getParameter("customer_bank") ;
String customer_account=request.getParameter("customer_account") ;
String customer_web=request.getParameter("customer_web") ;
String customer_tel1=request.getParameter("customer_tel1") ;
String customer_tel2=request.getParameter("customer_tel2") ;
String customer_fax=request.getParameter("customer_fax") ;
String customer_postcode=request.getParameter("customer_postcode") ;
String contact_person1=request.getParameter("contact_person1") ;
String contact_person1_department=request.getParameter("contact_person1_department") ;
String contact_person1_duty=request.getParameter("contact_person1_duty") ;
String contact_person1_sex = request.getParameter("contact_person1_sex") ;
String contact_person1_office_tel=request.getParameter("contact_person1_office_tel") ;
String contact_person1_home_tel=request.getParameter("contact_person1_home_tel") ;
String contact_person1_mobile=request.getParameter("contact_person1_mobile") ;
String contact_person1_email=request.getParameter("contact_person1_email") ;
String contact_person2=request.getParameter("contact_person2") ;
String contact_person2_department=request.getParameter("contact_person2_department") ;
String contact_person2_duty=request.getParameter("contact_person2_duty") ;
String contact_person2_sex = request.getParameter("contact_person2_sex") ;
String contact_person2_office_tel=request.getParameter("contact_person2_office_tel") ;
String contact_person2_home_tel=request.getParameter("contact_person2_home_tel") ;
String contact_person2_mobile=request.getParameter("contact_person2_mobile") ;
String contact_person2_email=request.getParameter("contact_person2_email") ;
String changer_ID=request.getParameter("changer_ID") ;
String changer=request.getParameter("changer") ;
String change_time=request.getParameter("change_time") ;
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String bodyc = new String(request.getParameter("invoice_info").getBytes("UTF-8"),"UTF-8");
String invoice_info=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("demand").getBytes("UTF-8"),"UTF-8");
String demand=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String checker_ID=request.getParameter("checker_ID") ;

int n=0;
	if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID,"check_tag").equals("1")){
if(n==0){
ResultSet rs2=crm_db.executeQuery(sql2) ;
if(rs2.next()){

try{
	String sqloo= "select * from crm_file where customer_ID='"+customer_ID+"'";
	 ResultSet rs8 = crm_db.executeQuery(sqloo);
	 if(rs8.next()){
	String sqll="insert into crm_file_dig(CHAIN_ID,CHAIN_NAME,CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_NICK,CUSTOMER_ADDRESS,CUSTOMER_CLASS,TYPE,CUSTOMER_BANK,CUSTOMER_ACCOUNT,CUSTOMER_WEB,CUSTOMER_TEL1,CUSTOMER_TEL2,CUSTOMER_EMAIL,CUSTOMER_FAX,CUSTOMER_POSTCODE,CONTACT_PERSON1,CONTACT_PERSON1_DEPARTMENT,CONTACT_PERSON1_DUTY,CONTACT_PERSON1_SEX,CONTACT_PERSON1_OFFICE_TEL,CONTACT_PERSON1_HOME_TEL,CONTACT_PERSON1_MOBILE,CONTACT_PERSON1_FAX,CONTACT_PERSON1_EMAIL,CONTACT_PERSON1_FAVORITE,CONTACT_PERSON2,CONTACT_PERSON2_DEPARTMENT,CONTACT_PERSON2_DUTY,CONTACT_PERSON2_SEX,CONTACT_PERSON2_OFFICE_TEL,CONTACT_PERSON2_HOME_TEL,CONTACT_PERSON2_MOBILE,CONTACT_PERSON2_FAX,CONTACT_PERSON2_EMAIL,CONTACT_PERSON2_FAVORITE,INVOICE_INFO,DEMAND,REMARK,CHECK_TAG,CONTACT_AMOUNT,ACHIEVEMENT_SUM,ATTACHMENT_NAME,TRADE_AMOUNT,RETURN_SUM,RETURN_AMOUNT,GATHER_PERIOD_SUM,GATHER_PERIOD_AVERAGE,FILE_CHANGE_AMOUNT,GATHER_PERIOD_LIMIT,GATHER_SUM_LIMIT,CONTACT_PERIOD_LIMIT,USED_CUSTOMER_NAME,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,LATELY_TRADE_TIME,LATELY_CONTACT_TIME,DELETE_TIME,RECOVERY_TIME,SALES_NAME,SALES_ID,MODIFY_TAG,EXCEL_TAG,REMIND_CONTACT_TAG,REMIND_GATHER_TAG,REMIND_RETURN_TAG,OPINION) values('"+rs8.getString("CHAIN_ID")+"','"+rs8.getString("CHAIN_NAME")+"','"+rs8.getString("CUSTOMER_ID")+"','"+rs8.getString("CUSTOMER_NAME")+"','"+rs8.getString("CUSTOMER_NICK")+"','"+rs8.getString("CUSTOMER_ADDRESS")+"','"+rs8.getString("CUSTOMER_CLASS")+"','"+rs8.getString("TYPE")+"','"+rs8.getString("CUSTOMER_BANK")+"','"+rs8.getString("CUSTOMER_ACCOUNT")+"','"+rs8.getString("CUSTOMER_WEB")+"','"+rs8.getString("CUSTOMER_TEL1")+"','"+rs8.getString("CUSTOMER_TEL2")+"','"+rs8.getString("CUSTOMER_EMAIL")+"','"+rs8.getString("CUSTOMER_FAX")+"','"+rs8.getString("CUSTOMER_POSTCODE")+"','"+rs8.getString("CONTACT_PERSON1")+"','"+rs8.getString("CONTACT_PERSON1_DEPARTMENT")+"','"+rs8.getString("CONTACT_PERSON1_DUTY")+"','"+rs8.getString("CONTACT_PERSON1_SEX")+"','"+rs8.getString("CONTACT_PERSON1_OFFICE_TEL")+"','"+rs8.getString("CONTACT_PERSON1_HOME_TEL")+"','"+rs8.getString("CONTACT_PERSON1_MOBILE")+"','"+rs8.getString("CONTACT_PERSON1_FAX")+"','"+rs8.getString("CONTACT_PERSON1_EMAIL")+"','"+rs8.getString("CONTACT_PERSON1_FAVORITE")+"','"+rs8.getString("CONTACT_PERSON2")+"','"+rs8.getString("CONTACT_PERSON2_DEPARTMENT")+"','"+rs8.getString("CONTACT_PERSON2_DUTY")+"','"+rs8.getString("CONTACT_PERSON2_SEX")+"','"+rs8.getString("CONTACT_PERSON2_OFFICE_TEL")+"','"+rs8.getString("CONTACT_PERSON2_HOME_TEL")+"','"+rs8.getString("CONTACT_PERSON2_MOBILE")+"','"+rs8.getString("CONTACT_PERSON2_FAX")+"','"+rs8.getString("CONTACT_PERSON2_EMAIL")+"','"+rs8.getString("CONTACT_PERSON2_FAVORITE")+"','"+rs8.getString("INVOICE_INFO")+"','"+rs8.getString("DEMAND")+"','"+rs8.getString("REMARK")+"','"+rs8.getString("CHECK_TAG")+"','"+rs8.getString("CONTACT_AMOUNT")+"','"+rs8.getString("ACHIEVEMENT_SUM")+"','"+rs8.getString("ATTACHMENT_NAME")+"','"+rs8.getString("TRADE_AMOUNT")+"','"+rs8.getString("RETURN_SUM")+"','"+rs8.getString("RETURN_AMOUNT")+"','"+rs8.getString("GATHER_PERIOD_SUM")+"','"+rs8.getString("GATHER_PERIOD_AVERAGE")+"','"+rs8.getString("FILE_CHANGE_AMOUNT")+"','"+rs8.getString("GATHER_PERIOD_LIMIT")+"','"+rs8.getString("GATHER_SUM_LIMIT")+"','"+rs8.getString("CONTACT_PERIOD_LIMIT")+"','"+rs8.getString("USED_CUSTOMER_NAME")+"','"+rs8.getString("REGISTER")+"','"+rs8.getString("CHECKER")+"','"+rs8.getString("CHANGER")+"','"+rs8.getString("REGISTER_ID")+"','"+rs8.getString("CHECKER_ID")+"','"+rs8.getString("CHANGER_ID")+"','"+rs8.getString("REGISTER_TIME")+"','"+rs8.getString("CHECK_TIME")+"','"+rs8.getString("CHANGE_TIME")+"','"+rs8.getString("LATELY_CHANGE_TIME")+"','"+rs8.getString("LATELY_TRADE_TIME")+"','"+rs8.getString("LATELY_CONTACT_TIME")+"','"+rs8.getString("DELETE_TIME")+"','"+rs8.getString("RECOVERY_TIME")+"','"+rs8.getString("SALES_NAME")+"','"+rs8.getString("SALES_ID")+"','"+rs8.getString("MODIFY_TAG")+"','"+rs8.getString("EXCEL_TAG")+"','"+rs8.getString("REMIND_CONTACT_TAG")+"','"+rs8.getString("REMIND_GATHER_TAG")+"','"+rs8.getString("REMIND_RETURN_TAG")+"','"+rs8.getString("OPINION")+"')";
	crm_db.executeUpdate(sqll) ;
	 }
		
		String sql = "update crm_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',customer_name='"+customer_name+"',customer_address='"+customer_address+"',customer_class='"+customer_class+"',type='"+type+"',customer_bank='"+customer_bank+"',customer_account='"+customer_account+"',customer_web='"+customer_web+"',customer_tel1='"+customer_tel1+"',customer_tel2='"+customer_tel2+"',customer_fax='"+customer_fax+"',customer_postcode='"+customer_postcode+"',used_customer_name='"+used_customer_name+"',gather_sum_limit='"+gather_sum_limit+"',gather_period_limit='"+gather_period_limit+"',contact_period_limit='"+contact_period_limit+"',contact_person1='"+contact_person1+"',contact_person1_department='"+contact_person1_department+"',contact_person1_duty='"+contact_person1_duty+"',contact_person1_sex='"+contact_person1_sex+"',contact_person1_office_tel='"+contact_person1_office_tel+"',contact_person1_home_tel='"+contact_person1_home_tel+"',contact_person1_mobile='"+contact_person1_mobile+"',contact_person1_email='"+contact_person1_email+"',contact_person2='"+contact_person2+"',contact_person2_department='"+contact_person2_department+"',contact_person2_duty='"+contact_person2_duty+"',contact_person2_sex='"+contact_person2_sex+"',contact_person2_office_tel='"+contact_person2_office_tel+"',contact_person2_home_tel='"+contact_person2_home_tel+"',contact_person2_mobile='"+contact_person2_mobile+"',contact_person2_email='"+contact_person2_email+"',changer_ID='"+changer_ID+"',changer='"+changer+"',invoice_info='"+invoice_info+"',demand='"+demand+"',remark='"+remark+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',check_tag='0',excel_tag='1' where customer_ID='"+customer_ID+"'" ;
	crm_db.executeUpdate(sql) ;


	sql="delete from crm_workflow where object_id='"+customer_ID+"'";
	crm_db.executeUpdate(sql);
	List rsList = GetWorkflow.getList(crm_db, "crm_config_workflow", "01");
	if(rsList.size()==0){//产品档案无工作流
		sql="update crm_file set check_tag='1' where customer_ID='"+customer_ID+"'";
		crm_db.executeUpdate(sql);
		sql="delete from ecommerce_workflow where object_id='"+customer_ID+"'";
		crm_db.executeUpdate(sql);
		List rsList1 = GetWorkflow.getList(crm_db, "ecommerce_config_workflow", "02");
		if(rsList1.size()==0){//电子商务的配送信息的发布审核无工作流
			sql = "update crm_file set excel_tag='3' where customer_ID='"+customer_ID+"'" ;//excel_tag为3表示所有审核工作流审核通过
			crm_db.executeUpdate(sql);
     	}else{
			Iterator ite=rsList1.iterator();
			while(ite.hasNext()){
				String[] elem=(String[])ite.next();
				sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+customer_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
				crm_db.executeUpdate(sql);
			}
		}
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into crm_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+customer_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		crm_db.executeUpdate(sql);
		}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("ecommerce/crm/change_choose_attachment.jsp?customer_ID="+customer_ID+"");
}else{
	response.sendRedirect("ecommerce/crm/change_ok_a.jsp?customer_ID="+customer_ID+"");
	}
}else{
response.sendRedirect("ecommerce/crm/change_ok_b.jsp?customer_ID="+customer_ID+"");
}}else{
response.sendRedirect("ecommerce/crm/change_ok_c.jsp");
}
crm_db.commit();
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