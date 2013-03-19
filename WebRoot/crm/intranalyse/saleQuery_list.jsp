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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script src="../../javascript/table/movetable.js"></script>
<%
String tablename="crm_order";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1'";
String queue="order by register_time desc";
String validationXml="../../xml/crm/crm_order.xml";
String nickName="销售业绩";
String fileName="saleQuery_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的销售业绩总数");
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs = crm_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<%
double demand_cost_price_sum=0.0d;
double executed_cost_price_sum=0.0d;
while(rs.next()){
	demand_cost_price_sum+=rs.getDouble("sale_price_sum");
	executed_cost_price_sum+=rs.getDouble("gathered_sum");
}
rs = crm_db.executeQuery(sql_search) ;
String chain_name="";
%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","销售类型")%>'},
                       {name: '<%=demo.getLang("erp","销售单编号")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
					   {name: '<%=demo.getLang("erp","销售人")%>'},
                       {name: '<%=demo.getLang("erp","完成时间")%>'},
                       {name: '<%=demo.getLang("erp","销售额")%>'},
                       {name: '<%=demo.getLang("erp","回款状态")%>'}
]
nseer_grid.column_width=[70,160,200,70,140,100,70];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
	<%
String finish_time=rs.getString("accomplish_time");
if(finish_time.equals("1800-01-01 00:00:00.0")){
	finish_time=demo.getLang("erp","未完成");
}
String gather_tag=rs.getString("gather_tag");
if(gather_tag.equals("3")){
	gather_tag=demo.getLang("erp","完成");
}else{
	gather_tag=demo.getLang("erp","未完成");
}
%>
	
['<%=rs.getString("order_type")%>',
	<%if(rs.getString("order_type").equals("订单")){%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../order/query.jsp?order_ID=<%=rs.getString("order_ID")%>")><%=rs.getString("order_ID")%></div>',
		<% }else{%>
		'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../retail/query.jsp?order_ID=<%=rs.getString("order_ID")%>")><%=rs.getString("order_ID")%></div>',
		<% }%>	'<%=exchange.toHtml(rs.getString("hr_chain_name"))%>','<%=exchange.toHtml(rs.getString("sales_name"))%>','<%=exchange.toHtml(finish_time)%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%>','<%=gather_tag%>'],
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
crm_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>