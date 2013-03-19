/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.auto_execute;

import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.getTime;
import java.text.*;
import javax.servlet.*;

public class resetDB extends Path{

    private nseer_db_backup nseer_db;
	private nseer_db_backup nseer_db1;
    private ResultSet rs=null;
    private String[] idgroup=new String[100000];

    public void resetDB(ServletContext dbApplication) {
		String classpath=getPath().substring(1,getPath().indexOf("WEB-INF"))+"WEB-INF/src/";
		String otherpath=getPath().substring(1,getPath().indexOf("WEB-INF"))+"WEB-INF/classes/conf/";
		String jsppath=getPath().substring(1,getPath().indexOf("WEB-INF"));
		String time=new getTime().getTime("yyyy-MM-dd HH:mm:ss");
		java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			nseer_db db=new nseer_db("mysql");
		String sqldb="show databases";
		ResultSet rsdb=db.executeQuery(sqldb);
		while(rsdb.next()){
			if(rsdb.getString("database").equals("ondemand1")){
			nseer_db=new nseer_db_backup(dbApplication);
			nseer_db1=new nseer_db_backup(dbApplication);
			if(nseer_db.conn(rsdb.getString("database"))&&nseer_db1.conn(rsdb.getString("database"))){
			String sqll="delete from document_config_public_char where kind='业务程序目录'";
			nseer_db.executeUpdate(sqll);
			sqll="delete from document_config_public_char where kind='辅助程序目录'";
			nseer_db.executeUpdate(sqll);
			sqll="delete from document_config_public_char where kind='工作主目录'";
			nseer_db.executeUpdate(sqll);
			sqll="delete from document_config_public_char where kind='数据源'";
			nseer_db.executeUpdate(sqll);
			sqll="delete from document_config_public_char where kind='组件程序目录'";
			nseer_db.executeUpdate(sqll);
			sqll="insert into document_config_public_char(kind,type_name,describe1,describe2) values('业务程序目录','"+jsppath+"','jsp','')";
			nseer_db.executeUpdate(sqll);
			sqll="insert into document_config_public_char(kind,type_name,describe1,describe2) values('业务程序目录','"+classpath+"','java','')";
			nseer_db.executeUpdate(sqll);
			sqll="insert into document_config_public_char(kind,type_name,describe1,describe2) values('辅助程序目录','"+otherpath+"','xml','')";
			nseer_db.executeUpdate(sqll);
			sqll="insert into document_config_public_char(kind,type_name,describe1,describe2) values('工作主目录','"+getPath().substring(1,getPath().indexOf("WEB-INF"))+"','jsp','')";
			nseer_db.executeUpdate(sqll);
			sqll="insert into document_config_public_char(kind,type_name,describe1,describe2) values('数据源','//localhost:3306/ondemand1','sql','"+getPath().substring(1,getPath().indexOf("WEB-INF"))+"')";
			nseer_db.executeUpdate(sqll);
			sqll="insert into document_config_public_char(kind,type_name,describe1,describe2) values('组件程序目录','"+classpath+"','java','')";
			nseer_db.executeUpdate(sqll);
			String sqlll="select * from document_otherprogram";
			ResultSet rslll=nseer_db1.executeQuery(sqlll);
			while(rslll.next()){
				String xmlpath=otherpath+rslll.getString("directory").substring(rslll.getString("directory").indexOf("/conf/")+6);
				sqlll="update document_otherprogram set directory='"+xmlpath+"' where id='"+rslll.getString("id")+"'";
				nseer_db.executeUpdate(sqlll);
				sqlll="update document_otherprogram_temp set directory='"+xmlpath+"' where id='"+rslll.getString("id")+"'";
				nseer_db.executeUpdate(sqlll);
			}
			
 		String sql = "select * from security_alive_access where time2='1800-01-01 00:00:00.0'";
 		rs=nseer_db.executeQuery(sql);
 		int i=0;
 		while(rs.next()){
		idgroup[i]=rs.getString("id");
 		i++;
 		}
 	for(int j=0;j<i;j++){
 	String sql2 = "update security_alive_access set time2='"+time+"',tag='3' where id="+idgroup[j]+"";
 	nseer_db.executeUpdate(sql2);
	}

	String sql3 = "update security_users set tag='0'";
String sql4="update document_multilanguage set tag='0'";
 	nseer_db.executeUpdate(sql4);

 	nseer_db.executeUpdate(sql3);
	sql3="update document_help set help_tag='0' where help_tag='2'";
	nseer_db.executeUpdate(sql3);
	sql3="update document_help set help_tag='1' where help_tag='3'";
	nseer_db.executeUpdate(sql3);
	 	nseer_db.close();
		nseer_db1.close();
		} else {
				System.out.println("i am sorry!");
 		}
			}
		}
		String sqlm="select * from unit_info where active_tag='0' order by id";
		ResultSet rsm=db.executeQuery(sqlm);
		while(rsm.next()){
			java.util.Date date1 = formatter.parse(rsm.getString("register_time"));
			long Time=(date1.getTime()/1000)+60*60*24*rsm.getInt("expiry_period");
			date1.setTime(Time*1000);
			if((date1.getTime()-now.getTime())<0){
				String sqlm1="update unit_info set active_tag='3' where id='"+rsm.getString("id")+"'";
				db.executeUpdate(sqlm1);
				nseer_db_backup dbm=new nseer_db_backup(dbApplication);
				if(dbm.conn(rsm.getString("unit_db_name"))){
				String username=rsm.getString("unit_id")+"_admin";
				sqlm1="update security_users set name='admin',human_name='nseer_admin' where human_ID='09020000000000100000'";
				dbm.executeUpdate(sqlm1);
				sqlm1="update hr_file set human_name='admin' where human_ID='09020000000000100000'";
				db.executeUpdate(sqlm1);
				sqlm1="update security_license set human_name='admin' where human_ID='09020000000000100000'";
				db.executeUpdate(sqlm1);
				dbm.close();
				} else {
				System.out.println("i am sorry!");
 		}
			}
		}
		db.close();
	 		} catch (Exception ex) {
				ex.printStackTrace();
 		}
	}

}