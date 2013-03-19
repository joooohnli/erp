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
public class calculate_ok extends HttpServlet{

private static final CharSequence Surplus1 = null;
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
	HttpSession dbSession=request.getSession();
	JspFactory _jspxFactory=JspFactory.getDefaultFactory();
	PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
	ServletContext dbApplication=dbSession.getServletContext();
	
	nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
	nseer_db_backup1 finance_db1 = new nseer_db_backup1(dbApplication);
	nseer_db_backup1 finance_db2 = new nseer_db_backup1(dbApplication);
	nseer_db_backup1 finance_db3 = new nseer_db_backup1(dbApplication);
	nseer_db_backup1 finance_db4 = new nseer_db_backup1(dbApplication);
	getNameFromID getNameFromID=new getNameFromID();
	PrintWriter out=response.getWriter();
try{
	if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db2.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db3.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db4.conn((String)dbSession.getAttribute("unit_db_name"))){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String time="";
		java.util.Date now = new java.util.Date();
		time=formatter.format(now);
		Long start_time = null;
		String start_time1 = "";
		String end_time = "";
		String calway_rate="";
		String calway="";
		int surplus=0;
		int surplus1=0;
		double net_value=0.0;
		double caled_sum=0.0;
		String surplus2="";
		String no_caled="";
		String sql="";
		ResultSet rs=null;
		String sql1="";
		ResultSet rs1=null;
		String sql2="";
		ResultSet rs2=null;
		String sql3="";
		ResultSet rs3=null;
		String sql4="";
		String fa_tag="";
		sql="select end_time,start_time,fa_tag from finance_account_period where account_finished_tag='0' order by account_period";
		rs=finance_db.executeQuery(sql);
		if(rs.next()){
			start_time = formatter.parse(rs.getString("start_time")).getTime();
			start_time1=rs.getString("start_time");
			end_time = rs.getString("end_time");
			fa_tag=rs.getString("fa_tag");
		}
			if(fa_tag.equals("0")){
		sql="select * from finance_fa_file";
		rs=finance_db.executeQuery(sql);
		while(rs.next()){
			if(rs.getString("caled_time").equals("1800-01-01")||formatter.parse(rs.getString("caled_time")).getTime()>start_time){
				sql1="select * from finance_config_calway where name='"+rs.getString("calway_id")+"'";
				
				rs1=finance_db1.executeQuery(sql1);
				if(rs1.next()){	
					surplus=Integer.parseInt(rs.getString("lifecycle"))-Integer.parseInt(rs.getString("caled_month"));
					if(surplus%12>0){
					 surplus1=(int)(Math.floor(surplus/12));
						}else{
					 surplus1=surplus/12;
						}
					surplus2=surplus1+"";
					int lifecycle=Integer.parseInt(rs.getString("lifecycle"))/12;
					String lifecycle1=lifecycle*(lifecycle+1)/2+"";
					calway_rate=rs1.getString("rate_formula").replace("原值", "original_value").replace("累计转回减值准备金额", "sum_re_presub").replace("累计减值准备金额", "sum_presub").replace("累计折旧", "caled_sum").replace("净残值率", "remnant_value_rate").replace("净残值", "remnant_value").replace("剩余使用年限",surplus2).replace("使用年限", "lifecycle").replace("已计提月份", "caled_month").replace("本月工作量", "work_month").replace("累计工作量", "work_sum").replace("工作总量", "work_total").replace("年数总和",lifecycle1).replace("期初账面余额",rs.getString("net_value"));
					sql2="select "+calway_rate+" from finance_fa_file where file_id='"+rs.getString("file_id")+"'";				
				rs2=finance_db2.executeQuery(sql2);
				if(rs2.next()){
					if(rs1.getString("formula").indexOf("工作")==-1){
					calway=rs1.getString("formula").replace("原值", "original_value").replace("累计减值准备金额", "sum_presub").replace("累计转回减值准备金额", "sum_re_presub").replace("累计折旧", "caled_sum").replace("净残值率", "remnant_value_rate").replace("净残值", "remnant_value").replace("使用年限", "lifecycle").replace("已计提月份", "caled_month").replace("本月工作量", "work_month").replace("累计工作量", "work_sum").replace("工作总量", "work_total").replace("月折旧率", rs2.getString(calway_rate)).replace("期初账面余额",rs.getString("net_value"));
					}else{
					calway=rs1.getString("formula").replace("原值", "original_value").replace("累计减值准备金额", "sum_presub").replace("累计转回减值准备金额", "sum_re_presub").replace("累计折旧", "caled_sum").replace("净残值率", "remnant_value_rate").replace("净残值", "remnant_value").replace("使用年限", "lifecycle").replace("已计提月份", "caled_month").replace("本月工作量", "work_month").replace("累计工作量", "work_sum").replace("工作总量", "work_total").replace("单位折旧", rs2.getString(calway_rate)).replace("期初账面余额",rs.getString("net_value"));
					}
					sql3="select "+calway+" from finance_fa_file where file_id='"+rs.getString("file_id")+"'";
					rs3=finance_db3.executeQuery(sql3);
					if(rs3.next()){
					
						caled_sum=Double.parseDouble(rs.getString("caled_sum"))+Double.parseDouble(rs3.getString(calway));
						String work_sum="0";
						String work_month="0";
					if(!rs.getString("work_sum").equals("")){
						work_sum=rs.getString("work_sum");
						
					}
					if(!rs.getString("work_month").equals("")){
						work_month=rs.getString("work_month");
					}
					double work_sum_month=Double.parseDouble(work_sum)+Double.parseDouble(work_month);
					System.out.print(work_sum_month+"dddddddddddddddddd");
					sql4="insert into finance_fa_caled(file_id,file_name,type_id,type_name,department_id,department_name,start_time,lifecycle,caled_time,original_value,caled_sum,work_total,work_sum,work_unit,work_month,cal_subtotal_month) values('"+rs.getString("file_id")+"','"+rs.getString("file_name")+"','"+rs.getString("type_id")+"','"+rs.getString("type_name")+"','"+rs.getString("department_id")+"','"+rs.getString("department_name")+"','"+rs.getString("start_time")+"','"+rs.getString("lifecycle")+"','"+time+"','"+rs.getString("original_value")+"','"+caled_sum+"','"+work_sum_month+"','"+Double.parseDouble(work_sum)+"','"+rs.getString("work_unit")+"','"+rs.getString("work_month")+"','"+rs3.getString(calway)+"')";
					finance_db4.executeUpdate(sql4);
					net_value=Double.parseDouble(rs.getString("net_value"))-Double.parseDouble(rs3.getString(calway));
					sql4="update finance_fa_file set caled_sum='"+caled_sum+"',work_sum='"+work_sum_month+"',work_month='0',caled_time='"+time+"',net_value='"+net_value+"',caled_time='"+time+"' where file_id='"+rs.getString("file_id")+"'";
					finance_db4.executeUpdate(sql4);
						}
					}
				}
			}else{
				no_caled+="⊙"+rs.getString("file_name");
			}
		}
		sql="select id from finance_fa_file where caled_time>='"+start_time1+"' and caled_time<='"+end_time+"'";
		rs=finance_db.executeQuery(sql);
		if(!rs.next()){
			sql="update finance_account_period set fa_tag='1' where start_time='"+start_time1+"' and end_time<='"+end_time+"'";
			finance_db4.executeUpdate(sql);
		}
		if(!no_caled.equals("")){
		out.println(no_caled.substring(1));
		}else{
			out.println("⊙");
		}

		}else{
			out.println("◎");	
		}

		finance_db.commit();
		finance_db1.commit();
		finance_db2.commit();
		finance_db3.commit();
		finance_db4.commit();
		finance_db.close();
		finance_db1.close();
		finance_db2.close();
		finance_db3.close();
		finance_db4.close();
	}
}catch (Exception ex){
		ex.printStackTrace();
	}
}
}