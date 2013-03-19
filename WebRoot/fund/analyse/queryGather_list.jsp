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
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/fund/fund_fund.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
 <div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="fund_fund";
String realname=(String)session.getAttribute("realeditorc");
String condition="(fund_execute_tag='1' or fund_pre_tag='0') and file_chain_name like '应收账款%'";
String queue="order by register_time desc";
String validationXml="../../xml/fund/fund_fund.xml";
String nickName="销售应收款";
String fileName="queryGather_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的销售应收款总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs = fund_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<%
double demand_cost_price_sum=0.0d;
double executed_cost_price_sum=0.0d;
while(rs.next()){
	demand_cost_price_sum+=rs.getDouble("demand_cost_price_sum");
	executed_cost_price_sum+=rs.getDouble("executed_cost_price_sum");
}
ResultSet rs1 = fund_db.executeQuery(sql_search) ;
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
					   {name: '<%=demo.getLang("erp","执行单/计划单编号")%>'},
                       {name: '<%=demo.getLang("erp","付款人")%>'},
                       {name: '<%=demo.getLang("erp","责任人")%>'},
                       {name: '<%=demo.getLang("erp","完成时间")%>'},
                       {name: '<%=demo.getLang("erp","理由")%>'},
					   {name: '<%=demo.getLang("erp","币种")%>'},
					   {name: '<%=demo.getLang("erp","应收金额")%>'},
					   {name: '<%=demo.getLang("erp","已收金额")%>'}
]
nseer_grid.column_width=[200,160,70,140,180,70,100,100];
nseer_grid.auto='<%=demo.getLang("erp","付款人")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
String finish_time=rs1.getString("finish_time");
if(finish_time.equals("1800-01-01 00:00:00.0")){
	finish_time="未完成";
}
%>

['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../gather/query.jsp?fund_ID=<%=rs1.getString("fund_ID")%>")><%=rs1.getString("fund_ID")%></div>','<%=exchange.toHtml(rs1.getString("funder"))%>','<%=exchange.toHtml(rs1.getString("designer"))%>','<%=exchange.toHtml(finish_time)%>','<%=exchange.toHtml(rs1.getString("apply_ID_group"))%>','<%=exchange.toHtml(rs1.getString("currency_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("demand_cost_price_sum"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("executed_cost_price_sum"))%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%@include file="../../include/head_msg.jsp"%>
<%fund_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>