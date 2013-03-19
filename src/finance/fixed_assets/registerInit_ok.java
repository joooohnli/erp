/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.fixed_assets;
 
import include.get_name_from_ID.getNameFromID;
import include.nseer_db.nseer_db_backup1;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
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

public class registerInit_ok extends HttpServlet{

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
	
int err_count=0;
String type_name=request.getParameter("type_name");
String file_id=request.getParameter("file_id");
String file_name=request.getParameter("file_name");
String addway=request.getParameter("addway");
String department=request.getParameter("department");
String specification=request.getParameter("specification");
String deposit_place=request.getParameter("deposit_place");
String status=request.getParameter("status");
String calway=request.getParameter("calway");
String start_time=request.getParameter("start_time");
String lifecycle=request.getParameter("lifecycle");
String work_total=request.getParameter("work_total");
String work_sum=request.getParameter("work_sum");
String work_unit=request.getParameter("work_unit");
String currency=request.getParameter("currency");
String original_value=request.getParameter("original_value");
String remnant_value=request.getParameter("remnant_value");
String remnant_value_rate=request.getParameter("remnant_value_rate");
String unit_cal=request.getParameter("unit_cal");
String caled_month=request.getParameter("caled_month");
String caled_sum=request.getParameter("caled_sum");
String caled_subtotal_rate=request.getParameter("caled_subtotal_rate");
String caled_subtotal=request.getParameter("caled_subtotal");

String net_value=request.getParameter("net_value");
String cal_file_name=request.getParameter("cal_file_name");
String sql="";
ResultSet rs=null;
if(type_name.equals("")||file_id.equals("")||file_name.equals("")||addway.equals("")||department.equals("")||start_time.equals("")||original_value.equals("")){
		err_count=1;	
	}else{
	sql="select file_id from finance_fa_file where file_id='"+file_id+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		err_count=2;
	}else{
	sql="select file_id from finance_fa_file where file_name='"+file_name+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		err_count=3;
	}else{
		String time="";
		sql="select start_time from finance_account_period where account_finished_tag='0' order by account_period";
		rs=finance_db.executeQuery(sql);
		if(rs.next()){
			time=rs.getString("start_time");
		}
		java.util.Date date1 = formatter.parse(time);
		java.util.Date date2 = formatter.parse(start_time);
		
		if(date1.getTime()<=date2.getTime()){
			err_count=4;
		}else{
			if(!validata.validata(original_value)||!validata.validata(caled_month)||!validata.validata(caled_sum)||!validata.validata(net_value)||!validata.validata(remnant_value)){
				err_count=5;
			}else{
				if(!validata.validata(caled_subtotal_rate)&&!caled_subtotal_rate.equals("undefined")){
					err_count=6;
				}else{
					if(!validata.validata(unit_cal)&&!unit_cal.equals("undefined")){
						err_count=7;
					}
				}
			}
			
		}
	}
	}
	}
if(err_count==0){	
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"financefafilecount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"financefafilecount",filenum);
	  
	  String addway_id=addway.substring(0,addway.indexOf(" "));
	  String addway_name=addway.substring(addway.indexOf(" ")+1);
	  String type_id=type_name.substring(0,type_name.indexOf(" "));
	  		 type_name=type_name.substring(type_name.indexOf(" ")+1);
	  String department_id=department.substring(0,department.indexOf(" "));
	  String department_name=department.substring(department.indexOf(" ")+1);
	if(!caled_subtotal_rate.equals("")&&unit_cal.equals("undefined")){  
      sql = "insert into finance_fa_file(card_id,type_id,type_name,file_id,file_name,addway_id,addway_name,department_id,department_name,specification,deposit_place,status_id,calway_id,start_time,lifecycle,currency,original_value,remnant_value,remnant_value_rate,caled_month,caled_sum,cal_subtotal,cal_subtotal_rate,net_value,cal_file_name) values('"+filenum+"','"+type_id+"','"+type_name+"','"+file_id+"','"+file_name+"','"+addway_id+"','"+addway_name+"','"+department_id+"','"+department_name+"','"+specification+"','"+deposit_place+"','"+status+"','"+calway+"','"+start_time+"','"+lifecycle+"','"+currency+"','"+original_value+"','"+remnant_value+"','"+remnant_value_rate+"','"+caled_month+"','"+caled_sum+"','"+caled_subtotal+"','"+caled_subtotal_rate+"','"+net_value+"','"+cal_file_name+"')";
	}else{
      sql = "insert into finance_fa_file(card_id,type_id,type_name,file_id,file_name,addway_id,addway_name,department_id,department_name,specification,deposit_place,status_id,calway_id,start_time,lifecycle,work_total,work_sum,work_unit,currency,original_value,remnant_value,remnant_value_rate,caled_month,caled_sum,cal_subtotal,unit_cal,net_value,cal_file_name) values('"+filenum+"','"+type_id+"','"+type_name+"','"+file_id+"','"+file_name+"','"+addway_id+"','"+addway_name+"','"+department_id+"','"+department_name+"','"+specification+"','"+deposit_place+"','"+status+"','"+calway+"','"+start_time+"','"+lifecycle+"','"+work_total+"','"+work_sum+"','"+work_unit+"','"+currency+"','"+original_value+"','"+remnant_value+"','"+remnant_value_rate+"','"+caled_month+"','"+caled_sum+"','"+caled_subtotal+"','"+unit_cal+"','"+net_value+"','"+cal_file_name+"')";
	}
    	finance_db.executeUpdate(sql);
		
	String sql1="update finance_config_assets_kind set delete_tag='1' where file_id='"+type_id+"'";
	finance_db.executeUpdate(sql1);//delete_tag为1说明分类被使用	

	sql1="update finance_config_assets_fluctuationway set delete_tag='1' where file_id='"+addway_id+"'";
	finance_db.executeUpdate(sql1);//delete_tag为1说明分类被使用	

	sql1="update finance_config_file_kind set delete_tag='1' where file_id='"+cal_file_name.split(" ")[0]+"'";
	finance_db.executeUpdate(sql1);//delete_tag为1说明分类被使用	

	sql1="update hr_config_file_kind set delete_tag='1' where file_id='"+department_id+"'";
	finance_db.executeUpdate(sql1);//delete_tag为1说明分类被使用	

	out.println(err_count);
}else{
	out.println(err_count);
}
		finance_db.commit();
		finance_db.close();
}
}catch (Exception ex){
		ex.printStackTrace();
	}
}
}