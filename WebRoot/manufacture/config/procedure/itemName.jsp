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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<form method="post" action="itemName_delete_getPara.jsp">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">
<div <%=DIV_STYLE1%> class="DIV_STYLE1">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","添加")%>" onClick=location="itemName_register.jsp">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","删除")%>"></div></td>
</tr>
</table>

<% 
String sql = "select * from manufacture_config_public_char where kind='工序' order by type_ID";
String sql_search=sql;
%>
<%@include file="../../../include/list_page.jsp"%>
<%
ResultSet rs = manufacture_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","工序项目编号")%>'},
                       {name: '<%=demo.getLang("erp","工序项目名称")%>'},
                       {name: '<%=demo.getLang("erp","工序项目描述")%>'},
	                   {name: '<%=demo.getLang("erp","负责人编号")%>'},
                       {name: '<%=demo.getLang("erp","变更")%>'}
                  ]
nseer_grid.column_width=[40,100,100,100,180,70];
nseer_grid.auto='<%=demo.getLang("erp","工序项目描述")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
	['<input type="checkbox" name="<%=k%>" value="<%=rs.getString("id")%>" style="height:10">','<%=rs.getString("type_ID")%>','<%=exchange.toHtml(rs.getString("type_name"))%>','<%=rs.getString("describe1")%>','<%=rs.getString("register_ID")%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("itemName_change.jsp?id=<%=rs.getString("id")%>")><%=demo.getLang("erp","变更")%></div>'],
<%
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
</form>
<%manufacture_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="itemName.jsp"/>