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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<form method="post" action="majorSecondKind_delete_getPara.jsp">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","添加")%>" onClick=location="majorSecondKind_register.jsp">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","删除")%>"><div></td>
</tr>
</table>
<% 
 String sql = "select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 String sql_search=sql;
%>
<%@include file="../../../include/list_page.jsp"%>
<%
 ResultSet rs = hr_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","职位分类编号")%>'},
	                   {name: '<%=demo.getLang("erp","职位分类名称")%>'},
	                   {name: '<%=demo.getLang("erp","职位编号")%>'},
	                   {name: '<%=demo.getLang("erp","职位名称")%>'}
	                   ]
nseer_grid.column_width=[40,100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","职位分类编号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
['<input <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" type="checkbox" name=<%=k%> value=<%=rs.getString("id")%>>','<%=rs.getString("first_kind_ID")%>','<%=exchange.toHtml(rs.getString("first_kind_name"))%>','<%=rs.getString("second_kind_ID")%>','<%=exchange.toHtml(rs.getString("second_kind_name"))%>'],

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
<%hr_db.close();%>
 </form>
<page:updowntag num="<%=intRowCount%>" file="majorSecondKind.jsp"/>

