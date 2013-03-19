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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="FileKind" class="include.nseer_cookie.FileKind" scope="page"/>
<link href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
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
<form id="mutiValidation" method="POST" action="register_reconfirm.jsp" onSubmit="return doValidate('../../xml/stock/stock_apply_gather.xml','mutiValidation')">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="winopen('register_product_list.jsp')" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","预览")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="history.back()" value="<%=demo.getLang("erp","返回")%>"></td>
 </tr>
 </table>
<%
try{
String register=(String)session.getAttribute("realeditorc");
String provider_ID=request.getParameter("provider_ID");
String provider_name=exchange.unURL(request.getParameter("provider_name"));
String[] aaa=FileKind.getKind((String)session.getAttribute("unit_db_name"),"purchase_file","provider_ID",provider_ID);
String purchaser=exchange.unURL(request.getParameter("purchaser"));
String purchaser_ID=request.getParameter("purchaser_ID");
String gatherer_name="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql="select * from stock_apply_gather";
ResultSet rs=stock_db.executeQuery(sql);
if(rs.next()){
	gatherer_name=rs.getString("gatherer_name");
}
%>
<div id="nseerGround" class="nseerGround">
 <%@include file="../include/paper_top.html"%>
 <input name="gatherer_name" type="hidden" value="<%=gatherer_name%>">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","放货登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<input name="provider_ID" type="hidden" value="<%=provider_ID%>">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品分类")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="fileKind_chain" value="<%=aaa[0]%> <%=exchange.toHtml(aaa[1])%>" type="hidden"><%=aaa[0]%> <%=exchange.toHtml(aaa[1])%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","放货人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="provider_name" value="<%=exchange.toHtml(provider_name)%>" type="hidden"><%=exchange.toHtml(provider_name)%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","采购人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="purchaser_ID" type="hidden" value="<%=exchange.toHtml(purchaser_ID)%>"><input name="purchaser" value="<%=exchange.toHtml(purchaser)%>" type="hidden"><%=exchange.toHtml(purchaser)%></td>

 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","入库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="reason" type="hidden" value="采购放货"><%=demo.getLang("erp","采购放货")%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","是否归还")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="not_return_tag"><option value="是"><%=demo.getLang("erp","是")%></option>
  </select></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","归还时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_return_time" onfocus="" id="date_start"></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 </tr>
 <tr style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span name="product_describe_ok" style="width:120px;background:#ffffff"></span><input type="hidden" name="product_describe" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" value="21"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_price" value="1"></td>
	 <input name="type" type="hidden" onFocus="this.blur()">
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总金额")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">&nbsp;</td> 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%" height="65"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<%
stock_db.close();
 }catch(Exception ex){ex.printStackTrace();}
%>