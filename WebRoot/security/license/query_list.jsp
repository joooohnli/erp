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

<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>

<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/security/security_license.xml"/>

<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="security_license";
String realname=(String)session.getAttribute("realeditorc");
String condition="human_ID!=''";
String queue="order by register_time desc";
String validationXml="../../xml/security/security_license.xml";
String nickName="许可证";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的许可证总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs = security_db.executeQuery(sql_search) ;
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
					   {name: '<%=demo.getLang("erp","档案编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
                       {name: '<%=demo.getLang("erp","发放时间")%>'},
					   {name: '<%=demo.getLang("erp","有效期限(天)")%>'},
					   {name: '<%=demo.getLang("erp","注册状态")%>'},
					   {name: '<%=demo.getLang("erp","查看")%>'}
]
nseer_grid.column_width=[180,200,100,160,80,70,70];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>">


 <%
String color="#000000";
String enrollment_tag="未注册";
	if(rs.getString("enrollment_tag").equals("1")){
			color="#0099cc";
			enrollment_tag="已注册";
		}
%>

['<span style="color:<%=color%>"><%=rs.getString("human_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("human_name"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("chain_name"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("register_time"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("expiry_period"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(enrollment_tag)%></span>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?id=<%=rs.getString("id")%>&human_ID=<%=rs.getString("human_ID")%>")><span style="color:<%=color%>"><%=demo.getLang("erp","查看")%></span></div>'],
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
security_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>