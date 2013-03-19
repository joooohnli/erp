<?xml version="1.0" encoding="UTF-8"?>
<%@page contentType="text/xml; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db design_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
String product_ID=request.getParameter("product_ID");
String design_ID="";
String sql1="select * from design_module where product_ID='"+product_ID+"' and check_tag='1'";
ResultSet rs1=design_db.executeQuery(sql1);
if(rs1.next()){
	design_ID=rs1.getString("design_ID") ;
try{
int i=1;

String product_date_name="";
String sql6="select * from design_module_details where design_ID='"+design_ID+"' order by details_number";
ResultSet rs6=design_db.executeQuery(sql6);
%>

<tree>
<%
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

String sql33="select * from design_module where product_ID='"+rs6.getString("product_ID")+"' and check_tag='1'";
ResultSet rs33=design_db1.executeQuery(sql33);
if(rs33.next()){
sql33="select * from design_module_details where design_ID='"+rs33.getString("design_ID")+"' order by details_number";
rs33=design_db1.executeQuery(sql33);
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
%>
<tree text="<%=rs6.getString("product_name")%>" action="<%=date_num%>" src="query_product_name.jsp?product_ID=<%=rs6.getString("product_ID")%>" />
<%}else{
String date_num="179206725"+rs6.getString("product_ID")+"★"+rs6.getString("product_name")+"★"+rs6.getString("type")+"★"+product_describe2+"★"+rs6.getString("amount")+"★"+amount_unit2+"★"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))+"★"+new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"));	
%>
<tree text="<%=rs6.getString("product_name")%>" action="<%=date_num%>" />
<%}
product_date_name+=rs6.getString("product_name")+",";
i++;
}
%>

</tree>
<%
if(!product_date_name.equals("")){
product_date_name=product_date_name.substring(0,product_date_name.length()-1);
//out.print(product_date_name);

}
design_db.close();
design_db1.close();

}
catch (Exception ex){
out.println("error"+ex);
}
}else{
%>

<%}%>