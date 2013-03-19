

<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%counter count=new counter(application);%>
<%nseer_db_backup manufacture_db = new nseer_db_backup(application);%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%

if(manufacture_db.conn((String)session.getAttribute("unit_db_name"))){

String manufacture_ID=request.getParameter("manufacture_ID");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String product_describe=request.getParameter("product_describe");
String amount=request.getParameter("amount");
String pay_ID_group=request.getParameter("pay_ID_group");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String design_ID=request.getParameter("design_ID") ;
String choice_group=request.getParameter("choice_group");
String[] procedure_ID=request.getParameterValues("procedure_ID");
String[] procedure_name=request.getParameterValues("procedure_name");
String[] procedure_describe=request.getParameterValues("procedure_describe");
String[] labour_hour_amount=request.getParameterValues("labour_hour_amount");
String[] amount_unit=request.getParameterValues("amount_unit");
String[] cost_price=request.getParameterValues("cost_price");
String[] subtotal=request.getParameterValues("subtotal");
double module_cost_price_sum=0.0d;
double labour_cost_price_sum=0.0d;
try{
for(int i=0;i<procedure_name.length;i++){
	int j=i+1;
	double module_subtotal=0.0d;
	labour_cost_price_sum+=Double.parseDouble(subtotal[i]);
	
	String sql1="select * from manufacture_design_procedure_module_details where design_ID='"+design_ID+"' and procedure_name='"+procedure_name[i]+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql1);
	while(rs1.next()){
		double module_amount=rs1.getDouble("amount")*Double.parseDouble(amount);
		double subtotal1=rs1.getDouble("cost_price")*module_amount;
		module_subtotal+=subtotal1;
		module_cost_price_sum+=subtotal1;
		String sql2="insert into manufacture_procedure_module(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,type,amount,amount_unit,cost_price,subtotal) values('"+manufacture_ID+"','"+procedure_name[i]+"','"+rs1.getString("details_number")+"','"+rs1.getString("product_ID")+"','"+rs1.getString("product_name")+"','"+rs1.getString("product_describe")+"','"+rs1.getString("type")+"','"+module_amount+"','"+rs1.getString("amount_unit")+"','"+rs1.getString("cost_price")+"','"+subtotal1+"')";
		manufacture_db.executeUpdate(sql2);
	}

	String sql="insert into manufacture_procedure(manufacture_ID,details_number,procedure_ID,procedure_name,procedure_describe,labour_hour_amount,amount_unit,cost_price,subtotal,module_subtotal) values('"+manufacture_ID+"','"+j+"','"+procedure_ID[i]+"','"+procedure_name[i]+"','"+procedure_describe[i]+"','"+labour_hour_amount[i]+"','"+amount_unit[i]+"','"+cost_price[i]+"','"+subtotal[i]+"','"+module_subtotal+"')";
	manufacture_db.executeUpdate(sql);
}

	String sql3="insert into manufacture_manufacture(manufacture_ID,product_ID,product_name,product_describe,amount,pay_ID_group,apply_id_group,module_cost_price_sum,labour_cost_price_sum,register_time,designer,register,remark,check_tag,excel_tag) values('"+manufacture_ID+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+pay_ID_group+"','"+choice_group+"','"+module_cost_price_sum+"','"+labour_cost_price_sum+"','"+register_time+"','"+designer+"','"+register+"','"+remark+"','0','2')";
	manufacture_db.executeUpdate(sql3);
	
	StringTokenizer tokenTO = new StringTokenizer(choice_group,","); 
	while(tokenTO.hasMoreTokens()) {
 String sql4="update manufacture_apply set manufacture_tag='1' where id='"+tokenTO.nextToken()+"'";
		manufacture_db.executeUpdate(sql4) ;
		}
int num=count.read((String)session.getAttribute("unit_db_name"),"manufacturecount");
count.write((String)session.getAttribute("unit_db_name"),"manufacturecount",num);
	manufacture_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","提交成功，需要审核！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返 回"")%> style="width: 50; " onClick=location="register_list.jsp">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印表单")%>" style="width: 55; " onClick=location="print_register.jsp?manufacture_ID=<%=manufacture_ID%>"></div>
 </td>
 </tr>
 </table>
 <%}else{
	%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="register_list.jsp"></div></td>
 </tr>
 </table>

<%}%>
