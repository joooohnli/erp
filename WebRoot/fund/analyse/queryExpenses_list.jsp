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
<jsp:useBean id="getCount" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
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
String condition="(fund_execute_tag='1' or fund_pre_tag='0') and (file_chain_name like '%费用%' or file_chain_name like '%工资%')";
String queue="order by register_time desc";
String validationXml="../../xml/fund/fund_fund.xml";
String nickName="费用";
String fileName="queryExpenses_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的费用单总数");
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
rs = fund_db.executeQuery(sql_search) ;
%>
<%
/*if(file_chain_name.indexOf("工资")==-1){
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,human_ID,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}else{
sql=query.query(dbase,tablename,timea,timeb,"","","","",fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}
int a=sql.indexOf("order");
String sql1=sql.substring(a-1,sql.length());
String sql2=sql.substring(0,a-1);
	if(file_chain_name.equals("")){
		sql2=sql2+" and file_chain_name like '%费用%'";
	}else if(!file_chain_name.equals("")){
		sql2=sql2+" and file_chain_name='"+file_chain_name+"'";
	}
	sql=sql2+sql1;
	ResultSet rs1=fund_db.executeQuery(sql);
	while(rs1.next()){
		demand_cost_price_sum+=rs1.getDouble("demand_cost_price_sum");
		executed_cost_price_sum+=rs1.getDouble("executed_cost_price_sum");
	}
	ResultSet rs = fund_db.executeQuery(sql) ;
	int intRowCount = getCount.count((String)session.getAttribute("unit_db_name"),sql);*/
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
					   {name: '<%=demo.getLang("erp","费用单编号")%>'},
                       {name: '<%=demo.getLang("erp","收款人")%>'},
                       {name: '<%=demo.getLang("erp","完成时间")%>'},
                       {name: '<%=demo.getLang("erp","理由")%>'},
					   {name: '<%=demo.getLang("erp","币种")%>'},
					   {name: '<%=demo.getLang("erp","应付金额")%>'},
					   {name: '<%=demo.getLang("erp","已付金额")%>'}
]
nseer_grid.column_width=[200,160,140,180,70,100,100];
nseer_grid.auto='<%=demo.getLang("erp","收款人")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String finish_time=rs.getString("finish_time");
if(finish_time.equals("1800-01-01 00:00:00.0")){
	finish_time="未完成";
}
%>

['<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../pay/query.jsp?fund_ID=<%=rs.getString("fund_ID")%>")><%=rs.getString("fund_ID")%></div>',
<%if(!rs.getString("funder").equals("")){
if(rs.getString("file_chain_name").indexOf("应付账款")!=-1){%>
'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../purchase/file/query.jsp?provider_ID=<%=rs.getString("funder_ID")%>")><%=exchange.toHtml(rs.getString("funder"))%></div>',
<%}else if(rs.getString("file_chain_name").indexOf("应收账款")!=-1){%>
'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../crm/file/query.jsp?customer_ID=<%=rs.getString("funder_ID")%>")><%=exchange.toHtml(rs.getString("funder"))%></div>',
<%}else{if(rs.getString("funder").equals("本单位")){%>
'<%=exchange.toHtml(rs.getString("funder"))%>',
<%}else{%>
'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../hr/file/query.jsp?human_ID=<%=rs.getString("funder_ID")%>")><%=exchange.toHtml(rs.getString("funder"))%></div>', 
<%}}}else 
if(rs.getString("funder").equals("")&&!rs.getString("chain_name").equals("")){%>
'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../hr/config/file/fileKind_details.jsp?chain_ID=<%=rs.getString("chain_ID")%>")><%=exchange.toHtml(rs.getString("chain_name"))%></div>',
<%}%> '<%=exchange.toHtml(finish_time)%>','<%=exchange.toHtml(rs.getString("apply_ID_group"))%>','<%=exchange.toHtml(rs.getString("currency_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("demand_cost_price_sum"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("executed_cost_price_sum"))%>'

],
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