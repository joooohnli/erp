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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db manufacture_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_module_balance.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="manufacture_module_balance";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2'";
String queue="order by register_time";
String validationXml="../../xml/manufacture/manufacture_module_balance.xml";
String nickName="生产计划";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的物料申领/退回登记总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from manufacture_config_workflow where type_id='05'";
ResultSet rs=manufacture_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
rs = manufacture_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(manufacture_ID,procedure_ID,procedure_name,register_time1,register_time2,config_id,module_time){
var register_time=register_time1+' '+register_time2;
var link1='check.jsp?manufacture_ID='+manufacture_ID+'&&procedure_ID='+procedure_ID+'&&procedure_name='+procedure_name+'&&register_time='+register_time+'&&config_id='+config_id+'&&module_time='+module_time;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","生产派工单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
	                   {name: '<%=demo.getLang("erp","工序名称")%>'},
                       {name: '<%=demo.getLang("erp","负责人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","申领/退回物料总额")%>'},
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
nseer_grid.column_width=[180,180,160,100,70,160,140,
<%
for(int i=1;i<workflow_amount;i++){
%>					   70,
<%
}
%> 
                           70
	];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
	<%
String register_time="";
if(rs.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rs.getString("register_time");
}

String sql1="select id from manufacture_workflow where object_ID='"+rs.getString("manufacture_ID")+"' and check_tag='0' and type_id='05' and module_time='"+rs.getString("module_time")+"' and procedure_ID='"+rs.getString("procedure_ID")+"'";

ResultSet rs2=manufacture_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id,module_time from manufacture_workflow where object_ID='"+rs.getString("manufacture_ID")+"' and type_id='05' and module_time='"+rs.getString("module_time")+"' and procedure_ID='"+rs.getString("procedure_ID")+"' order by id";

	rs2=manufacture_db1.executeQuery(sql1);
%>
	['<%=rs.getString("manufacture_ID")%>','<%=rs.getString("product_ID")%>','<%=exchange.toHtml(rs.getString("product_name"))%>','<%=exchange.toHtml(rs.getString("procedure_name"))%>','<%=exchange.toHtml(rs.getString("procedure_responsible_person"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("module_cost_price_sum"))%>'
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
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs.getString("manufacture_ID")%>","<%=rs.getString("procedure_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("procedure_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("register_time").substring(0,rs.getString("register_time").indexOf(" "))))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("register_time").substring(rs.getString("register_time").indexOf(" ")+1)))%>","<%=rs2.getString("config_id")%>","<%=rs2.getString("module_time")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%
}
%>
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
manufacture_db.close();
manufacture_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>