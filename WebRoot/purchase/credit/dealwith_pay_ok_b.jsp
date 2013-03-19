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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String gather_ID=(String)session.getAttribute("gather_ID");
String purchaser_ID=(String)session.getAttribute("purchaser_ID");
String purchaser=(String)session.getAttribute("purchaser");
String purchasecredit_cost_price_sum1=(String)session.getAttribute("purchasecredit_cost_price_sum1");
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form class="x-form" id="form1" method="POST" action="dealwith_reconfirm.jsp">
<input type="hidden" name="gather_ID" value="<%=gather_ID%>">
<input type="hidden" name="purchaser_ID" value="<%=purchaser_ID%>">
<input type="hidden" name="purchaser" value="<%=exchange.toHtml(purchaser)%>">
<input type="hidden" name="purchasecredit_cost_price_sum" value="<%=purchasecredit_cost_price_sum1%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; "></div></td>
</tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数量、单价、折扣必须是数字，请返回！")%></td>
</tr>
 </table>
 </form>
 </div>