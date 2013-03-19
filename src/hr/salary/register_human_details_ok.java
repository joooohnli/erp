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
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;


public class register_human_details_ok extends HttpServlet{
//创建方法
ServletContext application;

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

ValidataRecord vr= new  ValidataRecord();
ValidataNumber validata= new  ValidataNumber();
counter count = new counter(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register=(String)session.getAttribute("realeditorc");
String[] checkbox=request.getParameterValues("checkbox");
String[] human_ID_temp=request.getParameterValues("human_ID");
String[] bonus_sum_temp=request.getParameterValues("bonus_sum");
String[] sale_bonus_sum_temp=request.getParameterValues("sale_bonus_sum");
String[] deduct_sum_temp=request.getParameterValues("deduct_sum");
if(checkbox!=null&&checkbox.length>0){
	String[] human_ID=new String[checkbox.length];
	Double[] bonus_sum=new Double[checkbox.length];
	Double[] sale_bonus_sum=new Double[checkbox.length];
	Double[] deduct_sum=new Double[checkbox.length];
	Double[] subtotal=new Double[checkbox.length];
	for(int i=0;i<checkbox.length;i++){
		int j=Integer.parseInt(checkbox[i]);
		human_ID[i]=human_ID_temp[j];
		bonus_sum_temp[j]=bonus_sum_temp[j].replaceAll(",", "").replaceAll("，", "");
		if(!validata.validata(bonus_sum_temp[j])){
			bonus_sum_temp[j]="0";
		}
		bonus_sum[i]=Double.parseDouble(bonus_sum_temp[j]);
		sale_bonus_sum_temp[j]=sale_bonus_sum_temp[j].replaceAll(",", "").replaceAll("，", "");
		if(!validata.validata(sale_bonus_sum_temp[j])){
			sale_bonus_sum_temp[j]="0";
		}
		sale_bonus_sum[i]=Double.parseDouble(sale_bonus_sum_temp[j]);
		deduct_sum_temp[j]=deduct_sum_temp[j].replaceAll(",", "").replaceAll("，", "");
		if(!validata.validata(deduct_sum_temp[j])){
			deduct_sum_temp[j]="0";
		}
		deduct_sum[i]=Double.parseDouble(deduct_sum_temp[j]);
		subtotal[i]=bonus_sum[i]+sale_bonus_sum[i]-deduct_sum[i];
	}
	int pay_times=1;
	String sql="select * from hr_salary order by pay_times desc";
	ResultSet rs=hr_db.executeQuery(sql);
	if(rs.next()){
	pay_times=rs.getInt("pay_times")+1;
	}
	int register_tag=0;
	String salary_id="";
	sql="select salary_id from hr_salary where check_tag='0'";
	rs=hr_db.executeQuery(sql);
	if(rs.next()){
		salary_id=rs.getString("salary_id");
		register_tag=1;
	}else{//生成新的薪酬单
		salary_id=NseerId.getId("hr/salary",(String)dbSession.getAttribute("unit_db_name"));
		sql="insert into hr_salary(salary_id,pay_times) values ('"+salary_id+"','"+pay_times+"')";
		hr_db.executeUpdate(sql);
	}
	Double salary_sum_subtotal=0.0;
	Double salary_standard_sum_subtotal=0.0;
	for(int i=0;i<human_ID.length;i++){
		sql="select human_name,salary_standard_id,salary_sum from hr_file where human_id='"+human_ID[i]+"'";
		rs=hr_db.executeQuery(sql);
		if(rs.next()){
			String human_name=rs.getString("human_name");
			String salary_standard_id=rs.getString("salary_standard_id");
			Double salary_sum=subtotal[i]+rs.getDouble("salary_sum");
			salary_sum_subtotal+=salary_sum;
			salary_standard_sum_subtotal+=rs.getDouble("salary_sum");
			sql="insert into hr_salary_human_details (salary_id,human_id,human_name,salary_standard_id,standard_salary_sum,bonus_sum,deduct_sum,sale_bonus_sum,salary_sum) values ('"+salary_id+"','"+human_ID[i]+"','"+human_name+"','"+salary_standard_id+"','"+rs.getString("salary_sum")+"','"+bonus_sum[i]+"','"+deduct_sum[i]+"','"+sale_bonus_sum[i]+"','"+salary_sum+"')";
			hr_db.executeUpdate(sql);
			sql="select * from hr_salary_standard_details where standard_id='"+salary_standard_id+"'";
			rs=hr_db.executeQuery(sql);
			while(rs.next()){
				String sql1="insert into hr_salary_human_details_details (salary_id,human_id,human_name,item_id,item_name,salary) values ('"+salary_id+"','"+human_ID[i]+"','"+human_name+"','"+rs.getString("item_id")+"','"+rs.getString("item_name")+"','"+rs.getString("salary")+"')";
				hr_db1.executeUpdate(sql1);
			}
		}
		sql="update hr_file set salary_tag='1' where human_id='"+human_ID[i]+"'";
		hr_db.executeUpdate(sql);
	}
	sql="select * from hr_salary where salary_id='"+salary_id+"'";
	rs=hr_db.executeQuery(sql);
	if(rs.next()){
		salary_sum_subtotal+=rs.getDouble("salary_sum");
		salary_standard_sum_subtotal+=rs.getDouble("salary_standard_sum");
		int human_amount=rs.getInt("human_amount")+human_ID.length;
		sql="update hr_salary set human_amount='"+human_amount+"',salary_sum='"+salary_sum_subtotal+"',salary_standard_sum='"+salary_standard_sum_subtotal+"',register_time='"+time+"' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
	}
	sql="select id from hr_file where check_tag='1' and gar_tag='0' and salary_standard_id!='未定义' and salary_tag='0' and human_name!='admin'";
	rs=hr_db.executeQuery(sql);
	if(!rs.next()){
		sql="update hr_salary set register_finish_tag='1' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
	}
	
	List rsList = GetWorkflow.getList(hr_db, "hr_config_workflow", "03");//获得客户化设置中所设置的审核流程
	if(rsList.size()==0){
		String fund_id=NseerId.getId("fund/apply_pay_expenses",(String)dbSession.getAttribute("unit_db_name"));
		if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",salary_id)){
			String sql2="insert into fund_fund(fund_ID,reason,reasonexact,funder,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register_time,register) values('"+fund_id+"','付款','"+salary_id+"','本单位','550201','管理费用-工资','"+salary_sum_subtotal+"','人民币','元','"+time+"','"+register+"')";
			hr_db.executeUpdate(sql2);
		}
		sql="update hr_file set salary_tag='0'";
		hr_db.executeUpdate(sql);
		sql="update hr_salary set check_tag='1' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
	}else{
		if(register_tag==0){
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		String sql0 = "insert into hr_workflow(config_id,object_ID,type_id,describe1,describe2) values ('"+elem[0]+"','"+salary_id+"','03','"+elem[1]+"','"+elem[2]+"')" ;
		hr_db.executeUpdate(sql0);
		}
		}
	}	
	
	response.sendRedirect("hr/salary/register_ok.jsp?finished_tag=0");
}else{//一个人没选
	response.sendRedirect("hr/salary/register_ok.jsp?finished_tag=1");
}
 hr_db.commit();
  hr_db1.commit();
  hr_db.close();
hr_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("hr/salary/register_ok.jsp?finished_tag=2");
}
}
}


