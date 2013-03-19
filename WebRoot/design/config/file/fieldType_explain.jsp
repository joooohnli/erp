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
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="left"><%=demo.getLang("erp","商品：需要使用物料、部件、委外部件生产出来并且只用作销售的有形产品。")%>
	 </td>
	 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="left"><%=demo.getLang("erp","外购商品：直接采购，直接销售的产品，不需要生产、委外的有形产品。")%>
	 </td>
	 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="left"><%=demo.getLang("erp","物料：直接采购，只用做生产商品、部件、委外部件用途的有形产品。"
 )%>
	 </td>
	 </tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td
align="left"><%=demo.getLang("erp","部件：使用物料、部件、委外部件生产出来，作为生产商品、部件、委外部件的生产单元，它是有形的产品。")%>
	 </td>
	 </tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","委外部件：使用物料、部件、委外部件由委外单位生产出来，作为生产商品、部件、委外部件的生产单元，它是有形的产品。")%>
	 </td>
	 </tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","服务型产品：无形的不需要库存的产品。")%>
	 </td>
	 </tr>
 </table>
 </div>
 