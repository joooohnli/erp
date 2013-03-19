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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 

<style> 
.tdp 
{ 
border-bottom: 1 solid #000000; 
border-left: 1 solid #000000; 
border-right: 0 solid #ffffff; 
border-top: 0 solid #ffffff; 
} 
.tabp 
{ 
border-color: #000000 #000000 #000000 #000000; 
border-style: solid; 
border-top-width: 2px; 
border-right-width: 2px; 
border-bottom-width: 1px; 
border-left-width: 1px; 
} 
.NOPRINT { 
font-family: "<%=demo.getLang("erp","宋体")%>"; 
font-size: 9pt; 
} 

</style>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <font color="#1A98F1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script src="../../javascript/table/movetable.js">
</script>
<%
String condition="";
String condition1="";
String condition2="";
String condition3="";
String condition4="";
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String human_ID=(String)session.getAttribute("human_ID");
String keyword=(String)session.getAttribute("keyword");
if(timea==null&&timeb==null&&human_ID==null&&keyword==null){
response.sendRedirect("../include/error/session_error.jsp");
}else{
String dbase=(String)session.getAttribute("unit_db_name");
String tablename="security_alive_access";
String fieldName1="time1";
String fieldName2="human_ID";
String[] fieldName3={"first_kind_ID","first_kind_name","second_kind_ID","second_kind_name","third_kind_ID","third_kind_name","human_ID","human_name","editor","modulei"};
String queue="order by time1 desc";
condition="human_ID!=''";
ResultSet rs=query.queryDB(dbase,tablename,timea,timeb,human_ID,keyword,fieldName1,fieldName2,fieldName3,condition,queue);
int intRowCount=query.intValue();
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
int aa=intRowCount/10;
int bb=intRowCount%24;
%>
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%"> 
 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
  <table width="100%" bordercolorlight=#333333 bordercolordark=#efefef width="650">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","符合条件的访问记录总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
			 <td class="Noprint"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></td>
 </tr>
 </table>
 </div>
<%
			int n=1;
for(int i=0;i<aa;i++){
			int m=1;
%>

  <table width="100%" height="540" bordercolorlight=#333333 bordercolordark=#efefef width="650">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="7%"><%=demo.getLang("erp","姓名")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="7%"><%=demo.getLang("erp","用户名")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","登录时间")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","退出时间")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="7%"><%=demo.getLang("erp","IP地址")%></td>
 </tr>
<%
for(int j=0;j<10;j++){
rs.next();
String color="#000000";
String time2=rs.getString("time2");
	if(rs.getString("time2").equals("1800-01-01 00:00:00.0")){
			time2="当前在线";
			color="green";
		}else if(rs.getString("tag").equals("1")){
			color="red";
			time2=rs.getString("time2")+"即时禁止";
		}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="7%" <%=TD_STYLE2%> class="TD_STYLE2"><a href="../../../hr/file/query.jsp?human_ID=<%=rs.getString("human_ID")%>"><font color="<%=color%>"><%=exchange.toHtml(rs.getString("human_name"))%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><a href="../../license/query.jsp?human_ID=<%=rs.getString("human_ID")%>"><font color="<%=color%>"><%=rs.getString("editor")%></a></td>
 <td width="14%" <%=TD_STYLE2%> class="TD_STYLE2"><font color="<%=color%>"><%=exchange.toHtml(rs.getString("time1"))%></td>
 <td width="14%" <%=TD_STYLE2%> class="TD_STYLE2"><font color="<%=color%>"><%=exchange.toHtml(time2)%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><font color="<%=color%>"><%=exchange.toHtml(rs.getString("modulei"))%></td>
 </tr>
<%
}
%>
</table>

<hr align="center" width="90%" size="1" noshade class="NOPRINT"> 
<div class="PageNext"></div> 
<%}%>

<%	
query.close();
%>
</body>
</html>
<%}%>