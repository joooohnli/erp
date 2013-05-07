<%@page language="java" import="java.util.*" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject" import="org.json.simple.JSONArray"%>
<%
	nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));
	
	String chain_name = request.getParameter("chain_name"); 
	chain_name = new String(chain_name.getBytes("iso-8859-1"),"gb2312");  
	String stock_name = request.getParameter("stock_name"); 
	stock_name = new String(stock_name.getBytes("iso-8859-1"),"gb2312");   
	String sql = "";
	//test
	System.out.println(chain_name+"  "+stock_name);
	
	if (chain_name.equals("--全部种类--")&&stock_name.equals("--全部库房--")){	
		sql="SELECT product_id, product_name, sum(amount) as amount FROM `stock_paying_gathering` GROUP BY  product_id;";
	}
	else if (chain_name.equals("--全部种类--") && !stock_name.equals("--全部库房--")) {
		sql="SELECT product_id, product_name, sum(amount) as amount FROM `stock_paying_gathering` where stock_name='"+stock_name+"' GROUP BY  product_id ;";
	}
	else {

		sql="SELECT product_id, product_name, sum(amount) as amount FROM `stock_paying_gathering` GROUP BY  product_id;";
	}
	ResultSet rs = stock_db.executeQuery(sql);

    JSONArray array = new JSONArray();

	while (rs.next()){
		JSONArray temp=new JSONArray();
		nseer_db product_db = new nseer_db((String)session.getAttribute("unit_db_name"));
		sql = "SELECT * FROM `design_file` where product_id='"+rs.getString("product_id")+"'";
		ResultSet rs_pro = product_db.executeQuery(sql);
		if (rs_pro.next()){
				temp.add(rs_pro.getString("chain_id")+"/"+rs_pro.getString("chain_name"));
		}
		
		temp.add(rs.getString("product_id")+"/"+rs.getString("product_name"));
		temp.add(rs.getString("amount"));
		
		nseer_db stock_cell_db = new nseer_db((String)session.getAttribute("unit_db_name"));
		sql = "SELECT * FROM `stock_cell` where product_id='"+rs.getString("product_id")+"'";
		ResultSet rs_cell = stock_cell_db.executeQuery(sql);
		if (rs_cell.next()){
			temp.add(rs_cell.getString("max_amount"));
			temp.add(rs_cell.getString("min_amount"));
		}
		product_db.close();
		stock_cell_db.close();
		
		array.add(temp);
	}
	stock_db.close();
    
    out.print(array);
    
    out.flush();
    
   // out.close();
%>

