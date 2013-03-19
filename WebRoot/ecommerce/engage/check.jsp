<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*" import="com.fredck.FCKeditor.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db ecommerce_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<form id="mutiValidation" class="x-form" method="post" onSubmit="return doValidate('../../xml/hr/hr_major_release.xml','mutiValidation')&&TwoSubmit(this)">
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript">
 var onecount2;
 subcat2 = new Array();
 <% int p=0;
 String sql8="select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rs8=ecommerce_db.executeQuery(sql8); 
 while(rs8.next()) {%> 
 subcat2[<%=p++%>] = new 
 Array("<%=rs8.getString("id")%>","<%=rs8.getString("second_kind_ID")%>/<%=rs8.getString("second_kind_name")%>","<%=rs8.getString("first_kind_ID")%>/<%=rs8.getString("first_kind_name")%>");
 <%
	 }
 %> 
 onecount2=<%=p%>;
 function changelocation2(locationid)
  {
  mutiValidation.select5.length = 0; 
 
  var locid=locationid;
  var p;
  mutiValidation.select5.options[mutiValidation.select5.length]=new Option("",""); 
  for (p=0;p < onecount2; p++)
  {
 		 if(locid==""||locid==null){mutiValidation.select5.options[mutiValidation.select5.length]=
 			 new Option(subcat2[p][1],subcat2[p][1]);}//如果select1为空，则select5选择全部值
  else if (subcat2[p][2] == locid)
  { 
   mutiValidation.select5.options[mutiValidation.select5.length] = new Option(subcat2[p][1], 
 subcat2[p][1]);
  } 
  } 
 }
</script>
<%
String checker_ID=(String)session.getAttribute("human_IDD");
String checker=(String)session.getAttribute("realeditorc");
String register="";
String register_time="";
String release_id=request.getParameter("release_id");
String config_id=request.getParameter("config_id");
String sql6="select * from ecommerce_workflow where object_id='"+release_id+"' and check_tag='0' and config_id<'"+config_id+"'";
ResultSet rs6=ecommerce_db.executeQuery(sql6);
if(!rs6.next()){	
if(vt.validata((String)session.getAttribute("unit_db_name"),"hr_major_release","release_id",release_id,"check_tag").equals("0")){
try{
	String sqll = "select * from hr_major_release where release_id='"+release_id+"'" ;
	ResultSet rs = ecommerce_db1.executeQuery(sqll) ;
	if(rs.next()){
		
		String remark1=exchange.unHtml(rs.getString("remark1"));
		String remark2=exchange.unHtml(rs.getString("remark2"));
		String opinion=exchange.unHtml(rs.getString("opinion"));
if(rs.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rs.getString("register_time");
}
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>&release_id=<%=release_id%>";
}else{
form.action = "../../ecommerce_engage_check_ok?config_id=<%=config_id%>&release_id=<%=release_id%>";
}
}
</script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
<table height="30px" <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
 <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div>
 </td>
 </tr>
</table>

<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("chain_id"))%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","招聘类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="engage_type" style="width:60%">
<%if(rs.getString("engage_type").equals("社会招聘")){%>
  <option selected><%=demo.getLang("erp","社会招聘")%></option>
  <option><%=demo.getLang("erp","校园招聘")%></option>
<%}else{%>
  <option><%=demo.getLang("erp","社会招聘")%></option>
  <option selected><%=demo.getLang("erp","校园招聘")%></option>
<%}%>
 </select></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4" style="width:60%" 
onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
<%
  String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = ecommerce_db.executeQuery(sql4) ;
while(rs4.next()){
	if(rs.getString("human_major_first_kind_ID").equals(rs4.getString("first_kind_ID"))){
	%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>" selected><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%}else{%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
	}
}
%>

  </select></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5" style="width:60%">
	 <option value="<%=rs.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>" selected><%=rs.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></option>
	//if (mutiValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation2(mutiValidation.select4.value)
 //}
 </select></td>
 </tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","招聘人数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_amount" value="<%=rs.getString("human_amount")%>" style="width:60%"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","截止日期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="deadline" onfocus="" id="date_start" value="<%=exchange.toHtml(rs.getString("deadline"))%>" style="width:60%"></td>
	</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","职位描述")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark1"><%=remark1%></textarea>
</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","招聘要求")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark2"><%=remark2%></textarea>
</td>
</tr>  

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","审核意见")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="opinion"><%=opinion%></textarea>
</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%">&nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">&nbsp;</td>
 </tr>


<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="hidden" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register" value="<%=exchange.toHtml(register)%>"><%=exchange.toHtml(rs.getString("register"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(register_time)%>"><%=exchange.toHtml(rs.getString("register_time"))%></td>
 </tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="hidden" name="checker_ID" value="<%=checker_ID%>"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="checker" style="width:60%" value="<%=exchange.toHtml(checker)%>"></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%>&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input  name="check_time" type="hidden" width="100%" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>

	</tr> 
 </table>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</div>
</form>
<%
	ecommerce_db.close();	
}
	ecommerce_db1.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
ecommerce_db.close();
ecommerce_db1.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
   <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回！")%></td>
  </tr>
</table>
</div>
<%}}else{
ecommerce_db.close();
ecommerce_db1.close();
%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回！")%></td>
 </tr>
</table>
</div>
<%}
%>

