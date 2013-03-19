<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db designdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
String product_ID=request.getParameter("product_ID");
%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="post" action="../../design_price_change_register_alarm_ok?product_ID=<%=product_ID%>" onSubmit="return doValidate('../../xml/design/design_file.xml','mutiValidation')">
<%
if(vt.validata((String)session.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"check_tag").equals("1")){
	String list_price2=request.getParameter("list_price") ;
StringTokenizer tokenTO4 = new StringTokenizer(list_price2,","); 
String list_price="";
 while(tokenTO4.hasMoreTokens()) {
  String list_price1 = tokenTO4.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter("cost_price") ;
StringTokenizer tokenTO5 = new StringTokenizer(cost_price2,","); 
String cost_price="";
 while(tokenTO5.hasMoreTokens()) {
  String cost_price1 = tokenTO5.nextToken();
		cost_price +=cost_price1;
		}
int n=0;
		if(!validata.validata(list_price)){
			n++;
		}
		if(!validata.validata(cost_price)){
			n++;
		}
if(n==0){
%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register_time="";
try{
	String sql4 = "select * from design_config_public_char where kind='priceAlarm'";
 		ResultSet rs4=design_db.executeQuery(sql4);
 		double rate=0.0d;
 		while(rs4.next()){
			rate=Double.parseDouble(rs4.getString("type_name"))/100;
		} 
	String sqll = "select * from design_file where product_ID='"+product_ID+"'" ;
	ResultSet rss = designdb.executeQuery(sqll) ;
	while(rss.next()){
	String provider_group=exchange.unHtml(rss.getString("provider_group"));
	String product_describe=exchange.unHtml(rss.getString("product_describe"));
if(rss.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rss.getString("register_time");
}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_alarm.jsp?product_ID=<%=product_ID%>"></div>
</td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double price_odds=Double.parseDouble(cost_price)-rss.getDouble("real_cost_price");
		 if(Math.abs(price_odds/Double.parseDouble(cost_price))>=rate){
%>
	<td align="left"><font color="red"><%=demo.getLang("erp","成本单价与参考成本单价的差额超出报警比例，您确认提交吗？")%>
<%
		 }else{	
%>
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您确认提交吗？")%>
<%}%>
 </tr>
</table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>


 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="86.5%" colspan="3"><input name="product_ID" type="hidden" style="width: 100%; background-color:#C9E7DC" value="<%=rss.getString("product_ID")%>"><%=rss.getString("product_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="product_name" type="hidden" value="<%=exchange.toHtml(rss.getString("product_name"))%>"><%=exchange.toHtml(rss.getString("product_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","制造商")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="factory_name" type="hidden"value="<%=exchange.toHtml(rss.getString("factory_name"))%>"><%=exchange.toHtml(rss.getString("factory_name"))%>
 &nbsp;</td>
 </tr>
 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="select3" type="hidden"value="<%=rss.getString("chain_id")%>/<%=exchange.toHtml(rss.getString("chain_name"))%>"><%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品简称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="product_nick" type="hidden"value="<%=exchange.toHtml(rss.getString("product_nick"))%>"><%=exchange.toHtml(rss.getString("product_nick"))%>&nbsp;
 </td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","用途类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="type" type="hidden"value="<%=exchange.toHtml(rss.getString("type"))%>"><%=exchange.toHtml(rss.getString("type"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档次级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="product_class" type="hidden"value="<%=exchange.toHtml(rss.getString("product_class"))%>"><%=exchange.toHtml(rss.getString("product_class"))%>
 &nbsp;</td>
 </tr>	
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计量单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="personal_unit" type="hidden"value="<%=exchange.toHtml(rss.getString("personal_unit"))%>"><%=exchange.toHtml(rss.getString("personal_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计量值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="personal_value" type="hidden" value="<%=exchange.toHtml(rss.getString("personal_value"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rss.getDouble("personal_value"))%>&nbsp;
 </td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","市场单价(元)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="list_price" style="width:49%" value="<%=list_price%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计划成本单价")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="cost_price" style="width:49%" value="<%=cost_price%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","成本单价")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rss.getDouble("real_cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","保修期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="warranty" type="hidden"value="<%=exchange.toHtml(rss.getString("warranty"))%>"><%=exchange.toHtml(rss.getString("warranty"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","替代品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="twin_name" type="hidden"value="<%=exchange.toHtml(rss.getString("twin_name"))%>"><%=exchange.toHtml(rss.getString("twin_name"))%>&nbsp;</td>
 </tr>	
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","替代品编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="twin_ID" type="hidden" value="<%=rss.getString("twin_ID")%>"><%=rss.getString("twin_ID")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生命周期(年)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="lifecycle" type="hidden"value="<%=exchange.toHtml(rss.getString("lifecycle"))%>"><%=exchange.toHtml(rss.getString("lifecycle"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="amount_unit" type="hidden"value="<%=exchange.toHtml(rss.getString("amount_unit"))%>"><%=exchange.toHtml(rss.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
 </tr>
<%
String[] attachment_name1=DealWithString.divide(rss.getString("attachment_name"),20);	
%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td colspan="3" <%=TD_STYLE21%> class="TD_STYLE2" width="86.5%"><a href="javascript:winopen('query_attachment.jsp?id=<%=rss.getString("id")%>&tablename=design_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","产品描述")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="product_describe"><%=product_describe%></textarea>
</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","供应商集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rss.getString("provider_group")%></td>
</tr>	
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品经理")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="select4" type="hidden" value="<%=rss.getString("responsible_person_ID")%>/<%=exchange.toHtml(rss.getString("responsible_person_name"))%>"><%=rss.getString("responsible_person_ID")%>/<%=exchange.toHtml(rss.getString("responsible_person_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="changer" type="hidden" value="<%=exchange.toHtml(changer)%>"><%=exchange.toHtml(changer)%></td>
</tr>	
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="changer_ID" style="width:49%"></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%>&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="change_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
	<input name="lately_change_time" type="hidden" value="<%=exchange.toHtml(rss.getString("change_time"))%>">
	<input name="file_change_amount" type="hidden" value="<%=rss.getString("file_change_amount")%>">
</table>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%
	 design_db.close();	
}
designdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
designdb.close();
	design_db.close();	
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick="history.back()"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","市场单价、成本单价必须是数字，请返回！")%></td>
 </tr>
 </table>
<%}
}else{
designdb.close();
design_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该产品已变更，请返回！")%></td>
 </tr>
 </table>
<%}%>
</form>
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>