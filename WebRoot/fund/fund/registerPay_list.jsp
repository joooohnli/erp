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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
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
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js"></script>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String fund_ID=request.getParameter("fund_ID");
if(fund_ID==null) fund_ID="";
String tablename="fund_fund";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2' and fund_pre_tag='0' and fund_execute_tag='0' and qcs_dealwith_tag='1' and reason='付款'";
String queue="order by funder,reason,register_time";
String validationXml="../../xml/fund/fund_fund.xml";
String nickName="付款执行单";
String fileName="registerPay_list.jsp";
String rowSummary=demo.getLang("erp","当前等待调度的付款计划单总数");
%>
<form id="register_list" method="post" action="registerPay.jsp">
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs = fund_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","制定")+"\">";
%>
<%@include file="../../include/search_top.jsp"%>
<%
double cost_price_sum=0.0d;
while(rs.next()){
	cost_price_sum+=rs.getDouble("demand_cost_price_sum");
}
if(sql_search.indexOf("limit")!=-1){sql_search=sql_search.substring(0,sql_search.indexOf("limit"));};
rs = fund_db.executeQuery(sql_search) ;
%>
<input type="hidden" name="fund_ID" value="<%=fund_ID%>">

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","点选")%>'},
                       {name: '<%=demo.getLang("erp","收款人")%>'},
                       {name: '<%=demo.getLang("erp","理由")%>'},
	                   {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","科目")%>'},
					   {name: '<%=demo.getLang("erp","金额")%>'},
					   {name: '<%=demo.getLang("erp","币种")%>'}
]
nseer_grid.column_width=[40,160,160,140,200,100,70];
nseer_grid.auto='<%=demo.getLang("erp","收款人")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String color="#000000";
String color1="";
if(rs.getString("remind_gather_tag").equals("1")){
color1="red";
}else{
color1="#000000";
}
%>

['<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="choice" value="<%=rs.getString("id")%>">',
<%if(!rs.getString("funder").equals("")){%>
 '<span style="color:<%=color1%>"><input type="hidden" name="funder_ID" value="<%=rs.getString("funder_ID")%>"><%=exchange.toHtml(rs.getString("funder"))%></span>'
<%}else if(rs.getString("funder").equals("")&&!rs.getString("chain_name").equals("")){%>
 '<span style="color:<%=color1%>"><input type="hidden" name="chain_ID" value="<%=rs.getString("chain_ID")%>"><%=exchange.toHtml(rs.getString("chain_name"))%></span>'
<%}%>,
<%
if(rs.getString("file_chain_name").indexOf("应收账款")!=-1){
%>
 '<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../crm/order/query.jsp?order_ID=<%=rs.getString("reasonexact")%>")><span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("reasonexact"))%></span></div>'
<%}else if(rs.getString("file_chain_name").indexOf("应付账款")!=-1){
	if(rs.getString("file_chain_name").indexOf("委外加工费")==-1){
	if(rs.getString("file_chain_name").indexOf("配送费")==-1){
	%>
 '<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../purchase/purchase/query.jsp?purchase_ID=<%=rs.getString("reasonexact")%>")><span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("reasonexact"))%></span></div>'
<%}else{%>
'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../logistics/logistics/query.jsp?logistics_ID=<%=rs.getString("reasonexact")%>")><span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("reasonexact"))%></span></div>'
<%}}else{%>
 '<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../intrmanufacture/intrmanufacture/query.jsp?intrmanufacture_ID=<%=rs.getString("reasonexact")%>")><span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("reasonexact"))%></span></div>'
<%}}else if(rs.getString("file_chain_name").indexOf("工资")!=-1){%>
 '<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../../hr/salary/query.jsp?salary_id=<%=rs.getString("reasonexact")%>")><span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("reasonexact"))%></span></div>'
<%}else{%>
 '<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../apply_pay_expenses/query.jsp?apply_pay_ID=<%=rs.getString("reasonexact")%>")><span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("reasonexact"))%></span></div>'
<%}%>,
'<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("register_time"))%></span>','<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("file_chain_name"))%></span>','<span style="color:<%=color1%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("demand_cost_price_sum"))%></span>','<span style="color:<%=color1%>"><%=exchange.toHtml(rs.getString("currency_name"))%></span>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
</form>
<%@include file="../../include/search_bottom.jsp"%>

<%fund_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>