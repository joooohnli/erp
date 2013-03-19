<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String manufacture_ID=request.getParameter("manufacture_ID");
String procedure_ID=request.getParameter("procedure_ID");
String details_number=exchange.unURL(request.getParameter("details_number"));
%>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<form id="mutiValidation" class="x-form" method="POST" action="../../manufacture_procedure_check_procedure_transfer_ok" onSubmit="return doValidate('../../xml/manufacture/manufacture_manufacture.xml','mutiValidation')">
<%
String sql8="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_ID='"+procedure_ID+"' and procedure_finish_tag!='2' and details_number='"+details_number+"'";
ResultSet rs8=manufacture_db.executeQuery(sql8);
if(rs8.next()){
	try{
		String sql3="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_ID='"+procedure_ID+"' and details_number='"+details_number+"'";
		ResultSet rs3=manufacture_db.executeQuery(sql3);
		if(rs3.next()){
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
<input name="manufacture_ID" type="hidden" value="<%=manufacture_ID%>">
<input name="procedure_ID" type="hidden" value="<%=procedure_ID%>">
<input name="details_number" type="hidden" value="<%=details_number%>">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="30%"><%=demo.getLang("erp","本工序投产数量")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><input type="hidden" name="demand_amount" value="<%=rs3.getString("demand_amount")%>"><%=rs3.getString("demand_amount")%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="30%"><%=demo.getLang("erp","本工序合格品数量")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="real_amount" style="width:30%" value="<%=rs3.getString("real_amount")%>"></td>
</tr>
</table>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%
	}
	manufacture_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
manufacture_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check.jsp?manufacture_ID=<%=manufacture_ID%>"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回！")%></td>
 </tr>
</table>
</div>
<%}%>
</form>
</div>