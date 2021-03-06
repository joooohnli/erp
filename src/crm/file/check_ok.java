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
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
 
 import include.nseer_cookie.exchange;
 import include.nseer_db.*;
 import java.text.*;
 import include.get_name_from_ID.getNameFromID;
 import include.nseer_cookie.*;
 import validata.ValidataTag;
 import include.operateDB.CdefineUpdate;
 import include.alarm.CheckRows;


public class check_ok extends HttpServlet{


ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;


public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
counter count=new counter(dbApplication);
getNameFromID getNameFromID = new getNameFromID();
ValidataTag   vt=new  ValidataTag();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String customer_ID=request.getParameter("customer_ID");
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String oldKind_chain=request.getParameter("oldKind_chain");
String oldChain_id=Divide1.getId(oldKind_chain);
String sales_name="";
String sql6="select id from crm_workflow where object_ID='"+customer_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=crm_db.executeQuery(sql6);
if(!rs6.next()){
String sales_ID=request.getParameter("sales_ID");
if(!sales_ID.equals("")){
	sales_name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID,"human_name");
}
if(true){
String customer_name=request.getParameter("customer_name") ;
String customer_address=request.getParameter("customer_address") ;
String type=request.getParameter("type") ;
String customer_class=request.getParameter("class") ;
String gather_sum_limit2=request.getParameter("gather_sum_limit") ;
StringTokenizer tokenTO4 = new StringTokenizer(gather_sum_limit2,",");        
String gather_sum_limit="";
            while(tokenTO4.hasMoreTokens()) {
                String gather_sum_limit1 = tokenTO4.nextToken();
		gather_sum_limit +=gather_sum_limit1;
		}
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
String register=request.getParameter("register") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String bodyc = new String(request.getParameter("invoice_info").getBytes("gb2312"),"gb2312");
String invoice_info=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("demand").getBytes("gb2312"),"gb2312");
String demand=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("remark").getBytes("gb2312"),"gb2312");
String remark=exchange.toHtml(bodyb);
if(!vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_id",customer_ID,"check_tag").equals("1")){
try{
if(customer_ID==null||customer_ID.equals("")){
	customer_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
}
	String sql = "update crm_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',customer_name='"+customer_name+"',customer_address='"+customer_address+"',customer_class='"+customer_class+"',type='"+type+"',customer_bank='"+customer_bank+"',customer_account='"+customer_account+"',customer_web='"+customer_web+"',customer_tel1='"+customer_tel1+"',customer_tel2='"+customer_tel2+"',customer_fax='"+customer_fax+"',customer_postcode='"+customer_postcode+"',used_customer_name='"+used_customer_name+"',gather_sum_limit='"+gather_sum_limit+"',gather_period_limit='"+gather_period_limit+"',contact_period_limit='"+contact_period_limit+"',contact_person1='"+contact_person1+"',contact_person1_department='"+contact_person1_department+"',contact_person1_duty='"+contact_person1_duty+"',contact_person1_sex='"+contact_person1_sex+"',contact_person1_office_tel='"+contact_person1_office_tel+"',contact_person1_home_tel='"+contact_person1_home_tel+"',contact_person1_mobile='"+contact_person1_mobile+"',contact_person1_email='"+contact_person1_email+"',contact_person2='"+contact_person2+"',contact_person2_department='"+contact_person2_department+"',contact_person2_duty='"+contact_person2_duty+"',contact_person2_sex='"+contact_person2_sex+"',contact_person2_office_tel='"+contact_person2_office_tel+"',contact_person2_home_tel='"+contact_person2_home_tel+"',contact_person2_mobile='"+contact_person2_mobile+"',contact_person2_email='"+contact_person2_email+"',register='"+register+"',invoice_info='"+invoice_info+"',demand='"+demand+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',sales_name='"+sales_name+"',sales_ID='"+sales_ID+"' where customer_ID='"+customer_ID+"' and check_tag='0'" ;
	crm_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("crm_file","customer_ID",customer_ID,request);
	crm_db.executeUpdate(sql) ;
	/*****************************************************/
	if(!chain_id.equals("oldChain_id")){
		sql="update crm_config_file_kind set delete_tag='0' where file_id='"+oldChain_id+"'";
			crm_db.executeUpdate(sql);
		sql="update crm_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
			crm_db.executeUpdate(sql);//delete_tag为1说明机构被使用	
	}
	sql = "update crm_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+customer_ID+"' and config_id='"+config_id+"'" ;
	crm_db.executeUpdate(sql);
	sql="select id from crm_workflow where object_ID='"+customer_ID+"' and check_tag='0'";
	ResultSet rset=crm_db.executeQuery(sql);
	if(!rset.next()){
		CheckRows del=new CheckRows();
		del.delRowCount((String)dbSession.getAttribute("unit_db_name"),"crm_file");//报警
		sql="update crm_file set check_tag='1' where customer_ID='"+customer_ID+"'";
		crm_db.executeUpdate(sql);
	if(!sales_ID.equals("")){
	String sql1="select personal_work_amount from hr_file where human_ID='"+sales_ID+"'";
	ResultSet rs1=crm_db.executeQuery(sql1) ;
	if(rs1.next()){
		int personal_work_amount=rs1.getInt("personal_work_amount")+1;
		String sql3="update hr_file set personal_work_amount='"+personal_work_amount+"' where human_ID='"+sales_ID+"'";
		crm_db.executeUpdate(sql3) ;
	}

}
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
			String[] elem=(String[])ite1.next();
			sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+customer_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
			crm_db.executeUpdate(sql) ;
		}
	}
}	
}
}catch (Exception ex){
ex.printStackTrace();
}



response.sendRedirect("crm/file/check_choose_attachment.jsp?customer_ID="+customer_ID+"");
}else{

  response.sendRedirect("crm/file/check_ok.jsp?finished_tag=2");//用户时候登陆过

}}else{
	

response.sendRedirect("crm/file/check_ok.jsp?finished_tag=1");

}
}else{
	

response.sendRedirect("crm/file/check_ok.jsp?finished_tag=0");

}
crm_db.commit();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception x){
	x.printStackTrace();

}

}
}