<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
String search="";
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String search_tag=request.getParameter("search_tag");
if(search_tag.equals("0")){
String kind=request.getParameter("kind");
if(kind.equals("抽样标准")){
String sql="select standard_id,standard_name from qcs_sampling_standard";
ResultSet rs=qcs_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("standard_id")+"/"+rs.getString("standard_name")+"\n";
}
search=!search.equals("")?search.substring(0,search.length()-1):"179206725";
}else{
String sql="select type_name from qcs_config_public_char where kind='"+kind+"'";
if(kind.equals("质检值")){
sql="select type_id,type_name from qcs_config_public_char where kind='"+kind+"'";
ResultSet rs=qcs_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
}
search=!search.equals("")?search.substring(0,search.length()-1):"179206725";
}else{
ResultSet rs=qcs_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("type_name")+"\n";
}
search=!search.equals("")?search.substring(0,search.length()-1):"179206725";
}
}
}
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>