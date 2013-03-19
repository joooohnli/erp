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
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 
	 %>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript">
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
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
int i=1;
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register_time="";
String product_logistics_recommend_ID=request.getParameter("product_logistics_recommend_ID");
try{
	String sqll = "select * from logistics_product_providers_recommend where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"'" ;
	ResultSet rs = logistics_db.executeQuery(sqll) ;
	if(rs.next()){
		String recommend_describe=exchange.unHtml(rs.getString("recommend_describe"));
%>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" action="../../logistics_product_providers_change_ok" onSubmit="return doValidate('../../xml/logistics/logistics_product_providers_recommend.xml','mutiValidation')">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="winopen('register_provider_list.jsp')" value="<%=demo.getLang("erp","新添加")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","新删除")%>">&nbsp;<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","重新提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="history.back()" value="<%=demo.getLang("erp","返回")%>"></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","配送单位推荐单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","推荐单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="product_logistics_recommend_ID" type="hidden" value="<%=rs.getString("product_logistics_recommend_ID")%>"><%=rs.getString("product_logistics_recommend_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","推荐人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="recommender" type="hidden" value="<%=exchange.toHtml(rs.getString("recommender"))%>"><%=exchange.toHtml(rs.getString("recommender"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="product_name" type="hidden" value="<%=exchange.toHtml(rs.getString("product_name"))%>"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="product_ID" type="hidden" value="<%=rs.getString("product_ID")%>"><%=rs.getString("product_ID")%>&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<table id=tableOnlineEdit <%=TABLE_STYLE5%> class="TABLE_STYLE5">
<thead>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","点选")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","物流单位名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","所在区域")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","优质级别")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","联系人")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%">&nbsp; </td>
	</tr>
<%
String sql6="select * from logistics_product_providers_recommend_details where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' order by details_number";
ResultSet rs6=logistics_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%><input name="provider_ID<%=i%>" type="hidden" style="width: 100%" value="<%=rs6.getString("provider_ID")%>">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%><input name="provider_name<%=i%>" type="hidden" style="width: 100%" value="<%=exchange.toHtml(rs6.getString("provider_name"))%>"></td>
<%
String sql7="select * from logistics_file where provider_ID='"+rs6.getString("provider_ID")+"'";
ResultSet rs7=logisticsdb.executeQuery(sql7);
if(rs7.next()){	
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("type"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_class"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_tel1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("contact_person1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="../../logistics_product_providers_change_delete_details?id=<%=rs6.getString("id")%>&&product_logistics_recommend_ID=<%=product_logistics_recommend_ID%>"><%=demo.getLang("erp","删除")%></a></td>
 </tr>
<%
}else{
%>
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="../../logistics_product_providers_change_delete_details?id=<%=rs6.getString("id")%>&&product_logistics_recommend_ID=<%=product_logistics_recommend_ID%>"><%=demo.getLang("erp","删除")%></a></td>
 </tr>
<%
	 }
	i++;
	}
%>
 <tr style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="provider_ID" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="provider_name" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="type" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="provider_class" type="text" onFocus="this.blur()"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="provider_tel1" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="contact_person1" onFocus="this.blur()"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="provider_web" type="hidden" onFocus="this.blur()">&nbsp;</td>
 </tr>
</thead>
</table>
<input name="provider_amount" type="hidden" style="width: 100%" value="<%=i-1%>">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","变更人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="changer" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=exchange.toHtml(changer)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","变更时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="change_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","推荐要求")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="recommend_describe"><%=recommend_describe%></textarea>
</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
}
	logistics_db.close();
	logisticsdb.close();
	}
catch (Exception ex){
out.println("error"+ex);
}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>