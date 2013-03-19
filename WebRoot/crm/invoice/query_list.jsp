
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
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>
<% 
String tablename="crm_order";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js"></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/crm/invoice/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<%
String realname=(String)session.getAttribute("realeditorc");
String condition="invoice_tag!='0' and invoice_gar_tag='0' and gar_tag='0' and excel_tag='2'";
String queue="order by check_time desc";
String validationXml="../../xml/crm/crm_order.xml";
String nickName="销售订单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的订单总数");
int k=1;
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = crm_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","强制完成")+"\" onclick=\"showCompulsion(document.getElementById('rows_num').value,'"+tablename+"');\">"+DgButton.getGar(tablename,request);
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
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","订单编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","开票状态")%>'},
                       {name: '<%=demo.getLang("erp","应开票额度")%>'},
					   {name: '<%=demo.getLang("erp","未开票额度")%>'},
                       {name: '<%=demo.getLang("erp","已开票额度")%>'}
]
nseer_grid.column_width=[40,180,200,70,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%	
String invoice_tag="";
String order_tag=demo.getLang("erp","等待");
String color="#FF9A31";
if(rs1.getString("invoice_tag").equals("1")){
invoice_tag=demo.getLang("erp","等待");
}else if(rs1.getString("invoice_tag").equals("2")){
invoice_tag=demo.getLang("erp","执行");
color="mediumseagreen";
}else if(rs1.getString("invoice_tag").equals("3")){
invoice_tag=demo.getLang("erp","完成");
color="#3333FF";
}
if(rs1.getString("order_tag").equals("1")){
order_tag=demo.getLang("erp","执行");

}else if(rs1.getString("order_tag").equals("2")){
order_tag=demo.getLang("erp","完成");

}else if(rs1.getString("order_tag").equals("3")){
order_tag=demo.getLang("erp","强制完成");
}
%>	
['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>⊙<%=rs1.getString("invoice_tag")%>" style="height:10">','<span style="color:<%=color%>" ><%=rs1.getString("order_ID")%></span>','<span style="color:<%=color%>" ><%=exchange.toHtml(rs1.getString("customer_name"))%></span>','<span style="color:<%=color%>" ><%=invoice_tag%></span>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("sale_price_sum"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("uninvoice_sum"))%>',<%if(rs1.getDouble("invoiced_sum")!=0&&rs1.getString("order_type").equals("订单")){%>'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query_details.jsp?reasonexact=<%=rs1.getString("order_ID")%>")><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("invoiced_sum"))%></div>'<%}else{%>'<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("invoiced_sum"))%>'<%}%>],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%	
crm_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>