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
<%nseer_db draft_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>

<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String sql1="";
String chain_group=Responsible.getString(draft_db,"crm_config_file_kind",register_ID);
String tablename="crm_order";
String realname=(String)session.getAttribute("realeditorc");
String condition="(check_tag='5' or check_tag='9')";
String queue="order by register_time desc";
String validationXml="../../input_control/validation-config.xml";
String validationXml1="input_control/validation-config.xml";
String nickName="销售订单";
String fileName="order_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的销售订单总数");
int k=1;
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs=draft_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
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
                       {name: '<%=demo.getLang("erp","销售人")%>'},
                       {name: '<%=demo.getLang("erp","电话")%>'},
					   {name: '<%=demo.getLang("erp","预提货时间")%>'},
                       {name: '<%=demo.getLang("erp","客户类型")%>'},
                       {name: '<%=demo.getLang("erp","销售总额")%>'},
                       {name: '<%=demo.getLang("erp","登记")%>'}
                      ]
nseer_grid.column_width=[40,180,100,100,100,100,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
	<%
String color="#000000";
String demand_pay_time="";
demand_pay_time=rs.getString("demand_pay_time");
if(rs.getString("order_ID").indexOf("T")!=-1){
	color="#cc0099";
}
if(chain_group.indexOf(","+rs.getString("chain_id")+",")!=-1){ 
%>
['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10">','<span style="color:<%=color%>"><%=rs.getString("order_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("customer_name"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("sales_name"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(demand_pay_time)%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("type"))%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%></span>',
<%if(rs.getString("check_tag").equals("9")){%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("order.jsp?order_ID=<%=rs.getString("order_ID")%>")><%=demo.getLang("erp","重新登记")%></div>'
<%}else{%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("order.jsp?order_ID=<%=rs.getString("order_ID")%>")><%=demo.getLang("erp","继续登记")%></div>'
<%
}
k++;
%>
],
<%
}else{
%>
['','<%=demo.getLang("erp","非责任人")%>','','','','','','',''],
<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%@include file="../../include/search_bottom.jsp"%>

<%draft_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>