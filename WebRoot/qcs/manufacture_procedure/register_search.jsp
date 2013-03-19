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
		sql="select type_id,type_name from qcs_config_public_char where kind_id='06'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
	case 1:
	{
		sql="select standard_id,standard_name from qcs_sampling_standard where check_tag='1'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("standard_id")+"/"+rs.getString("standard_name")+"\n";
		}
		break;
	}
	case 2:
	{
		String solution_id=request.getParameter("solution_id");
		sql="select item,analyse_method,default_basis,ready_basis,quality_method,standard_value,standard_max,standard_min from qcs_solution_details where solution_id='"+solution_id+"'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
        search+=rs.getString("item")+"⊙"+rs.getString("analyse_method")+"⊙"+rs.getString("default_basis")+"⊙"+rs.getString("ready_basis")+"⊙"+rs.getString("quality_method")+"⊙"+rs.getString("standard_value")+"⊙"+rs.getString("standard_max")+"⊙"+rs.getString("standard_min")+"\n";
		
		}
		break;
	}
	case 3:
	{   
		String product_id=request.getParameter("param");
		sql="select solution_id,solution_name from qcs_solution where product_id='"+product_id+"' and check_tag='1'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("solution_id")+"/"+rs.getString("solution_name")+"\n";
		}
		break;
	}
	case 4:
	{
		sql="select type_id,type_name from qcs_config_public_char where kind_id='14'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
	case 5:
	{		
		String standard_id=request.getParameter("standard_id");
		String quality_amount=request.getParameter("quality_amount");
        int point_position=quality_amount.indexOf(".");
		quality_amount=quality_amount.substring(0,point_position);
		sql="select sampling_method from qcs_sampling_standard where standard_id='"+standard_id+"' and check_tag='1'";
		rs=qcs_db.executeQuery(sql);
		String sampling_method="";
		if(rs.next()){
		sampling_method=rs.getString("sampling_method");
		if(Divide.getId(sampling_method).equals("01")){
			sql="select sampling_amount,accept_amount,reject_amount from qcs_sampling_standard_details where standard_id='"+standard_id+"'";
			rs=qcs_db.executeQuery(sql);
			if(rs.next()){
				search+=rs.getString("sampling_amount")+"⊙"+rs.getString("accept_amount")+"⊙"+rs.getString("reject_amount")+"\n";
			}else{
				search="";
			}
		}else if(Divide.getId(sampling_method).equals("02")){
			sql="select batch,sampling_formula,accept_amount,reject_amount from qcs_sampling_standard_details where standard_id='"+standard_id+"'  order by batch";
			rs=qcs_db.executeQuery(sql);
			if(rs.next()){	
				  if(Integer.parseInt(rs.getString("batch"))>=Integer.parseInt(quality_amount)){ search+=rs.getString("sampling_formula").replaceAll("批量数",quality_amount)+"⊙"+rs.getString("accept_amount")+"⊙"+rs.getString("reject_amount")+"\n";
			      }else{
				       search="";
			      }
			}
		}else{
			sql="select batch,sampling_amount,accept_amount,reject_amount from qcs_sampling_standard_details where standard_id='"+standard_id+"'  order by batch";
			rs=qcs_db.executeQuery(sql);
			if(rs.next()){
				if(Integer.parseInt(rs.getString("batch"))>=Integer.parseInt(quality_amount)){
				search+=rs.getString("sampling_amount")+"⊙"+rs.getString("accept_amount")+"⊙"+rs.getString("reject_amount")+"\n";
			    }else{
				     search="";
			    }
			}
		}
		}
		break;
	}
	case 6:
	{	
		String keyword=request.getParameter("param");
		sql="select type_id,type_name from qcs_config_public_char where kind_id='14' and (type_id like '%"+keyword+"%' or type_name like '%"+keyword+"%')";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
	case 7:
	{	
		String keyword=request.getParameter("param");
		sql="select type_id,type_name from manufacture_config_public_char";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
	
}
search=!search.equals("")&&!search.equals("0")?search.substring(0,search.length()-1):"0";
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>