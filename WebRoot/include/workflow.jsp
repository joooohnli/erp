<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
String sql = "select id,type_id,describe1,describe2 from "+workflow_table+" where type_id='"+type_id+"' order by id";
String sql_search=sql;
int k=1;
int i=1;

%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
</tr>
</table>
<%@include file="../../../include/list_page.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","审核流程")%>'},
                       {name: '<%=demo.getLang("erp","审核人编号")%>'},
                       {name: '<%=demo.getLang("erp","审核人姓名")%>'},
                       {name: '<%=demo.getLang("erp","变更")%>'}
]
nseer_grid.column_width=[80,180,180,70];
nseer_grid.auto='<%=demo.getLang("erp","审核人编号")%>';
nseer_grid.data = [
<%
ResultSet rs = qcs_db.executeQuery(sql) ;	
while(rs.next()){
	String choice="审核流程"+i;
	i++;
	%> ['<%=demo.getLang("erp",choice)%>','<%=rs.getString("describe1")%>','<%=exchange.toHtml(rs.getString("describe2"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("<%=change_file%>?id=<%=rs.getString("id")%>&type_id=<%=rs.getString("type_id")%>")><%=demo.getLang("erp","变更")%></div>'],
<%
k++;
}
%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
<%qcs_db.close();%>