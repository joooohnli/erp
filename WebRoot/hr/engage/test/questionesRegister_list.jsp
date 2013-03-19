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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_config_major_second_kind.xml"/>
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
String tablename="hr_config_major_second_kind";
String realname=(String)session.getAttribute("realeditorc");
String condition="second_kind_name!=''";
String queue="order by first_kind_ID,second_kind_id";
String validationXml="../../../xml/hr/hr_config_major_second_kind.xml";
String nickName="考试出题";
String fileName="questionesRegister_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的考试出题总数：");
%>
<%@include file="../../../include/search.jsp"%>
<% 
try{
ResultSet rs = hr_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","出题")+"\" onClick=location=\"questionesRegister_locate.jsp\">";
%>
<%@include file="../../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(first_kind_ID,second_kind_ID,first_kind_name,second_kind_name){
var link1='questionesRegister_testPaper_list.jsp?first_kind_ID='+first_kind_ID+'&&second_kind_ID='+second_kind_ID+'&&first_kind_name='+first_kind_name+'&&second_kind_name='+second_kind_name;
document.location.href=link1;
}
function id_link2(first_kind_ID,second_kind_ID,first_kind_name,second_kind_name){
var link2='questionesRegister.jsp?first_kind_ID='+first_kind_ID+'&&second_kind_ID='+second_kind_ID+'&&first_kind_name='+first_kind_name+'&&second_kind_name='+second_kind_name;
document.location.href=link2;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","职位分类编号")%>'},
                       {name: '<%=demo.getLang("erp","职位分类名称")%>'},
                       {name: '<%=demo.getLang("erp","职位编号")%>'},
                       {name: '<%=demo.getLang("erp","职位名称")%>'},
                       {name: '<%=demo.getLang("erp","套题数量")%>'},
					   {name: '<%=demo.getLang("erp","出题")%>'}
]
nseer_grid.column_width=[100,100,100,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","职位分类名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
['<%=rs.getString("first_kind_ID")%>','<%=exchange.toHtml(rs.getString("first_kind_name"))%>','<%=rs.getString("second_kind_ID")%>','<%=exchange.toHtml(rs.getString("second_kind_name"))%>','<div style="text-decoration : underline;color:#3366FF"  onclick=id_link1("<%=rs.getString("first_kind_ID")%>","<%=rs.getString("second_kind_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("first_kind_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("second_kind_name")))%>")><%=toUtf8String.utf8String(exchange.toURL(rs.getString("test_amount")))%></div>',
 '<div style="text-decoration : underline;color:#3366FF"  onclick=id_link2("<%=rs.getString("first_kind_ID")%>","<%=rs.getString("second_kind_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("first_kind_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("second_kind_name")))%>")><%=demo.getLang("erp","出题")%></div>'],
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