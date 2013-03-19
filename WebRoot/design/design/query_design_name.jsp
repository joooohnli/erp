<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db design_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<%nseer_db designdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%

//"02040020070721100005"
//02040020070721100001
String design_ID=request.getParameter("design_ID");
try{
String sql="select * from design_module where design_ID='"+design_ID+"'";
ResultSet rs=designdb.executeQuery(sql);
if(rs.next()){
String check_tag="";
String design_module_tag="等待";
String color="#FF9A31";
String color1="#FF9A31";
if(rs.getString("check_tag").equals("0")){
check_tag="等待";
}else if(rs.getString("check_tag").equals("1")){
check_tag="通过";
color1="mediumseagreen";
}else if(rs.getString("check_tag").equals("9")){
check_tag="未通过";
color1="red";
}
if((rs.getString("check_tag").equals("0")&&rs.getString("change_tag").equals("0"))||rs.getString("check_tag").equals("9")){
design_module_tag="等待";
}else if(rs.getString("check_tag").equals("0")&&rs.getString("change_tag").equals("1")){
design_module_tag="执行";
color="mediumseagreen";
}else if(rs.getString("check_tag").equals("1")&&rs.getString("change_tag").equals("0")){
design_module_tag="完成";
color="3333FF";
}
String design_nu="";

String design_st="";

String design_date_sum="";
int i=1;
String sql6="select * from design_module_details where design_ID='"+design_ID+"' order by details_number";
ResultSet rs6=design_db.executeQuery(sql6);
while(rs6.next()){

String product_describe1;
String amount_unit1;
String product_describe2;
String amount_unit2;

if(rs6.getString("product_describe").equals("")){
 product_describe1="&nbsp;";
product_describe2="7311732A";
}else{
 product_describe1=rs6.getString("product_describe");
 product_describe2=rs6.getString("product_describe");


}
if(rs6.getString("amount_unit").equals("")){
 amount_unit1="&nbsp;";
 amount_unit2="7311732A";

}else{
 amount_unit1=rs6.getString("amount_unit");
 amount_unit2=rs6.getString("amount_unit");

}
String sql22="select * from design_module where product_ID='"+rs6.getString("product_ID")+"' and check_tag='1'";
ResultSet rs22=design_db1.executeQuery(sql22);

if(rs22.next()){

String sql33="select * from design_module_details where design_ID='"+rs22.getString("design_ID")+"' order by details_number";
ResultSet rs33=design_db1.executeQuery(sql33);
String date_num="";

while(rs33.next()){

if(rs33.getString("product_describe").equals("")){
 product_describe1="&nbsp;";
product_describe2="7311732A";
}else{
 product_describe1=rs33.getString("product_describe");
 product_describe2=rs33.getString("product_describe");


}
if(rs33.getString("amount_unit").equals("")){
 amount_unit1="&nbsp;";
 amount_unit2="7311732A";

}else{
 amount_unit1=rs33.getString("amount_unit");
 amount_unit2=rs33.getString("amount_unit");

}
date_num+=rs33.getString("product_ID")+"★"+rs33.getString("product_name")+"★"+rs33.getString("type")+"★"+product_describe2+"★"+rs33.getString("amount")+"★"+amount_unit2+"★"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs33.getDouble("cost_price"))+"★"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs33.getDouble("subtotal"))+"︽";
}
date_num=date_num.substring(0,date_num.length()-2);

design_nu+=rs6.getString("product_ID")+"|||"+date_num+"^";
}else{
design_nu+="179206725"+rs6.getString("product_ID")+"★"+rs6.getString("product_name")+"★"+rs6.getString("type")+"★"+product_describe2+"★"+rs6.getString("amount")+"★"+amount_unit2+"★"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))+"★"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))+"^";
}


design_date_sum+=rs6.getString("product_ID")+"#"+rs6.getString("product_name")+"#"+rs6.getString("type")+"#"+product_describe1+"#"+rs6.getString("amount")+"#"+amount_unit1+"#"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))+"#"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))+"@";

design_st+=rs6.getString("product_name")+",";
i++;
}

if(!design_date_sum.equals("")){
design_date_sum=design_date_sum.substring(0,design_date_sum.length()-1);
out.print(design_date_sum);
out.print("**");
}

if(!design_st.equals("")){
design_st=design_st.substring(0,design_st.length()-1);
out.print(design_st);
out.print("~!~");
}

if(!design_nu.equals("")){
design_nu=design_nu.substring(0,design_nu.length()-1);
out.println(design_nu);
}





}
design_db.close();
design_db1.close();

designdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>