/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package portal.purchase;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import include.operateDB.CdefineUpdate;
import include.tree_index.businessComment;

public class register1_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
ServletContext dbApplication=dbSession.getServletContext();
try{
businessComment demo=new businessComment();
               demo.setPath(request);
Email mail=new Email();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
if(!chain_id.equals("")){
String purchaser=request.getParameter("purchaser");
String purchaser_ID=request.getParameter("purchaser_ID");
String provider_name=request.getParameter("provider_name") ;
String provider_address=request.getParameter("provider_address") ;
String type=request.getParameter("type") ;
String provider_class=request.getParameter("class1") ;
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
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("invoice_info").getBytes("UTF-8"),"UTF-8");
String invoice_info=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("demand_products").getBytes("UTF-8"),"UTF-8");
String demand_products=exchange.toHtml(bodya);

String provider_ID=NseerId.getId("purchase/file",(String)dbSession.getAttribute("unit_db_name"));
	
    String sqll="select * from purchase_file where provider_ID='"+provider_ID+"' and provider_name='"+provider_name+"'";
	ResultSet rset=purchase_db.executeQuery(sqll) ;
if(rset.next()){
	
response.sendRedirect("portal/purchase/register1_ok_a.jsp");
}else{
	String sql = "insert into purchase_file(chain_id,chain_name,provider_ID,provider_name,provider_address,provider_class,type,provider_bank,provider_account,provider_web,provider_tel1,provider_fax,provider_postcode,used_provider_name,contact_person1,contact_person1_department,contact_person1_duty,contact_person1_sex,contact_person1_office_tel,contact_person1_home_tel,contact_person1_mobile,contact_person1_email,contact_person2,contact_person2_department,contact_person2_duty,contact_person2_sex,contact_person2_office_tel,contact_person2_home_tel,contact_person2_mobile,contact_person2_email,register,register_time,invoice_info,demand_products,check_tag,modify_tag,excel_tag,purchaser,purchaser_ID) values ('"+chain_id+"','"+chain_name+"','"+provider_ID+"','"+provider_name+"','"+provider_address+"','"+provider_class+"','"+type+"','"+provider_bank+"','"+provider_account+"','"+provider_web+"','"+provider_tel1+"','"+provider_fax+"','"+provider_postcode+"','"+used_provider_name+"','"+contact_person1+"','"+contact_person1_department+"','"+contact_person1_duty+"','"+contact_person1_sex+"','"+contact_person1_office_tel+"','"+contact_person1_home_tel+"','"+contact_person1_mobile+"','"+contact_person1_email+"','"+contact_person2+"','"+contact_person2_department+"','"+contact_person2_duty+"','"+contact_person2_sex+"','"+contact_person2_office_tel+"','"+contact_person2_home_tel+"','"+contact_person2_mobile+"','"+contact_person2_email+"','"+register+"','"+register_time+"','"+invoice_info+"','"+demand_products+"','0','0','1','"+purchaser+"','"+purchaser_ID+"')" ;
	purchase_db.executeUpdate(sql) ;
	String[] email_box={contact_person1_email};
	mail.send(email_box,"smtp.sina.com.cn","yhuser@sina.com","123456",demo.getLang("erp","注册信息"),"欢迎您注册成为我们的供应商，您的档案编号是:"+provider_ID);
	
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("purchase_file","provider_ID",provider_ID,request);
	purchase_db.executeUpdate(sql) ;
	/*****************************************************/
   List rsList = GetWorkflow.getList(purchase_db, "purchase_config_workflow", "01");

	if(rsList.size()==0){
		sql="update purchase_file set check_tag='1' where provider_ID='"+provider_ID+"'";
		purchase_db.executeUpdate(sql) ;
		

	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+provider_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		purchase_db.executeUpdate(sql);
		}
	}

	response.sendRedirect("portal/purchase/register1_choose_attachment.jsp?provider_ID="+provider_ID+"");
	}
	
	}else{
	response.sendRedirect("portal/purchase/register1_ok_b.jsp");
	}
	purchase_db.commit();	
	design_db.commit();
purchase_db.close();
	design_db.close();
	}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 