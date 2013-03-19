/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.meeting;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import include.nseer_cookie.exchange;

public class dealwith_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 oa_db=new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){

Note note=new Note();
Email mail=new Email();


String meeting_ID=request.getParameter("meeting_ID");
String dealwith_checker=request.getParameter("dealwith_checker");
String dealwith_checker_ID=request.getParameter("dealwith_checker_ID");
String dealwith_time=request.getParameter("time");
String dealwith_type=request.getParameter("dealwith_type");
String cols_number=request.getParameter("cols_number");
String[] check_type=request.getParameterValues("check_type");

String[] chain_id=request.getParameterValues("chain_id");
String send_type="";
if(check_type!=null){
	if(chain_id!=null){
if(check_type!=null){
	for(int i=0;i<check_type.length;i++){
		send_type+=check_type[i]+",";
	}
	send_type=send_type.substring(0,send_type.length()-1);
}
int n=0;
/*for(int j=1;j<=Integer.parseInt(cols_number);j++){
	String checkbox_name="col"+j;
	String[] cols=request.getParameterValues(checkbox_name);
	if(cols!=null){
	for(int m=0;m<cols.length;m++){
		if(!cols[m].equals("")){
			n++;
		}
	}
	}
}*/
String[] email_box=new String[chain_id.length];
n=0;
int p=0;
String sql2="select * from oa_meeting where meeting_ID='"+meeting_ID+"' and check_tag='2'";
ResultSet rs2=oa_db.executeQuery(sql2);
if(rs2.next()){
String content=rs2.getString("content");
String subject=exchange.toHtml(rs2.getString("subject"));
for(int j=0;j<chain_id.length;j++){
	//String checkbox_name="col"+j;
	//String[] cols=request.getParameterValues(checkbox_name);
	
	
		if(!chain_id[j].equals("")){
			n++;
			if(chain_id[j].indexOf("//")!=-1){
				StringTokenizer token=new StringTokenizer(chain_id[j].substring(0,chain_id[j].length()-2),"/");
					while(token.hasMoreTokens()){
						String human_ID=token.nextToken();
						String human_name=token.nextToken();
						String sql="insert into oa_meeting_dealwith_details(meeting_ID,human_ID,human_name,human_major_first_kind_name,human_major_second_kind_name) values('"+meeting_ID+"','"+human_ID+"','"+human_name+"','','')";
						oa_db.executeUpdate(sql);
						String sql3="select * from hr_file where human_ID='"+human_ID+"'";
						ResultSet rs3=oa_db.executeQuery(sql3);
						if(rs3.next()){
							email_box[p]=rs3.getString("human_email");
							p++;
						if(send_type.indexOf("发短信")!=-1){
						note.send("bjnseer","8888",rs3.getString("human_cellphone"),content);
						}
						}
					}
				}else if(chain_id[j].substring(chain_id[j].length()-1).equals("/")){
					StringTokenizer token=new StringTokenizer(chain_id[j],"/");
					while(token.hasMoreTokens()){
						String human_ID=token.nextToken();
						String human_name=token.nextToken();
						String human_major_first_kind_name=token.nextToken();
						String sql="insert into oa_meeting_dealwith_details(meeting_ID,human_ID,human_name,human_major_first_kind_name,human_major_second_kind_name) values('"+meeting_ID+"','"+human_ID+"','"+human_name+"','"+human_major_first_kind_name+"','')";
						oa_db.executeUpdate(sql);
						String sql3="select * from hr_file where human_ID='"+human_ID+"'";
						ResultSet rs3=oa_db.executeQuery(sql3);
						if(rs3.next()){
							email_box[p]=rs3.getString("human_email");
							p++;
						if(send_type.indexOf("发短信")!=-1){
						note.send("bjnseer","8888",rs3.getString("human_cellphone"),content);
						}
						}
					}
				}else{
					StringTokenizer token=new StringTokenizer(chain_id[j],"/");
					while(token.hasMoreTokens()){
						String human_ID=token.nextToken();
						String human_name=token.nextToken();
						String human_major_first_kind_name=token.nextToken();
						String human_major_second_kind_name=token.nextToken();
						String sql="insert into oa_meeting_dealwith_details(meeting_ID,human_ID,human_name,human_major_first_kind_name,human_major_second_kind_name) values('"+meeting_ID+"','"+human_ID+"','"+human_name+"','"+human_major_first_kind_name+"','"+human_major_second_kind_name+"')";
						oa_db.executeUpdate(sql);
						String sql3="select * from hr_file where human_ID='"+human_ID+"'";
						ResultSet rs3=oa_db.executeQuery(sql3);
						if(rs3.next()){
							email_box[p]=rs3.getString("human_email");
							p++;
						if(send_type.indexOf("发短信")!=-1){
						note.send("bjnseer","8888",rs3.getString("human_cellphone"),content);
						}
						}
					}
				}
		}
	
	
}
if(send_type.indexOf("发邮件")!=-1){
	mail.send(email_box,"smtp.sina.com.cn","yhuser@sina.com","123456",subject,content);
}
if(n==0){
	
  	response.sendRedirect("oa/meeting/dealwith_ok_a.jsp");
	}else{

	String sql1="update oa_meeting set dealwith_checker='"+dealwith_checker+"',dealwith_checker_ID='"+dealwith_checker_ID+"',dealwith_time='"+dealwith_time+"',dealwith_type='"+dealwith_type+"',check_tag='3' where meeting_ID='"+meeting_ID+"'";
	oa_db.executeUpdate(sql1);
	
response.sendRedirect("oa/meeting/dealwith_ok_b.jsp");
	}
}else{
	
  	response.sendRedirect("oa/meeting/dealwith_ok_c.jsp");
}
}else{
	
  	response.sendRedirect("oa/meeting/dealwith_ok_e.jsp");
}
}else{
	
  	response.sendRedirect("oa/meeting/dealwith_ok_d.jsp");
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