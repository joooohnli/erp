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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="query_from_time" scope ="page" class ="include.query.query_from_time"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<%
try{
String timea="";
String timeb="";
String sql=query_from_time.query_from_time(timea,timeb);
String sql_search=sql;
%>
<%@include file="../../include/list_page.jsp"%>
<%
intRowCount=query.count((String)session.getAttribute("unit_db_name"),sql_search.substring(0,sql_search.indexOf("limit")));
int maxPage=(intRowCount+pageSize-1)/pageSize;
strPage=strPage.substring(0,strPage.indexOf("⊙"))+"⊙"+maxPage;
ResultSet rs=stock_db.executeQuery(sql_search);
%> 
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","盘点单编号")%>'},
                       {name: '<%=demo.getLang("erp","盘点时间")%>'},
					   {name: '<%=demo.getLang("erp","盘点人")%>'}
]
nseer_grid.column_width=[180,200,300];
nseer_grid.auto='<%=demo.getLang("erp","盘点单编号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 	
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("staticQuery_list_getpara.jsp?static_report_ID=<%=rs.getString("static_report_ID")%>")><%=rs.getString("static_report_ID")%></div>','<%=exchange.toHtml(rs.getString("static_report_time"))%>','<%=exchange.toHtml(rs.getString("register"))%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="staticQuery_list.jsp"/>
<%	
stock_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>