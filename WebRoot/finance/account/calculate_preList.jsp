<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%
String select1=(String)session.getAttribute("select1");
String sql="select * from finance_account_details ";
	ResultSet rs=finance_db.executeQuery(sql);
	int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script src="../../javascript/table/movetable.js"></script>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=demo.getLang("erp","符合条件的明细分类账：")%><%=select2%><%=demo.getLang("erp","实际物料成本（元）")%><%=demo.getLang("erp","记录总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="calculate_locate.jsp"></div></td>
 </tr>
 
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","时间")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="6%"><%=demo.getLang("erp","凭证号")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","摘要")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="15%"><%=demo.getLang("erp","借方金额")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="15%"><%=demo.getLang("erp","贷方金额")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="15%"><%=demo.getLang("erp","期末余额")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="6%"><%=demo.getLang("erp","类")%></td>
 </tr>
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
if(!rs.getString("first_kind_ID").equals("1243")&&!rs.getString("first_kind_ID").equals("1501")&&!rs.getString("first_kind_name").equals("销售收入")){
	%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
		<%if(rs.getString("finance_time").equals("1800-01-01")){
		%>
			 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%">&nbsp;</td>
			 <%}else{%>
 
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><%=rs.getString("finance_time")%></td>
	 <%}%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=rs.getString("voucher_in_month_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><%=exchange.toHtml(rs.getString("summary_content"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_month_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_month_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(rs.getDouble("current_balance_sum")))%>&nbsp;</td>

	 <%if(rs.getString("debit_or_loan").equals("借")&&rs.getDouble("current_balance_sum")>=0){%>

 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","借")%></td>
	 <%}else if(rs.getString("debit_or_loan").equals("借")&&rs.getDouble("current_balance_sum")<0){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","贷")%></td>
			<%}else if(rs.getString("debit_or_loan").equals("贷")&&rs.getDouble("current_balance_sum")>=0){%>

			<td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","贷")%></td>
			<%}else{%>
			 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","借")%></td>
				 <%}%>
 </tr>
	<%}%>
</page:pages>
  </table>
<%
finance_db.close();
%>
<page:updowntag num="<%=intRowCount%>" file="calculate_preList.jsp"/>