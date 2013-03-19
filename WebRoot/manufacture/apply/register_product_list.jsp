<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js">
</script>
<%
String[] choice=request.getParameterValues("choice");
String[] product_ID1=new String[100000];
double[] amount=new double[100000];
String condition="where ";
String choice_group="";
int i;
int m=0;

for(i=0;i<choice.length-1;i++){
	condition=condition+"pay_ID='"+choice[i]+"'"+" or ";
	choice_group=choice_group+choice[i]+",";
}
condition=condition+"pay_ID='"+choice[i]+"'";
choice_group=choice_group+choice[i];

	String sql = "select distinct product_ID from stock_pay_details "+condition+"" ;
	ResultSet rs = stockdb.executeQuery(sql) ;
	while(rs.next()){
		double amount1=0.0d;
		String sql1="select sum(amount) from stock_pay_details where product_ID='"+rs.getString("product_ID")+"'";
		ResultSet rs1 = stock_db.executeQuery(sql1) ;
		if(rs1.next()){
			amount1=rs1.getDouble("sum(amount)");
		}
		if(amount1!=0){
			product_ID1[m]=rs.getString("product_ID");
			amount[m]=amount1;
			m++;
		}
	}
String[] product_ID=new String[m];
String[] product_name=new String[m];
String[] product_describe=new String[m];
String[] pay_ID_group=new String[m];

for(i=0;i<m;i++){
	String sql4="select * from stock_pay_details where product_ID='"+product_ID1[i]+"'";
	ResultSet rs4 = stock_db.executeQuery(sql4) ;
	if(rs4.next()){
			product_ID[i]=rs4.getString("product_ID");
			product_name[i]=rs4.getString("product_name");
			product_describe[i]=rs4.getString("product_describe");
	}
	String sql2="select distinct pay_ID from stock_pay_details where product_ID='"+product_ID1[i]+"'";
	ResultSet rs2 = stockdb.executeQuery(sql2) ;
	while(rs2.next()){
		double amount2=0.0d;
		String sql3="select sum(amount) from stock_pay_details where product_ID='"+product_ID1[i]+"' and pay_ID='"+rs2.getString("pay_ID")+"'";
		ResultSet rs3 = stock_db.executeQuery(sql3) ;
		if(rs3.next()){
			amount2=rs3.getDouble("sum(amount)");
		}
		int a=choice_group.indexOf(rs2.getString("pay_ID"));
		
		if(amount2!=0&&a!=-1){
			if(pay_ID_group[i]==null){
				pay_ID_group[i]=rs2.getString("pay_ID");
			}else{
				pay_ID_group[i]=pay_ID_group[i]+","+rs2.getString("pay_ID");
			}
		}
	}
}
stock_db.close();
%>
<form id="register1" method="POST" action="register.jsp">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","产品编号")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","产品名称")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","描述")%> </td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","出库单编号集合")%></td>
 </tr>
<%
for(i=0;i<m;i++){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="product_ID" value="<%=product_ID[i]%>"><%=product_ID[i]%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="product_name" value="<%=product_name[i]%>"><%=product_name[i]%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="product_describe" value="<%=product_describe[i]%>"><%=product_describe[i]%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="amount" value="<%=amount[i]%>"><%=amount[i]%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" name="pay_ID_group" value="<%=pay_ID_group[i]%>"><%=pay_ID_group[i]%>&nbsp;</td>
 </tr>
<%
	}
stockdb.close();
%>
</table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","预览计划单")%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
 </tr>
 </table>
 </form>