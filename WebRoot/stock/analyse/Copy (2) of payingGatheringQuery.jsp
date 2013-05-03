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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_paying_gathering.xml"/>
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
String product_ID=(String)session.getAttribute("product_ID");
String tablename="stock_paying_gathering";
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition="demand_amount!='0' and product_id='"+product_ID+"'";
String queue="order by register_time";
String validationXml="../../xml/stock/stock_paying_gathering.xml";
String nickName="出入库记录";
String fileName="payingGatheringQuery.jsp";
String rowSummary=demo.getLang("erp","符合条件的出入库记录：");
int k=1;
double balance_amount=0.0d;

%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1= stock_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","返回")+"\" onClick=\"history.back()\">";
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
                       {name: '<%=demo.getLang("erp","入库/出库")%>'},
                       {name: '<%=demo.getLang("erp","入库单号")%>'},
                       {name: '<%=demo.getLang("erp","出库单号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
					   {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","时间")%>'},
					   {name: '<%=demo.getLang("erp","入库数量")%>'},
                       {name: '<%=demo.getLang("erp","出库数量")%>'},
					   {name: '<%=demo.getLang("erp","库存数量")%>'}
]
nseer_grid.column_width=[70,180,180,70,180,160,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
	['<%=rs1.getString("paying_or_gathering")%>',
	
<%if(rs1.getString("paying_or_gathering").equals("入库")){
	balance_amount+=rs1.getDouble("amount");
		%>
'<%=rs1.getString("gather_ID")%>','','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=rs1.getString("product_ID")%>','<%=exchange.toHtml(rs1.getString("register_time"))%>','<%=rs1.getDouble("amount")%>','','<%=balance_amount%>'
<%}else{
	balance_amount=balance_amount-rs1.getDouble("amount");
%>
'','<%=rs1.getString("pay_ID")%>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=rs1.getString("product_ID")%>','<%=exchange.toHtml(rs1.getString("register_time"))%>','','<%=rs1.getDouble("amount")%>','<%=balance_amount%>'
		<%}%>
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
<%
stock_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>