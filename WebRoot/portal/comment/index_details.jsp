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
<%iisPrint iisPrint=new iisPrint(request);%>
<%
DealWithString DealWithString=new DealWithString(application);
nseer_db db = new nseer_db("ondemand1");
%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<table width="930" height="400" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="930" valign="top">
	<table width="930" border="0">
	<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","反馈信息")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
<%
String write_time="";
String id=request.getParameter("id");
try{
	String sqll = "select * from ecommerce_comment where id='"+id+"'" ;
	ResultSet rss = db.executeQuery(sqll) ;
	while(rss.next()){
if(rss.getString("write_time").equals("1800-01-01 00:00:00.0")){
write_time="";
}else{
write_time=rss.getString("write_time");
}
%>
<table width="805" bgcolor="#FFFFFF" align="center"  >
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="index.jsp"></div>
 </td>
 </tr>
</table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
 <table  id=theObjTable <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","姓名")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rss.getString("name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rss.getString("sex"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rss.getString("company"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rss.getString("address"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rss.getString("tel"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","Email")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rss.getString("email"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","反馈信息分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rss.getString("kind"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","反馈时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(write_time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","反馈信息内容")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rss.getString("comment")%></td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","回复")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rss.getString("reply")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","附件")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" ><%=iisPrint.printOrNotSin(rss.getString("attachment1"),response,rss.getString("id"),"ecommerce_comment","attachment1")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%">&nbsp;</td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" >&nbsp;</td>
 </tr>
 </table>
<%
}
db.close();
}
catch (Exception ex){
out.println("error2:"+ex);
}
%>
</table>
<%@include file="../bottom.jsp"%>