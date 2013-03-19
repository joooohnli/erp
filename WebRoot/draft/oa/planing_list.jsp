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
<jsp:useBean id="query" scope="page" class="include.excel_export.excel"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db oa_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/oa/oa_planing.xml"/>

<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String tablename="oa_planing";
String realname=(String)session.getAttribute("realeditorc");
String condition="(check_tag='5' or check_tag='9')";
String queue="order by register_time desc";
String validationXml="../../input_control/validation-config.xml";
String validationXml1="input_control/validation-config.xml";
String nickName="计划";
String fileName="planing_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的计划草稿总数");
int k=1;
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs=oa_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
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
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","计划主题")%>'},
                       {name: '<%=demo.getLang("erp","计划类型")%>'},
                       {name: '<%=demo.getLang("erp","开始时间")%>'},
					   {name: '<%=demo.getLang("erp","结束时间")%>'},
					   {name: '<%=demo.getLang("erp","制定")%>'}
	]
nseer_grid.column_width=[40,180,180,180,100,70];
nseer_grid.auto='<%=demo.getLang("erp","计划主题")%>';
nseer_grid.data = [    	

<page:pages rs="<%=rs%>" strPage="<%=strPage%>">

['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10">','<%=exchange.toHtml(rs.getString("subject"))%>','<%=exchange.toHtml(rs.getString("type"))%>','<%=exchange.toHtml(rs.getString("begin_time"))%>','<%=exchange.toHtml(rs.getString("end_time"))%>',
<%if(rs.getString("check_tag").equals("9")){%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("planing.jsp?planing_ID=<%=rs.getString("planing_ID")%>")><%=demo.getLang("erp","重新制定")%></div>'
<%}else{%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("planing.jsp?planing_ID=<%=rs.getString("planing_ID")%>")><%=demo.getLang("erp","继续制定")%></div>'
<%}%>
],
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
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>

<%oa_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
}catch(Exception ex){ex.printStackTrace();}
%>
