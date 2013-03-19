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
<jsp:useBean id="available" class="stock.getBalanceAmountDetails" scope="request"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
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
<%
String pay_ID=request.getParameter("pay_ID") ;
String checker=(String)session.getAttribute("realeditorc");
String checker_ID=(String)session.getAttribute("human_IDD");
String[] stock=new String[1000];
int m=0;
String sql3="select * from stock_config_public_char where responsible_person_ID like '%"+checker_ID+"%'";
ResultSet rs3=stock_db.executeQuery(sql3);
while(rs3.next()){
	stock[m]=rs3.getString("stock_ID")+"/"+rs3.getString("stock_name");
	m++;
}
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
if(vt.validata((String)session.getAttribute("unit_db_name"),"stock_transfer_pay","pay_ID",pay_ID,"check_tag").equals("5")||vt.validata((String)session.getAttribute("unit_db_name"),"stock_transfer_pay","pay_ID",pay_ID,"check_tag").equals("9")){
try{
String sql="select * from stock_transfer_pay where pay_ID='"+pay_ID+"'";
ResultSet rs=stockdb.executeQuery(sql);
if(rs.next()){
	String remark=exchange.unHtml(rs.getString("remark"));
	String reasonexact = rs.getString("reasonexact"); 
StringTokenizer tokenTO3 =null;
String stock_ID ="";
String stock_name="";
if(!reasonexact.equals(" /")){
tokenTO3 = new StringTokenizer(reasonexact,"/"); 

 while(tokenTO3.hasMoreTokens()) {
  stock_ID = tokenTO3.nextToken();
				stock_name = tokenTO3.nextToken();
		}
}else{
 tokenTO3 = new StringTokenizer(reasonexact,"/"); 
 if(tokenTO3.hasMoreTokens()) {
  stock_ID = tokenTO3.nextToken();}
}
%>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<form id="mutiValidation" method="POST">
<!-- ############################################ -->
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_stock_transferPay_draft_ok'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_stock_transferPay_check_ok?pay_ID=<%=rs.getString("pay_ID")%>');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="winopen('transferPay_product_list.jsp')" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<!-- ############################################ -->
<div id="nseerGround" class="nseerGround"> 
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","内部调出申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="pay_ID" type="hidden" value="<%=rs.getString("pay_ID")%>"><%=rs.getString("pay_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","调出库")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="hidden" name="reasonexact" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>"><%=exchange.toHtml(rs.getString("reasonexact"))%></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit>
<thead>
<tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","点选")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品编号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","申请调出数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","成本单价（元）")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计（元）")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%">&nbsp;</td>
 </tr>
<%
int i=1;
String sql6="select * from stock_transfer_pay_details where pay_ID='"+pay_ID+"'";
ResultSet rs6=stock_db.executeQuery(sql6);
while(rs6.next()){
%>
<input name="balance_amount<%=i%>" type="hidden" value="<%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),stock_name)%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_name<%=i%>" type="hidden" value="<%=exchange.toHtml(rs6.getString("product_name"))%>"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_ID<%=i%>" type="hidden" value="<%=rs6.getString("product_ID")%>"><%=rs6.getString("product_ID")%></td>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_describe<%=i%>" type="hidden" value="<%=rs6.getString("product_describe")%>"><%=rs6.getString("product_describe")%></td>
 
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount_unit<%=i%>" type="hidden" value="<%=exchange.toHtml(rs6.getString("amount_unit"))%>"><%=exchange.toHtml(rs6.getString("amount_unit"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount<%=i%>" value="<%=demo.qformat(rs6.getDouble("amount"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price<%=i%>" type="hidden" value="<%=rs6.getDouble("cost_price")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="transferPay_delete_details.jsp?id=<%=rs6.getString("id")%>&&pay_ID=<%=rs.getString("pay_ID")%>"><%=demo.getLang("erp","删除")%></a></td>
 </tr>
<%
	i++;
	}
	stock_db.close();
%>
<input name="product_amount" type="hidden" value="<%=i-1%>">

<!-- ############################################ -->
<tr style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox"  type="checkbox"id=checkLine></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span name="product_describe_ok" style="width:120px;background:#ffffff"></span><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe" type="hidden" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount"><input name="balance_amount" type="hidden"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 </tr>
</thead>
</table>
<!-- ############################################ -->
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总件数")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=demo.qformat(rs.getDouble("demand_amount"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总金额")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(rs.getString("register"))%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" onfocus="setday(this)" value="<%=exchange.toHtml(rs.getString("register_time"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=exchange.toHtml(checker)%>">
 <input name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>">
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" height="65" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="7" width="86.5%">
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
stockdb.close();
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
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="transferPay_list.jsp"></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已保存草稿，请返回")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>