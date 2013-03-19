/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.salary;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;

public class check_human_details_ok extends HttpServlet{
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
counter count= new  counter(dbApplication);
ValidataNumber validata= new  ValidataNumber();
ValidataRecord vr= new  ValidataRecord();

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
String salary_id=request.getParameter("salary_id");
String config_id=request.getParameter("config_id");
String sql6="select id from hr_workflow where object_ID='"+salary_id+"' and type_id='03' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=hr_db.executeQuery(sql6);
if(!rs6.next()){
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql="select salary_sum from hr_salary where salary_id='"+salary_id+"' and check_tag='0' and register_finish_tag='1'";
ResultSet rs=hr_db.executeQuery(sql);
if(rs.next()){
	Double salary_sum=rs.getDouble("salary_sum");
	String[] human_id=request.getParameterValues("human_ID");
	String[] bonus_sum=request.getParameterValues("bonus_sum");
	String[] sale_bonus_sum=request.getParameterValues("sale_bonus_sum");
	String[] deduct_sum=request.getParameterValues("deduct_sum");
	Double[] subtotal=new Double[human_id.length];
	if(human_id!=null&&human_id.length>0){
		for(int i=0;i<human_id.length;i++){
			bonus_sum[i]=bonus_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(bonus_sum[i])){
				bonus_sum[i]="0";
			}
			sale_bonus_sum[i]=sale_bonus_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(sale_bonus_sum[i])){
				sale_bonus_sum[i]="0";
			}
			deduct_sum[i]=deduct_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(deduct_sum[i])){
				deduct_sum[i]="0";
			}
			subtotal[i]=Double.parseDouble(bonus_sum[i])+Double.parseDouble(sale_bonus_sum[i])-Double.parseDouble(deduct_sum[i]);
			sql="select standard_salary_sum,salary_sum from hr_salary_human_details where salary_id='"+salary_id+"' and human_id='"+human_id[i]+"'";
			ResultSet rs1=hr_db.executeQuery(sql);
			if(rs1.next()){
				Double salary_sum_temp=rs1.getDouble("standard_salary_sum")+subtotal[i];
				salary_sum+=rs1.getDouble("salary_sum")-salary_sum_temp;
				sql="update hr_salary_human_details set bonus_sum='"+bonus_sum[i]+"',sale_bonus_sum='"+sale_bonus_sum[i]+"',deduct_sum='"+deduct_sum[i]+"',salary_sum='"+salary_sum_temp+"' where salary_id='"+salary_id+"' and human_id='"+human_id[i]+"'";
				hr_db.executeUpdate(sql);
			}
		}
		sql="update hr_salary set salary_sum='"+salary_sum+"' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
	}
	sql = "update hr_workflow set checker='"+checker+"',checker_id='"+checker_id+"',check_time='"+time+"',check_tag='1' where object_ID='"+salary_id+"' and config_id='"+config_id+"' and type_id='03'" ;
	hr_db.executeUpdate(sql);
	sql="select id from hr_workflow where object_ID='"+salary_id+"' and check_tag='0' and type_id='03'";
	ResultSet rset=hr_db.executeQuery(sql);
	if(!rset.next()){
		String fund_id=NseerId.getId("fund/apply_pay_expenses",(String)dbSession.getAttribute("unit_db_name"));
		if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",salary_id)){
			String sql2="insert into fund_fund(fund_ID,reason,reasonexact,funder,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register_time,register) values('"+fund_id+"','付款','"+salary_id+"','本单位','550201','管理费用-工资','"+salary_sum+"','人民币','元','"+time+"','"+checker+"')";
			hr_db.executeUpdate(sql2);
		}
		sql="update hr_file set salary_tag='0'";
		hr_db.executeUpdate(sql);
		sql="update hr_salary set check_tag='1' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
	}
	response.sendRedirect("hr/salary/check_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("hr/salary/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("hr/salary/check_ok.jsp?finished_tag=2");
}
  hr_db.commit();
  hr_db.close();
  hr_db1.commit();
  hr_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}