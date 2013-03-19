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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<jsp:useBean id="query" scope="page" class="include.query.query_key"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/document/document_multilanguage.xml"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<%
try{
nseer_db document_db=new nseer_db((String)session.getAttribute("unit_db_name"));
String register_ID=(String)session.getAttribute("human_IDD");
String tablename="document_multilanguage";
String realname=(String)session.getAttribute("realeditorc");
String condition="language_tag='0'";
String queue="order by id";
String validationXml="../../xml/document/document_multilanguage.xml";
String nickName="语言配置";
String fileName="query_list.jsp";
String rowSummary="";
%>
<%@include file="../../include/search.jsp"%>
<%
sql_search=sql_search.replace("order by id","order by length('"+keyword+"') / length(name) desc");
ResultSet rs = document_db.executeQuery(sql_search);
int k=1;
nseer_db document_db1=new nseer_db((String)session.getAttribute("unit_db_name"));
String sql10="select * from document_config_public_char where kind='语言类型'";
ResultSet rs10=document_db1.executeQuery(sql10);
int t=0;
while(rs10.next()){t++;}
rs10.first();
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
                       {name: '<%=demo.getLang("erp","组名")%>'},
					   {name: '<%=demo.getLang("erp","单词")%>'},
 <%
rs10.first();
for(int i=0;i<t;i++){
%>
	                  {name: '<%=rs10.getString("type_name")%>'},
	<%
		rs10.next();	
}
%>
                       {name: '<%=demo.getLang("erp","查看")%>'}
]
nseer_grid.column_width=[100,200, <%rs10.first();for(int i=0;i<t;i++){%>190,<%rs10.next();}%>,70];
nseer_grid.auto='<%=demo.getLang("erp","组名")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
   ['<%=exchange.toHtml(rs.getString("tablename"))%>','<%=exchange.toHtml(rs.getString("name"))%>',
<%
rs10.first();
for(int i=0;i<t;i++){
%>
	'<%=exchange.toHtml(rs.getString(rs10.getString("type_name")))%>',
<%
rs10.next();
}%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?id=<%=rs.getString("id")%>")><%=demo.getLang("erp","查看")%></div>'],
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
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
document_db.close();
document_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>