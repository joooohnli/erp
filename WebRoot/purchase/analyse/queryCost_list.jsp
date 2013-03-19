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
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_purchase.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String tablename="purchase_purchase";
String realname=(String)session.getAttribute("realeditorc");
String queue="order by register_time desc";
String condition="check_tag='2' and excel_tag='2' and purchase_tag='2'";
String validationXml="../../xml/purchase/purchase_purchase.xml";
String nickName="物流单位档案";
String fileName="queryCost_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的采购执行单总数");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs1 = purchase_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\"打印\" onClick=\"javascript:winopen('queryCost_list_print.jsp')\">";
%>
<%@include file="../../include/search_top.jsp"%>
 <% 
String dbase=(String)session.getAttribute("unit_db_name");
double list_price_sum=query.sumTotal(dbase,sql_search,"list_price_sum");
double real_cost_price_sum=query.sumTotal(dbase,sql_search,"real_cost_price_sum");
 %>
<!-- <table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="2"><%=demo.getLang("erp","市场总价")%>：<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(list_price_sum)%><%=demo.getLang("erp","元")%></td>
 </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","采购总成本")%>：<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(real_cost_price_sum)%><%=demo.getLang("erp","元")%></td>
  <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="打印" onClick="javascript:winopen('queryCost_list_print.jsp')"></div></td>
 </tr>
 </table> -->
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","执行单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","执行单状态")%>'},
                       {name: '<%=demo.getLang("erp","市场价（元）")%>'},
					   {name: '<%=demo.getLang("erp","采购成本（元）")%>'}
]
nseer_grid.column_width=[180,180,100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%	
String check_tag="";
String stock_gather_tag="";
String pay_tag="";
String gather_tag="";
String invoice_tag="";
String purchase_tag=demo.getLang("erp","等待");
String color="#FF9A31";
if(rs1.getString("check_tag").equals("1")){
check_tag=demo.getLang("erp","等待");
}else if(rs1.getString("check_tag").equals("2")){
check_tag=demo.getLang("erp","通过");
}else if(rs1.getString("check_tag").equals("9")){
check_tag=demo.getLang("erp","未通过");
}
if(rs1.getString("stock_gather_tag").equals("1")){
stock_gather_tag=demo.getLang("erp","等待");
}else if(rs1.getString("stock_gather_tag").equals("2")){
stock_gather_tag=demo.getLang("erp","执行");
}else if(rs1.getString("stock_gather_tag").equals("3")){
stock_gather_tag=demo.getLang("erp","完成");
}
if(rs1.getString("pay_tag").equals("1")){
pay_tag=demo.getLang("erp","等待");
}else if(rs1.getString("pay_tag").equals("2")){
pay_tag=demo.getLang("erp","执行");
}else if(rs1.getString("pay_tag").equals("3")){
pay_tag=demo.getLang("erp","完成");
}
if(rs1.getString("gather_tag").equals("1")){
gather_tag=demo.getLang("erp","等待");
}else if(rs1.getString("gather_tag").equals("2")){
gather_tag=demo.getLang("erp","执行");
}else if(rs1.getString("gather_tag").equals("3")){
gather_tag=demo.getLang("erp","完成");
}
if(rs1.getString("invoice_tag").equals("1")){
invoice_tag=demo.getLang("erp","等待");
}else if(rs1.getString("invoice_tag").equals("2")){
invoice_tag=demo.getLang("erp","执行");
}else if(rs1.getString("invoice_tag").equals("3")){
invoice_tag=demo.getLang("erp","完成");
}
if(rs1.getString("purchase_tag").equals("1")){
purchase_tag=demo.getLang("erp","执行");
color="mediumseagreen";
}else if(rs1.getString("purchase_tag").equals("2")){
purchase_tag=demo.getLang("erp","完成");
color="3333FF";
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("queryCost.jsp?purchase_ID=<%=rs1.getString("purchase_ID")%>")><span style="color:<%=color%>"><%=rs1.getString("purchase_ID")%></span></div>','<span style="color:<%=color%>"><%=rs1.getString("product_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("product_name"))%></span>','<span style="color:<%=color%>"><%=purchase_tag%></span>',
 '<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("list_price_sum"))%>',
 '<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("real_cost_price_sum"))%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%	
purchase_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>