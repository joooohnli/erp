<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db new_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("HH");
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
String time_select=(String)session.getAttribute("time_select");
String time0=formatter.format(now);
String time=formatter1.format(now);
String time1=time+" "+time0+":00:00";
String time2=time+" "+time0+":59:59";
int[] amount=new int[24];
int i=0;
String line_data="";
String line_clock="";
if(time.equals(time_select)){
for(int j=0;j<24;j++){
time1=time+" "+j+":00:00";
time2=time+" "+j+":59:59";
if(j<23){
String sql="select count(id) from security_alive_access where time1>='"+time1+"' and time1<='"+time2+"'";
ResultSet rs = new_db.executeQuery(sql) ;
if(rs.next())
{
amount[j+1]=rs.getInt("count(id)");
	}else{
		amount[j+1]=0;
	}
	line_data+=amount[j+1]+",";
}else{
String sql="select count(id) from security_alive_access where time1>='"+time1+"' and time1<='"+time2+"'";
ResultSet rs = new_db.executeQuery(sql) ;
if(rs.next())
{
amount[0]=rs.getInt("count(id)");
	}else{
		amount[0]=0;
	}
	line_data=amount[0]+","+line_data;
}
	line_clock+=j+",";
}
}else{
for(int j=0;j<24;j++){
time1=time_select+" "+j+":00:00";
time2=time_select+" "+j+":59:59";
if(j<23){
String sql="select count(id) from security_alive_access where time1>='"+time1+"' and time1<='"+time2+"'";
ResultSet rs = new_db.executeQuery(sql) ;
if(rs.next())
{
amount[j+1]=rs.getInt("count(id)");
}else{
		amount[j+1]=0;
	}
	line_data+=amount[j+1]+",";
}else{
String sql="select count(id) from security_alive_access where time1>='"+time1+"' and time1<='"+time2+"'";
ResultSet rs = new_db.executeQuery(sql) ;
if(rs.next())
{
amount[0]=rs.getInt("count(id)");
}else{
		amount[0]=0;
	}
	line_data=amount[0]+","+line_data;
}
	line_clock+=j+",";
}
}
line_data=line_data.substring(0,line_data.length()-1);
line_clock=line_clock.substring(0,line_clock.length()-1);
out.println(line_clock+"^_^川大科技-->http://www.nseer.com<$$>"+line_data+"★"+line_data);
new_db.close();
%>