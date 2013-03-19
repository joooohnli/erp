<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="getThreeKinds" class="include.get_three_kinds.getThreeKinds" scope="page"/>
<jsp:useBean id="getThreeKinds1" class="include.get_three_kinds.getThreeKinds1" scope="page"/>
<jsp:useBean id="getRateFromID" class="include.get_rate_from_ID.getRateFromID" scope="page"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="fieldValue" scope ="page" class ="purchase.Fieldvalue"/>
<%nseer_db_backup crm_db = new nseer_db_backup(application);%>
<%nseer_db_backup hr_db = new nseer_db_backup(application);%>
<%nseer_db_backup stock_db = new nseer_db_backup(application);%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
String customer_ID=request.getParameter("customer_ID") ;
String sales_ID=request.getParameter("sales_ID") ;
String register_ID=(String)session.getAttribute("human_IDD");
String register=request.getParameter("register") ;
String stock_name=request.getParameter("stock_name") ;
stock_name=stock_name+"库房";
String remark = request.getParameter("remark");
String[] product_name=request.getParameterValues("product_name") ;
String[] product_ID=request.getParameterValues("product_ID") ;
String[] product_describe=request.getParameterValues("product_describe") ;
String[] amount=request.getParameterValues("amount") ;
String[] off_discount=request.getParameterValues("off_discount") ;
String[] list_price=request.getParameterValues("list_price") ;
String[] cost_price=request.getParameterValues("cost_price") ;
String[] real_cost_price=request.getParameterValues("real_cost_price") ;
String[] amount_unit=request.getParameterValues("amount_unit") ;
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
int a=product_ID.length;
String customer_name="";
String sales_name="";
if(a!=1){
	if(crm_db.conn((String)session.getAttribute("unit_db_name"))&&hr_db.conn((String)session.getAttribute("unit_db_name"))&&stock_db.conn((String)session.getAttribute("unit_db_name"))){
int p=0;
double order_discount=getRateFromID.getRateFromID((String)session.getAttribute("unit_db_name"),"security_users","human_ID",sales_ID,"retail_discount");
double order_discount1=getRateFromID.getRateFromID((String)session.getAttribute("unit_db_name"),"security_users","human_ID",register_ID,"retail_discount");
for(int i=1;i<product_ID.length;i++){
	if(off_discount[i].equals("")) off_discount[i]="0";
	StringTokenizer tokenTO2 = new StringTokenizer(list_price[i],","); 
	String list_price2="";
 while(tokenTO2.hasMoreTokens()) {
  String list_price1 = tokenTO2.nextToken();
		list_price2 +=list_price1;
		}
		if(!validata.validata(amount[i])||!validata.validata(off_discount[i])||!validata.validata(list_price2)){
			p++;
		}else{

			 if(Double.parseDouble(off_discount[i])>order_discount&&Double.parseDouble(off_discount[i])>order_discount1){
			p++;
		}
		String sql6="select * from stock_balance_details where stock_name='"+stock_name+"' and product_ID='"+product_ID[i]+"'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		if(rs6.getDouble("amount")<Double.parseDouble(amount[i])){
			p++;
		}
	}else{
			p++;
	}
		}
}
	String sqla="select * from crm_file where customer_ID='01050000000000000000'";
	ResultSet rsa=crm_db.executeQuery(sqla);
	if(!rsa.next()){
		String sqlb="insert into crm_file(customer_ID,customer_name,type,check_tag) values('01050000000000000000','零售非会员','零售非会员','1')";
		crm_db.executeUpdate(sqlb);
	}
	String sql="select * from crm_file where customer_ID='"+customer_ID+"' and type like '%零售%'";
	ResultSet rs=crm_db.executeQuery(sql);
	if(!rs.next()){
		p++;
	}else{
		customer_name=rs.getString("customer_name");
	}
	if(!sales_ID.equals("")){
	String sql4="select * from hr_file where human_ID='"+sales_ID+"'";
	ResultSet rs4=hr_db.executeQuery(sql4);
	if(!rs4.next()){
		p++;
	}else{
		sales_name=rs4.getString("human_name");
	}
	}else{
		p++;
	}
	String sql5="select * from stock_config_public_char where stock_name='"+stock_name+"'";
	ResultSet rs5=stock_db.executeQuery(sql5);
	String stock_ID="";
	if(rs5.next()){
		
		stock_ID=rs5.getString("stock_ID");
	}

if(p==0){
	String type="零售非会员";
	if(!customer_ID.equals("01050000000000000000")){
		type="零售会员";
	}
	
	String[] handbooka1=getThreeKinds1.getThreeKinds((String)session.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID);
	String[] handbooka={"","","","","",""};
if(!sales_ID.equals("")){
handbooka=getThreeKinds.getThreeKinds((String)session.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID);
}
	int filenum=count.read((String)session.getAttribute("unit_db_name"),"crmordertempcount");
 count.write((String)session.getAttribute("unit_db_name"),"crmordertempcount",filenum);

String sql1 = "insert into crm_order_retail_temp(order_ID,first_kind_ID,first_kind_name,second_kind_ID,second_kind_name,third_kind_ID,third_kind_name,hr_first_kind_ID,hr_first_kind_name,hr_second_kind_ID,hr_second_kind_name,hr_third_kind_ID,hr_third_kind_name,customer_ID,customer_name,stock_name,stock_ID,register_time,sales_ID,sales_name,register,type,order_type,remark,check_tag,excel_tag) values ('"+filenum+"','"+handbooka1[0]+"','"+handbooka1[1]+"','"+handbooka1[2]+"','"+handbooka1[3]+"','"+handbooka1[4]+"','"+handbooka1[5]+"','"+handbooka[0]+"','"+handbooka[1]+"','"+handbooka[2]+"','"+handbooka[3]+"','"+handbooka[4]+"','"+handbooka[5]+"','"+customer_ID+"','"+customer_name+"','"+stock_name+"','"+stock_ID+"','"+time+"','"+sales_ID+"','"+sales_name+"','"+register+"','"+type+"','零售','"+remark+"','0','2')" ;
	crm_db.executeUpdate(sql1) ;
double sale_price_sum=0.0d;
double list_price_sum=0.0d;
double cost_price_sum=0.0d;
double real_cost_price_sum=0.0d;
double pay_amount_sum=0.0d;
for(int i=1;i<product_ID.length;i++){
	if(off_discount[i].equals("")) off_discount[i]="0";
	StringTokenizer tokenTO2 = new StringTokenizer(list_price[i],","); 
	String list_price2="";
 while(tokenTO2.hasMoreTokens()) {
  String list_price1 = tokenTO2.nextToken();
		list_price2 +=list_price1;
		}
	double subtotal=Double.parseDouble(list_price2)*(1-Double.parseDouble(off_discount[i])/100)*Double.parseDouble(amount[i]);
	sale_price_sum+=subtotal;
	list_price_sum+=Double.parseDouble(list_price2)*Double.parseDouble(amount[i]);
	cost_price_sum+=Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
	real_cost_price_sum+=Double.parseDouble(real_cost_price[i])*Double.parseDouble(amount[i]);
	pay_amount_sum+=Double.parseDouble(amount[i]);
	String sql2="insert into crm_order_retail_details_temp(order_ID,details_number,product_ID,product_name,product_describe,list_price,amount,cost_price,real_cost_price,off_discount,subtotal,amount_unit) values('"+filenum+"','"+i+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+list_price2+"','"+amount[i]+"','"+cost_price[i]+"','"+real_cost_price[i]+"','"+off_discount[i]+"','"+subtotal+"','"+amount_unit[i]+"')";
	crm_db.executeUpdate(sql2);
}

String sql3="update crm_order_retail_temp set list_price_sum='"+list_price_sum+"',sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"' where order_ID='"+filenum+"'";
crm_db.executeUpdate(sql3);
crm_db.close();
hr_db.close();
stock_db.close();

response.sendRedirect("register_reconfirm.jsp?order_ID="+filenum+"");
}else{
	%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="form1" class="x-form" method="POST" action="register.jsp">
<input type="hidden" name="customer_ID" value="<%=customer_ID%>">
<input type="hidden" name="sales_ID" value="<%=sales_ID%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数量、单价、折扣必须是数字，零售店库房、会员编号必须正确并保证本零售店库房有商品，折扣必须在权限范围内，请返回确认！")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</form>
</div>
<%}}else{
		 %>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="form1" class="x-form" method="POST" action="register.jsp">
<input type="hidden" name="customer_ID" value="<%=customer_ID%>">
<input type="hidden" name="sales_ID" value="<%=sales_ID%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td> 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</form>
</div>
<%
	 }
	 }else{
	%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="form2" class="x-form" method="POST" action="register.jsp">       
<input type="hidden" name="customer_ID" value="<%=customer_ID%>">
<input type="hidden" name="sales_ID" value="<%=sales_ID%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择产品，请返回。")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</form>
</div>
<%}%> 
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
