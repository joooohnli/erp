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
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="JavaScript">
function FormMenu(targ,selObj,restore){ 
eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
if (restore) selObj.selectedIndex=0;
}
</script>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script> 
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="timeLocateValidation" class="x-form" method="post" action="bill_list.jsp" onSubmit="return doValidate('../../../xml/finance/finance_config_public_char.xml','timeLocateValidation')">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","查询")%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请选择银行科目")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select1" style="width: 60%;">
<%
  String sql = "select category_name from finance_config_file_kind where bank_tag='1' and details_tag='0' order by file_ID" ;
	 ResultSet rs = finance_db.executeQuery(sql) ;
while(rs.next()){%>	
			<option value="<%=rs.getString("category_name")%>"><%=rs.getString("category_name")%></option>
<%}
finance_db.close();
%>
</select></td> 
</tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请输入时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="timea" onfocus="" id="date_start" type="text" style="width: 14%"><%=demo.getLang("erp","至")%><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="timeb" onfocus="" id="date_end" type="text" style="width: 14%"><%=demo.getLang("erp","（YYYY-MM-DD）")%></td> 
 </tr>
 </table>
</form>
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>