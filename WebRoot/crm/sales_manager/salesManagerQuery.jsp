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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<%@include file="../include/head_list.jsp"%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_file.xml"/>
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
String sales_ID=(String)session.getAttribute("sales_ID");
String tablename="crm_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="sales_ID='"+sales_ID+"' and check_tag='1' and gar_tag='0'";
String queue="";
String validationXml="../../xml/crm/crm_file.xml";
String nickName="客户档案";
String fileName="salesManagerQuery.jsp";
String rowSummary=demo.getLang("erp","符合条件的客户档案总数");
%>
 <%@include file="../../include/search.jsp"%>
<%
ResultSet rs = crm_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","客户编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","优质级别")%>'},
                       {name: '<%=demo.getLang("erp","客户分类")%>'},
	                   {name: '<%=demo.getLang("erp","客户类型")%>'},				   
					   {name: '<%=demo.getLang("erp","联系人")%>'}
]
nseer_grid.column_width=[160,100,70,200,100,70];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">

['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?customer_ID=<%=rs.getString("customer_ID")%>")><%=rs.getString("customer_ID")%></div>','<%=exchange.toHtml(rs.getString("customer_name"))%>','<%=exchange.toHtml(rs.getString("customer_class"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=exchange.toHtml(rs.getString("type"))%>','<%=exchange.toHtml(rs.getString("contact_person1"))%>'],
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
crm_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>