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
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String tablename="crm_order";
String realname=(String)session.getAttribute("realeditorc");
String condition="(invoice_tag='1' or invoice_tag='2') and invoice_check_tag='0'";
String queue="order by check_time";
String validationXml="../../xml/crm/crm_order.xml";
String nickName="销售订单";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","当前等待登记发票信息的订单总数");
%>
 <%@include file="../../include/search.jsp"%>
<%
ResultSet rs = crm_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","订单编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","电话")%>'},
                       {name: '<%=demo.getLang("erp","预提货时间")%>'},
					   {name: '<%=demo.getLang("erp","销售人")%>'},
                       {name: '<%=demo.getLang("erp","销售总额")%>'},
                       {name: '<%=demo.getLang("erp","登记")%>'}
]
nseer_grid.column_width=[180,200,70,100,70,100,70];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String demand_pay_time="";
demand_pay_time=rs.getString("demand_pay_time");
%>	
['<%=rs.getString("order_ID")%>','<%=exchange.toHtml(rs.getString("customer_name"))%>','<%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>','<%=exchange.toHtml(demand_pay_time)%>','<%=exchange.toHtml(rs.getString("sales_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("register.jsp?order_ID=<%=rs.getString("order_ID")%>")><%=demo.getLang("erp","登记")%></div>'],
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