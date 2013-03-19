<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hrdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String checker=(String)session.getAttribute("realeditorc");
String checker_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_ID=request.getParameter("human_ID");
String config_id=request.getParameter("config_id");
String training_time=request.getParameter("training_time");
String sql90="select id from hr_workflow where object_ID='"+human_ID+"' and training_time='"+training_time+"' and check_tag='0' and type_id='05' and config_id<'"+config_id+"'";
ResultSet rs90=hr_db.executeQuery(sql90);
if(!rs90.next()){
String training_amount="";
String lately_change_time="";
String file_change_amount="";
String sql8 = "select * from hr_training where human_ID='"+human_ID+"' and check_tag='0'" ;
	ResultSet rs8 = hrdb.executeQuery(sql8) ;
	if(rs8.next()){
try{
	String sql1="select * from hr_file where human_ID='"+human_ID+"'";
	ResultSet rs1= hr_db.executeQuery(sql1) ;
	if(rs1.next()){
		lately_change_time=rs1.getString("change_time");
		file_change_amount=rs1.getString("file_change_amount");
		training_amount=rs1.getString("training_amount");
	}
	String sql = "select * from hr_training where human_ID='"+human_ID+"' and check_tag='0'" ;
	ResultSet rs = hrdb.executeQuery(sql) ;
	if(rs.next()){
		String remark=exchange.unHtml(rs.getString("remark"));
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?human_ID=<%=human_ID%>&&config_id=<%=config_id%>&&training_time=<%=training_time%>";
}else{
form.action = "../../hr_training_check_ok?human_ID=<%=human_ID%>&&config_id=<%=config_id%>&&training_time=<%=training_time%>";
}
}
</script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" class="x-form" method="POST" onSubmit="return doValidate('../../xml/hr/hr_training.xml','mutiValidation')&&TwoSubmit(this)">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%>&nbsp;<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind><%=demo.getLang("erp","通过")%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp;"></td> 
 </tr> 
 </table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="3"><input name="human_ID" type="hidden" style="width:60%" value="<%=rs.getString("human_ID")%>"><%=rs.getString("human_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_name" type="hidden" style="width:60%" value="<%=exchange.toHtml(rs.getString("human_name"))%>"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_first_kind" type="hidden" style="width:60%" value="<%=rs.getString("human_major_first_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_second_kind" type="hidden" style="width:60%" value="<%=rs.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训项目")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="training_item" style="width:60%">
<%
  String sql9= "select * from hr_config_public_char where kind='培训项目' order by id" ;
	 ResultSet rs9 = hr_db.executeQuery(sql9) ;
while(rs9.next()){
	if(rs.getString("training_item").equals(rs9.getString("type_name"))){%>
		<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>" selected><%=exchange.toHtml(rs9.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>"><%=exchange.toHtml(rs9.getString("type_name"))%></option>
<%
	}
}
String training_hour = new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("training_hour"))+"";
if(training_hour.equals("NaN"))
	training_hour = "00:00";
%>
  </select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训课时")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="training_hour" type="text" style="width:60%" value="<%=exchange.toHtml(training_hour)%>"></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训成绩")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="training_result_degree" style="width:60%">
<%
  String sql6= "select * from hr_config_public_char where kind='培训成绩' order by id" ;
	 ResultSet rs6 = hr_db.executeQuery(sql6) ;
while(rs6.next()){
	if(rs.getString("training_result_degree").equals(rs6.getString("type_name"))){%>
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
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="checker" style="width:60%" value="<%=exchange.toHtml(checker)%>"></td><input type="hidden" name="checker_ID" value="<%=checker_ID%>">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="check_time" style="width:60%" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
	 <td height="65" <%=TD_STYLE4%> class="TD_STYLE7" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr> 
 </table>
<input name="lately_change_time" type="hidden" value="<%=lately_change_time%>">
<input name="file_change_amount" type="hidden" value="<%=file_change_amount%>">
<input name="training_amount" type="hidden" value="<%=training_amount%>">
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
	}
	hrdb.close();
	hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	hrdb.close();
	hr_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回！")%></td>
 </tr>
</table>
<%}}else{
	 hr_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回")%></td>
 </tr>
</table>
<%}%>
</div>