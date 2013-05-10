<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*" import="com.fredck.FCKeditor.*"%>
<%@include file="../top.jsp"%>
<%@include file="../include/head.jsp"%>
<%nseer_db db = new nseer_db("ondemand1");%>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#4c89b5,endColorStr=#FFFFFF)" >
<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="200" bgcolor="#ebf3fb">&nbsp;</td>
    <td width="600" valign="top"><table width="600" border="0">
	<tr>
        <td width="600" class="STYLE1" >&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","联系我们")%></td>
      </tr>
      <tr>
        <td><img src="../images/list.jpg" width="700" height="2" /></td>
      </tr>
	  <tr><td></table>
<%
String sql="select * from ecommerce_contact where check_tag='1'";
ResultSet rs=db.executeQuery(sql);
while(rs.next()){
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%" >
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="2"><%=demo.getLang("erp",rs.getString("chain_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","电话:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp",rs.getString("tel"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","传真:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp",rs.getString("fax"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","地址:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp",rs.getString("address"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","邮编:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp",rs.getString("postcode"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","EMAIL:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp",rs.getString("email"))%></td>
 </tr>
  <%if(!rs.getString("qq1").equals("")) {%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","QQ:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><a target=blank href=http://wpa.qq.com/msgrd?V=1&amp;Uin=<%=rs.getString("qq1")%>&amp;Site=川大科技&amp;Menu=yes><font style=font-size:12px;>&nbsp;<%=rs.getString("qq1")%><img SRC=http://wpa.qq.com/pa?p=10:<%=rs.getString("qq1")%>:10 border=0 ></font></a></td>
 </tr>
 
  <%}
  if(!rs.getString("qq2").equals("")) {%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","QQ:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><a target=blank href=http://wpa.qq.com/msgrd?V=1&amp;Uin=<%=rs.getString("qq2")%>&amp;Site=川大科技&amp;Menu=yes><font style=font-size:12px;>&nbsp;<%=rs.getString("qq2")%><img SRC=http://wpa.qq.com/pa?p=10:<%=rs.getString("qq2")%>:10 border=0 ></font></a></td>
 </tr>
 <%}%>

 <%if(!rs.getString("qq3").equals("")) {%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","QQ:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><a target=blank href=http://wpa.qq.com/msgrd?V=1&amp;Uin=<%=rs.getString("qq3")%>&amp;Site=川大科技&amp;Menu=yes><font style=font-size:12px;>&nbsp;<%=rs.getString("qq3")%><img SRC=http://wpa.qq.com/pa?p=10:<%=rs.getString("qq3")%>:10 border=0 ></font></a></td>
 </tr>
<%}%>

 <%
	
if(!rs.getString("qq4").equals("")) {%>


 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","QQ:")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><a target=blank href=http://wpa.qq.com/msgrd?V=1&amp;Uin=<%=rs.getString("qq4")%>&amp;Site=川大科技&amp;Menu=yes><font style=font-size:12px;>&nbsp;<%=rs.getString("qq4")%><img SRC=http://wpa.qq.com/pa?p=10:<%=rs.getString("qq4")%>:10 border=0 ></font></a></td>
 </tr>
 
 <%}%>
 </table>
<%}
db.close();
%>
</td>
  </tr>
</table>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>
</body>
