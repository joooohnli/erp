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
<jsp:useBean id="query" scope="page" class="include.query.query_key"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@include file="../include/head1.jsp"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=demo.getLang("erp","川大科技信息化平台")%></title>

<% 
	 demo.setPath(request);
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=demo.getLang("erp","我的公告")%></td>
 </tr>
 </table>
<%
try{
String status="";
String sql = "select * from oa_message where check_tag='2' order by register_time desc";
String sql_search=sql;
%>
<%@include file="../../include/list_page.jsp"%>
 <%
ResultSet rs = oa_db.executeQuery(sql_search);
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3" ><%=demo.getLang("erp","符合条件的内部公告总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
			
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
                       {name: '<%=demo.getLang("erp","主题")%>'},
                       {name: '<%=demo.getLang("erp","分类")%>'},
                       {name: '<%=demo.getLang("erp","内容")%>'},
                       {name: '<%=demo.getLang("erp","公告详情")%>'}
					   ]
nseer_grid.column_width=[150,180,200,200];
nseer_grid.auto='<%=demo.getLang("erp","公告详情")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
  ['<%=exchange.toHtml(rs.getString("subject"))%>','<%=exchange.toHtml(rs.getString("type"))%>','<%=rs.getString("content")%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("bulletin.jsp?message_ID=<%=rs.getString("message_ID")%>")><%=demo.getLang("erp","公告详情")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>  
<%oa_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="bulletin_list.jsp"/>
<%}catch(Exception ex){ex.printStackTrace();}%>