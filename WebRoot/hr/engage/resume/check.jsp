<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hr_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String checker=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String details_number=request.getParameter("details_number");
if(vt.validata((String)session.getAttribute("unit_db_name"),"hr_resume","details_number",details_number,"check_tag").equals("0")){
try{
	String sqll = "select * from hr_resume where details_number='"+details_number+"'" ;
	ResultSet rs = hr_db1.executeQuery(sqll) ;
	while(rs.next()){
		String history_records=exchange.unHtml(rs.getString("history_records"));
		String remark=exchange.unHtml(rs.getString("remark"));
		String birthday="";
	if(!rs.getString("birthday").equals("1800-01-01")) birthday=rs.getString("birthday");
%>
<script language="javascript" src="../../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" class="x-form" method="POST" action="../../../hr_engage_resume_check_ok" onSubmit="return doValidate('../../../xml/hr/hr_questiones.xml','mutiValidation')">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","推荐面试")%>" name="B1"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div>
 </td>
 </tr>
</table>

<div style="position:absolute;">
<div style="display:block; position:absolute; z-index:10;right:30px; top:43px;"><a href="javascript:winopen('check_picture.jsp?picture=<%=rs.getString("picture")%>')"><img src="../../human_pictures/<%=exchange.toHtml(rs.getString("picture"))%>" width="120" height="145"></a></div>

 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr style="background-image:url(../../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="details_number" type="hidden" value="<%=rs.getString("details_number")%>"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_name" value="<%=exchange.toHtml(rs.getString("human_name"))%>" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="sex" style="width:49%">
<%if(rs.getString("sex").equals("男")){%>
  <option selected><%=demo.getLang("erp","男")%></option>
  <option><%=demo.getLang("erp","女")%></option>
<%}else{%>
  <option><%=demo.getLang("erp","男")%></option>
  <option selected><%=demo.getLang("erp","女")%></option>
<%}%>
 </select></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_email" style="width:49%" value="<%=exchange.toHtml(rs.getString("human_email"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","招聘类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("engage_type"))%></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_tel" style="width:49%" value="<%=exchange.toHtml(rs.getString("human_tel"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_cellphone" style="width:49%" value="<%=exchange.toHtml(rs.getString("human_cellphone"))%>"> 
 </td>
 </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="age" style="width:49%" value="<%=exchange.toHtml(rs.getString("age"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="idcard" style="width:49%" value="<%=exchange.toHtml(rs.getString("idcard"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_address" style="width:49%" type="text" value="<%=exchange.toHtml(rs.getString("human_address"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_postcode" style="width:49%" value="<%=exchange.toHtml(rs.getString("human_postcode"))%>">
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_home_tel" style="width:49%" value="<%=exchange.toHtml(rs.getString("human_home_tel"))%>"></td>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
 </tr>
 <tr style="background-image:url(../../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="nationality" style="width:49%">
<%
  String sql18 = "select * from hr_config_public_char where kind='国籍' order by id" ;
	 ResultSet rs18 = hr_db.executeQuery(sql18) ;
while(rs18.next()){
	if(rs18.getString("type_name").equals(rs.getString("nationality"))){%>
		<option value="<%=exchange.toHtml(rs18.getString("type_name"))%>" selected><%=exchange.toHtml(rs18.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs18.getString("type_name"))%>"><%=exchange.toHtml(rs18.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出生地")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="birthplace" style="width:49%" value="<%=exchange.toHtml(rs.getString("birthplace"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="birthday" style="width:49%" value="<%=exchange.toHtml(birthday)%>"></td> 
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","民族")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="race" style="width:49%">
<%
  String sql9 = "select * from hr_config_public_char where kind='民族' order by id" ;
	 ResultSet rs9 = hr_db.executeQuery(sql9) ;
while(rs9.next()){
	if(rs9.getString("type_name").equals(rs.getString("race"))){%>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="religion" style="width:49%">
<%
  String sql10 = "select * from hr_config_public_char where kind='宗教信仰' order by id" ;
	 ResultSet rs10 = hr_db.executeQuery(sql10) ;
while(rs10.next()){
	if(rs10.getString("type_name").equals(rs.getString("religion"))){%>
		<option value="<%=exchange.toHtml(rs10.getString("type_name"))%>" selected><%=exchange.toHtml(rs10.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs10.getString("type_name"))%>"><%=exchange.toHtml(rs10.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="party" style="width:49%">
<%
  String sql11 = "select * from hr_config_public_char where kind='政治面貌' order by id" ;
	 ResultSet rs11 = hr_db.executeQuery(sql11) ;
while(rs11.next()){
	if(rs11.getString("type_name").equals(rs.getString("party"))){%>
		<option value="<%=exchange.toHtml(rs11.getString("type_name"))%>" selected><%=exchange.toHtml(rs11.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs11.getString("type_name"))%>"><%=exchange.toHtml(rs11.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","毕业院校")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="college" style="width:49%" value="<%=exchange.toHtml(rs.getString("college"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_degree" style="width:49%">
<%
  String sql12 = "select * from hr_config_public_char where kind='学历' order by id" ;
	 ResultSet rs12 = hr_db.executeQuery(sql12) ;
while(rs12.next()){
	if(rs12.getString("type_name").equals(rs.getString("educated_degree"))){%>
		<option value="<%=exchange.toHtml(rs12.getString("type_name"))%>" selected><%=exchange.toHtml(rs12.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs12.getString("type_name"))%>"><%=exchange.toHtml(rs12.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>  
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_years" style="width:49%">
<%
  String sql13 = "select * from hr_config_public_char where kind='教育年限' order by id" ;
	 ResultSet rs13 = hr_db.executeQuery(sql13) ;
while(rs13.next()){
	if(rs13.getString("type_name").equals(rs.getString("educated_years"))){%>
		<option value="<%=exchange.toHtml(rs13.getString("type_name"))%>" selected><%=exchange.toHtml(rs13.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs13.getString("type_name"))%>"><%=exchange.toHtml(rs13.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_major" style="width:49%">
<%
  String sql14 = "select * from hr_config_public_char where kind='学历专业' order by id" ;
	 ResultSet rs14 = hr_db.executeQuery(sql14) ;
while(rs14.next()){
	if(rs14.getString("type_name").equals(rs.getString("educated_major"))){%>
		<option value="<%=exchange.toHtml(rs14.getString("type_name"))%>" selected><%=exchange.toHtml(rs14.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs14.getString("type_name"))%>"><%=exchange.toHtml(rs14.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬要求")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="demand_salary_standard" value="<%=exchange.toHtml(rs.getString("demand_salary_standard"))%>" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","注册时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("register_time"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="speciality" style="width:49%">
<%
  String sql15 = "select * from hr_config_public_char where kind='特长' order by id" ;
	 ResultSet rs15 = hr_db.executeQuery(sql15) ;
while(rs15.next()){
	if(rs15.getString("type_name").equals(rs.getString("speciality"))){%>
		<option value="<%=exchange.toHtml(rs15.getString("type_name"))%>" selected><%=exchange.toHtml(rs15.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs15.getString("type_name"))%>"><%=exchange.toHtml(rs15.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="hobby" style="width:49%">
<%
  String sql16 = "select * from hr_config_public_char where kind='爱好' order by id" ;
	 ResultSet rs16 = hr_db.executeQuery(sql16) ;
while(rs16.next()){
	if(rs16.getString("type_name").equals(rs.getString("hobby"))){%>
		<option value="<%=exchange.toHtml(rs16.getString("type_name"))%>" selected><%=exchange.toHtml(rs16.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs16.getString("type_name"))%>"><%=exchange.toHtml(rs16.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","推荐人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="checker" style="width:49%" value="<%=exchange.toHtml(checker)%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","推荐时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="check_time" style="width:49%" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=hr_resume&fieldname=attachment_name')">
<%=exchange.toHtml(attachment_name1[1])%></a>&nbsp;</td>

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","个人履历")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="history_records"><%=history_records%></textarea>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","备注")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","筛选推荐意见")%>  </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark1"></textarea>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr>
 </table>
 </div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
}
			 hr_db.close();
			 hr_db1.close();
}
catch (Exception ex){
out.println("error"+ex);
}				 
}else{
	hr_db.close();
	hr_db1.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回")%></td>
 </tr>
</table>
<%}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
</div>