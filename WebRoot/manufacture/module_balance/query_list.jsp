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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_module_balance.xml"/>
<% 
try{
String tablename="manufacture_module_balance";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table> 
<script src="../../javascript/table/movetable.js"></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<%
String realname=(String)session.getAttribute("realeditorc");
String condition="excel_tag='2' and gar_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/manufacture/manufacture_module_balance.xml";
String nickName="物料申领退回";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的物料申领/退回总数：");
int k=1;
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = manufacture_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(manufacture_ID,procedure_ID,procedure_name,register_time1,register_time2){
var register_time=register_time1+' '+register_time2;
var link1='query.jsp?manufacture_ID='+manufacture_ID+'&&procedure_ID='+procedure_ID+'&&procedure_name='+procedure_name+'&&register_time='+register_time;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","生产派工单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","工序名称")%>'},
                       {name: '<%=demo.getLang("erp","负责人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","申领/退回物料总额")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[40,180,180,180,70,70,160,160,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
	<%	
String check_tag="";
String color="#FF9A31";
if(rs1.getString("check_tag").equals("0")){
check_tag="等待审核";
}else if(rs1.getString("check_tag").equals("1")){
check_tag="审核通过";
color="3333FF";
}
%>
['<%if(check_tag.equals("审核通过")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs1.getString("manufacture_ID")%>","<%=rs1.getString("procedure_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("procedure_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("register_time").substring(0,rs1.getString("register_time").indexOf(" "))))%>","<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("register_time").substring(rs1.getString("register_time").indexOf(" ")+1)))%>")><%=rs1.getString("manufacture_ID")%></div>','<%=rs1.getString("product_ID")%>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=exchange.toHtml(rs1.getString("procedure_name"))%>','<%=exchange.toHtml(rs1.getString("procedure_responsible_person"))%>','<%=exchange.toHtml(rs1.getString("register_time"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("module_cost_price_sum"))%>','<span style="color:<%=color%>"><%=check_tag%></span>'],
<% k++;%>
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
manufacture_db.close();	
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>