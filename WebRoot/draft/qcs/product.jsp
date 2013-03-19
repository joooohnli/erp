<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_cookie.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%isPrint isPrint=new isPrint(request);%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<head>
<link rel="stylesheet" type="text/css" href="../../css/qcs/purchase/purchase.css" />
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/draft/qcs/product.js"></script>
<script language="javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<%

try{
String qcs_id=request.getParameter("qcs_id");
String register=(String)session.getAttribute("realeditorc");
String register_id=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String sql="select * from qcs_product_config where qcs_id='"+qcs_id+"' and (check_tag='5' or check_tag='9')";
ResultSet rs=qcs_db.executeQuery(sql);
if(rs.next()){
%>
<body onload="locateSelectDiv()">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data">
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2"></td>
<td <%=TD_STYLE1%> class="TD_STYLE8">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_qcs_product_draft_ok','../../xml/qcs/qcs_product_config.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_qcs_product_check_ok','../../xml/qcs/qcs_product_config.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","产品质检配置单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","配置单编号")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="qcs_id" name="qcs_id" type="text" width="100%" value="<%=qcs_id%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","产品编号")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=rs.getString("product_id")%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","产品名称")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="100%" value="<%=rs.getString("product_name")%>" readonly /></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","采购质检方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="purchase_qcs_way" name="purchase_qcs_way" type="text" width="100%"  onclick="loadAjaxDiv('purchase_qcs_way');this.blur();" value="<%=rs.getString("purchase_qcs_way")%>" readonly /><div class="select_div_l" id="purchase_qcs_way_div"  onclick="loadAjaxDiv('purchase_qcs_way')"></div></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","委外质检方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="intrmanu_qcs_way" name="intrmanu_qcs_way" type="text" width="100%"  onclick="loadAjaxDiv('intrmanu_qcs_way');this.blur();" value="<%=rs.getString("intrmanu_qcs_way")%>" readonly /><div class="select_div_r" id="intrmanu_qcs_way_div" onclick="loadAjaxDiv('intrmanu_qcs_way')"></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","发货质检方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="crm_deliver_qcs_way" name="crm_deliver_qcs_way" type="text" width="100%"  onclick="loadAjaxDiv('crm_deliver_qcs_way');this.blur();" value="<%=rs.getString("crm_deliver_qcs_way")%>" readonly /><div class="select_div_l" id="crm_deliver_qcs_way_div"  onclick="loadAjaxDiv('crm_deliver_qcs_way')"></div></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","库存质检方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="stock_qcs_way" name="stock_qcs_way" type="text" width="100%"  onclick="loadAjaxDiv('stock_qcs_way');this.blur();" value="<%=rs.getString("stock_qcs_way")%>" readonly /><div class="select_div_l" id="stock_qcs_way_div"  onclick="loadAjaxDiv('stock_qcs_way')"></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","生产入库质检方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="manu_product_qcs_way" name="manu_product_qcs_way" type="text" width="100%"  onclick="loadAjaxDiv('manu_product_qcs_way');this.blur();" value="<%=rs.getString("manu_product_qcs_way")%>" readonly /><div class="select_div_l" id="manu_product_qcs_way_div"  onclick="loadAjaxDiv('manu_product_qcs_way')"></div></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","生产工序质检方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="manu_procedure_qcs_way" name="manu_procedure_qcs_way" type="text" width="100%"  onclick="loadAjaxDiv('manu_procedure_qcs_way');this.blur();" value="<%=rs.getString("manu_procedure_qcs_way")%>" readonly /><div class="select_div_r" id="manu_procedure_qcs_way_div"  onclick="loadAjaxDiv('manu_procedure_qcs_way')"></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","其他质检方式")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="other_qcs_way" name="other_qcs_way" type="text" width="100%"  onclick="loadAjaxDiv('other_qcs_way');this.blur();" value="<%=rs.getString("other_qcs_way")%>" readonly /><div class="select_div_r" id="other_qcs_way_div"  onclick="loadAjaxDiv('other_qcs_way')"></div></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%">&nbsp;</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register" name="register" type="text" width="37%" value="<%=register%>" readonly /><input id="register_id" name="register_id" type="hidden" value="<%=register_id%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","登记时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="35%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="change_time" name="change_time" type="text" width="37%" value="<%=time%>" readonly /></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="15%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="85%" colspan="3"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" /><%=exchange.unURL(rs.getString("remark"))%></textarea></td>
</tr>
<%=isPrint.hasOrNot3d(rs.getString("attachment1"),"附件&nbsp;&nbsp;&nbsp;","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,rs.getString("id"),"qcs_product_config")%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</body>
<%
}
 qcs_db.close();
}catch(Exception ex){
ex.printStackTrace();
}		
%>