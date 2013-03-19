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
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db qcsdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
try{
String sqla="select * from stock_balance where address_group!='' and qcs_apply_tag='0' order by chain_id";
 String sql_search=sqla;
%>
<%@include file="../../include/list_page.jsp"%>
 <%
ResultSet rs1=qcsdb.executeQuery(sql_search);
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="2"></td>
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
	                   {name: '<%=demo.getLang("erp","质检调度")%>'}
]
nseer_grid.column_width=[200,200,200,100];
nseer_grid.auto='<%=demo.getLang("erp","产品编号/名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
['<%=rs1.getString("chain_ID")%>/<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=rs1.getString("product_ID")%>/<%=exchange.toHtml(rs1.getString("product_name"))%>',
	<%
String sql="select * from stock_cell where product_ID='"+rs1.getString("product_ID")+"'";
ResultSet rs=qcs_db.executeQuery(sql);
if(rs.next()){
	String color="#000000";	
	if(rs1.getDouble("amount")>rs.getDouble("max_amount")){
	color="red";
	}
	if(rs1.getDouble("amount")<rs.getDouble("min_amount")){
	color="orange";
	}
%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../stock/analyse/queryBalance.jsp?product_ID=<%=rs1.getString("product_ID")%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("product_name")))%>")><span style="color:<%=color%>"><%=rs1.getDouble("amount")%></span></div>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("stock_register.jsp?product_id=<%=rs.getString("product_id")%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("product_name")))%>")><%=demo.getLang("erp","质检调度")%></div>'<%}%>],
</page:pages>
['']];
/*************************************************************/
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/head_msg.jsp"%>
<%qcsdb.close();
qcs_db.close();
%>
<page:updowntag num="<%=intRowCount%>" file="stock.jsp"/>
<%}catch(Exception ex){ex.printStackTrace();}%>