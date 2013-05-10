<%@page language="java" import="java.util.*" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject" import="org.json.simple.JSONArray"%>
<%
	nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));
	
	String chain_name = request.getParameter("chain_name"); 
	chain_name = new String(chain_name.getBytes("iso-8859-1"),"gb2312");  
	String stock_name = request.getParameter("stock_name"); 
	stock_name = new String(stock_name.getBytes("iso-8859-1"),"gb2312");   
	String stock_num = request.getParameter("stock_num"); 
	stock_num = new String(stock_num.getBytes("iso-8859-1"),"gb2312");
	String drug_name = request.getParameter("drug_name"); 
	drug_name = new String(drug_name.getBytes("iso-8859-1"),"gb2312");
	String sql = "";
	//test
	System.out.println(chain_name+"  "+stock_name+"   "+stock_num+"    "+drug_name);
	//stock_name
	String sql_stock_name="";
	if (stock_name != null && !stock_name.equals("--全部库房--")) {
		sql_stock_name = "A.stock_name='" + stock_name +"'";
	} else {
		sql_stock_name = "A.stock_name!=''";
	}
	//stock_num
	String sql_stock_num="";
	if (stock_num != null && !stock_num.equals("--全部库存--")) {
		
		if (stock_num.equals("<50")){
			sql_stock_num="amount<50";	
		} else if (stock_num.equals(">20000")) {
			sql_stock_num="amount>20000";
		} else {
			String[] nums = stock_num.split("-");
			sql_stock_num="amount BETWEEN " + nums[0] + " AND " +nums[1];
		}
	} else {
		sql_stock_num="amount>0";
	}
	//drug_name
	String sql_drug_name="";
	if (drug_name != null && !drug_name.equals("")) {
		sql_drug_name = "A.product_name LIKE '%" + drug_name + "%' OR A.product_id LIKE '%" + drug_name + "%'";
	} else {
		sql_drug_name = "A.product_name!=''";
	}
	//chain_name
	String sql_chain_name="";
	if (chain_name != null && !chain_name.equals("--全部种类--")) {
		sql_chain_name="B.chain_name='" + chain_name + "'";
	} else {
		sql_chain_name="B.chain_name!=''";
	}
	//sql="SELECT product_id, product_name, sum(amount) as amount FROM `stock_paying_gathering` WHERE " + sql_stock_name + " AND " + sql_drug_name + "GROUP BY  product_id HAVING " + sql_stock_num + ";";
	sql="SELECT A.product_id,A.product_name,sum(amount) as amount,chain_id,chain_name FROM stock_paying_gathering AS A inner join design_file AS B on A.PRODUCT_ID=B.PRODUCT_ID WHERE "
	 + sql_stock_name + " AND " 
	 + sql_drug_name + " AND " 
	 + sql_chain_name + " GROUP BY A.product_id HAVING " 
	 + sql_stock_num + ";";
	System.out.println(sql);
//	if (chain_name.equals("--全部种类--")&&stock_name.equals("--全部库房--")){	
	//	sql="SELECT product_id, product_name, sum(amount) as amount FROM `stock_paying_gathering` GROUP BY  product_id;";
//	}
	//else if (chain_name.equals("--全部种类--") && !stock_name.equals("--全部库房--")) {
//		sql="SELECT product_id, product_name, sum(amount) as amount FROM `stock_paying_gathering` where stock_name='"+stock_name+"' GROUP BY  product_id ;";
//	}
	//
	//else {

	//	sql="SELECT product_id, product_name, sum(amount) as amount FROM `stock_paying_gathering` GROUP BY  product_id;";
	//}
	ResultSet rs = stock_db.executeQuery(sql);

    JSONArray array = new JSONArray();

	while (rs.next()){
		JSONArray temp=new JSONArray();
		nseer_db product_db = new nseer_db((String)session.getAttribute("unit_db_name"));
	//	sql = "SELECT * FROM `design_file` where product_id='"+rs.getString("product_id")+"'";
	//	ResultSet rs_pro = product_db.executeQuery(sql);
	//	if (rs_pro.next()){
				temp.add(rs.getString("chain_id")+"/"+rs.getString("chain_name"));
	//	}
		
		temp.add(rs.getString("product_id")+"/"+rs.getString("product_name"));
		temp.add(rs.getString("amount"));
		
		nseer_db stock_cell_db = new nseer_db((String)session.getAttribute("unit_db_name"));
		sql = "SELECT * FROM `stock_cell` where product_id='"+rs.getString("product_id")+"'";
		ResultSet rs_cell = stock_cell_db.executeQuery(sql);
		if (rs_cell.next()){
			temp.add(rs_cell.getString("max_amount"));
			temp.add(rs_cell.getString("min_amount"));
		}
	//	product_db.close();
		stock_cell_db.close();
		
		array.add(temp);
	}
	stock_db.close();
    
    out.print(array);
    
    out.flush();
    
   // out.close();
%>

