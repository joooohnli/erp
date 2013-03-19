<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_major_release.xml"/>
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
String tablename="hr_major_release";
String realname=(String)session.getAttribute("realeditorc");
String condition="";
String queue="order by register_time";
String validationXml="../../../xml/hr/hr_major_release.xml";
String nickName="职位";
String fileName="change_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的职位发布总数：");
%>
<%@include file="../../../include/search.jsp"%>
 <%
 try{
ResultSet rs= hr_db.executeQuery(sql_search);
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
%>
<%@include file="../../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","职位名称")%>'},
                       {name: '<%=demo.getLang("erp","机构名称")%>'},
                       {name: '<%=demo.getLang("erp","招聘人数")%>'},
                       {name: '<%=demo.getLang("erp","发布时间")%>'},
                       {name: '<%=demo.getLang("erp","截止时间")%>'},
					   {name: '<%=demo.getLang("erp","修改")%>'},
					   {name: '<%=demo.getLang("erp","删除")%>'}
]
nseer_grid.column_width=[100,200,100,160,100,70,70];
nseer_grid.auto='<%=demo.getLang("erp","机构名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String color="#000000";
java.util.Date date = formatter1.parse(rs.getString("deadline"));
if((date.getTime()-now.getTime())<0) color="red";
%>
['<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("human_amount"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>','<span style="color:<%=color%>"><%=rs.getString("deadline")%></span>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("change.jsp?id=<%=rs.getString("id")%>")><%=demo.getLang("erp","修改")%></div>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("change_delete_reconfirm.jsp?id=<%=rs.getString("id")%>")><%=demo.getLang("erp","删除")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/search_bottom.jsp"%>
<%@include file="../../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
hr_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>