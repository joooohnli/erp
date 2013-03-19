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
<%nseer_db document_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>

<form method="post" action="commonPage_delete_getPara.jsp">

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","添加")%>" onClick=location="commonPage_register.jsp">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","删除")%>"></div></td>
</tr>
</table>
<% 
 String sql = "select * from ecommerce_web_template_ii order by ID";
 
String sql_search=sql;
int k=1;
%>


<%@include file="../../../include/list_page.jsp"%>
<%
  ResultSet rs = document_db.executeQuery(sql) ;
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
                    {name: '<%=demo.getLang("erp","模版图样")%>'},
                    {name: '<%=demo.getLang("erp","模版名称")%>'},
                    {name: '<%=demo.getLang("erp","模版文件")%>'},
                    {name: '<%=demo.getLang("erp","登记人")%>'},
                    {name: '<%=demo.getLang("erp","登记时间")%>'}
] 
nseer_grid.column_width=[40,100,150,150,150,150];
nseer_grid.auto='<%=demo.getLang("erp","模版图样")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 

	['<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name=<%=k%> value=<%=rs.getString("id")%>>','<img src="../../commonPage_template/<%=rs.getString("attachment1")%>" width="50" height="50" hspace="1">','<%=exchange.toHtml(rs.getString("topic"))%>','<%=rs.getString("filename")%>','<%=exchange.toHtml(rs.getString("register"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>'],
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
<%document_db.close();%>
 </form>
<page:updowntag num="<%=intRowCount%>" file="commonPage.jsp"/>