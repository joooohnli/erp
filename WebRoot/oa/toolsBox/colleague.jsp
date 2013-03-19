<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
	 demo.setPath(request);
%>
<%@include file="../include/head_list.jsp"%>
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db securitydb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<title><%=demo.getLang("erp","恩信科技开源ERP")%></title>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=demo.getLang("erp","我的同事")%></div></td>
 </tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
	String sql = "select * from security_users left join security_alive_access on security_users.human_ID=security_alive_access.human_ID where security_alive_access.time2 like '1800-01-01%' order by security_users.human_ID" ;
	ResultSet rs = securitydb.executeQuery(sql) ;
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
int pageSize=25;
String pageSize_temp=request.getParameter("pageSize");
if(pageSize_temp!=null&&!pageSize_temp.equals("")){pageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(pageSize).toString());
String strPage = request.getParameter("page");
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&(strPage.equals("")||!validata.validata(strPage))){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(maxPage>0&&Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
strPage=strPage+"⊙"+maxPage;
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><div class="div_handbook"><%=demo.getLang("erp","当前在线的同事总数：")%><%=intRowCount%><%=demo.getLang("erp","人")%></div></td>
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
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
	                   {name: '<%=demo.getLang("erp","netmeeting")%>'},
	                   {name: '<%=demo.getLang("erp","QQ")%>'},
					   {name: '<%=demo.getLang("erp","发消息")%>'}
]
nseer_grid.column_width=[100,100,140,100,70];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String sql1="select * from hr_file where human_ID='"+rs.getString("human_ID")+"'";
ResultSet rs1=security_db.executeQuery(sql1);
if(rs1.next()){%>
  ['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../hr/file/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><%=exchange.toHtml(rs.getString("human_name"))%></div>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=winopen("netmeeting.htm")><%=demo.getLang("erp","netmeeting")%></div>','<div style="text-decoration : underline;color:#3366FF" onclick=winopen("http://wpa.qq.com/msgrd?V=5&Uin=<%=rs1.getString("human_home_tel")%>&Exe=QQ&Site=im.qq.com&Menu=No")><img SRC=http://wpa.qq.com/pa?p=5:<%=rs1.getString("human_home_tel")%>:5 alt="给我发消息"></div>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("send.jsp?cell=<%=rs1.getString("human_cellphone")%>&&email=<%=rs1.getString("human_email")%>")><%=demo.getLang("erp","发消息")%></div>'],
  <%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%
security_db.close();
securitydb.close();
%> 
<page:updowntag num="<%=intRowCount%>" file="colleague.jsp"/>