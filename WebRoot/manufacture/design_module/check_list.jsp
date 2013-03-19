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
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_design_procedure.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="manufacture_design_procedure";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and module_gar_tag='0' and design_module_tag='1' and gar_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/manufacture/manufacture_design_procedure.xml";
String nickName="产品工序设计";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","等待审核的工序物料设计单总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from manufacture_config_workflow where type_id='02'";
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
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","工序设计单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
	                   {name: '<%=demo.getLang("erp","设计人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","工时总成本")%>'},
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
nseer_grid.column_width=[180,180,200,70,140,100,
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
String color="#000000";
String sql1="select id from manufacture_workflow where object_ID='"+rs.getString("design_ID")+"' and describe1 like '%"+register_ID+"%' and check_tag='0' and type_id='02'";
ResultSet rs2=manufacture_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from manufacture_workflow where object_ID='"+rs.getString("design_ID")+"' and type_id='02' order by id";
	rs2=manufacture_db1.executeQuery(sql1);
%>
	['<span style="color:<%=color%>"><%=rs.getString("design_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("product_ID"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("product_name"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("designer"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("register_time"))%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%></span>'
<%
for(int i=1;i<=workflow_amount;i++){
	String status="";
	if(rs2.next()){
			if(rs2.getString("check_tag").equals("0")){
			status="未审核";
			}else if(rs2.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs2.getString("check_tag").equals("9")){
			status="未通过";
			}
			if(rs2.getString("check_tag").equals("0")&&rs2.getString("describe1").indexOf(register_ID)!=-1){
			status="未审核";	
%>
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?design_ID=<%=rs.getString("design_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],

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