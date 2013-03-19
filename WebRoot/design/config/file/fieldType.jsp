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
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<form method="post" action="fieldType_delete_getPara.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
</tr>
</table>
<%
String field_type=(String)session.getAttribute("field_type");
String sql="";
if(field_type.equals("0")){
	sql = "select * from design_config_public_char where kind='产品用途' order by id";
}else{
	sql = "select * from design_config_public_char where kind='产品用途' and describe1='1' order by id";
}
  String sql_search=sql;
%>
<%@include file="../../../include/list_page.jsp"%>
 <%
 ResultSet rs = design_db.executeQuery(sql_search) ;
int k=1;
%>

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
                       {name: '<%=demo.getLang("erp","产品用途类型名称")%><a href="fieldType_explain.jsp" target="_blank"><%=demo.getLang("erp","（具体解释）")%></a>'}
]
nseer_grid.column_width=[40,935];
nseer_grid.auto='<%=demo.getLang("erp","产品用途类型名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
	if(rs.getString("type_name").equals("商品")||rs.getString("type_name").equals("物料")||rs.getString("type_name").equals("部件")||rs.getString("type_name").equals("委外部件")||rs.getString("type_name").equals("外购商品")||rs.getString("type_name").equals("服务型产品")||rs.getString("type_name").equals("受托产品")){
%>


	['','<%=exchange.toHtml(rs.getString("type_name"))%>'],<%}else{%>['<input type="checkbox" name="<%=k%>" value="<%=rs.getString("id")%>" style="height:10">','<%=exchange.toHtml(rs.getString("type_name"))%>'],
<%
	}
k++;
%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
<%design_db.close();%>
 </form>
<page:updowntag num="<%=intRowCount%>" file="fieldType.jsp"/> 