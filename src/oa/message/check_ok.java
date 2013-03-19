/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.message;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import include.nseer_cookie.exchange;

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

String message_ID=request.getParameter("message_ID");
String checker=request.getParameter("checker");
String checker_ID=request.getParameter("checker_ID");
String check_time=request.getParameter("check_time");
String[] check_type=request.getParameterValues("check_type");
String[] chain_id=request.getParameterValues("chain_id");
String send_type="";
if(check_type!=null){
	for(int i=0;i<check_type.length;i++){
		send_type+=check_type[i]+",";
	}
	send_type=send_type.substring(0,send_type.length()-1);
}
int n=0;
int check_amount=0;
String content="";
String file_name="";
String subject="";
String sql2="select * from oa_message where message_ID='"+message_ID+"'";
ResultSet rs2=oa_db.executeQuery(sql2);
if(rs2.next()){
	check_amount=rs2.getInt("check_amount")+1;
	subject=exchange.toHtml(rs2.getString("subject"));
	content=rs2.getString("content");
	file_name=rs2.getString("attachment1");
	File file=new File(path+"oa/file_attachments/"+file_name);

if(chain_id==null||check_type==null){
	
  	response.sendRedirect("oa/message/check_ok_a.jsp");
}else{
	String[] email_box=new String[chain_id.length];
	n=0;
int p=0;
for(int j=0;j<chain_id.length;j++){
	//String checkbox_name="col"+j;
	//String[] cols=request.getParameterValues(checkbox_name);
	
	
		if(!chain_id[j].equals("")){
			n++;
				StringTokenizer token=new StringTokenizer(chain_id[j],"/");
					while(token.hasMoreTokens()){
						String human_ID=token.nextToken();
						String human_name=token.nextToken();
						String sql3="select * from hr_file where human_ID='"+human_ID+"'";
						ResultSet rs3=oa_db.executeQuery(sql3);
						if(rs3.next()){
							email_box[p]=rs3.getString("human_email");
							p++;
						String sql="insert into oa_message_details(message_ID,chain_ID,chain_name,human_ID,human_name,human_major_first_kind_name,human_major_second_kind_name,batch_amount,cell,email) values('"+message_ID+"','"+rs3.getString("chain_ID")+"','"+rs3.getString("chain_name")+"','"+human_ID+"','"+human_name+"','"+rs3.getString("human_major_first_kind_name")+"','"+rs3.getString("human_major_second_kind_name")+"','"+check_amount+"','"+rs3.getString("human_cellphone")+"','"+rs3.getString("human_email")+"')";
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
  	response.sendRedirect("oa/message/check_ok_a.jsp");
	}else{
	String sql1="update oa_message set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_type='"+send_type+"',check_amount='"+check_amount+"',check_tag='1' where message_ID='"+message_ID+"'";
	oa_db.executeUpdate(sql1);
response.sendRedirect("oa/message/check_ok_b.jsp");
	}
}
}else{

  	response.sendRedirect("oa/message/check_ok_c.jsp");
}
oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}