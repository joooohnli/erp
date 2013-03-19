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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crm_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String sql1="";
String chain_group=Responsible.getString(crm_db,"crm_config_file_kind",register_ID);
String tablename="crm_order";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2'";
String queue="order by register_time";
String validationXml="../../xml/crm/crm_order.xml";
String nickName="销售订单";
String fileName="check_list1.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的订单总数");
%>
<%@include file="../../include/search.jsp"%>
<%
int workflow_amount=0;
String sql="select count(id) from crm_config_workflow where type_id='04'";
ResultSet rs=crm_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
rs = crm_db.executeQuery(sql_search) ;
if(intRowCount!=0){
	session.setAttribute("task_content","none");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%>  class="TD_STYLE3"><%=demo.getLang("erp","等待审核：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 </table>
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
	<%
for(int i=1;i<workflow_amount;i++){
		String title="流程"+i;
%>
					   {name: '<%=demo.getLang("erp",title)%>'},
<%
}
	String title="流程"+workflow_amount;
%> 
                           {name: '<%=demo.getLang("erp",title)%>'}
]
nseer_grid.column_width=[100,
<%
for(int i=1;i<workflow_amount;i++){
%>					   70,
<%
}
%> 
                           70
	];
nseer_grid.auto='<%=demo.getLang("erp","订单编号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
if(chain_group.indexOf(","+rs.getString("chain_id")+",")!=-1){
String color="#000000";
String demand_pay_time="";
demand_pay_time=rs.getString("demand_pay_time");
if(rs.getString("order_ID").indexOf("T")!=-1){
	color="#cc0099";
} 
sql1="select id from crm_workflow where object_ID='"+rs.getString("order_ID")+"' and check_tag='0' and which_time='0'";
ResultSet rs2=crm_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from crm_workflow where object_ID='"+rs.getString("order_ID")+"' and which_time='0' order by id";
	rs2=crm_db1.executeQuery(sql1);
%>
['<span style="color:<%=color%>"><%=rs.getString("order_ID")%></span>'
<%
for(int i=1;i<=workflow_amount;i++){
	String status="";
	if(rs2.next()){
			if(rs2.getString("check_tag").equals("0")){
			status="无权限";
			}else if(rs2.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs2.getString("check_tag").equals("9")){
			status="未通过";
			}
			if(rs2.getString("check_tag").equals("0")&&rs2.getString("describe1").indexOf(register_ID)!=-1){
%>
,'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("check.jsp?order_ID=<%=rs.getString("order_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%
}}else{
%>
['<%=demo.getLang("erp","非责任人")%>'
<%
for(int i=1;i<=workflow_amount;i++){
%>
,''
<%}%>],
<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%
}else{
%>
<table valign="center">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td><%session.removeAttribute("task_content");%></td>
</tr>
</table>
<%	
}
crm_db.close();
crm_db1.close();
%>