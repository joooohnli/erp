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
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<div id="nseerGround" class="nseerGround"> 
<form id="retailRateChange" class="x-form" method="post" action="../../../crm_config_intranalyse_retailRate_change_ok" onSubmit="return doValidate('../../../xml/design/design_file.xml','retailRateChange');">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="retailRate_list.jsp"></div></td>
 </tr>
 </table>
<%String product_ID=request.getParameter("product_ID");
String product_name=exchange.unURL(request.getParameter("product_name"));
String retail_sale_bonus_rate=request.getParameter("retail_sale_bonus_rate");
String retail_profit_bonus_rate=request.getParameter("retail_profit_bonus_rate");
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","产品编号")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="hidden" name="product_ID" value=<%=product_ID%>><%=product_ID%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","产品名称")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="hidden" name="product_name" value=<%=exchange.toHtml(product_name)%>><%=exchange.toHtml(product_name)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","绩效比例(按毛利)")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="retail_profit_bonus_rate" value=<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(retail_profit_bonus_rate))%> style="width: 15%">%</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","绩效比例(按销售额)")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="retail_sale_bonus_rate" value=<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(retail_sale_bonus_rate))%> style="width: 15%">%</td>
</tr>
<% String sql="select * from design_file where product_ID='"+product_ID+"' and serial_number_tag='1'";
	ResultSet rs=design_db.executeQuery(sql);
	if(rs.next()){
		if(rs.getString("calculate_bonus_sn_tag").equals("是")){
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","个别计价")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="calculate_bonus_sn_tag" style="width: 15%;">
		<option value="是" selected><%=demo.getLang("erp","是")%></option>
		<option value="否"><%=demo.getLang("erp","否")%></option>
  </select></td>
			 </tr>

			 <%}else{%>
			 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","绩效比例(按毛利)")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="calculate_bonus_sn_tag" style="width: 15%;">
		<option value="是"><%=demo.getLang("erp","是")%></option>
		<option value="否" selected><%=demo.getLang("erp","否")%></option>
  </select></td>
			 </tr>
			 <%}
			 }
			 
			 design_db.close();%>
</table> 
</form>
</div>