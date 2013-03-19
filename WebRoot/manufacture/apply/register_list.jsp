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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_pay.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String tablename="stock_pay";
String realname=(String)session.getAttribute("realeditorc");
String condition="(reason='销售出库' or reason='部件出库' or reason='销售赊货') and manufacture_apply_tag='0' and demand_amount!='0' and pay_tag!='2'";
String queue="order by register_time";
String validationXml="../../xml/stock/stock_pay.xml";
String nickName="出库单";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","当前等待生产的出库单总数：");
%>
<%@include file="../../include/search.jsp"%>
 <%
try{
String register_ID=(String)session.getAttribute("human_IDD");
ResultSet rs = stock_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","制定计划")+"\">";
%>
<form method="post" action="register.jsp">
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
					   {name: '<%=demo.getLang("erp","点选")%>'},
                       {name: '<%=demo.getLang("erp","出库单编号")%>'},
                       {name: '<%=demo.getLang("erp","出库理由")%>'},
                       {name: '<%=demo.getLang("erp","出库详细理由")%>'},
	                   {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","总件数")%>'},
	                   {name: '<%=demo.getLang("erp","总金额（元）")%>'},
	                   {name: '<%=demo.getLang("erp","确认生产数量")%>'}
]
nseer_grid.column_width=[40,180,70,200,160,70,100,100];
nseer_grid.auto='<%=demo.getLang("erp","出库详细理由")%>';
nseer_grid.data = [
<%
String pay_ID="";
%>
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String color="#000000";
pay_ID=rs.getString("pay_ID");
if(rs.getString("apply_manufacture_amount_tag").equals("1")){
	color="#0099cc";
}
if(rs.getString("pay_ID").indexOf("part")!=-1){
	pay_ID=rs.getString("pay_ID").substring(0,rs.getString("pay_ID").indexOf("part"));
}
%>
	['<input type="checkbox" name="choice" value="<%=rs.getString("pay_ID")%>"','<span style="color:<%=color%>"><%=pay_ID%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("reason"))%></span>',
	<%if(!rs.getString("reasonexact_details").equals("")){%>'<span style="color:<%=color%>"><%=rs.getString("reasonexact")%>-<%=exchange.toHtml(rs.getString("reasonexact_details"))%></span>',<%}else{%>'<span style="color:<%=color%>"><%=rs.getString("reasonexact")%></span>',<%}%>'<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("register_time"))%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("demand_amount"))%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%></span>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("register_change_pay.jsp?pay_ID=<%=rs.getString("pay_ID")%>")><%=demo.getLang("erp","确认生产数量")%></div>'
	],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
</form>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
stock_db.close();
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>