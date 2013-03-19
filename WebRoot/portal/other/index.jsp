<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*"%>
<%@include file="../top.jsp"%>
<%@include file="../include/head.jsp"%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<% nseer_db db = new nseer_db("ondemand1");%>
<table width="930" height="680" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="200" bgcolor="#ebf3fb">&nbsp;</td>
    <td width="600" valign="top"><table width="600" border="0">
	<tr>
        <td width="600" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","其他信息")%></td>
      </tr>
      <tr>
        <td><img src="../images/list.jpg" width="700" height="2" /></td>
      </tr>
<%
String column=request.getParameter("column");
String realname="";
String register_ID="";
String timea="";
String timeb="";
String type="";
String responsible_person_name="";
if(timea==null||timeb==null||responsible_person_name==null||type==null){
response.sendRedirect("../include/error/session_error.jsp");
}else{
String dbase="ondemand1";
String tablename="ecommerce_other";
String fieldName1="register_time";
String fieldName2="chian_name";
String fieldName3="chain_ID";
String fieldName4="topic";
String fieldName5="content";
String condition="check_tag='1' and chain_ID!='02'";
String condition1="check_tag='9' and excel_tag='9' and chain_ID!='02'";
String condition2="check_tag='0' and excel_tag='0' and chain_ID!='02'";
String condition3="check_tag='1' and excel_tag='3' and chain_ID!='02'";
String queue="order by register_time";
ResultSet rs4=query.queryDB(dbase,tablename,timea,timeb,"","","",responsible_person_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition1,queue,realname);
int intRowCount1=query.intRowCount();
ResultSet rs5=query.queryDB(dbase,tablename,timea,timeb,"","","",responsible_person_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition2,queue,realname);
int intRowCount2=query.intRowCount();
ResultSet rs3=query.queryDB(dbase,tablename,timea,timeb,"","","",responsible_person_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition3,queue,realname);
int intRowCount3=query.intRowCount();
ResultSet rs=query.queryDB(dbase,tablename,timea,timeb,"","","",responsible_person_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
int pageSize=25;
int intRowCount=query.intRowCount();
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&strPage.equals("")&&!validata.validata(strPage)){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
strPage=strPage+"⊙"+maxPage;
%>
<tr>
        <td height="469" valign="top" class="STYLE1">
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
      <a href="index_details.jsp?id=<%=rs.getString("id")%>" target="_blank"><%=rs.getString("other_ID")%>--<%=exchange.toHtml(rs.getString("topic"))%>--<%=exchange.toHtml(rs.getString("chain_name"))%></a><br/>
</page:pages>
</td>
      </tr>
      <tr>
        <td height="17" class="STYLE1"><page:updowntag num="<%=intRowCount%>" file="index.jsp"/></td>
      </tr>
    </table></td>
  </tr>
</table>
<%
}	
db.close();%>
<%@include file="../bottom.jsp"%>

