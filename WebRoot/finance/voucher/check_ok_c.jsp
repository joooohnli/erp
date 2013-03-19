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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<%
int err_number=Integer.parseInt(request.getParameter("err_number"));
String voucher_in_month_id=request.getParameter("voucher_in_month_id") ;
String register_time=request.getParameter("register_time") ;
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick=location="check.jsp?voucher_in_month_id=<%=voucher_in_month_id%>&&register_time=<%=register_time%>" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
<%
switch (err_number){
 case 3:
	out.println(demo.getLang("erp","现金流量明细有误！"));
	break;
 case 4:
	out.println(demo.getLang("erp","摘要不能为空！"));
	break;
 case 5:
	out.println(demo.getLang("erp","科目不合法！"));
	break;
 case 6:
	out.println(demo.getLang("erp","借贷不平衡"));
	break;
 case 7:
	out.println(demo.getLang("erp","制单时间必须在当前会计期间内！"));
	break;
 case 8:
	out.println(demo.getLang("erp","科目不合法！"));
	break;
 case 9:
	out.println(demo.getLang("erp","数量核算科目的数量有误！"));
	break;
 case 10:
	out.println(demo.getLang("erp","结算方式不能为空！"));
	break;
 case 11:
	out.println(demo.getLang("erp","票号不能为空！"));
	break;
 case 12:
	out.println(demo.getLang("erp","票据日期不能为空！"));
	break;
 case 13:
	out.println(demo.getLang("erp","票据日期不能大于制单日期！"));
	break;
 case 14:
	out.println(demo.getLang("erp","请正确填写分录！"));
	break;
 case 15:
	out.println(demo.getLang("erp","重复提交！"));
	break;
case 16:
	out.println(demo.getLang("erp","借方或贷方金额必须为数字"));
	break;
}
%>
 </td>
 </tr>
 </table>
 </div>