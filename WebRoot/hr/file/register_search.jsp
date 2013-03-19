<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%>
<%
String search="";
nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String keyword=request.getParameter("keyword");

String sql="select * from hr_config_file_kind where nick_name like '"+keyword+"%' or file_id like '"+keyword+"%'";
ResultSet rs=hr_db.executeQuery(sql);
while(rs.next()){
	if(!rs.getString("category_name").equals("all"))
	search+=rs.getString("category_name")+"\n";
}
search=!search.equals("")?search.substring(0,search.length()-1):"179206725";
out.print(search);
hr_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>
