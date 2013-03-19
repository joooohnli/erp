/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.intrmessage;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 oa_db=new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){
Note note=new Note();
Email mail=new Email();
String intrmessage_ID=request.getParameter("intrmessage_ID");
String checker=request.getParameter("checker");
String checker_ID=request.getParameter("checker_ID");
String check_time=request.getParameter("check_time");
String messager_type=request.getParameter("messager_type");
String[] check_type=request.getParameterValues("check_type");
String[] chain_id_array=request.getParameterValues("chain_id");
String send_type="";
if(check_type!=null){
	for(int i=0;i<check_type.length;i++){
		send_type+=check_type[i]+",";
	}
	send_type=send_type.substring(0,send_type.length()-1);
}
if(chain_id_array!=null){
	int n=0;	
	for(int j=0;j<chain_id_array.length;j++){
		if(!chain_id_array[j].equals("")){
			n++;
		}
	}
int check_amount=0;
String content="";
String file_name="";
String subject="";
String sql2="select * from oa_intrmessage where intrmessage_ID='"+intrmessage_ID+"'";
ResultSet rs2=oa_db.executeQuery(sql2);
if(rs2.next()){
	check_amount=rs2.getInt("check_amount")+1;
	subject=rs2.getString("subject");
	content=rs2.getString("content");
	file_name=rs2.getString("attachment1");
	File file=new File(path+"oa/file_attachments/"+file_name);
if(n==0||check_type==null){	
  	response.sendRedirect("oa/intrmessage/check_ok_a.jsp");
}else{
	String[] email_box=new String[n];
	n=0;
int p=0;
if(messager_type.equals("客户")){
	for(int j=0;j<chain_id_array.length;j++){
		if(!chain_id_array[j].equals("")){
			n++;
			String messager_ID=chain_id_array[j].split("/")[0];
			String messager_name=chain_id_array[j].split("/")[1];
			String sql3="select * from crm_file where customer_ID='"+messager_ID+"'";
			ResultSet rs3=oa_db.executeQuery(sql3);
			if(rs3.next()){
				email_box[p]=rs3.getString("customer_email");
				p++;
			String sql="insert into oa_intrmessage_details(intrmessage_ID,type,chain_id,chain_name,messager_ID,messager_name,batch_amount,cell,email) values('"+intrmessage_ID+"','"+messager_type+"','"+rs3.getString("chain_id")+"','"+rs3.getString("chain_name")+"','"+messager_ID+"','"+messager_name+"','"+check_amount+"','"+rs3.getString("contact_person1_mobile")+"','"+rs3.getString("customer_email")+"')";
			oa_db.executeUpdate(sql);
			if(send_type.indexOf("发短信")!=-1){
			note.send("bjnseer","8888",rs3.getString("contact_person1_mobile"),content);
			}
			}
		}
	}
}else if(messager_type.equals("采购供应商")){
	for(int j=0;j<chain_id_array.length;j++){
		if(!chain_id_array[j].equals("")){
			n++;
			String messager_ID=chain_id_array[j].split("/")[0];
			String messager_name=chain_id_array[j].split("/")[1];
			String sql3="select * from purchase_file where provider_ID='"+messager_ID+"'";
			ResultSet rs3=oa_db.executeQuery(sql3);
			if(rs3.next()){
				email_box[p]=rs3.getString("provider_email");
				p++;
			String sql="insert into oa_intrmessage_details(intrmessage_ID,type,chain_id,chain_name,messager_ID,messager_name,batch_amount,cell,email) values('"+intrmessage_ID+"','"+messager_type+"','"+rs3.getString("chain_id")+"','"+rs3.getString("chain_name")+"','"+messager_ID+"','"+messager_name+"','"+check_amount+"','"+rs3.getString("contact_person1_mobile")+"','"+rs3.getString("provider_email")+"')";
			oa_db.executeUpdate(sql);
			if(send_type.indexOf("发短信")!=-1){
			note.send("bjnseer","8888",rs3.getString("contact_person1_mobile"),content);
			}
			}
		}
	}
}else if(messager_type.equals("委外厂商")){
	for(int j=0;j<chain_id_array.length;j++){
		if(!chain_id_array[j].equals("")){
			n++;
			String messager_ID=chain_id_array[j].split("/")[0];
			String messager_name=chain_id_array[j].split("/")[1];
			String sql3="select * from intrmanufacture_file where provider_ID='"+messager_ID+"'";
			ResultSet rs3=oa_db.executeQuery(sql3);
			if(rs3.next()){
				email_box[p]=rs3.getString("provider_email");
				p++;
			String sql="insert into oa_intrmessage_details(intrmessage_ID,type,chain_id,chain_name,messager_ID,messager_name,batch_amount,cell,email) values('"+intrmessage_ID+"','"+messager_type+"','"+rs3.getString("chain_id")+"','"+messager_ID+"','"+messager_name+"','"+check_amount+"','"+rs3.getString("contact_person1_mobile")+"','"+rs3.getString("provider_email")+"')";
			oa_db.executeUpdate(sql);
			if(send_type.indexOf("发短信")!=-1){
			note.send("bjnseer","8888",rs3.getString("contact_person1_mobile"),content);
			}
			}
		}
	}
}else{
	for(int j=0;j<chain_id_array.length;j++){
		if(!chain_id_array[j].equals("")){
			n++;
			String messager_ID=chain_id_array[j].split("/")[0];
			String messager_name=chain_id_array[j].split("/")[1];
			String sql3="select * from hr_file where human_ID='"+messager_ID+"'";
			ResultSet rs3=oa_db.executeQuery(sql3);
			if(rs3.next()){
				email_box[p]=rs3.getString("human_email");
				p++;
			String sql="insert into oa_intrmessage_details(intrmessage_ID,type,chain_ID,chain_name,messager_ID,messager_name,batch_amount,cell,email) values('"+intrmessage_ID+"','"+messager_type+"','"+rs3.getString("chain_ID")+"','"+rs3.getString("chain_name")+"','"+messager_ID+"','"+messager_name+"','"+check_amount+"','"+rs3.getString("human_cellphone")+"','"+rs3.getString("human_email")+"')";
			oa_db.executeUpdate(sql);
			if(send_type.indexOf("发短信")!=-1){
			note.send("bjnseer","8888",rs3.getString("human_cellphone"),content);
			}
			}
		}
	}
}
if(send_type.indexOf("发邮件")!=-1){
	mail.send(email_box,"smtp.sina.com.cn","yhuser@sina.com","123456",subject,content);
}
if(n==0){	
  	response.sendRedirect("oa/intrmessage/check_ok_a.jsp");
	}else{
	String sql1="update oa_intrmessage set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_type='"+send_type+"',check_amount='"+check_amount+"',check_tag='1' where intrmessage_ID='"+intrmessage_ID+"'";
	oa_db.executeUpdate(sql1);
	
response.sendRedirect("oa/intrmessage/check_ok_b.jsp");
	}
}
}else{	
  	response.sendRedirect("oa/intrmessage/check_ok_c.jsp");
}
oa_db.commit();
oa_db.close();
}else{	
  	response.sendRedirect("oa/intrmessage/check_ok_d.jsp");
}
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}