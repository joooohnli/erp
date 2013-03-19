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
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<% nseer_db db = new nseer_db("ondemand1");%>
<% DealWithString DealWithString=new DealWithString(application);%>
<table width="930" height="680" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="200" bgcolor="#ebf3fb">&nbsp;</td>
    <td width="600" valign="top"><table width="600" border="0">
	<tr>
        <td width="50%" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","反馈信息")%></td>
		<td align="right"><a href="register2.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","我要留言")%></font></a>&nbsp;&nbsp;<a href="../self/index.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","自助服务")%></font></a></td>
      </tr>
      <tr>
        <td colspan="2"><img src="../images/list.jpg" width="700" height="2" /></td>
      </tr>
<% 
String realname="";
String register_ID="";
String timea="";
String timeb="";
String kind="";
String keyword="";
if(timea==null||timeb==null||kind==null||keyword==null){
response.sendRedirect("../include/error/session_error.jsp");
}else{
String dbase="ondemand1";
String tablename="ecommerce_comment";
String fieldName1="write_time";
String fieldName2="kind";
String[] fieldName3={"name","company","address","email","tel"};
String condition="ecommerce_comment.check_tag!='2'";
String condition1="ecommerce_comment.check_tag='0'";
String condition2="ecommerce_comment.check_tag='1'";
String queue="order by ecommerce_comment.write_time desc";
ResultSet rs3=query.queryDB(dbase,tablename,timea,timeb,kind,keyword,fieldName1,fieldName2,fieldName3,condition1,queue);
int intRowCount1=query.intValue();
ResultSet rs4=query.queryDB(dbase,tablename,timea,timeb,kind,keyword,fieldName1,fieldName2,fieldName3,condition2,queue);
int intRowCount2=query.intValue();
ResultSet rs=query.queryDB(dbase,tablename,timea,timeb,kind,keyword,fieldName1,fieldName2,fieldName3,condition,queue);
int intRowCount=query.intValue();
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
int pageSize=25;
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
        <td height="469" valign="top" class="STYLE1" colspan="2">
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
      <a href="index_details.jsp?id=<%=rs.getString("id")%>" target="_blank"><%=rs.getString("comment_ID")%>--<%=exchange.toHtml(rs.getString("name"))%>--<%=exchange.toHtml(rs.getString("company"))%>--<%=exchange.toHtml(rs.getString("address"))%>--<%=exchange.toHtml(rs.getString("tel"))%></a><br/>
</page:pages>
</td>
      </tr>
      <tr>
        <td height="17" class="STYLE1" colspan="2"><page:updowntag num="<%=intRowCount%>" file="index.jsp"/></td>
      </tr>
    </table></td>
  </tr>
</table>
<%
}	
db.close();%>
<%@include file="../bottom.jsp"%>

