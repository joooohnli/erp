<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db securitydb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
try{
String sql = "select * from security_users left join security_alive_access on security_users.human_ID=security_alive_access.human_ID where security_alive_access.time2='1800-01-01 00:00:00' order by security_users.human_ID";
ResultSet rs = securitydb.executeQuery(sql);
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
String data="";
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
strPage="";
}
String human_name="";
while(rs.next()){
%>
<%
String sql1="select distinct human_name from security_alive_access where human_ID='"+rs.getString("human_ID")+"'  and modulei='"+rs.getString("modulei")+"' order by time1 desc";
ResultSet rs1=security_db.executeQuery(sql1);
if(rs1.next()&&!human_name.equals(rs.getString("human_name"))){
data+=exchange.toHtml(rs.getString("human_name"))+'⊙'+rs.getString("human_ID")+",";
human_name=rs.getString("human_name");
}}
out.println(data.substring(0,data.length()-1));
%>
<%
security_db.close();
securitydb.close();
}catch(Exception ex){ex.printStackTrace();}
%>