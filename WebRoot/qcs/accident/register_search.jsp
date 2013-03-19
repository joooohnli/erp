<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%>
<%
String search="";
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String search_tag=request.getParameter("search_tag");
String keyword=request.getParameter("keyword");
String sql="";
ResultSet rs=null;
switch(Integer.parseInt(search_tag)){
	case 0:
	{
		sql="select product_id,product_name from design_file where check_tag='1' and (product_id like '%"+keyword+"%' or product_name like '%"+keyword+"%')";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("product_id")+"/"+rs.getString("product_name")+"\n";
		}
		break;
	}
}
search=!search.equals("")?search.substring(0,search.length()-1):"179206725";
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>