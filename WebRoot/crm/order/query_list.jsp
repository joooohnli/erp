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
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/crm/order/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<%
try{
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
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String condition="";
String sql1="";
String chain_group=Responsible.getString(crm_db,"crm_config_file_kind",register_ID);
String realname=(String)session.getAttribute("realeditorc");
String condition0="check_tag!='3' and gar_tag='0' and excel_tag='2'";
String queue="order by register_time desc";
String validationXml="../../xml/crm/crm_order.xml";
String nickName="销售订单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的订单总数");
int k=1;
String condition1="order_tag='0' and gar_tag='0' and excel_tag='2'";
String condition2="order_tag='1' and gar_tag='0' and excel_tag='2'";
String condition3="order_tag='2' and gar_tag='0' and excel_tag='2'";
String condition4="order_tag='3' and gar_tag='0' and excel_tag='2'";
%>
<%@include file="../../include/search_a.jsp"%>
<%
condition=condition1;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount1 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition2;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount2 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition3;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount3 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition4;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount4 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition0;
%>
<%@include file="../../include/search_b.jsp"%>
<%
ResultSet rs1 = crm_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","订单状态")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
                       {name: '<%=demo.getLang("erp","出库状态")%>'},
					   {name: '<%=demo.getLang("erp","配送状态")%>'},
					   {name: '<%=demo.getLang("erp","收货状态")%>'},
					   {name: '<%=demo.getLang("erp","回款状态")%>'},
	                   {name: '<%=demo.getLang("erp","发票状态")%>'}
]
nseer_grid.column_width=[40,180,200,70,70,70,70,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%if(chain_group.indexOf(","+rs1.getString("chain_id")+",")!=-1){%>
<%	
String check_tag="";
String manufacture_tag="";
String pay_tag="";
String logistics_tag="";
String receive_tag="";
String gather_tag="";
String invoice_tag="";
String order_tag=demo.getLang("erp","等待");
String color="#FF9A31";
if(rs1.getString("check_tag").equals("0")&&rs1.getString("modify_tag").equals("0")){
check_tag=demo.getLang("erp","等待");
}else if(rs1.getString("check_tag").equals("0")&&rs1.getString("modify_tag").equals("1")){
check_tag=demo.getLang("erp","执行");
}else if(rs1.getString("check_tag").equals("1")){
check_tag=demo.getLang("erp","完成");
}else if(rs1.getString("check_tag").equals("9")){
check_tag=demo.getLang("erp","未通过");
}
if(rs1.getString("manufacture_tag").equals("1")){
manufacture_tag=demo.getLang("erp","等待");
}else if(rs1.getString("manufacture_tag").equals("2")){
manufacture_tag=demo.getLang("erp","执行");
}else if(rs1.getString("manufacture_tag").equals("3")){
manufacture_tag=demo.getLang("erp","完成");
}
if(rs1.getString("pay_tag").equals("1")){
pay_tag=demo.getLang("erp","等待");
}else if(rs1.getString("pay_tag").equals("2")){
pay_tag=demo.getLang("erp","执行");
}else if(rs1.getString("pay_tag").equals("3")){
pay_tag=demo.getLang("erp","完成");
}
if(rs1.getString("logistics_tag").equals("1")){
logistics_tag=demo.getLang("erp","等待");
}else if(rs1.getString("logistics_tag").equals("2")){
logistics_tag=demo.getLang("erp","执行");
}else if(rs1.getString("logistics_tag").equals("3")){
logistics_tag=demo.getLang("erp","完成");
}
if(rs1.getString("receive_tag").equals("1")){
receive_tag=demo.getLang("erp","等待");
}else if(rs1.getString("receive_tag").equals("2")){
receive_tag=demo.getLang("erp","执行");
}else if(rs1.getString("receive_tag").equals("3")){
receive_tag=demo.getLang("erp","完成");
}
if(rs1.getString("gather_tag").equals("1")){
gather_tag=demo.getLang("erp","等待");
}else if(rs1.getString("gather_tag").equals("2")){
gather_tag=demo.getLang("erp","执行");
}else if(rs1.getString("gather_tag").equals("3")){
gather_tag=demo.getLang("erp","完成");
}
if(rs1.getString("invoice_tag").equals("1")){
invoice_tag=demo.getLang("erp","等待");
}else if(rs1.getString("invoice_tag").equals("2")){
invoice_tag=demo.getLang("erp","执行");
}else if(rs1.getString("invoice_tag").equals("3")){
invoice_tag=demo.getLang("erp","完成");
}
if(rs1.getString("order_tag").equals("1")){
order_tag=demo.getLang("erp","执行");
color="mediumseagreen";
}else if(rs1.getString("order_tag").equals("2")){
order_tag=demo.getLang("erp","完成");
color="3333FF";
}
%>
['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>⊙<%=rs1.getString("order_tag")%>" style="height:10">','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?order_ID=<%=rs1.getString("order_ID")%>")><%=rs1.getString("order_ID")%></div>',' <span style="color:<%=color%>" ><%=exchange.toHtml(rs1.getString("customer_name"))%></span>',
	'<span style="color:<%=color%>"><%=order_tag%></span>',
	'<span style="color:<%=color%>"><%=check_tag%></span>',
	'<span style="color:<%=color%>" ><%=pay_tag%></span>',
	'<span style="color:<%=color%>"><%=logistics_tag%></span>',
	'<span style="color:<%=color%>"><%=receive_tag%></span>',
	'<span style="color:<%=color%>"><%=gather_tag%></span>',
	'<span style="color:<%=color%>"><%=invoice_tag%></span>'],
	<%k++;%>
<%}else{%>
  ['','<%=demo.getLang("erp","非责任人")%>','','','','','','','',''],
<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
crm_db.close();	
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>