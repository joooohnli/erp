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
<%nseer_db purchase_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_apply_gather.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <%
String tablename="stock_apply_gather";
String realname=(String)session.getAttribute("realeditorc");
String queue="order by register_time";
String condition="gatherer_type='采购放货' and check_tag='0' and excel_tag='2'";
String validationXml="../../xml/stock/stock_apply_gather.xml";
String nickName="申请单";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的申请单总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from purchase_config_workflow where type_id='07'";
ResultSet rs=purchase_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
sql = "select * from stock_apply_gather where gatherer_type='采购放货' and check_tag='0' and excel_tag='2' order by register_time" ;
rs = purchase_db1.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(provider_ID,provider_name,purchaser_ID,purchaser,purchasecredit_cost_price_sum){ 
 var link1='query_getpara.jsp?provider_ID='+provider_ID+'&&provider_name='+provider_name+'&&purchaser_ID='+purchaser_ID+'purchaser='+purchaser+'&&purchasecredit_cost_price_sum='+purchasecredit_cost_price_sum;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","申请单编号")%>'},
                       {name: '<%=demo.getLang("erp","放货人")%>'},
                       {name: '<%=demo.getLang("erp","采购人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","归还时间")%>'},
	                   {name: '<%=demo.getLang("erp","总件数")%>'},
	                   {name: '<%=demo.getLang("erp","总金额（元）")%>'},	                   
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
nseer_grid.column_width=[180,150,100,160,100,100,100,<%for(int i=1;i<workflow_amount;i++){%>70,<%}%>70];
nseer_grid.auto='<%=demo.getLang("erp","放货人")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String demand_return_time="";
if(rs.getString("demand_return_time").equals("1800-01-01 00:00:00.0")){
demand_return_time="";
}else{
demand_return_time=rs.getString("demand_return_time");
}
String sql1="select id from purchase_workflow where object_ID='"+rs.getString("gather_ID")+"' and check_tag='0'";
ResultSet rs2=purchase_db.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from purchase_workflow where object_ID='"+rs.getString("gather_ID")+"' order by id";
	rs2=purchase_db.executeQuery(sql1);
%>
['<%=rs.getString("gather_ID")%>','<%=exchange.toHtml(rs.getString("gatherer_name"))%>','<%=exchange.toHtml(rs.getString("purchaser"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>','<%=exchange.toHtml(demand_return_time)%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("demand_amount"))%>',' <%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>'
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
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?gather_ID=<%=rs.getString("gather_ID")%>&config_ID=<%=rs2.getString("config_ID")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%	
purchase_db.close();
purchase_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>