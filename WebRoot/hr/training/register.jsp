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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="POST" action="../../hr_training_register_ok" onSubmit="return doValidate('../../xml/hr/hr_training.xml','mutiValidation')">    
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../hr_training_register_draft_ok','../../xml/hr/hr_training.xml'",request)%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()">
 </div></td>
 </tr>
</table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_ID=request.getParameter("human_ID");
try{
	String sqll = "select * from hr_file where human_ID='"+human_ID+"'" ;
	ResultSet rss = hr_db.executeQuery(sqll) ;
	if(rss.next()){
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="3"><input name="human_ID" type="hidden" value="<%=rss.getString("human_ID")%>"><%=rss.getString("human_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_name" type="hidden" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_name"))%>"><%=exchange.toHtml(rss.getString("human_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_first_kind" type="hidden" style="width:49%" value="<%=rss.getString("human_major_first_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_first_kind_name"))%>"><%=exchange.toHtml(rss.getString("human_major_first_kind_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_second_kind" type="hidden" style="width:49%" value="<%=rss.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%>"><%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%></td>
 <input name="chain_name" type="hidden" value="<%=rss.getString("chain_name")%>">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训项目")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="training_item" style="width:49%">
<%	
  String sql9= "select * from hr_config_public_char where kind='培训项目' order by id" ;
	 ResultSet rs9 = hr_db.executeQuery(sql9) ;
while(rs9.next()){%>
		<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>"><%=exchange.toHtml(rs9.getString("type_name"))%></option>
<%
}
%>
</select></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训课时")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" style="width:49%" name="training_hour"></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训成绩")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="training_result_degree" style="width:49%">
<%
  String sql6= "select * from hr_config_public_char where kind='培训成绩' order by id" ;
	 ResultSet rs6 = hr_db.executeQuery(sql6) ;
while(rs6.next()){%>
		<option value="<%=exchange.toHtml(rs6.getString("type_name"))%>"><%=exchange.toHtml(rs6.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" style="width:49%" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="register_time" type="hidden" style="width:49%" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" >
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
<td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"> &nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"> &nbsp;</td>
	</tr> 
 </table> 
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%}
			 hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}				 
%>
</form>
</div>