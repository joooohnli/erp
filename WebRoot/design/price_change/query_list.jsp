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
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>

<%
String tablename="design_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and price_change_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","当前产品档案总数：");
%>
 <%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=design_db.executeQuery(sql_search);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","用途类型")%>'},
                       {name: '<%=demo.getLang("erp","产品分类")%>'},
					   {name: '<%=demo.getLang("erp","市场单价")%>'},
					   {name: '<%=demo.getLang("erp","计划成本单价")%>'},
					   {name: '<%=demo.getLang("erp","成本单价")%>'},
					   {name: '<%=demo.getLang("erp","库存数量")%>'}
                    ]
nseer_grid.column_width=[160,200,70,70,100,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","产品分类")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?product_ID=<%=rs1.getString("product_ID")%>")><%=rs1.getString("product_ID")%></div>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("list_price"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("real_cost_price"))%>',
	<%if(!rs1.getString("type").equals("服务型产品")){%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../stock/analyse/queryBalance.jsp?product_ID=<%=rs1.getString("product_ID")%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("product_name")))%>")><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs1.getString("product_ID"))%></div>'<%}else{%>''<%}%>],
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
design_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>