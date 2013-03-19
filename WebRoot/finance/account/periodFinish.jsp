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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="accountPeriod" class="include.get_name_from_ID.AccountPeriod" scope="page"/>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language=javascript src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String[] account_period=accountPeriod.getAccountPeriod((String)session.getAttribute("unit_db_name"));
if(account_period[0]!=null){
String sql = "select * from finance_voucher where check_tag='0' and account_period='"+account_period[0]+"'" ;
ResultSet rs = finance_db.executeQuery(sql) ;
if(!rs.next()){
	sql = "select * from finance_voucher where check_tag='1' and account_tag='0' and account_period='"+account_period[0]+"'" ;
	rs = finance_db.executeQuery(sql) ;
	if(!rs.next()){
		sql="select * from finance_voucher where account_tag='1' and profit_or_cost='0' and cost_tag='0' and account_period='"+account_period[0]+"'";
		rs=finance_db.executeQuery(sql);
		if(!rs.next()){
			sql="select * from finance_voucher where account_tag='1' and (profit_or_cost='1' or profit_or_cost='0') and profit_tag='0' and account_period='"+account_period[0]+"'";
			rs=finance_db.executeQuery(sql);
			if(!rs.next()){
%>
<form id="timeLocateValidation" class="x-form" method="post" action="../../finance_account_periodFinish_ok" onSubmit="return doValidate('../../xml/finance/finance_config_public_char.xml','timeLocateValidation')">
<input type="hidden" name="account_period" value="<%=account_period[0]%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3" width="30%"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","开始")%>"></div></td>	
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="70%"><%=demo.getLang("erp","对会计期间")%><%=account_period[0]%><%=demo.getLang("erp","开始结账，您确认吗？")%></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3" width="30%">&nbsp;</td>	
 </tr>
</table> 
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请输入结账时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="timea" onfocus="" id="date_start" style="width: 20%"><%=demo.getLang("erp","（YYYY-MM-DD）")%></td> 
 </tr>
</table>
</form>
<%
}else{%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="70%">&nbsp;</td>	
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="70%"><%=demo.getLang("erp","尚有未结转利润的凭证，不能结账！")%></td>
 </tr>
 </table> 
<%}
}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="70%">&nbsp;</td>
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="70%"><%=demo.getLang("erp","尚有未结转成本的凭证，不能结账！")%></td>
 </tr>
 </table> 
<%}
}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="70%">&nbsp;</td>	
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="70%"><%=demo.getLang("erp","尚有未登账的凭证，不能结账！")%></td>
 </tr>
 </table> 
<%}
}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="70%">&nbsp;</td>
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="70%"><%=demo.getLang("erp","尚有未审核的凭证，不能结账！")%></td>
 </tr>
 </table> 
<%
}
	}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="70%">&nbsp;</td>
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="70%"><%=demo.getLang("erp","本会计年度已结束，不能结账！")%></td>
 </tr>
 </table> 
<%
}
finance_db.close();
%>
</div>

<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>