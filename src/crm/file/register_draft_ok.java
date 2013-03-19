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
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import java.io.*;
import java.util.*;
import include.nseer_cookie.*;
import include.get_name_from_ID.getNameFromID;
import include.operateDB.CdefineUpdate;

public class register_draft_ok extends HttpServlet{
ServletContext application;
nseer_db_backup1 erp_db = null;
public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


	try{
//实例化
		
HttpSession session=request.getSession();
counter count=new counter(dbApplication);
getNameFromID getNameFromID = new getNameFromID();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String sales_name="";
String sales_ID=request.getParameter("sales_ID");
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String sql2="select id from crm_config_file_kind where chain_ID='"+chain_id+"'";
ResultSet rs2=crm_db.executeQuery(sql2) ;
if(!sales_ID.equals("")){
	sql2="select id from hr_file where human_ID='"+sales_ID+"' and human_major_first_kind_name='销售'";
	rs2=crm_db.executeQuery(sql2) ;
}
if(rs2.next()){
if(!sales_ID.equals("")){
	sales_name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID,"human_name");
}
String customer_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String customer_name=request.getParameter("customer_name") ;
String customer_address=request.getParameter("customer_address") ;
String type=request.getParameter("type") ;
String customer_class=request.getParameter("class1") ;
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
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("invoice_info").getBytes("UTF-8"),"UTF-8");
String invoice_info=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("demand").getBytes("UTF-8"),"UTF-8");
String demand=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
try{
  String sqll="select id from crm_file where customer_ID='"+customer_ID+"' and customer_name='"+customer_name+"'";
	ResultSet rset=crm_db.executeQuery(sqll) ;
if(rset.next()){
	response.sendRedirect("crm/file/register_draft_ok.jsp?finished_tag=0");//用户时候登陆过
   }else{

	String sql = "insert into crm_file(customer_ID,customer_name,customer_address,customer_class,type,customer_bank,customer_account,customer_web,customer_tel1,customer_tel2,customer_fax,customer_postcode,used_customer_name,gather_sum_limit,gather_period_limit,contact_period_limit,contact_person1,contact_person1_department,contact_person1_duty,contact_person1_sex,contact_person1_office_tel,contact_person1_home_tel,contact_person1_mobile,contact_person1_email,contact_person2,contact_person2_department,contact_person2_duty,contact_person2_sex,contact_person2_office_tel,contact_person2_home_tel,contact_person2_mobile,contact_person2_email,register,register_time,invoice_info,demand,remark,check_tag,modify_tag,excel_tag,sales_name,sales_ID,chain_id,chain_name) values ('"+customer_ID+"','"+customer_name+"','"+customer_address+"','"+customer_class+"','"+type+"','"+customer_bank+"','"+customer_account+"','"+customer_web+"','"+customer_tel1+"','"+customer_tel2+"','"+customer_fax+"','"+customer_postcode+"','"+used_customer_name+"','"+gather_sum_limit+"','"+gather_period_limit+"','"+contact_period_limit+"','"+contact_person1+"','"+contact_person1_department+"','"+contact_person1_duty+"','"+contact_person1_sex+"','"+contact_person1_office_tel+"','"+contact_person1_home_tel+"','"+contact_person1_mobile+"','"+contact_person1_email+"','"+contact_person2+"','"+contact_person2_department+"','"+contact_person2_duty+"','"+contact_person2_sex+"','"+contact_person2_office_tel+"','"+contact_person2_home_tel+"','"+contact_person2_mobile+"','"+contact_person2_email+"','"+register+"','"+register_time+"','"+invoice_info+"','"+demand+"','"+remark+"','5','0','1','"+sales_name+"','"+sales_ID+"','"+chain_id+"','"+chain_name+"')" ;
	crm_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("crm_file","customer_ID",customer_ID,request);
	crm_db.executeUpdate(sql) ;
	/*****************************************************/
	
    sql="update crm_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
	crm_db.executeUpdate(sql);//delete_tag为1说明分类被使用	
	
response.sendRedirect("crm/file/register_choose_attachment.jsp?customer_ID="+customer_ID+"");
}
	
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
	

 response.sendRedirect("crm/file/register_draft_ok.jsp?finished_tag=1");//用户时候登陆过


}
crm_db.commit();
hr_db.commit();
crm_db.close();
	hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}