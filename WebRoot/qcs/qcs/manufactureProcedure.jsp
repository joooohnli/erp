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
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_manufacture.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
try{
String tablename="manufacture_manufacture";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and excel_tag='2' and manufacture_tag='0' and qcs_apply_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/manufacture/manufacture_manufacture.xml";
String nickName="生产派工单";
String fileName="manufactureProcedure.jsp";
String rowSummary=demo.getLang("erp","符合条件的生产派工单总数");
%>
 <%@include file="../../include/search.jsp"%>
 <%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
ResultSet rs=qcs_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","生产派工单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","质检调度")%>'}
]
nseer_grid.column_width=[180,180,100,100,180,90];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
 String register_time="";
if(rs.getString("register_time")==null)
 register_time="";
 else{
register_time=rs.getString("register_time");
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../manufacture/manufacture/query.jsp?manufacture_ID=<%=rs.getString("manufacture_ID")%>")><%=rs.getString("manufacture_ID")%></div>','<%=rs.getString("product_id")%>','<%=exchange.toHtml(rs.getString("product_name"))%>','<%=exchange.toHtml(rs.getString("register"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("manufactureProcedure_register.jsp?manufacture_id=<%=rs.getString("manufacture_id")%>&product_id=<%=rs.getString("product_id")%>")><%=demo.getLang("erp","质检调度")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%qcs_db.close();}catch(Exception ex){ex.printStackTrace();}%>