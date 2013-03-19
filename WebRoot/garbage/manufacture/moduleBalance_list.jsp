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
<jsp:useBean id="query" scope="page" class="include.excel_export.excel"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_module_balance.xml"/>

<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/garReconfirm.js"></script>

<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String tablename="manufacture_module_balance";
String realname=(String)session.getAttribute("realeditorc");
String condition="(check_tag='2' or gar_tag='1')";
String queue="order by register_time desc";
String validationXml="../../input_control/validation-config.xml";
String validationXml1="input_control/validation-config.xml";
String nickName="物料申领/退回登记单";
String fileName="moduleBalance_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的物料申领/退回登记单总数");
int k=1;
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>

 <%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs=design_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","转入草稿箱")+"\" onclick=\"showDraDiv(document.getElementById('rows_num').value,'"+tablename+"');\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","永久删除")+"\" onclick=\"showDeleteDiv(document.getElementById('rows_num').value,'"+tablename+"');\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","还原")+"\" onclick=\"showRecovery(document.getElementById('rows_num').value,'"+tablename+"');\">";
%>
 <%@include file="../../include/search_top.jsp"%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(manufacture_ID,procedure_ID,procedure_name,register_time1,register_time2){
var register_time=register_time1+' '+register_time2;
var link1='../../manufacture/module_balance/query.jsp?manufacture_ID='+manufacture_ID+'&&procedure_ID='+procedure_ID+'&&procedure_name='+procedure_name+'&&register_time='+register_time;
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
                       {name: '<%=demo.getLang("erp","申领/退回物料总额")%>'}
]
nseer_grid.column_width=[40,180,180,100,100,100,200];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [

<%while(rs.next()){%>

['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10">','<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs.getString("manufacture_ID")%>","<%=rs.getString("procedure_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("procedure_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("register_time").substring(0,rs.getString("register_time").indexOf(" "))))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("register_time").substring(rs.getString("register_time").indexOf(" ")+1)))%>")><%=rs.getString("manufacture_ID")%></div>','<%=rs.getString("product_ID")%>','<%=exchange.toHtml(rs.getString("product_name"))%>','<%=exchange.toHtml(rs.getString("procedure_name"))%>','<%=exchange.toHtml(rs.getString("procedure_responsible_person"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("module_cost_price_sum"))%>'],
<%
k++;}
%>
['']];

nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<input type="hidden" id="gar_recovery_tag" value="check_tag='2'">
<input type="hidden" id="field1" value="manufacture_id">
<input type="hidden" id="gar_tag" value="gar_tag='1'">
<input type="hidden" id="field" value="manufacture_id">
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<%design_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
}catch(Exception ex){ex.printStackTrace();}
%>
