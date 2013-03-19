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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_balance.xml"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<% 
try{
	String tablename="stock_balance";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

<%
String condition="";
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition0="address_group!=''";
String queue="order by chain_id";
String validationXml="../../xml/stock/stock_balance.xml";
String nickName="动态库存";
String fileName="queryBalance_list_print.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品总数");
int k=1;
%>
<%@include file="../../include/search_a.jsp"%>
<%
condition=condition0;
%>
<%@include file="../../include/search_b.jsp"%>
<%
ResultSet rs1 = stock_db.executeQuery(sql_search);
otherButtons="&nbsp;<OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value="+demo.getLang("erp","打印")+" onclick=\"javascript:window.print()\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value="+demo.getLang("erp","页面设置")+" onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value="+demo.getLang("erp","打印预览")+" onclick=document.all.WebBrowser.ExecWB(7,1)>";
int n=0;
int m=0;
double amount=0.0d;
while(rs1.next()){
	amount+=rs1.getDouble("amount");
String sql2="select min_amount,max_amount from stock_cell where product_ID='"+rs1.getString("product_ID")+"'";
ResultSet rs2=stock_db1.executeQuery(sql2);
if(rs2.next()){
	if(rs1.getDouble("amount")>rs2.getDouble("max_amount")){
	n++;
	}
	if(rs1.getDouble("amount")<rs2.getDouble("min_amount")){
	m++;
	}
}
}
rs1 = stock_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","当前库存总数：")%><%=amount%><%=demo.getLang("erp","件")%>&nbsp;<font color="red"><%=demo.getLang("erp","当前库存上限报警产品种类数：")%><%=n%><%=demo.getLang("erp","种")%>,&nbsp;
  <font color="orange"><%=demo.getLang("erp","库存下限报警产品种类数：")%><%=m%><%=demo.getLang("erp","种")%>
  </td>
</tr>
</table>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","产品分类")%>'},
                       {name: '<%=demo.getLang("erp","产品编号/名称")%>'},
	                   {name: '<%=demo.getLang("erp","库存数量")%>'},
                       {name: '<%=demo.getLang("erp","安全库存上限")%>'},
	                   {name: '<%=demo.getLang("erp","安全库存下限")%>'}
]
nseer_grid.column_width=[300,200,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","产品编号/名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 	
['<%=rs1.getString("chain_id")%>/<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=rs1.getString("product_ID")%>/<%=exchange.toHtml(rs1.getString("product_name"))%>',
<%
String sql="select * from stock_cell where product_ID='"+rs1.getString("product_ID")+"'";
ResultSet rs=stock_db1.executeQuery(sql);
if(rs.next()){
	String color="#000000";	
	if(rs1.getDouble("amount")>rs.getDouble("max_amount")){
	color="red";
	}
	if(rs1.getDouble("amount")<rs.getDouble("min_amount")){
	color="orange";
	}
%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("queryBalance.jsp?product_ID=<%=rs1.getString("product_ID")%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("product_name")))%>")><span style="color:<%=color%>"><%=rs1.getDouble("amount")%></span></div>','<span style="color:<%=color%>"><%=rs.getDouble("max_amount")%></span>','<span style="color:<%=color%>"><%=rs.getDouble("min_amount")%></span>'<%}%>],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
stock_db.close();	
stock_db1.close();
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>