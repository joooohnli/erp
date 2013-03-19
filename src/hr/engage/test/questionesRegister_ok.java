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
import java.util.*;
import java.io.*;
import java.text.*;
import include.nseer_db.*;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import validata.ValidataNumber;


public class questionesRegister_ok extends HttpServlet{
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
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);
	

counter count= new  counter(dbApplication);

ValidataNumber  validata= new  ValidataNumber();

int amount_sum=0;
String human_major_first_kind_ID="";
String human_major_first_kind_name="";
String human_major_second_kind_ID="";
String human_major_second_kind_name="";
String human_major_first_kind=request.getParameter("select4");
if(human_major_first_kind!=null&&!human_major_first_kind.equals("")){
StringTokenizer tokenTO4 = new StringTokenizer(human_major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        human_major_first_kind_ID = tokenTO4.nextToken();
		human_major_first_kind_name = tokenTO4.nextToken();
		}
}
String human_major_second_kind=request.getParameter("select5");
if(human_major_second_kind!=null&&!human_major_second_kind.equals("")){
StringTokenizer tokenTO5 = new StringTokenizer(human_major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        human_major_second_kind_ID = tokenTO5.nextToken();
		human_major_second_kind_name = tokenTO5.nextToken();
		}
}
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String test_limited_time=request.getParameter("test_limited_time") ;
String kind_amount=request.getParameter("kind_amount") ;
int amount1=Integer.parseInt(kind_amount);
int p=0;
int pp=0;
for(int i=1;i<=amount1;i++){
	String temkind="kind"+i;
	String temgroup_amount="group_amount"+i;
	String first_kind=request.getParameter(temkind) ;
	String group_amount=request.getParameter(temgroup_amount) ;
	int amount2=Integer.parseInt(group_amount);
	String id_group="";
	for(int j=1;j<=amount2;j++){
		String temamount="amount"+i+j;
		String amount=request.getParameter(temamount) ;
		int amount3=0;
		if(amount!=null&&!amount.equals("")){
			if(!validata.validata(amount)){
			p++;
			}else{
			pp+=Double.parseDouble(amount);
			}
		}
		if(!test_limited_time.equals("")){
			if(!validata.validata(test_limited_time)||Double.parseDouble(test_limited_time)==0){
			p++;
			}
		}
	}
}
if(p==0&&!test_limited_time.equals("")&&pp!=0){
int n=0;
for(int i=1;i<=amount1;i++){
	String temkind="kind"+i;
	String temgroup_amount="group_amount"+i;
	String first_kind=request.getParameter(temkind) ;
	String group_amount=request.getParameter(temgroup_amount) ;
	int amount2=Integer.parseInt(group_amount);
	String id_group="";
	for(int j=1;j<=amount2;j++){
		String temgroup="group"+i+j;
		String temamount="amount"+i+j;
		String temamounta="amounta"+i+j;
		String group=request.getParameter(temgroup) ;
		String amount=request.getParameter(temamount) ;
		String amounta=request.getParameter(temamounta) ;
		int amount3=0;
		if(amount.equals("")||amount==null){
			amount3=0;
		}else{
			amount3=Integer.parseInt(amount);
		}
		if(amount3>Integer.parseInt(amounta)){
			n++;
		}
	}
}
if(n==0){
	

String test_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

for(int i=1;i<=amount1;i++){
	String temkind="kind"+i;
	String temgroup_amount="group_amount"+i;
	String first_kind=request.getParameter(temkind) ;
	String group_amount=request.getParameter(temgroup_amount) ;
	int amount2=Integer.parseInt(group_amount);
	String id_group="";
	for(int j=1;j<=amount2;j++){
		String temgroup="group"+i+j;
		String temamount="amount"+i+j;
		String group=request.getParameter(temgroup) ;
		String amount=request.getParameter(temamount) ;
		int amount3=0;
		if(amount.equals("")||amount==null){
			amount3=0;
		}else{
			amount3=Integer.parseInt(amount);
		}
		amount_sum+=amount3;
		String sql="select * from hr_questiones where first_kind_name='"+first_kind+"' and second_kind_name='"+group+"' order by rand() limit "+amount3+"";
		ResultSet rs=hr_db.executeQuery(sql);
		while(rs.next()){
			id_group=id_group+rs.getString("id")+",";
		}
	}
	if(!id_group.equals("")){
	String sql1 = "insert into hr_test_details(test_ID,question_first_kind,question_id_group) values ('"+test_ID+"','"+first_kind+"','"+id_group+"')" ;
	hr_db.executeUpdate(sql1) ;
	}
}
int totalsum=amount_sum*2;



	String sql2 = "insert into hr_test(test_ID,register,register_time,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,questiones_amount,max_total_points,test_limited_time) values ('"+test_ID+"','"+register+"','"+register_time+"','"+human_major_first_kind_ID+"','"+human_major_first_kind_name+"','"+human_major_second_kind_ID+"','"+human_major_second_kind_name+"','"+amount_sum+"','"+totalsum+"','"+test_limited_time+"')" ;
	hr_db.executeUpdate(sql2) ;
	String sql3="select * from hr_config_major_second_kind where first_kind_ID='"+human_major_first_kind_ID+"' and second_kind_ID='"+human_major_second_kind_ID+"'";
	ResultSet rs3=hr_db.executeQuery(sql3) ;
	if(rs3.next()){
		int test_amount=rs3.getInt("test_amount")+1;
	String sql4 = "update hr_config_major_second_kind set test_amount='"+test_amount+"' where first_kind_ID='"+human_major_first_kind_ID+"' and second_kind_ID='"+human_major_second_kind_ID+"'" ;
	hr_db.executeUpdate(sql4) ;
	}


response.sendRedirect("hr/engage/test/questionesRegister_ok_a.jsp");


}else{

response.sendRedirect("hr/engage/test/questionesRegister_ok_b.jsp");
}}else{


response.sendRedirect("hr/engage/test/questionesRegister_ok_c.jsp");

}
 hr_db.commit();
 hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}