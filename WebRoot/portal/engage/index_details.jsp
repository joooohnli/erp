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
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","人才信息")%></td>
      </tr>
      <tr>
        <td><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
<%
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String id=request.getParameter("id");
try{
	String sql="select * from hr_major_release where id='"+id+"'";
	ResultSet rs= db.executeQuery(sql) ;
	if(rs.next()){
		String remark1=exchange.unHtml(rs.getString("remark1"));
		String remark2=exchange.unHtml(rs.getString("remark2"));
%>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<table width="805" bgcolor="#FFFFFF" align="center"  >
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="index.jsp"></div></td> 
 </tr> 
 </table>
 <table  id=theObjTable <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("chain_id"))%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","招聘类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("engage_type"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("human_major_first_kind_name")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","招聘人数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("human_amount")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","截止日期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("deadline"))%></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","职位描述")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=remark1%></td>
<td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","招聘要求")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=remark2%></td>
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
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>