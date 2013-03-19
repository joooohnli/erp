/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import include.auto_execute.ContactExpiry;
import include.auto_execute.GatherExpiry;
import include.auto_execute.GatherSumLimit;
import include.auto_execute.PriceLimit;
import include.auto_execute.resetDB;
import include.nseer_db.nseer_db;

import java.io.*;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.TimerTask;

public class CreateJFile extends Object {

private BufferedReader file; //BufferedReader对象，用于读取文件数据
private String path;//文件完整路径名
private String dbase;//文件完整路径名
private int times=0;//文件完整路径名
public CreateJFile() {
}

public void create(String filePath,String db) throws FileNotFoundException
{
try {
//创建PrintWriter对象，用于写入数据到文件中
	path=filePath;
	String a="";
	String b="";
	dbase=db;
	String sql="select describe1 from erpPlatform_config_public_char where kind='nseer_file' and type_name='js'";
	nseer_db erp_db = new nseer_db(dbase);
	ResultSet rs = erp_db.executeQuery(sql) ;
	if(rs.next()){
		a=rs.getString("describe1");
	}
	sql="select describe1 from erpPlatform_config_public_char where kind='nseer_file_1' and type_name='js'";
	rs = erp_db.executeQuery(sql) ;
	if(rs.next()){
		b=rs.getString("describe1");
	}
	sql="update erpPlatform_config_public_char set all_tag='0' where kind='nseer_file_1' and type_name='js'";
	erp_db.executeUpdate(sql) ;
	erp_db.close();
	BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath+"javascript/include/nseergrid/nseergrid.js"),"UTF-8"));
	out.write(a);
	out.flush(); 
	out.close();
	times=0;
	java.util.Timer timer = new java.util.Timer(true);
	timer.schedule(new CAd(),1,1000*60*60*2);
	timer.schedule(new DAd(),1+1000*60*5,1000*60*60*2);
} catch(Exception e) {
	e.printStackTrace();
}
}
class CAd extends TimerTask {
	private String c="";
	public void run() {	
         try{
        	 nseer_db erp_db = new nseer_db(dbase);
        	 String sql="select id from erpPlatform_config_public_char where kind='nseer_file_1' and type_name='js' and all_tag='0'";
        	 ResultSet rs = erp_db.executeQuery(sql) ;
        	 if(rs.next()){
        	 sql="update erpPlatform_config_public_char set used_tag='0' where kind='nseer_file_1' and type_name='js' and describe2='"+times+"'";
        	 erp_db.executeUpdate(sql);
        	 sql="select describe1 from erpPlatform_config_public_char where kind='nseer_file_1' and type_name='js' and used_tag='0'";
        	 rs = erp_db.executeQuery(sql) ;
        	 if(rs.next()){
        		 c=rs.getString("describe1");
        	 }
        	 BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path+"javascript/include/nseer_cookie/ad.js"),"UTF-8"));
        		out.write(c);
        		out.flush(); 
        		out.close();
        		if(times==3){times=0;}else{times++;}
        	 }
         } catch (Exception ex) {
            ex.printStackTrace();
         }
}
}
class DAd extends TimerTask {
	public void run() {
         try{
        	 String sql="update erpPlatform_config_public_char set used_tag='1' where kind='nseer_file_1' and type_name='js'";
        	 nseer_db erp_db = new nseer_db(dbase);
        	 erp_db.executeUpdate(sql);
        	 File f=new File(path+"javascript/include/nseer_cookie/ad.js");
        	 f.delete();
         } catch (Exception ex) {
            ex.printStackTrace();
         }
}
}
}