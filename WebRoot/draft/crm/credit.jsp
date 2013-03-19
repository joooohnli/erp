<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是 ：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<%
String pay_ID=request.getParameter("pay_ID") ;
String config_id=request.getParameter("config_id");
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
if(vt.validata((String)session.getAttribute("unit_db_name"),"stock_apply_pay","pay_ID",pay_ID,"check_tag").equals("5")||vt.validata((String)session.getAttribute("unit_db_name"),"stock_apply_pay","pay_ID",pay_ID,"check_tag").equals("9")){
try{
String sql="select * from stock_apply_pay where pay_ID='"+pay_ID+"'";
ResultSet rs=crm_db.executeQuery(sql);
if(rs.next()){
	String remark=exchange.unHtml(rs.getString("remark"));
%>
<script language="javascript">
function delSelect(){
 var checkboxs = document.getElementsByName("checkbox");
 var table = document.getElementById("tableOnlineEdit");
 var tr = table.getElementsByTagName("tr");
 for (var i=0; i<checkboxs.length; i++) {
 if(tr.length==2){
 checkboxs[i].checked = false;
 return;
 }
 if(checkboxs[i].checked==true){
 removeTr(checkboxs[i]);
 i=-1;
 }
 }
}

function removeTr(obj) {
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
</script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="mutiValidation" method="POST">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_crm_credit_draft_ok','../../xml/stock/stock_apply_pay.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_crm_credit_check_ok','../../xml/stock/stock_apply_pay.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="winopen('credit_product_list.jsp')" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="credit_list.jsp"></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","赊货申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><input name="pay_ID" type="hidden" value="<%=rs.getString("pay_ID")%>"><%=rs.getString("pay_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","客户分类")%>&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="payer_chain_name" value="<%=exchange.toHtml(rs.getString("payer_chain_name"))%>" type="hidden"><%=exchange.toHtml(rs.getString("payer_chain_name"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","赊货人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="payer_name" type="hidden" value="<%=exchange.toHtml(rs.getString("payer_name"))%>"><%=exchange.toHtml(rs.getString("payer_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","是否归还")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="not_return_tag">
<%if(rs.getString("not_return_tag").equals("0")){%>
						<option value="0" selected><%=demo.getLang("erp","是 ")%></option>
						
<%}%>
  </select></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","归还时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_return_time" onfocus="" id="date_start" value="<%=exchange.toHtml(rs.getString("demand_return_time"))%>"></td>
</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=tableOnlineEdit>
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","当前库存数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","市场单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%">&nbsp; </td>
 </tr>
<%
int i=1;
String sql6="select * from stock_apply_pay_details where pay_ID='"+pay_ID+"'";
ResultSet rs6=stock_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_name<%=i%>" type="hidden" value="<%=exchange.toHtml(rs6.getString("product_name"))%>"><%=exchange.toHtml(rs6.getString("product_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_ID<%=i%>" type="hidden" value="<%=rs6.getString("product_ID")%>"><%=rs6.getString("product_ID")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="available_amount<%=i%>" type="hidden" value="<%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"))%>"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount<%=i%>" value="<%=demo.qformat(rs6.getDouble("amount"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("amount_unit")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="list_price<%=i%>" type="hidden" value="<%=rs6.getDouble("list_price")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("list_price"))%></td>
<input name="cost_price<%=i%>" type="hidden" value="<%=rs6.getDouble("cost_price")%>">
<input name="type<%=i%>" type="hidden" value="<%=exchange.toHtml(rs6.getString("type"))%>">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("list_price_subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="credit_delete_details.jsp?id=<%=rs6.getString("id")%>&&pay_ID=<%=rs.getString("pay_ID")%>"><%=demo.getLang("erp","删除")%></a></td>
 </tr>
<%
	i++;
	}
%>
<input name="product_amount" type="hidden" value="<%=i-1%>">
<tr style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id="checkLine"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID" onFocus="this.blur()"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><span name="product_describe_ok" style="width:120px;background:#ffffff"></span><input type="hidden" name="product_describe" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" value="21"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="list_price" onFocus="this.blur()"></td>
 <input name="cost_price" type="hidden" onFocus="this.blur()">
 <input name="type" type="hidden" onFocus="this.blur()">
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 </tr>
</thead>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总件数")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("demand_amount"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总金额")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("list_price_sum"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","销售人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="sales_ID" type="hidden" value="<%=rs.getString("sales_ID")%>"><input name="sales_name" type="hidden" value="<%=exchange.toHtml(rs.getString("sales_name"))%>"><%=exchange.toHtml(rs.getString("sales_name"))%></td>
<input name="payer_ID" type="hidden" value="<%=rs.getString("payer_ID")%>">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","出库理由")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="reason" type="hidden" value="<%=exchange.toHtml(rs.getString("reason"))%>"><%=exchange.toHtml(rs.getString("reason"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_ID" type="hidden" value="<%=register_ID%>"><input name="register" type="hidden" value="<%=exchange.toHtml(register)%>"><%=exchange.toHtml(register)%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%">
 <textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
 </div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
<%
}
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="credit_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已提交审核，请返回！")%></td>
 </tr>
</table>
</div>
<%}
stock_db.close();
crm_db.close();
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>