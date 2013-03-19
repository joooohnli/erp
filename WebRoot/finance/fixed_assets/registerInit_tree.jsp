<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String sql="";
ResultSet rs=null;
try{
String tag=request.getParameter("tag");
String file_id=request.getParameter("file_id");
String lifecycle=request.getParameter("lifecycle");
String remnant_value_rate=request.getParameter("remnant_value_rate");
String depositing_subject=request.getParameter("depositing_subject");
String nick_name=request.getParameter("nick_name");
String daily_tag=request.getParameter("daily_tag");
String bank_tag=request.getParameter("bank_tag");
String assistance=request.getParameter("assistance");
String describe3=request.getParameter("describe3");
String describe2=request.getParameter("describe2");
String describe1=request.getParameter("describe1");
String select="";

if(tag.equals("select")){
	sql = "select number_in_asset_table,first_kind_name from finance_config_report_itema order by number_in_asset_table " ;
	rs = finance_db.executeQuery(sql) ;
	while(rs.next()){
		select+=rs.getString("number_in_asset_table")+"⊙"+rs.getString("first_kind_name")+"◎";
	}
	select=select+"☆";
	sql = "select number_in_profit_table,first_kind_name from finance_config_report_itemb order by number_in_profit_table " ;
	rs = finance_db.executeQuery(sql) ;
	while(rs.next()){
	select+=rs.getString("number_in_profit_table")+"⊙"+rs.getString("first_kind_name")+"◎";
	}
	select=select+"☆";
	sql = "select number_in_cash1_table,first_kind_name from finance_config_report_itemd order by number_in_cash1_table " ;
	rs = finance_db.executeQuery(sql) ;
	while(rs.next()){
	select+=rs.getString("number_in_cash1_table")+"⊙"+rs.getString("first_kind_name")+"◎";
	}
	out.println(select);
}else{
	if(tag.equals("add")){
	sql="update finance_config_file_kind set daily_tag='"+daily_tag+"',bank_tag='"+bank_tag+"',assistance='"+assistance+"' where file_id='"+file_id+"'";
	}else{
		if(tag.equals("nseer1")){
	 		sql="update finance_config_assets_kind set lifecycle='"+lifecycle+"',remnant_value_rate='"+remnant_value_rate+"' where file_id='"+file_id+"'";
		}else{
			if(tag.equals("nseer2")){
	 			sql="update finance_config_assets_fluctuationway set depositing_subject='"+depositing_subject+"' where file_id='"+file_id+"'";
	 		}else{
	 			if(tag.equals("nseer3")){
	 				sql="update finance_config_file_kind set nick_name='"+nick_name+"' where file_id='"+file_id+"'";
	 			}else{
	 				sql="update hr_config_file_kind set nick_name='"+nick_name+"',describe3='"+describe3+"',describe2='"+describe2+"',describe1='"+describe1+"' where file_id='"+file_id+"'";
	 			}			 
			}
		}
	}
finance_db.executeUpdate(sql);
}
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>