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
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-2.js"></script>
<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="strategyClassRegister" class="x-form" method="post" action="../../../purchase_config_file_strategyClass_register_ok" onSubmit="return doValidate('../../../xml/purchase/purchase_config_public_char.xml','strategyClassRegister')">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"> <div id="loaddiv" style="display:none;border:1px solid red; height:20px;background-color: #FF0033;width:80%;float :left ;" ></div>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="strategyClass.jsp"></div></td>
 </tr>
 </table>
<input name="strategyClass" type="hidden" value="供应商级别" id="kind">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","供应商优质级别名称")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="validator_dup" name="type_name" style="width:30%" onblur="ajax_validation('strategyClassRegister','kind','validator_dup','purchase_config_public_char','type_name','../../../vd6',this)"></td>
</tr>
</table> 
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</div>
