<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*,include.get_name_from_ID.getNameFromID"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="getRateFromID" class="include.get_rate_from_ID.getRateFromID" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db purchasedb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/qcs/qcs/stock.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script language="javascript" src="../../javascript/include/div/divViewChange.js"></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<%
getNameFromID getnamefromid=new getNameFromID();
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register=(String)session.getAttribute("realeditorc");
String register_id=(String)session.getAttribute("human_IDD");
String product_id=request.getParameter("product_id") ;
String product_name=exchange.unURL(request.getParameter("product_name")) ;
try{
	String quality_way=getnamefromid.getNameFromID((String)session.getAttribute("unit_db_name"),"design_file","product_id",product_id,"stock_qcs_way");
if(!quality_way.equals("")){
%>
<%String table_width1="1205px";%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","调度完成")%>" onClick="showApplyOk('<%=product_id%>');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","库存明细单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=product_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="100%" value="<%=product_name%>" readonly /></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检方式")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="stock_qcs_way" name="stock_qcs_way" type="text" width="100%" value="<%=quality_way%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","库房名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","存储地址")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","当前库存数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","质检申请")%></td>
 </tr>
<%
String sql6="select * from stock_balance_details where product_id='"+product_id+"' order by stock_ID";
ResultSet rs6=purchase_db.executeQuery(sql6);
int i=1;
while(rs6.next()){
String style="cursor:hand;color:blue;";
String apply_tag=demo.getLang("erp","申请");
String onclick_chain="onclick=\"showBill(\'"+i+"\')\";";
if(rs6.getString("qcs_apply_tag").equals("1")){apply_tag=demo.getLang("erp","已申请");onclick_chain="";style="";}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1" id="">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" id="stock_name<%=i%>"><%=exchange.toHtml(rs6.getString("stock_name"))%></td>
 <input type="hidden" id="stock_id_hidden<%=i%>" value="<%=rs6.getString("stock_id")%>"/>
 <td <%=TD_STYLE2%> class="TD_STYLE2" id="nick_name<%=i%>"><%=exchange.toHtml(rs6.getString("nick_name"))%></td>
 <%
double serial_number_tag=getRateFromID.getRateFromID((String)session.getAttribute("unit_db_name"),"stock_cell","product_id",product_id,"serial_number_tag");
if(serial_number_tag==0){%>
<td <%=TD_STYLE2%> class="TD_STYLE2" id="amount<%=i%>"><%=rs6.getDouble("amount")%></td>
<%}else if(serial_number_tag==1){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" id="amount<%=i%>"><a href="queryBalance_sn_details_getpara.jsp?product_id=<%=product_id%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(product_name))%>&&stock_name=<%=toUtf8String.utf8String(exchange.toURL(rs6.getString("stock_name")))%>&&amount=<%=rs6.getDouble("amount")%>"><%=rs6.getDouble("amount")%></a></td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2" id="amount<%=i%>"><a href="queryBalance_bn_details_getpara.jsp?product_id=<%=product_id%>&&product_name=<%=toUtf8String.utf8String(exchange.toURL(product_name))%>&&stock_name=<%=toUtf8String.utf8String(exchange.toURL(rs6.getString("stock_name")))%>&&amount=<%=rs6.getDouble("amount")%>"><%=rs6.getDouble("amount")%></a></td>
<%}%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><div  style="<%=style%>" <%=onclick_chain%> id="apply<%=i%>"><%=apply_tag%></div></td>
</tr>
<%
i++;}
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<div id="bill_div" nseerDef="dragAble" style="position:absolute;left:200px;top:100px;display:none;width:730px;height:480px;overflow:hidden;z-index:1;background:#E8E8E8;">

  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif" ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>

<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div style="height:350px">
<form id="qcs_apply" name="qcs_apply" method="POST">
<table width="670px">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" onClick="registerOk('qcs_apply');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","退出")%>" onClick="document.getElementById('bill_div').style.display='none';"></td>
 </tr>
 </table>
<%table_width="670px";%>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","库存质检申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp","申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="apply_id" name="apply_id" type="text" width="100%" onfocus="alert('<%=demo.getLang("erp","申请单编号由系统生成")%>');this.blur();" value="" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp","库房名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="div_stock_name" name="div_stock_name" type="text" width="100%" value="" readonly /><input type="hidden" id="div_stock_id_hidden" name="div_stock_id_hidden" value=""/></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","存储地址")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","当前库存数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","标签号")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_product_id" name="div_product_id" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_product_name" name="div_product_name" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_amount_unit" name="div_amount_unit" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_nick_name" name="div_nick_name" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_amount" name="div_amount" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_label" name="div_label" type="text" width="100%" readonly /></td>
</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp","申请人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="div_register" name="div_register" type="text" width="100%" value="<%=register%>" readonly /><input id="div_register_id" name="div_register_id" type="hidden" width="100%" value="<%=register_id%>" readonly /></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp","申请时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="div_register_time" name="div_register_time" type="text" width="100%" value="<%=time%>" readonly /></td>
 </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><textarea style="height:40px;" <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="div_remark" /></textarea></td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
 </form>
</div>

</TD>
<TD  background="../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
<%
 String sql = "select amount_unit from design_file where product_id='"+product_id+"'" ;
 ResultSet rs = purchasedb.executeQuery(sql) ;
if(rs.next()){
%>
<input type="hidden" id="amount_unit_hidden" value="<%=rs.getString("amount_unit")%>">
<%
}
	purchase_db.close();
	purchasedb.close();
	
}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick=location="stock.jsp" value="<%=demo.getLang("erp","返回")%>"></div></td>
</tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该产品尚未制定质检方式！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
  </div>
<%}	
	}catch (Exception ex){
ex.printStackTrace();
}
%>
