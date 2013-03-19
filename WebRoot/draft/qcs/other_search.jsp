<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
String search="";
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String search_tag=request.getParameter("search_tag");
String sql="";
ResultSet rs=null;
switch(Integer.parseInt(search_tag)){
	case 0:
	{
		String product_id=request.getParameter("param1");		
		sql="select solution_id,solution_name from qcs_solution where product_id='"+product_id+"' and check_tag='1'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("solution_id")+"/"+rs.getString("solution_name")+"\n";
		}
		break;
	}
	case 1:
	{
		String solution_id=request.getParameter("solution_id");
		sql="select item,analyse_method,default_basis,ready_basis,quality_method,standard_value,standard_max,standard_min from qcs_solution_details where solution_id='"+solution_id+"'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("item")+"⊙"+rs.getString("analyse_method")+"⊙"+rs.getString("default_basis")+"⊙"+rs.getString("ready_basis")+"⊙"+rs.getString("quality_method")+"⊙"+rs.getString("standard_value")+"⊙"+rs.getString("standard_max")+"⊙"+rs.getString("standard_min")+"\n";
		}
		break;
	}
	case 2:
	{
		sql="select standard_id,standard_name from qcs_sampling_standard where check_tag='1'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("standard_id")+"/"+rs.getString("standard_name")+"\n";
		}
		break;
	}
	case 3:
	{		
		String standard_id=request.getParameter("standard_id");
		String quality_amount=request.getParameter("quality_amount");
		sql="select sampling_method from qcs_sampling_standard where standard_id='"+standard_id+"'";
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
				search="0";
			}
		}else if(Divide.getId(sampling_method).equals("02")){
			sql="select sampling_formula,accept_amount,reject_amount from qcs_sampling_standard_details where standard_id='"+standard_id+"' and batch>='"+quality_amount+"' order by batch";
			rs=qcs_db.executeQuery(sql);
			if(rs.next()){
				search+=rs.getString("sampling_formula").replaceAll("批量数",quality_amount)+"⊙"+rs.getString("accept_amount")+"⊙"+rs.getString("reject_amount")+"\n";
			}else{
				search="0";
			}
		}else{
			sql="select sampling_amount,accept_amount,reject_amount from qcs_sampling_standard_details where standard_id='"+standard_id+"' and batch>='"+quality_amount+"' order by batch";
			rs=qcs_db.executeQuery(sql);
			if(rs.next()){
				search+=rs.getString("sampling_amount")+"⊙"+rs.getString("accept_amount")+"⊙"+rs.getString("reject_amount")+"\n";
			}else{
				search="0";
			}
		}
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
		String keyword=request.getParameter("param1");
		sql="select type_id,type_name from qcs_config_public_char where kind_id='14' and (type_id like '%"+keyword+"%' or type_name like '%"+keyword+"%')";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
	case 6:
	{
		sql="select type_id,type_name from qcs_config_public_char where kind_id='06'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}
	case 7:
	{
		String keyword=request.getParameter("param1");
		sql="select provider_id,provider_name from purchase_file where check_tag='1' and (provider_id like '"+keyword+"%' or provider_name like '"+keyword+"%')";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("provider_id")+"/"+rs.getString("provider_name")+"\n";
		}
		break;
	}
	case 8:
	{
		String keyword=request.getParameter("param1");
		sql="select customer_id,customer_name from crm_file where check_tag='1' and (customer_id like '"+keyword+"%' or customer_name like '"+keyword+"%')";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("customer_id")+"/"+rs.getString("customer_name")+"\n";
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