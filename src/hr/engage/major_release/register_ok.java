/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.major_release;

import include.nseer_cookie.Divide1;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class register_ok extends HttpServlet{
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
counter count=new counter(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String fileKind_chain=request.getParameter("kind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String major_first_kind=request.getParameter("select4");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
String major_second_kind=request.getParameter("select5");
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String engage_type=request.getParameter("engage_type") ;
String human_amount=request.getParameter("human_amount") ;
String deadline=request.getParameter("deadline") ;
String bodyc = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodyc);
String bodyb = new String(request.getParameter("remark2").getBytes("UTF-8"),"UTF-8");
String remark2=exchange.toHtml(bodyb);
try{
	int filenum1=count.read((String)dbSession.getAttribute("unit_db_name"),"hrReleaseID");
	count.write((String)dbSession.getAttribute("unit_db_name"),"hrReleaseID",filenum1);
	String sql = "insert into hr_major_release(chain_id,chain_name,release_id,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,register,register_time,human_amount,deadline,remark1,remark2,engage_type,check_tag) values ('"+chain_id+"','"+chain_name+"','"+filenum1+"','"+major_first_kind_ID+"','"+major_first_kind_name+"','"+major_second_kind_ID+"','"+major_second_kind_name+"','"+register+"','"+register_time+"','"+human_amount+"','"+deadline+"','"+remark1+"','"+remark2+"','"+engage_type+"','0')" ;

	hr_db.executeUpdate(sql) ;

List rsList1 = GetWorkflow.getList(hr_db, "ecommerce_config_workflow", "06");
	String[] elem1=new String[3];
	if(rsList1.size()==0){
		String sql1="update hr_major_release set check_tag='1' where chain_id='"+chain_id+"' and chain_name='"+chain_name+"'";
		hr_db.executeUpdate(sql1) ;
	}else{
	Iterator ite1=rsList1.iterator();
		while(ite1.hasNext()){
		elem1=(String[])ite1.next();
		sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem1[0]+"','"+filenum1+"','"+elem1[1]+"','"+elem1[2]+"','06')" ;
		hr_db.executeUpdate(sql) ;
		}
}
	hr_db.commit();
	hr_db1.commit();
	hr_db.close();	
	hr_db1.close();
response.sendRedirect("hr/engage/major_release/register_ok_a.jsp");
}
catch (Exception ex){
out.println("error"+ex);
}
			
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}