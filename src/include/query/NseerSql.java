/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
/*
 * 该类用于获得sql语句字符串
 * 
 */
package include.query;

import java.sql.*;
import java.util.*;
import filetree.*;
import include.nseer_db.nseer_db;
import include.get_sql.getKeyColumn;
public class NseerSql{
	/*
	 * 该方法用于获得关键字查询的sql语句字符串
	 * 参数:
	 * keyword_value--录入的关键字字符串
	 * condition--查询附加条件
	 * queue--查询排序条件
	 */
public String getRegularSql(String dbase,String tablename,String keyword_value,String condition,String queue){

getKeyColumn column=new getKeyColumn();

String sql="";
try{

String[] keyword_column_array=column.Column(dbase,tablename);//获得关键字查询设置的字段

if(!keyword_value.equals("")&&keyword_column_array!=null&&keyword_value.split("⊙").length>0){/*如果录入的关键字不为空且关键字查询设置的字段不为空，对所有字段进行模糊查询*/
	sql="("	;
	for(int i=0;i<keyword_value.split("⊙").length;i++){
for(String option:keyword_column_array){
sql+=option+" like "+"'%"+keyword_value.split("⊙")[i]+"%'"+" or ";
}
sql=sql.substring(0,sql.length()-4)+") and (";
}
	sql=sql.substring(0,sql.length()-6);
}
if(!sql.equals("")){
	if(!condition.equals("")){
		sql+=" and "+condition;
		}
}else {
	if(!condition.equals("")){
		sql+=" "+condition;
		}
}


if(!sql.equals("")){


if(!queue.equals("")){
sql+=" "+queue;
sql="select * from "+tablename+" where "+sql;

}else{
sql="select * from "+tablename+" where "+sql;

}


}else{

if(!queue.equals("")){
sql+=" "+queue;
sql="select * from "+tablename+sql;

}else{
sql="select * from "+tablename;

}

}

//sql=NseerFileTree.escape(sql);//转化成特殊乱码字符，为了传输时使用
}catch (Exception ex){
ex.printStackTrace();			
}
return sql;

}



public String getAdvanceSql(String dbase,String tablename,String condition,String queue,String[] str_select,String[] str_input,String[] time_select,String[] time_inputa,String[] time_inputb,String[] num_select,String[] num_inputa,String[] num_inputb){

	getKeyColumn column=new getKeyColumn();

	String sql="";
	try{

	String[] keyword_column_array=column.Column(dbase,tablename);//获得关键字查询设置的字段
	for(int i=0;i<str_select.length;i++){
		if(!str_select[i].equals("")){
			sql+=str_select[i]+" like '%"+str_input[i]+"%' and ";
		}
	}
	for(int i=0;i<time_select.length;i++){
		if(!time_select[i].equals("")){
			if(!time_inputa[i].equals("")){
				sql+=time_select[i]+" >= '"+time_inputa[i]+" 00:00:00' and ";
			}
			if(!time_inputb[i].equals("")){
				sql+=time_select[i]+" <= '"+time_inputb[i]+" 23:59:59' and ";
			}
		}
	}
	for(int i=0;i<num_select.length;i++){
		if(!num_select[i].equals("")){
			if(!num_inputa[i].equals("")){
				sql+=num_select[i]+" >= '"+num_inputa[i]+"' and ";
			}
			if(!num_inputb[i].equals("")){
				sql+=num_select[i]+" <= '"+num_inputb[i]+"' and ";
			}
		}
	}
	if(!sql.equals("")){/*如果录入的关键字不为空且关键字查询设置的字段不为空，对所有字段进行模糊查询*/
	sql=sql.substring(0,sql.length()-5);
	}
	
	
	if(!sql.equals("")){
		if(!condition.equals("")){
			sql+=" and "+condition;
			}
	}else {
		if(!condition.equals("")){
			sql+=" "+condition;
			}
	}


	if(!sql.equals("")){


	if(!queue.equals("")){
	sql+=" "+queue;
	sql="select * from "+tablename+" where "+sql;

	}else{
	sql="select * from "+tablename+" where "+sql;

	}


	}else{

	if(!queue.equals("")){
	sql+=" "+queue;
	sql="select * from "+tablename+sql;

	}else{
	sql="select * from "+tablename;

	}

	}
	}catch (Exception ex){
	ex.printStackTrace();			
	}
	return sql;

	}




}