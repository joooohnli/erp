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
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<script type="text/javascript" src="../../../javascript/include/div/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/qcs/config/publics/qualityBasis.js"></script>

<body>
<form method="post" action="strategyClass_delete_getPara.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td></td>
</tr>
</table>
<% 
 String sql = "select * from qcs_config_sample_code order by id";
String sql_search=sql;

int k=1;

%>

<%@include file="../../../include/list_page.jsp"%>
 <%
  ResultSet rs = qcs_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","编号")%>'},
                       {name: '<%=demo.getLang("erp","下限")%>'},
                       {name: '<%=demo.getLang("erp","上限")%>'},
                       {name: '<%=demo.getLang("erp","特殊检验水平I")%>'},
                       {name: '<%=demo.getLang("erp","特殊检验水平II")%>'},
                       {name: '<%=demo.getLang("erp","特殊检验水平III")%>'},
                       {name: '<%=demo.getLang("erp","特殊检验水平IIII")%>'},
                       {name: '<%=demo.getLang("erp","一般检验水平I")%>'},
                       {name: '<%=demo.getLang("erp","一般检验水平II")%>'},
                       {name: '<%=demo.getLang("erp","一般检验水平III")%>'}
]
nseer_grid.column_width=[40,100,100,100,100,100,100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","编号")%>';
nseer_grid.data = [
<%
while(rs.next()){
%>
	['<%=exchange.toHtml(rs.getString("type_id"))%>','<%=exchange.toHtml(rs.getString("min"))%>','<%=exchange.toHtml(rs.getString("max"))%>','<%=exchange.toHtml(rs.getString("slevel1"))%>','<%=exchange.toHtml(rs.getString("slevel2"))%>','<%=exchange.toHtml(rs.getString("slevel3"))%>','<%=exchange.toHtml(rs.getString("slevel4"))%>','<%=exchange.toHtml(rs.getString("clevel1"))%>','<%=exchange.toHtml(rs.getString("clevel2"))%>','<%=exchange.toHtml(rs.getString("clevel3"))%>'],
<%}%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
<%qcs_db.close();%>
 </form> 
</body>

