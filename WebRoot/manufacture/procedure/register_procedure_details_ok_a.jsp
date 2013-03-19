<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,include.nseer_db.*" import="java.util.*" import="java.io.*" import ="java.text.*" %>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% 
nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String manufacture_ID=request.getParameter("manufacture_ID");
String procedure_name=(String)session.getAttribute("procedure_name");
String qcs_tag="0";
String sql = "select qcs_tag from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"'";
	ResultSet rs = manufacture_db.executeQuery(sql) ;
	if(rs.next()){
		qcs_tag=rs.getString("qcs_tag");
	}
%>
<script language="javascript" src="../../javascript/manufacture/procedure/qcsjudgment.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","未完成")%>" onClick=location="register.jsp?manufacture_ID=<%=manufacture_ID%>">
 <%if(qcs_tag.equals("0")){%>
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","完成")%>" style="width: 50; " onClick="qcsJudgment();">
<%}else{%>
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","完成")%>" style="width: 50; " onClick=location="register_procedure_finish_reconfirm.jsp?manufacture_ID=<%=manufacture_ID%>&&procedure_name=<%=toUtf8String.utf8String(exchange.toURL(procedure_name))%>">
<%}%>
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register.jsp?manufacture_ID=<%=manufacture_ID%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","本次登记成功，需要审核！您确认本工序完成了吗？")%></td>
 </tr>
 </table>
</div>