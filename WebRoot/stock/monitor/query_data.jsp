<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db new_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
String sql = "SELECT * FROM `stock_balance`;";
ResultSet rs = new_db.executeQuery(sql);
//name and amount and id of products in stock_balance
String name_amount_id = "";
while(rs.next()) {
	name_amount_id += rs.getString("product_name");
	name_amount_id += "^_^";
	name_amount_id += rs.getString("amount");
	name_amount_id += "^_^";
	name_amount_id += rs.getString("product_id");
	name_amount_id += "^_^";
}
out.println(name_amount_id);
new_db.close();
%>