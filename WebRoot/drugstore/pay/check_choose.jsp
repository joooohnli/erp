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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<form method="post" action="../../stock_pay_check_choose_ok">
<%
String stock_ID=request.getParameter("stock_ID");
String product_ID=request.getParameter("product_ID");
String pay_ID=request.getParameter("pay_ID");
String timea=request.getParameter("timea");
String timeb=request.getParameter("timeb");
if(timea==null) timea="";
if(timeb==null) timeb="";
if(!timea.equals("")) timea=timea+" 00:00:00";
if(!timeb.equals("")) timeb=timeb+" 23:59:59";
String sql="";
if(timea.equals("")&&timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' order by register_time";
}else if(!timea.equals("")&&timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' and register_time>='"+timea+"' order by register_time";
}else if(timea.equals("")&&!timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' and register_time<='"+timeb+"' order by register_time";
}else if(!timea.equals("")&&!timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' and register_time>='"+timea+"' and register_time<='"+timeb+"' order by register_time";
}
 ResultSet rs = stock_db.executeQuery(sql) ;
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","出库")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","搜索")%>" onClick=location="check_choose_locate.jsp?stock_ID=<%=stock_ID%>&&product_ID=<%=product_ID%>&&pay_ID=<%=pay_ID%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
</tr>
</table>
<input name="stock_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=stock_ID%>">
<input name="product_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=product_ID%>">
<input name="pay_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=pay_ID%>">

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","库房名称")%>'},
                       {name: '<%=demo.getLang("erp","S/N")%>'},
					   {name: '<%=demo.getLang("erp","入库时间")%>'}
]
nseer_grid.column_width=[40,180,100,100,100,160];
nseer_grid.auto='<%=demo.getLang("erp","S/N")%>';
nseer_grid.data = [
<%
while(rs.next()){
%>

['<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="serial_number" value=<%=rs.getString("serial_number")%>>','<%=rs.getString("product_ID")%>','<%=exchange.toHtml(rs.getString("product_name"))%>','<%=exchange.toHtml(rs.getString("stock_name"))%>','<%=rs.getString("serial_number")%>','<%=exchange.toHtml(rs.getString("register_time"))%>'],

<%}%>

['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%stock_db.close();%>
</form>
<%@include file="../../include/head_msg.jsp"%>