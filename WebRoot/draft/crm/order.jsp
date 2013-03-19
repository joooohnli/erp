<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crmdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript">
function delSelect(){
var checkboxs = document.getElementsByName("checkbox");
var table = document.getElementById("tableOnlineEdit");
var tr = table.getElementsByTagName("tr");
 for (var i=0; i<checkboxs.length; i++){
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
function removeTr(obj){
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
</script>
<%
String order_ID=request.getParameter("order_ID") ;
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
if(vt.validata((String)session.getAttribute("unit_db_name"),"crm_order","order_ID",order_ID,"check_tag").equals("9")||vt.validata((String)session.getAttribute("unit_db_name"),"crm_order","order_ID",order_ID,"check_tag").equals("5")){
try{
String sql="select * from crm_order where order_ID='"+order_ID+"'";
ResultSet rs=crmdb.executeQuery(sql);
while(rs.next()){
	String remark=exchange.unHtml(rs.getString("remark"));
%>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_crm_order_draft_ok','../../xml/crm/crm_order.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_crm_order_check_ok','../../xml/crm/crm_order.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  onclick="winopen('order_product_list.jsp')" value="<%=demo.getLang("erp","添加商品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  onclick="delSelect()"  value="<%=demo.getLang("erp","删除商品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="order_list.jsp"></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","销售订单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","订单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><input name="order_ID" type="hidden" value="<%=rs.getString("order_ID")%>"><%=rs.getString("order_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="customer_name" type="hidden" value="<%=exchange.toHtml(rs.getString("customer_name"))%>"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="customer_ID" type="hidden" width="100%" value="<%=rs.getString("customer_ID")%>"><%=rs.getString("customer_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","电话")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_contact_person_tel" value="<%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","提货时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_pay_time" onfocus="" id="date_start" value="<%=exchange.toHtml(rs.getString("demand_pay_time"))%>"></td>
 </tr>
<input name="demand_customer_address" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_customer_address"))%>">
<input name="demand_customer_mailing_address" type="hidden" width="100%" value="<%=exchange.toHtml(rs.getString("demand_customer_mailing_address"))%>">
<input name="demand_contact_person" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_contact_person"))%>">
<input name="demand_contact_person_fax" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_contact_person_fax"))%>">
<input name="demand_pay_type" type="hidden">
<input name="demand_pay_fee_type" type="hidden">
<input type="hidden" name="demand_pay_fee_sum" value="">
<input type="hidden" name="demand_gather_time" value="<%=exchange.toHtml(rs.getString("demand_gather_time"))%>">
<input name="demand_gather_type" type="hidden">
<input name="demand_gather_method" type="hidden">
<input name="demand_invoice_type" type="hidden">
<input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>">
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE id=tableOnlineEdit <%=TABLE_STYLE5%> class="TABLE_STYLE5">
<thead>
<tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","折扣（%）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%">&nbsp; </td>
 </tr>
<%
int i=1;
String sql6="select * from crm_order_details where order_ID='"+rs.getString("order_ID")+"'";
ResultSet rs6=crm_db.executeQuery(sql6);
while(rs6.next()){
%>	
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID<%=i%>" value="<%=rs6.getString("product_ID")%>" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" value="<%=exchange.toHtml(rs6.getString("product_name"))%>" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><div><%=rs6.getString("product_describe")%></div><input type="hidden" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" onFocus="this.blur()" value="<%=rs6.getString("product_describe")%>"></td>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount<%=i%>" value="<%=demo.qformat(rs6.getDouble("amount"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("amount_unit")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="list_price<%=i%>" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("list_price"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price<%=i%>" type="hidden"  value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>"><input name="real_cost_price<%=i%>" type="hidden"  value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("real_cost_price"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="off_discount<%=i%>" value="<%=rs6.getDouble("off_discount")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="order_delete_details.jsp?id=<%=rs6.getString("id")%>&&order_ID=<%=rs.getString("order_ID")%>"><%=demo.getLang("erp","删除")%></a></td>
 </tr>
<%	i++;
	}%>
<tr style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID" onFocus="this.blur()"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" onFocus="this.blur()"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><span name="product_describe_ok" style="width:120px;background:#ffffff"></span><input type="hidden" name="product_describe" onFocus="this.blur()"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit" onFocus="this.blur()"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="list_price"><input name="cost_price" type="hidden"><input name="real_cost_price" type="hidden"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="off_discount" value="0"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
</thead>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","总计")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","订单附件")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=crm_order&fieldname=attachment_name')"><%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","销售人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="sales_name" type="hidden" value="<%=exchange.toHtml(rs.getString("sales_name"))%>"><%=exchange.toHtml(rs.getString("sales_name"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","销售编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="sales_ID" type="hidden" value="<%=rs.getString("sales_ID")%>"><%=rs.getString("sales_ID")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="type" type="hidden" value="<%=exchange.toHtml(rs.getString("type"))%>"><%=exchange.toHtml(rs.getString("type"))%></td>
<input name="register_ID" type="hidden" value="<%=register_ID%>">
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" height="65" width="9%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
<input name="product_amount" type="hidden" value="<%=i-1%>">
<input name="modify_tag" type="hidden" value="<%=rs.getString("modify_tag")%>">
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
crm_db.close();
crmdb.close(); 
}
catch (Exception ex){
ex.printStackTrace();
}
%>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
}else{
crmdb.close();
crm_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="order_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","该记录已提交审核，请返回！")%></td>
 </tr>
</table>
</div>
<%}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>