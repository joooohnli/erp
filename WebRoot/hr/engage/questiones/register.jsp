<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" action="../../../hr_engage_questiones_register_ok" onSubmit="return doValidate('../../../xml/hr/hr_questiones.xml','mutiValidation')">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"> <input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></div>
 </td>
 </tr>
</table>
<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
<script language="javascript" src="/check.js"></script>
<script language="javascript">
 var onecount;
 subcat = new Array();
 <% int i=0;
 String sql="select * from hr_config_question_second_kind where second_kind_name!=''";
 ResultSet rs=hr_db.executeQuery(sql); 
 while(rs.next()) {%> 
 subcat[<%=i++%>] = new 
 Array("<%=rs.getString("id")%>","<%=rs.getString("second_kind_ID")%>/<%=rs.getString("second_kind_name")%>","<%=rs.getString("first_kind_ID")%>/<%=rs.getString("first_kind_name")%>");
 <% 
	 }
 %> 
 
 onecount=<%=i%>;
 
 function changelocation(locationid)
  {
  mutiValidation.select2.length = 0; 
 
  var locid=locationid;
  var i;
  mutiValidation.select2.options[mutiValidation.select2.length]=new Option("",""); 
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){mutiValidation.select2.options[mutiValidation.select2.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则select2选择全部值
  else if (subcat[i][2] == locid)
  { 
   mutiValidation.select2.options[mutiValidation.select2.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }
var count=0;
function CheckForm(form) {
	trimform(form);
	if(count>0) {
 	return false;
 	}
 	count++;
if(!form.agree.checked) {
	 alert("确认提交吗？如果确认请点选确认提交");
	 form.agree.focus();
	 count=count-1;
	 return (false);
	}
		return(true);
}
</script>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","试题I级分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select1" style="width:60%"
onChange="changelocation(mutiValidation.select1.options[mutiValidation.select1.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%
  String sqll = "select * from hr_config_question_first_kind order by id" ;
	 ResultSet rss = hr_db.executeQuery(sqll) ;
while(rss.next()){%>
		<option value=<%=rss.getString("first_kind_ID")%>/<%=exchange.toHtml(rss.getString("first_kind_name"))%>><%=rss.getString("first_kind_ID")%>/<%=exchange.toHtml(rss.getString("first_kind_name"))%></option>
<%}
hr_db.close();
%>
  </select></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","试题II级分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select2" style="width:60%"><script language = "JavaScript">
	//if (mutiValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation(mutiValidation.select1.value)
 //}
 </script>
 </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register" style="width:60%" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="register_time" style="width:60%" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","正确答案")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="correctkey" style="width:60%"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","试题出处")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="derivation" style="width:60%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" height="65"><%=demo.getLang("erp","题干")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="body"></textarea>
</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案a")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="bodya" cols="122" rows="2"></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案b")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="bodyb" cols="122" rows="2"></textarea>
</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案c")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="bodyc" cols="122" rows="2"></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案d")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="bodyd" cols="122" rows="2"></textarea>
</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7"><%=demo.getLang("erp","答案e")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="bodye" cols="122" rows="2"></textarea>
</td>
 </tr>
</table>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
</div>