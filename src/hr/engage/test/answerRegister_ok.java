/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.test;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;   
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class answerRegister_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();


nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

counter counta= new  counter(dbApplication);

String answer_id="";
String human_name=request.getParameter("human_name");
String idcard=request.getParameter("idcard");
String test_ID=request.getParameter("test_ID");
String questiones_amount=request.getParameter("questiones_amount");
String max_total_points=request.getParameter("max_total_points");
String usedtime=request.getParameter("usedtime");
String test_time=request.getParameter("test_time");
int testing_ID=counta.read((String)dbSession.getAttribute("unit_db_name"),"hrTestingcount");
counta.write((String)dbSession.getAttribute("unit_db_name"),"hrTestingcount",testing_ID);
	String sql9 = "insert into hr_tester(testing_ID,human_name,idcard,test_time,examtime,test_ID,max_total_points) values ('"+testing_ID+"','"+human_name+"','"+idcard+"','"+test_time+"','"+usedtime+"','"+test_ID+"','"+max_total_points+"')" ;
	hr_db.executeUpdate(sql9) ;

String sql="select * from hr_test_details where test_ID='"+test_ID+"' order by id";
ResultSet rs=hr_db1.executeQuery(sql);
while(rs.next()){
	answer_id="";
String temkind="first_kind"+rs.getString("id");
String temcount="count"+rs.getString("id");
String kind=request.getParameter(temkind);
String count=request.getParameter(temcount);

int amount=Integer.parseInt(count);
for(int i=1;i<=amount;i++){
	String temanswer=rs.getString("id")+i;
	String[] answer1=request.getParameterValues(temanswer);
	String answer="";
	if(answer1!=null){
	for(int k=0;k<answer1.length;k++){
		answer+=answer1[k];
	}
	}else{
		answer="f";
	}

	answer_id=answer_id+answer+",";
}
	String sql2 = "insert into hr_tester_answer_details(testing_ID,human_name,idcard,test_ID,question_first_kind,answer_id_group) values ('"+testing_ID+"','"+human_name+"','"+idcard+"','"+test_ID+"','"+kind+"','"+answer_id+"')" ;
	hr_db.executeUpdate(sql2) ;
}
    hr_db.commit();
	hr_db1.commit();
	hr_db.close();
	hr_db1.close();

response.sendRedirect("hr/engage/test/answerRegister_ok_a.jsp?usedtime="+toUtf8String.utf8String(exchange.toURL(usedtime))+"");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
