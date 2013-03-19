<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,include.get_name_from_ID.getNameFromID" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");
%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
	nseer_db qcs_db = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<%
	nseer_db qcsdb = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/qcs/qcs/manufactureProduct.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script language="javascript" src="../../javascript/include/div/divViewChange.js"></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<%
	getNameFromID getnamefromid = new getNameFromID();
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
	String register = (String) session.getAttribute("realeditorc");
	String register_id = (String) session.getAttribute("human_IDD");
	String gather_id = request.getParameter("gather_id");
	String stock_ID = "";
	try {
	String sql6 = "select * from stock_gather_details where gather_id='"+ gather_id + "' order by details_number";
	ResultSet rs6 = qcs_db.executeQuery(sql6);
	int p = 0;
	List qcsWay_list=(List)(new java.util.ArrayList());
	while (rs6.next()) {
	String qcs_way=getnamefromid.getNameFromID((String) session.getAttribute("unit_db_name"),"design_file", "product_id", rs6.getString("product_id"),"manu_product_qcs_way");
				qcsWay_list.add(qcs_way);
				if(qcs_way.equals("")){p++;}
				}
	if(p==0){
		String sql = "select * from stock_gather where gather_id='"
				+ gather_id + "'";
		ResultSet rs = qcsdb.executeQuery(sql);
		if (rs.next()) {
			String sql3 = "select * from stock_config_public_char where describe1='库房' and responsible_person_ID like '%"+ register_id + "%'";
			ResultSet rs3 = qcs_db.executeQuery(sql3);
			while (rs3.next()) {
				stock_ID += rs3.getString("stock_ID") + ",";
			}
%>
<%
	String table_width1 = "100%";
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp", "调度完成")%>" onClick="showApplyOk('<%=gather_id%>');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp", "返回")%>" onClick="history.back();"></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "入库单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "入库单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="gather_id" name="gather_id" type="text" width="100%" value="<%=gather_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "入库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="reason" name="reason" type="text" width="100%" value="<%=exchange.toHtml(rs.getString("reason"))%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "入库详细理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="reasonexact" name="reasonexact" type="text" width="100%" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>/<%=exchange.toHtml(rs									.getString("reasonexact_details"))%>" readonly /></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp", "产品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "产品名称")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp", "应入库件数")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp", "已入库件数")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp", "质检方式")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp", "质检申请")%></td>
 </tr>
<%
	String product_id = "";
			String gather_details_number = "";
			sql6 = "select * from stock_gather_details where gather_id='"+ gather_id + "' order by details_number";
			rs6 = qcs_db.executeQuery(sql6);
			int i = 1;
			while (rs6.next()) {
				gather_details_number = rs6.getString("details_number");
				product_id = rs6.getString("product_id");
				String style = "cursor:hand;color:blue;";
				String apply_tag = demo.getLang("erp", "申请");
				String qcsApply_tag="0";
				String onclick_chain = "onclick=\"showBill(\'" + i+ "\')\";";
				if (rs6.getString("qcs_apply_tag").equals("1")) {
					apply_tag = demo.getLang("erp", "已申请");
					qcsApply_tag="1";
					onclick_chain = "";
					style = "";
				}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2" id="product_id<%=i%>"><%=rs6.getString("product_id")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" id="product_name<%=i%>"><%=exchange
										.toHtml(rs6.getString("product_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" id="amount<%=i%>"><%=rs6.getDouble("amount")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" id="gathered_amount<%=i%>"><%=rs6.getDouble("gathered_amount")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" id="qcs_way<%=i%>" value="<%=qcsWay_list.get(i-1)%>"><%=qcsWay_list.get(i-1)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><div  style="<%=style%>" <%=onclick_chain%> id="apply<%=i%>"><%=apply_tag%></div><input type="hidden" id="qcsApply_tag<%=i%>" value="<%=qcsApply_tag%>"></td>
 </tr>
<%
	i++;
			}
%>
</table>
<input type="hidden" id="product_amount" value="<%=i-1%>">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "应入库总件数")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="demand_amount" name="demand_amount" type="text" width="37%" value="<%=rs.getString("demand_amount")%>" readonly /></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "已入库总件数")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="demand_amount" name="demand_amount" type="text" width="37%" value="<%=rs.getString("gathered_amount")%>" readonly /></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register" name="register" type="text" width="37%" value="<%=exchange.toHtml(rs.getString("register"))%>" readonly /></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register_time" name="register_time" type="text" width="37%" value="<%=exchange.toHtml(rs.getString("register_time"))%>" readonly /></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="checker" name="checker" type="text" width="37%" value="<%=exchange.toHtml(rs.getString("checker"))%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="check_time" name="check_time" type="text" width="37%" value="<%=exchange.toHtml(rs.getString("check_time"))%>" readonly /></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp", "审核意见")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" readonly /><%=exchange.toHtml(rs.getString("remark"))%></textarea></td>
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

<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp", "恩信科技开源ERP")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>

<div style="height:350px">
<form id="qcs_apply" name="qcs_apply" method="POST">
<table width="670px">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp", "确定")%>" onClick="registerOk('qcs_apply');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp", "退出")%>" onClick="document.getElementById('bill_div').style.display='none';"></td>
 </tr>
 </table>
<%
	table_width = "670px";
%>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "生产入库质检申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp", "申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="apply_id" name="apply_id" type="text" width="100%" onfocus="alert('<%=demo.getLang("erp", "申请单编号由系统生成")%>');this.blur();" value="" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp", "入库单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="div_gather_id" name="div_gather_id" type="text" width="100%" value="<%=gather_id%>" readonly /></td>
</tr>
</table>
<input type="hidden" id="gather_details_number" name="gather_details_number" value="<%=gather_details_number%>">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp", "产品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp", "产品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp", "单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp", "应入库件数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp", "标签号")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_product_id" name="div_product_id" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_product_name" name="div_product_name" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_amount_unit" name="div_amount_unit" type="text" width="100%" readonly /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" id="div_demand_amount" name="div_demand_amount" type="text" width="100%" readonly /></td>
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp", "申请人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="div_register" name="div_register" type="text" width="100%" value="<%=register%>" readonly /><input id="div_register_id" name="div_register_id" type="hidden" width="100%" value="<%=register_id%>" readonly /></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="20%"><%=demo.getLang("erp", "申请时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="div_register_time" name="div_register_time" type="text" width="100%" value="<%=time%>" readonly /></td>
 </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "备注")%>：</td>
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
	sql = "select amount_unit from design_file where product_id='"+ product_id + "'";
			rs = qcsdb.executeQuery(sql);
			if (rs.next()) {
%>
<input type="hidden" id="amount_unit_hidden" value="<%=rs.getString("amount_unit")%>">
<%
	}
		}
		}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="manufactureProduct.jsp"></div></td>
</tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","尚有产品未配置质检方式，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
</table>
</div>
<%		
		}
		qcs_db.close();
		qcsdb.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>