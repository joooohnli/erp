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
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String static_report_ID=(String)session.getAttribute("static_report_ID");
String sql="select * from stock_balance_static_report where static_report_ID='"+static_report_ID+"'";
ResultSet rs=stock_db.executeQuery(sql);
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","生成盘点表")%>" onClick=location="getStaticReport_excel.jsp?filenum=<%=static_report_ID%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> style="width:98%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","盘点单：")%><%=static_report_ID%><%=demo.getLang("erp","的产品总数：")%><%=intRowCount%><%=demo.getLang("erp","种")%></td>
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
	                   {name: '<%=demo.getLang("erp","库存数量")%>'}
]
nseer_grid.column_width=[180,300,160];
nseer_grid.auto='<%=demo.getLang("erp","产品分类")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
	
['<%=rs.getString("chain_ID")%>/<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=rs.getString("product_ID")%>/<%=exchange.toHtml(rs.getString("product_name"))%>',
<%
String sql1="select * from stock_cell where product_ID='"+rs.getString("product_ID")+"'";
ResultSet rs1=stock_db1.executeQuery(sql1);
if(rs1.next()){
	String color="#000000";	
	if(rs.getDouble("amount")>rs1.getDouble("max_amount")){
	color="red";
	}
	if(rs.getDouble("amount")<rs1.getDouble("min_amount")){
	color="orange";
	}
%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("staticQuery_details.jsp?static_report_ID=<%=static_report_ID%>&&product_ID=<%=rs.getString("product_ID")%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("product_name")))%>")><span style="color:<%=color%>"><%=rs.getDouble("amount")%></span></div>'<%}%>],

</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div> 
<%
stock_db.close();	
stock_db1.close();	
%>
<%@include file="../../include/head_msg.jsp"%>