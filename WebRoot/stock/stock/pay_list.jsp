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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_pay.xml"/>
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
String register_ID=(String)session.getAttribute("human_IDD");
String tablename="stock_pay";
String realname=(String)session.getAttribute("realeditorc");
String condition="pay_tag!='2' and pay_pre_tag='0' and demand_amount!='0' and reason!='部件出库'";
String queue="order by register_time";
String validationXml="../../xml/stock/stock_pay.xml";
String nickName="出库单";
String fileName="pay_list.jsp";
String rowSummary=demo.getLang("erp","当前等待做调度的出库单总数：");
boolean qcsPurchase=true;
boolean qcsIntrmanufacture=true;
boolean qcs_manufacture_product=true;
%>
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs = stock_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","出库单编号")%>'},
                       {name: '<%=demo.getLang("erp","出库理由")%>'},
					   {name: '<%=demo.getLang("erp","出库详细理由")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","总金额（元）")%>'},
					   {name: '<%=demo.getLang("erp","出库调度")%>'}
]
nseer_grid.column_width=[180,70,180,160,70,100,70];
nseer_grid.auto='<%=demo.getLang("erp","出库详细理由")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
	<%
String register_time="";
if(rs.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rs.getString("register_time");
}
%>

['<%=rs.getString("pay_ID")%>','<%=exchange.toHtml(rs.getString("reason"))%>',
	<%if(!rs.getString("reasonexact_details").equals("")){%>
		'<%=exchange.toHtml(rs.getString("reasonexact"))%>-<%=rs.getString("reasonexact_details")%>',
			<%}else{
	if(rs.getString("reason").equals("销售出库")){%>
		'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../crm/order/query.jsp?order_ID=<%=rs.getString("reasonexact")%>")><%=rs.getString("reasonexact")%></div>',
			<%}else if(rs.getString("reason").equals("生产领料")){%>
			'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../manufacture/manufacture/query.jsp?manufacture_ID=<%=rs.getString("reasonexact")%>")><%=rs.getString("reasonexact")%></div>',
				<%}else{%>
				'<%=exchange.toHtml(rs.getString("reasonexact"))%>',<%}}%>
				'<%=exchange.toHtml(register_time)%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("demand_amount"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("pay.jsp?pay_ID=<%=rs.getString("pay_ID")%>")><%=demo.getLang("erp","出库调度")%></div>'],

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
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>