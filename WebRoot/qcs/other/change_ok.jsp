<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@include file="../include/head.jsp"%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
int finished_tag=Integer.parseInt(request.getParameter("finished_tag"));
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" height="10"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick=location="change_list.jsp" value="<%=demo.getLang("erp","返回")%>"></div></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
<%
switch(finished_tag){
	case 0:
		out.println(demo.getLang("erp","该记录已变更，请返回！"));
		break;
	case 1:
		out.println(demo.getLang("erp","变更完成，请返回！"));
		break;
	case 2:
		out.println(demo.getLang("erp","质检项目不能为空!"));
		break;
	case 3:
		out.println(demo.getLang("erp","附件类型错误或附件容量太大"));
		break;
}
%>
 </td>
 </tr>
 </table>
  </div>