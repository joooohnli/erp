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
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/logistics/logistics_logistics.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

<%
String tablename="logistics_logistics";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1'";
String queue="order by register_time desc";
String validationXml="../../xml/logistics/logistics_logistics.xml";
String nickName="配送单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的配送单总数");
%>
<%@include file="../../include/search.jsp"%>

<%try{
otherButtons="";
ResultSet rs1=logistics_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","配送单编号")%>'},
                       {name: '<%=demo.getLang("erp","订单编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","配送数量")%>'},
                       {name: '<%=demo.getLang("erp","配送费用")%>'}
]
nseer_grid.column_width=[180,180,100,200,150,100,100];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?logistics_ID=<%=rs1.getString("logistics_ID")%>")><%=rs1.getString("logistics_ID")%></div>','<%=rs1.getString("order_ID")%>','<%=exchange.toHtml(rs1.getString("customer_name"))%>','<%=rs1.getString("product_ID")%>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("demand_amount"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("demand_price_sum"))%>'],
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
logistics_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>