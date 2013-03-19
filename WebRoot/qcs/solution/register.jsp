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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="sum" scope="page" class="finance.Sum"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../javascript/qcs/solution/solution.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String register=(String)session.getAttribute("realeditorc");
String register_id=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String product_id=request.getParameter("product_id");
String product_name=exchange.unURL(request.getParameter("product_name"));
%>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../qcs_solution_register_draft_ok','../../xml/qcs/qcs_solution.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="registerOk('mutiValidation');" value=<%=demo.getLang("erp","保存")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="del_button" onclick="deleteSelect('bill_body')" value=<%=demo.getLang("erp","删除")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","质检方案")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id="bill_head">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","方案编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" value="" id="solution_id" name="solution_id" onfocus="alert('<%=demo.getLang("erp","方案编号由系统生成")%>');this.blur();" /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","方案名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="solution_name" type="text" width="100%" value=""></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=product_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="100%" value="<%=product_name%>" readonly /></td>
 </tr>
 <tr>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="designer" name="designer" type="text" width="100%" value=""></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","质量标准")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="quality_standard" name="quality_standard" onchange="setDetails(this.value);">
 <option value="">
 </option>
 <%
String sql1="select standard_id,standard_name from qcs_quality_standard where product_id='"+product_id+"' and check_tag='1'";
 ResultSet rs1=qcs_db.executeQuery(sql1);
 while(rs1.next()){%>
 <option value="<%=exchange.toHtml(rs1.getString("standard_id"))%>/<%=exchange.toHtml(rs1.getString("standard_name"))%>"><%=exchange.toHtml(rs1.getString("standard_id"))%>/<%=exchange.toHtml(rs1.getString("standard_name"))%></option>
 
 <%
 } 
 %>
 </select>
 </td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="item"><%=demo.getLang("erp","质检项目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="analyse_method"><%=demo.getLang("erp","分析方法")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%" id="default_basis"><%=demo.getLang("erp","首选质检依据")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%" id="ready_basis"><%=demo.getLang("erp","备选质检依据")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%" id="quality_method"><%=demo.getLang("erp","质检方法")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="standard_value"><%=demo.getLang("erp","标准值")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="standard_max"><%=demo.getLang("erp","标准上限")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="standard_min"><%=demo.getLang("erp","标准下限")%></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=register%>"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_id" value="<%=register_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=time%>" readonly></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%" height="65"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","附件")%>&nbsp;&nbsp;&nbsp;：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file" width="100%"></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>