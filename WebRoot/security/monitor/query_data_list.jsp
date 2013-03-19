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
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/security/security_alive_access.xml"/>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
try{
String time_select=(String)session.getAttribute("time_select");
String hour=request.getParameter("hour");
String time1=time_select+" "+hour+":00:00";
String time2=time_select+" "+hour+":59:59";
nseer_db new_db = new nseer_db((String)session.getAttribute("unit_db_name"));
int intRowCount=0;
String sql="select count(*) from security_alive_access where time1>='"+time1+"' and time1<='"+time2+"'";
ResultSet rs=new_db.executeQuery(sql) ;
if(rs.next()){
	intRowCount=rs.getInt("count(*)");
}
sql="select * from security_alive_access where time1>='"+time1+"' and time1<='"+time2+"' order by time1";
rs=new_db.executeQuery(sql) ;
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="关闭窗口" onClick="window.close();"></div></td>
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
                       {name: '<%=demo.getLang("erp","登录时间")%>'},
                       {name: '<%=demo.getLang("erp","退出时间")%>'},
                       {name: '<%=demo.getLang("erp","IP地址")%>'}
]
nseer_grid.column_width=[180,200,160,160,160];
nseer_grid.auto='<%=demo.getLang("erp","用户名")%>';
nseer_grid.data = [
<%
while(rs.next()){
String color="#000000";
time2=rs.getString("time2");
	if(rs.getString("time2").equals("1800-01-01 00:00:00.0")){
			time2="当前在线";
			color="green";
		}else if(rs.getString("tag").equals("1")){
			color="red";
			time2=rs.getString("time2")+"即时禁止";
		}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../hr/file/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("human_name"))%></span></div>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../license/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("editor"))%></span></div>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("time1"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(time2)%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("modulei"))%></span>'],
<%}%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%	
new_db.close();
}catch(Exception ex){
ex.printStackTrace();
}
%>