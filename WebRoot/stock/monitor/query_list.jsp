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
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db securitydb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/security/security_users.xml"/>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%	
try{
String sql = "" ;
String strPage=request.getParameter("page");
String pageSize_temp=request.getParameter("pageSize");
int intRowCount=0;
int pageSize=25;
if(pageSize_temp!=null&&!pageSize_temp.equals("")){pageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(pageSize).toString());

sql="select count(*) from security_alive_access left join security_users on security_alive_access.human_id=security_users.human_id where security_alive_access.time2='1800-01-01 00:00:00'";
ResultSet rs = securitydb.executeQuery(sql) ;
if(rs.next()){
	intRowCount=rs.getInt("count(*)");
}
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&strPage.equals("")&&!validata.validata(strPage)){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
sql="select * from security_alive_access left join security_users on security_alive_access.human_id=security_users.human_id where security_alive_access.time2='1800-01-01 00:00:00' order by time1 desc limit "+(Integer.parseInt(strPage)-1)*pageSize+","+pageSize;
strPage=strPage+"⊙"+maxPage;
rs = securitydb.executeQuery(sql) ;
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
  <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","图形分析")%>" onClick=location="javascript:winopen('query.jsp')"></div></td>
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
                       {name: '<%=demo.getLang("erp","用户名")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
                       {name: '<%=demo.getLang("erp","登录时间")%>'},
					   {name: '<%=demo.getLang("erp","IP地址")%>'},
					   {name: '<%=demo.getLang("erp","临时禁止")%>'}
]
nseer_grid.column_width=[200,100,150,150,150,100];
nseer_grid.auto='<%=demo.getLang("erp","姓名")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../hr/file/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><%=exchange.toHtml(rs.getString("human_name"))%></div>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../security/license/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><%=exchange.toHtml(rs.getString("name"))%></div>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=exchange.toHtml(rs.getString("time1"))%>','<%=exchange.toHtml(rs.getString("modulei"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query_delete_reconfirm.jsp?human_ID=<%=rs.getString("human_ID")%>&&name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("name")))%>")><%=demo.getLang("erp","临时禁止")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="query_list.jsp"/>
<%
security_db.close();
securitydb.close();
}catch(Exception ex){ex.printStackTrace();}
%>