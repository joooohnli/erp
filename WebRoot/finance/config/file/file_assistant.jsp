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
nseer_db finance_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String parent_file_id=request.getParameter("parent_file_id");
String file_id=request.getParameter("file_id");
String file_name=request.getParameter("file_name");
String details_tag=request.getParameter("details_tag");
if(details_tag.equals("0")){		  
	String sqla="update finance_voucher set chain_id='"+file_id+"',chain_name='"+file_name+"' where chain_id='"+parent_file_id+"'";
	finance_db.executeUpdate(sqla);
	int i=0;
	sqla = "select * from finance_gl where file_id='"+parent_file_id+"'";
    ResultSet rs =finance_db.executeQuery(sqla);
	while(rs.next()){
		sqla="insert into finance_gl(file_ID,file_name,debit_or_loan,itema_name,itemb_name,itemd_name,last_year_balance_sum,debit_year_sum,loan_year_sum,current_balance_sum,account_period,corr_stock_tag) values('"+file_id+"','"+file_name+"','"+rs.getString("debit_or_loan")+"','"+rs.getString("itema_name")+"','"+rs.getString("itemb_name")+"','"+rs.getString("itemd_name")+"','"+rs.getString("last_year_balance_sum")+"','"+rs.getString("debit_year_sum")+"','"+rs.getString("loan_year_sum")+"','"+rs.getString("current_balance_sum")+"','"+rs.getString("account_period")+"','"+rs.getString("corr_stock_tag")+"')";				
		finance_db1.executeUpdate(sqla);
		i++;
	}
	sqla="update finance_config_file_kind set details_tag='1' where file_ID='"+parent_file_id+"'";
	finance_db.executeUpdate(sqla);
	if(i!=0){
	sqla="update finance_config_file_kind set delete_tag='1' where file_ID='"+file_id+"'";
	finance_db.executeUpdate(sqla);
	}
}
finance_db.close();
finance_db1.close();
}catch(Exception ex){
	ex.printStackTrace();
}
%>