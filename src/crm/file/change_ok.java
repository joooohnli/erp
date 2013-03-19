/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.file;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*; 
import java.io.*;
import include.nseer_cookie.* ;
import include.nseer_db.*;
import include.alarm.CheckRows;
import include.get_sql.getInsertSql;
import include.query.getRecordCount;
import validata.ValidataTag;
import include.operateDB.CdefineUpdate;

public class change_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

	//实例化
counter count=new counter(dbApplication);
getInsertSql getInsertSql = new getInsertSql();
getRecordCount  query=new getRecordCount();
ValidataTag  vt=new  ValidataTag();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String id=request.getParameter("id");
String sales_ID=request.getParameter("sales_ID");
String sales_name="";
String customer_ID=request.getParameter("customer_ID") ;
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
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
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"crm_file");
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_file","id",id,"check_tag").equals("1")){
	String sqll="insert into crm_file_dig("+column_group+") select "+column_group+" from crm_file where id='"+id+"'";
	crm_db.executeUpdate(sqll) ;
	String sql = "update crm_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',customer_name='"+customer_name+"',customer_address='"+customer_address+"',customer_class='"+customer_class+"',type='"+type+"',customer_bank='"+customer_bank+"',customer_account='"+customer_account+"',customer_web='"+customer_web+"',customer_tel1='"+customer_tel1+"',customer_tel2='"+customer_tel2+"',customer_fax='"+customer_fax+"',customer_postcode='"+customer_postcode+"',used_customer_name='"+used_customer_name+"',gather_sum_limit='"+gather_sum_limit+"',gather_period_limit='"+gather_period_limit+"',contact_period_limit='"+contact_period_limit+"',contact_person1='"+contact_person1+"',contact_person1_department='"+contact_person1_department+"',contact_person1_duty='"+contact_person1_duty+"',contact_person1_sex='"+contact_person1_sex+"',contact_person1_office_tel='"+contact_person1_office_tel+"',contact_person1_home_tel='"+contact_person1_home_tel+"',contact_person1_mobile='"+contact_person1_mobile+"',contact_person1_email='"+contact_person1_email+"',contact_person2='"+contact_person2+"',contact_person2_department='"+contact_person2_department+"',contact_person2_duty='"+contact_person2_duty+"',contact_person2_sex='"+contact_person2_sex+"',contact_person2_office_tel='"+contact_person2_office_tel+"',contact_person2_home_tel='"+contact_person2_home_tel+"',contact_person2_mobile='"+contact_person2_mobile+"',contact_person2_email='"+contact_person2_email+"',changer_ID='"+changer_ID+"',changer='"+changer+"',invoice_info='"+invoice_info+"',demand='"+demand+"',remark='"+remark+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"' where id="+id+"" ;
	crm_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("crm_file","customer_ID",customer_ID,request);
	crm_db.executeUpdate(sql) ;
	/*****************************************************/
	if(!chain_id.equals("")){
		sql="update crm_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
			crm_db.executeUpdate(sql);//delete_tag为1说明机构被使用	
	}
	List rsList = GetWorkflow.getList(crm_db, "crm_config_workflow", "01");
	if(rsList.size()==0){
		sql="update crm_file set check_tag='1' where customer_ID='"+customer_ID+"'";
		crm_db.executeUpdate(sql) ;
	if(type.equals("合作伙伴")){
	List rsList1 = GetWorkflow.getList(crm_db, "ecommerce_config_workflow", "02");
	sql="delete from ecommerce_workflow where object_ID='"+customer_ID+"'";
	crm_db.executeUpdate(sql);
	if(rsList1.size()==0){
		String sql1="update crm_file set excel_tag='3' where customer_ID='"+customer_ID+"'";
		crm_db.executeUpdate(sql1) ;
	}else{
		Iterator ite1=rsList1.iterator();
		while(ite1.hasNext()){
			String[] elem1=(String[])ite1.next();
			sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2) values 	('"+elem1[0]+"','"+customer_ID+"','"+elem1[1]+"','"+elem1[2]+"')" ;
			crm_db.executeUpdate(sql) ;
		}
}
}
	}else{
		if(!sales_ID.equals("")){
	String sqlh="select * from hr_file where human_ID='"+sales_ID+"'";
	ResultSet rsh=crm_db.executeQuery(sqlh) ;
	if(rsh.next()){
		int personal_work_amount=rsh.getInt("personal_work_amount")-1;
		String sqlh3="update hr_file set personal_work_amount='"+personal_work_amount+"' where human_ID='"+sales_ID+"'";
		crm_db.executeUpdate(sqlh3) ;
	}

}
		CheckRows add=new CheckRows();
		add.addRowCount((String)dbSession.getAttribute("unit_db_name"),"crm_file");//报警
		sql="delete from crm_workflow where object_ID='"+customer_ID+"'";
		crm_db.executeUpdate(sql) ;
		sql="update crm_file set check_tag='0' where customer_ID='"+customer_ID+"'";
		crm_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into crm_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+customer_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		crm_db.executeUpdate(sql) ;
		}
	}
	
response.sendRedirect("crm/file/change_choose_attachment.jsp?customer_ID="+customer_ID+"");
}else{

response.sendRedirect("crm/file/change_ok_a.jsp");//用户时候登陆过


}

crm_db.commit();
crm_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}