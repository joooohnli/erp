/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.file;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataTag;
import include.get_sql.getInsertSql;
import include.nseer_cookie.Divide1;
import include.operateDB.CdefineUpdate;


public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
getInsertSql getInsertSql=new getInsertSql();
ResultSet rset=null;
String id=request.getParameter("id");

String logisticser=request.getParameter("logisticser");
String logisticser_ID=request.getParameter("logisticser_ID");
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String provider_address=request.getParameter("provider_address") ;
String type=request.getParameter("type") ;
String provider_class=request.getParameter("class") ;
String used_provider_name=request.getParameter("used_provider_name") ;
String provider_bank=request.getParameter("provider_bank") ;
String provider_account=request.getParameter("provider_account") ;
String provider_web=request.getParameter("provider_web") ;
String provider_tel1=request.getParameter("provider_tel1") ;
String provider_fax=request.getParameter("provider_fax") ;
String provider_postcode=request.getParameter("provider_postcode") ;
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
String bodya = new String(request.getParameter("demand_products").getBytes("UTF-8"),"UTF-8");
String demand_products=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("recommend_products").getBytes("UTF-8"),"UTF-8");
String recommend_products=exchange.toHtml(bodyb);
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"logistics_file");
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_file","provider_ID",provider_ID,"check_tag").equals("1")){
try{

String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);


	String sqll="insert into logistics_file_dig("+column_group+") select "+column_group+" from logistics_file where id='"+id+"'";
	logistics_db.executeUpdate(sqll) ;
	String sql = "update logistics_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',provider_name='"+provider_name+"',provider_address='"+provider_address+"',provider_class='"+provider_class+"',type='"+type+"',provider_bank='"+provider_bank+"',provider_account='"+provider_account+"',provider_web='"+provider_web+"',provider_tel1='"+provider_tel1+"',provider_fax='"+provider_fax+"',provider_postcode='"+provider_postcode+"',used_provider_name='"+used_provider_name+"',contact_person1='"+contact_person1+"',contact_person1_department='"+contact_person1_department+"',contact_person1_duty='"+contact_person1_duty+"',contact_person1_sex='"+contact_person1_sex+"',contact_person1_office_tel='"+contact_person1_office_tel+"',contact_person1_home_tel='"+contact_person1_home_tel+"',contact_person1_mobile='"+contact_person1_mobile+"',contact_person1_email='"+contact_person1_email+"',contact_person2='"+contact_person2+"',contact_person2_department='"+contact_person2_department+"',contact_person2_duty='"+contact_person2_duty+"',contact_person2_sex='"+contact_person2_sex+"',contact_person2_office_tel='"+contact_person2_office_tel+"',contact_person2_home_tel='"+contact_person2_home_tel+"',contact_person2_mobile='"+contact_person2_mobile+"',contact_person2_email='"+contact_person2_email+"',changer_ID='"+changer_ID+"',changer='"+changer+"',invoice_info='"+invoice_info+"',demand_products='"+demand_products+"',recommend_products='"+recommend_products+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',logisticser='"+logisticser+"',logisticser_ID='"+logisticser_ID+"',check_tag='0' where provider_ID='"+provider_ID+"'" ;
	logistics_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("logistics_file","provider_ID",provider_ID,request);
	logistics_db.executeUpdate(sql) ;
	/*****************************************************/
	
	sql="delete from logistics_workflow where object_id='"+provider_ID+"'";
	logistics_db.executeUpdate(sql) ;

	List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	sql="select id,describe1,describe2 from logistics_config_workflow where type_id='01'";
	rset=logistics_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
	if(rsList.size()==0){
		sql="update logistics_file set check_tag='1' where provider_ID='"+provider_ID+"'";
		logistics_db.executeUpdate(sql) ;
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into logistics_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+provider_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		logistics_db.executeUpdate(sql) ;
		}
	}	
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("logistics/file/change_choose_attachment.jsp?provider_ID="+provider_ID+"");
}else{
	response.sendRedirect("logistics/file/change_ok_a.jsp");
	}
	logistics_db.commit();
	logistics_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 