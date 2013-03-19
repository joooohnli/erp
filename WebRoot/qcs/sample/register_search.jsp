<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
String search="";
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String search_tag=request.getParameter("search_tag");
String sql="";
ResultSet rs=null;
switch(Integer.parseInt(search_tag)){
	case 0:
	{
		sql="select type_id,type_name from qcs_config_public_char where kind_id='15'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
	case 1:
	{
		String reason=request.getParameter("reason");
		String keyword=request.getParameter("keyword");
		sql="select apply_id from qcs_apply_details where reason='"+reason+"' and apply_id like '%"+keyword+"%' and qcs_tag='0'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("apply_id")+"\n";
		}
		break;
	}
	case 2:
	{
		String reason=request.getParameter("reason");
		String apply_id=request.getParameter("apply_id");
		sql="select label,product_id,product_name,amount_unit,demand_amount from qcs_apply_details where apply_id='"+apply_id+"' and qcs_tag='0'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("label")+"⊙"+rs.getString("product_id")+"⊙"+rs.getString("product_name")+"⊙"+rs.getString("amount_unit")+"⊙"+rs.getString("demand_amount")+"\n";
		}
		break;
	}
	case 3:
	{
		String product_id=request.getParameter("param1");		
		sql="select solution_id,solution_name from qcs_solution where product_id='"+product_id+"' and check_tag='1'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("solution_id")+"/"+rs.getString("solution_name")+"\n";
		}
		break;
	}
	case 4:
	{
		String solution_id=request.getParameter("solution_id");
		sql="select item,analyse_method,default_basis,ready_basis,quality_method,standard_value,standard_max,standard_min from qcs_solution_details where solution_id='"+solution_id+"'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("item")+"⊙"+rs.getString("quality_method")+"⊙"+rs.getString("standard_value")+"⊙"+rs.getString("standard_max")+"⊙"+rs.getString("standard_min")+"\n";
		}
		break;
	}
	case 5:
	{	
		String keyword=request.getParameter("param1");
		sql="select type_id,type_name from qcs_config_public_char where kind_id='14' and (type_id like '%"+keyword+"%' or type_name like '%"+keyword+"%')";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
}
search=!search.equals("")?search.substring(0,search.length()-1):"0";
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>