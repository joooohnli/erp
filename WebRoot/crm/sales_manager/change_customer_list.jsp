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
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_file.xml"/>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
try{
String tablename="crm_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and gar_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/crm/crm_file.xml";
String nickName="客户档案";
String fileName="change_customer_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的客户档案总数");

String sales_ID="";
String sales_name="";
if(request.getParameter("sales_ID")==null){
	sales_ID=(String)session.getAttribute("sales_ID_search");
}else{
	sales_ID=request.getParameter("sales_ID");
	session.setAttribute("sales_ID_search",sales_ID);
}
if(request.getParameter("sales_name")==null){
	sales_name=(String)session.getAttribute("sales_name_search");
}else{
	sales_name=request.getParameter("sales_name");
	session.setAttribute("sales_name_search",sales_name);
}

String dbase=(String)session.getAttribute("unit_db_name");
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="customer_ID";
String condition2="check_tag='1' and gar_tag='0' and sales_ID='"+sales_ID+"'";
ResultSet rs2=query.queryDB(dbase,tablename,"","","","","","",fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition2,queue,realname);
int intRowCount1=query.intRowCount();
String customer_ID_group="";
%>
<form method="post" action="../../crm_sales_manager_change_customer_ok?sales_ID=<%=sales_ID%>&&sales_name=<%=toUtf8String.utf8String(exchange.toURL(sales_name))%>">
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = crm_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","提交")+"\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","返回")+"\" onclick=location=\"change_list.jsp\">";
%>
<%@include file="../../include/search_top.jsp"%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","其中")%><%=sales_name%><%=demo.getLang("erp","负责的客户为")%>：<%=intRowCount1%><%=demo.getLang("erp","例")%>。</td>
			 <td <%=TD_STYLE3%> class="TD_STYLE3">
			 </td>
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
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","客户编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","优质级别")%>'},
                       {name: '<%=demo.getLang("erp","客户分类")%>'},
					   {name: '<%=demo.getLang("erp","行业")%>'},
                       {name: '<%=demo.getLang("erp","销售人员")%>'}
]
nseer_grid.column_width=[40,160,200,70,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","客户分类")%>';
nseer_grid.data = [
	<%while(rs1.next()){
customer_ID_group+=rs1.getString("customer_ID")+","	;
%>
[
	
	<%if(sales_ID.equals(rs1.getString("sales_ID"))){
	%>'<input type="checkbox" name="choice" style="height:10" value="<%=rs1.getString("customer_ID")%>" checked>'
		<%}else{%>
		'<input type="checkbox" name="choice" value="<%=rs1.getString("customer_ID")%>">'
	<%}%>,
		'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?customer_ID=<%=rs1.getString("customer_ID")%>")><%=rs1.getString("customer_ID")%></div>','<%=exchange.toHtml(rs1.getString("customer_name"))%>','<%=exchange.toHtml(rs1.getString("customer_class"))%>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<%=exchange.toHtml(rs1.getString("sales_name"))%>'
],
	<%}%>
['']];

nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>

<input type=hidden name="customer_ID_group" value="<%=customer_ID_group%>">
</form>
<%@include file="../../include/search_bottom.jsp"%>
<%query.close();
crm_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>