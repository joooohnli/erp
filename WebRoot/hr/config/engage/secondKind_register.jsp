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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-2.js"></script>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <form id="secondKindRegister" class="x-form" method="post" action="../../../hr_config_engage_secondKind_register_ok" onSubmit="return doValidate('../../../xml/hr/hr_config_question_first_kind.xml','secondKindRegister')">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div id="loaddiv" style="display:none;border:1px solid red; height:20px;background-color: #FF0033;width:80%;float :left ;" ></div>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="secondKind.jsp"></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","试题I级分类编号/名称")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="first_kind" class="style16" style="width=30%" id="validator_select">
<%
  String sql1 = "select * from hr_config_question_first_kind order by first_kind_ID" ;
	 ResultSet rs1 = hr_db.executeQuery(sql1) ;
				while(rs1.next()){%>
				<option value="<%=rs1.getString("first_kind_ID")%>/<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=rs1.getString("first_kind_ID")%>/<%=exchange.toHtml(rs1.getString("first_kind_name"))%></option>
<%
}
hr_db.close();
%>
  </select></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","试题II级分类名称")%>&nbsp;</td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" id="validator_dup" name="second_kind_name" style="width=30%" onblur="ajax_validation('secondKindRegister','validator_select','validator_dup','hr_config_question_second_kind','second_kind_name','../../../vd2',this)"></td>
</tr>
</table> 
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>

