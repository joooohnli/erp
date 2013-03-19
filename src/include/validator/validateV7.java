/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.validator;

import include.nseer_cookie.count;
import include.nseer_cookie.counter;
import include.nseer_db.nseer_db;
import include.tree_index.businessComment;
import java.sql.ResultSet;
import java.util.StringTokenizer;
import javax.servlet.ServletContext;
import javax.servlet.http.*;
import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;
import validata.ValidataNumber;

public class validateV7 {
	WebContext ctx = WebContextFactory.get();
	HttpSession dbSession = ctx.getSession();
	HttpServletRequest request=ctx.getHttpServletRequest();
	ServletContext dbApplication = dbSession.getServletContext();
	businessComment demo=new businessComment();
	String unit_db_name = (String) dbSession.getAttribute("unit_db_name");
	
	public String validateDuplicateCode(String table_name,String col_name1,String col_name2,String value_var1, String page_var) {//验证输入的字符串是否重复
		String msg = "";
		demo.setPath(request);
		nseer_db Interface_db = new nseer_db(unit_db_name);
		try {
			String interface_sql = "select "+col_name1+" from "+table_name+" where "+col_name2+"='"+ page_var + "' and "+col_name1+"='"+value_var1+"'";
			ResultSet rs = Interface_db.executeQuery(interface_sql);
			if (rs.next()) {
				msg =  demo.getLang("erp","已存在！");
			} else {
				msg = "OK";
			}
			Interface_db.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return msg;
	}

	public String validateNumber(int value_var1_length,String value_var1) {//验证编号是否为两位数字
		String msg = "";
		demo.setPath(request);
		try {
			ValidataNumber va = new ValidataNumber();
			if (va.validata(value_var1, value_var1_length)) {
				msg = "OK";
			} else {
				msg = "有误，必须是"+value_var1_length+"位数字。";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return msg;
	}
	public String validateNull(String value_var1,String alertSentence_var) {//验证编号是否为空值
		String msg = "";
		demo.setPath(request);
		try {
			String temp=value_var1.trim();
			if (!temp.equals("")&&temp!=null) {
				msg = "OK";
			} else {
				msg = alertSentence_var+" "+demo.getLang("erp","不允许为空值。");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return msg;
	}
	public String validateDescribe(String temp_table1,String describe) {//验证编号责任人编号是否合法
		String msg = "";
		nseer_db Interface_db = new nseer_db(unit_db_name);
		String register_ID = (String) dbSession.getAttribute("human_IDD");
		demo.setPath(request);
		try {
			String responsible_person="";
			int n=0;
			int m=0;
				StringTokenizer tokenTO6= new StringTokenizer(describe,", ");        
				while(tokenTO6.hasMoreTokens()) {
					String sql1="insert into "+temp_table1+"(human_ID,register_ID) values('"+tokenTO6.nextToken()+"','"+register_ID+"') ";
					Interface_db.executeUpdate(sql1);
					m++;
				}
				String sql2="select distinct human_ID from "+temp_table1+" where register_ID='"+register_ID+"'";
			ResultSet rs2=Interface_db.executeQuery(sql2);
			rs2.last();
			if(rs2.getRow()!=m){n++;}
			String sql3="delete from "+temp_table1+" where register_ID='"+register_ID+"'";
					Interface_db.executeUpdate(sql3);
			
			StringTokenizer tokenTO8 = new StringTokenizer(describe,", ");        
				while(tokenTO8.hasMoreTokens()) {
					String sql8="select * from hr_file where human_ID='"+tokenTO8.nextToken()+"'";
					ResultSet rs8=Interface_db.executeQuery(sql8);
					if(rs8.next()){
						responsible_person+=rs8.getString("human_name")+", ";
					}else{
					n++;
					}
				}
			if(n!=0){
			msg=demo.getLang("erp","有误，责任人必须是本系统用户，销售责任人不包括客户经理，请返回确认！");
			}else{
			msg="OK";
			}			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return msg;
	}
	public String validateDupChange(String table_name,String col_name1,String col_name2,String col_name3,String value_var1,String value_var2,String page_var) {//验证输入的字符串是否重复
		String msg = "";
		demo.setPath(request);
		nseer_db Interface_db = new nseer_db(unit_db_name);
		try {
			String interface_sql = "select "+col_name1+" from "+table_name+" where "+col_name2+"='"+ page_var + "' and "+col_name1+"='"+value_var1+"' and "+col_name3+"!='"+value_var2+"'";
			ResultSet rs = Interface_db.executeQuery(interface_sql);
			if (rs.next()) {
				msg =  demo.getLang("erp","已存在！");
			} else {
				msg = "OK";
			}
			Interface_db.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return msg;
	}
}
