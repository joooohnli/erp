<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db logisticsdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String discussion_ID=request.getParameter("discussion_ID") ;
String processer=(String)session.getAttribute("realeditorc");
String processer_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
try{
String sql="select * from logistics_discussion where discussion_ID='"+discussion_ID+"' and discussion_tag!='2'";
ResultSet rs=logisticsdb.executeQuery(sql);
if(rs.next()){
	String remark=exchange.unHtml(rs.getString("remark"));
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "../../logistics_discussion_dealwith_ok?discussion_ID=<%=rs.getString("discussion_ID")%>";
}else{
form.action = "dealwith_delete_reconfirm.jsp?discussion_ID=<%=rs.getString("discussion_ID")%>";
}
}
</script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/logistics/logistics_discussion.xml','mutiValidation')&&TwoSubmit(this)">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","处理完成")%><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind><%=demo.getLang("erp","转垃圾箱")%>&nbsp;<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="dealwith_list.jsp"></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","配送报价单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","报价单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="87%"><input name="discussion_ID" type="hidden" value="<%=rs.getString("discussion_ID")%>"><%=rs.getString("discussion_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","物流单位名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="provider_name" type="hidden" value="<%=exchange.toHtml(rs.getString("provider_name"))%>"><%=exchange.toHtml(rs.getString("provider_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","物流单位编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="provider_ID" type="hidden" value="<%=rs.getString("provider_ID")%>"><%=rs.getString("provider_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","电话")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_contact_person_tel" value="<%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","拟发货时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_pay_time" onfocus="" id="date_start" value="<%=exchange.toHtml(rs.getString("demand_pay_time"))%>"></td>
 </tr>
<input name="demand_contact_person" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_contact_person"))%>">
<input name="demand_contact_person_fax" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_contact_person_fax"))%>">
<input name="change_time" type="hidden" value="<%=exchange.toHtml(time)%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","运费（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","推荐物流单位")%></td>
 </tr>
<%
int i=1;
String sql6="select * from logistics_discussion_details where discussion_ID='"+rs.getString("discussion_ID")+"'";
ResultSet rs6=logistics_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="../product_providers/query_product.jsp?product_ID=<%=rs6.getString("product_ID")%>" target="_blank"><%=rs6.getString("product_ID")%></a></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" value="<%=exchange.toHtml(rs6.getString("product_name"))%>" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><div><%=rs6.getString("product_describe")%></div><input type="hidden" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" onFocus="this.blur()" value="<%=rs6.getString("product_describe")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount<%=i%>" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("amount"))%>" onFocus="this.blur()"></td>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit<%=i%>" value="<%=exchange.toHtml(rs6.getString("amount_unit"))%>" onFocus="this.blur()"></td>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="list_price<%=i%>" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("list_price"))%>" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price<%=i%>" type="hidden"  value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>"><input name="real_cost_price<%=i%>" type="hidden"  value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("real_cost_price"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%></td>
<%if(rs6.getString("dealwith_tag").equals("0")){%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><a href="../../logistics_discussion_dealwith_recommend_ok?discussion_ID=<%=rs.getString("discussion_ID")%>&provider_ID=<%=rs.getString("provider_ID")%>&product_ID=<%=rs6.getString("product_ID")%>&processer=<%=toUtf8String.utf8String(exchange.toURL(processer))%>&processer_ID=<%=processer_ID%>"><%=demo.getLang("erp","推荐物流单位")%></a></td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","已推荐")%></td>
<%}%>
 </tr>
<%
	i++;
	}
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","总计")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","报价单附件")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=logistics_discussion&fieldname=attachment_name')"><%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","处理人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="processer" value="<%=processer%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","处理人编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="processer_ID"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="87%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
  </table>
<%@include file="../include/paper_bottom.html"%>
 </div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
	<%
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
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="dealwith_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","对不起，该报价单已处理，请返回！")%></td>
 </tr>
</table>
</div>
	<%
}
	logistics_db.close();
	logisticsdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>