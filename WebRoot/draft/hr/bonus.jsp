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
<%nseer_db hr_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<%
try{%>
<%
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_ID=request.getParameter("human_ID");
String bonus_time=request.getParameter("bonus_time");
String bonus_amount="";
String lately_change_time="";
String file_change_amount="";
String sql1="select * from hr_file where human_ID='"+human_ID+"'";
	ResultSet rs1= hr_db.executeQuery(sql1) ;
	if(rs1.next()){
		lately_change_time=rs1.getString("change_time");
		file_change_amount=rs1.getString("file_change_amount");
		bonus_amount=rs1.getString("bonus_amount");
	}
String sql="select * from hr_bonus where human_ID='"+human_ID+"' and bonus_time='"+bonus_time+"' and (check_tag='5' or check_tag='9')";
ResultSet rs = hr_db1.executeQuery(sql);
if(rs.next()){
	String remark=exchange.unHtml(rs.getString("remark"));
%>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
<div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_hr_bonus_draft_ok','../../xml/hr/hr_bonus.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_hr_bonus_check_ok','../../xml/hr/hr_bonus.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div></td> 
 </tr> 
 </table>
<input type="hidden" name="bonus_time" value="<%=bonus_time%>">
<table <%=TABLE_STYLE7%> class="TABLE_STYLE5" style="width:100%;" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="3"><input name="human_ID" style="width:60%" type="hidden" value="<%=rs.getString("human_ID")%>"><%=rs.getString("human_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_name" style="width:60%" type="hidden" value="<%=exchange.toHtml(rs.getString("human_name"))%>"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_first_kind" style="width:60%" type="hidden" value="<%=rs.getString("human_major_first_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_second_kind" style="width:60%" type="hidden" value="<%=rs.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","奖励项目")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="bonus_item" style="width:60%">
<%
  String sql9= "select * from hr_config_public_char where kind='奖励项目' order by id" ;
	 ResultSet rs9 = hr_db.executeQuery(sql9) ;
while(rs9.next()){
	if(rs.getString("bonus_item").equals(rs9.getString("type_name"))){%>
		<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>" selected><%=exchange.toHtml(rs9.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>"><%=exchange.toHtml(rs9.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","奖励价值(元)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="bonus_worth" style="width:60%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("bonus_worth"))%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","奖励等级")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="bonus_degree" style="width:60%">
<%
  String sql6= "select * from hr_config_public_char where kind='奖励等级' order by id" ;
	 ResultSet rs6 = hr_db.executeQuery(sql6) ;
while(rs6.next()){
	if(rs.getString("bonus_degree").equals(rs6.getString("type_name"))){%>
		<option value="<%=exchange.toHtml(rs6.getString("type_name"))%>" selected><%=exchange.toHtml(rs6.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs6.getString("type_name"))%>"><%=exchange.toHtml(rs6.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register" style="width:60%" value="<%=exchange.toHtml(register)%>"></td><input name="register_ID" type="hidden" value="<%=register_ID%>">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="register_time" style="width:60%" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
<td height="65" <%=TD_STYLE4%> class="TD_STYLE7" width="11%">&nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr> 
 </table>
<input name="lately_change_time" type="hidden" value="<%=exchange.toHtml(lately_change_time)%>">
<input name="file_change_amount" type="hidden" value="<%=file_change_amount%>">
<input name="bonus_amount" type="hidden" value="<%=bonus_amount%>">
</form>
</div>
<%
	hr_db.close();
	hr_db1.close();
}else{
hr_db.close();
hr_db1.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该草稿已重新登记，请返回")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="bonus_list.jsp"></div></td>
 </tr>
</table>
<%}%>
<%
}catch (Exception ex){
ex.printStackTrace();
}%>