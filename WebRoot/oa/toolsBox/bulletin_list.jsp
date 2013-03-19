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
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/oa/oa_message.xml"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<% 
	 demo.setPath(request);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=demo.getLang("erp","恩信科技开源ERP")%></title>


 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=demo.getLang("erp","我的公告")%></div></td>
 </tr>
 </table>
<%
String tablename="oa_message";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='2'";
String queue="order by register_time desc";
String validationXml="../../xml/oa/oa_message.xml";
String nickName="群发对象";
String fileName="bulletin_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的内部公告总数：");
String status="";
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs=oa_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","主题")%>'},
                       {name: '<%=demo.getLang("erp","分类")%>'},
                       {name: '<%=demo.getLang("erp","内容")%>'},
					   {name: '<%=demo.getLang("erp","公告详情")%>'}
]
nseer_grid.column_width=[100,100,70,70];
nseer_grid.auto='<%=demo.getLang("erp","内容")%>';
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
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%oa_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>