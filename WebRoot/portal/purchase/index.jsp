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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#4c89b5,endColorStr=#FFFFFF)" >
<table width="930" height="680" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="200" bgcolor="#ebf3fb">&nbsp;</td>
    <td width="600" valign="top"><table width="600" border="0">
	<tr>
        <td width="50%" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","采购信息")%></td>
		<td align="right"><a href="register1.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","注册供应商信息")%></font></a>&nbsp;&nbsp;<a href="register2.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","我能供应")%></font></a>&nbsp;&nbsp;<a href="../self/index.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","自助服务")%></font></a></td>
      </tr>
      <tr>
        <td colspan="2"><img src="../images/list.jpg" width="700" height="2" /></td>
      </tr>
<% 
String realname="";
String register_ID="";
String timea="";
String timeb="";
String type="111";
String first_kind_name="";
String second_kind_name="";
String third_kind_name="";
String customer_ID="";
String customer_name="";
String responsible_person_name="";
if(timea==null||timeb==null||first_kind_name==null||second_kind_name==null||third_kind_name==null||responsible_person_name==null||type==null){
response.sendRedirect("../include/error/session_error.jsp");
}else{
String dbase="ondemand1";
String tablename="design_file";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="responsible_person_name";
String condition="";
if(type.equals("111")){
	condition="check_tag='1' and excel_tag='3'";
}else{
	condition="check_tag='1' and excel_tag='3' and type='"+type+"'";
}
String queue="order by register_time desc";
ResultSet rs=query.queryDB(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,responsible_person_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
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
        <td height="469" valign="top" class="STYLE1" colspan="2">
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
      <a href="index_details.jsp?id=<%=rs.getString("id")%>" target="_blank"><%=rs.getString("product_ID")%>--<%=exchange.toHtml(rs.getString("product_name"))%>--<%=exchange.toHtml(rs.getString("chain_name"))%></a><br/>
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