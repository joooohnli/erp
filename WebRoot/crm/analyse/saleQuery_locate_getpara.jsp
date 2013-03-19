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

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String timea=request.getParameter("timea");
String timeb=request.getParameter("timeb");
String customer_amount=request.getParameter("customer_amount");
String first_kind_name="";
String second_kind_name="";
String third_kind_name="";
if(customer_amount.equals("")) customer_amount="0";
char[] chars = customer_amount.toCharArray();
int x=0;
for(int i=0;i<chars.length;i++){
	if(chars[i]>='0'&&chars[i] <='9'){
  	x++;
  }
  }
if(x==chars.length){
first_kind_name=request.getParameter("select1");
if(first_kind_name==null) first_kind_name="";
String select2=request.getParameter("select2");
if(select2!=null&&!select2.equals("")){
StringTokenizer tokenTO1 = new StringTokenizer(select2,"/"); 
 while(tokenTO1.hasMoreTokens()) {
  first_kind_name = tokenTO1.nextToken();
				second_kind_name = tokenTO1.nextToken();
		}
}
String select3=request.getParameter("select3");
if(select3!=null&&!select3.equals("")){
StringTokenizer tokenTO2 = new StringTokenizer(select3,"/"); 
 while(tokenTO2.hasMoreTokens()) {
  first_kind_name = tokenTO2.nextToken();
				second_kind_name = tokenTO2.nextToken();
				third_kind_name = tokenTO2.nextToken();
		}
}
String sales_name=request.getParameter("select4");
if(sales_name==null) sales_name="";
String trade=request.getParameter("select5");
if(trade==null) trade="";
session.setAttribute("trade",trade);
session.setAttribute("timea",timea);
session.setAttribute("timeb",timeb);
session.setAttribute("first_kind_name",first_kind_name);
session.setAttribute("second_kind_name",second_kind_name);
session.setAttribute("third_kind_name",third_kind_name);
session.setAttribute("sales_name",sales_name);
session.setAttribute("customer_amount",customer_amount);
response.sendRedirect("saleQuery_list.jsp");
}else{
%>
<%@include file="../include/head.jsp"%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
  </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick="history.back()"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <%=demo.getLang("erp","排序客户数目必须是整数，请返回！")%></td>
  </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
 </div>
<%}%>