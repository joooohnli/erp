/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.fixed_assets.change;
 
import include.get_name_from_ID.getNameFromID;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;

public class surplusValue_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
getNameFromID getNameFromID=new getNameFromID();
PrintWriter out=response.getWriter();
try{
if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	counter count=new counter(dbApplication);
	ValidataNumber validata=new ValidataNumber();
	
String file_id=request.getParameter("file_id");
String file_name=request.getParameter("file_name");
String start_time=request.getParameter("start_time");
String specification=request.getParameter("specification");
String original_value=request.getParameter("original_value");
String net_value=request.getParameter("net_value");
String cb_remnant_value_rate=request.getParameter("cb_remnant_value_rate");
String ca_remnant_value_rate=request.getParameter("ca_remnant_value_rate");
String cb_remnant_value=request.getParameter("cb_remnant_value");
String ca_remnant_value=request.getParameter("ca_remnant_value");
String change_reason=request.getParameter("change_reason");
String change_time=request.getParameter("change_date");
String changer=request.getParameter("changer");
String sql="";
ResultSet rs=null;
	String changebill_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
    sql = "insert into finance_fa_change(changebill_id,file_id,file_name,start_time,specification,cb_original_value,cb_net_value,cb_remnant_value_rate,ca_remnant_value_rate,cb_remnant_value,ca_remnant_value,change_reason,change_time,changer,change_kind) values('"+changebill_id+"','"+file_id+"','"+file_name+"','"+start_time+"','"+specification+"','"+original_value+"','"+net_value+"','"+cb_remnant_value_rate+"','"+ca_remnant_value_rate+"','"+cb_remnant_value+"','"+ca_remnant_value+"','"+change_reason+"','"+change_time+"','"+changer+"','净残值调整')";
    	finance_db.executeUpdate(sql); 
    	
    sql="select * from finance_fa_file where file_id='"+file_id+"'";
    	rs=finance_db.executeQuery(sql);
    if(rs.next()){
    	sql="insert into finance_fa_file_dig(card_id,type_id,type_name,file_id,file_name,addway_id,addway_name,department_id,department_name,specification,deposit_place,status_id,calway_id,start_time,lifecycle,currency,original_value,remnant_value,remnant_value_rate,caled_month,caled_sum,cal_subtotal,cal_subtotal_rate,net_value,cal_file_name,work_total,work_sum,work_unit,unit_cal,project,sum_presub,sum_re_presub,caled_time,change_time,exchange_rate,reduceway_id,reduceway_name,reduce_time,clear_income,clear_expense,clear_reason,lately_change_time) values('"+rs.getString("card_id")+"','"+rs.getString("type_id")+"','"+rs.getString("type_name")+"','"+rs.getString("file_id")+"','"+rs.getString("file_name")+"','"+rs.getString("addway_id")+"','"+rs.getString("addway_name")+"','"+rs.getString("department_id")+"','"+rs.getString("department_name")+"','"+rs.getString("specification")+"','"+rs.getString("deposit_place")+"','"+rs.getString("status_id")+"','"+rs.getString("calway_id")+"','"+rs.getString("start_time")+"','"+rs.getString("lifecycle")+"','"+rs.getString("currency")+"','"+rs.getString("original_value")+"','"+rs.getString("remnant_value")+"','"+rs.getString("remnant_value_rate")+"','"+rs.getString("caled_month")+"','"+rs.getString("caled_sum")+"','"+rs.getString("cal_subtotal")+"','"+rs.getString("cal_subtotal_rate")+"','"+rs.getString("net_value")+"','"+rs.getString("cal_file_name")+"','"+rs.getString("work_total")+"','"+rs.getString("work_sum")+"','"+rs.getString("work_unit")+"','"+rs.getString("unit_cal")+"','"+rs.getString("project")+"','"+rs.getString("sum_presub")+"','"+rs.getString("sum_re_presub")+"','"+rs.getString("caled_time")+"','"+rs.getString("change_time")+"','"+rs.getString("exchange_rate")+"','"+rs.getString("reduceway_id")+"','"+rs.getString("reduceway_name")+"','"+rs.getString("reduce_time")+"','"+rs.getString("clear_income")+"','"+rs.getString("clear_expense")+"','"+rs.getString("clear_reason")+"','"+change_time+"')";
    	finance_db.executeUpdate(sql); 	
    	  	
      sql="update finance_fa_file set remnant_value='"+ca_remnant_value+"',remnant_value_rate='"+ca_remnant_value_rate+"',change_time='"+change_time+"' where file_id='"+file_id+"'";	
      finance_db.executeUpdate(sql);
    }
		finance_db.commit();
		finance_db.close();
		out.println("提交成功");
}
}catch (Exception ex){
		ex.printStackTrace();
	}
}
}