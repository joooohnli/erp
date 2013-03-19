<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hrdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_ID=request.getParameter("human_ID");
if(vt.validata((String)session.getAttribute("unit_db_name"),"hr_file","human_ID",human_ID,"check_tag").equals("1")){
try{
	String sqll = "select * from hr_file where human_ID='"+human_ID+"'" ;
	ResultSet rss = hrdb.executeQuery(sqll) ;
	while(rss.next()){
	String history_records=exchange.unHtml(rss.getString("history_records"));
	String family_membership=exchange.unHtml(rss.getString("family_membership"));
	String remark=exchange.unHtml(rss.getString("remark"));
	String birthday=rss.getString("birthday");
	if(birthday.equals("1800-01-01"))
 birthday = "";
%>
<div id="nseerGround" class="nseerGround">
<form class="x-form" id="mutiValidation" method="POST" action="../../hr_file_change_picture" onSubmit="return doValidate('../../xml/hr/hr_file.xml','mutiValidation')"> 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()">
 </td>
 </tr>
</table>
<div style="position:absolute;">
<div style="display:block; position:absolute; z-index:10;right:30px; top:43px;"><a href="javascript:winopen('query_picture.jsp?picture=<%=exchange.toHtml(rss.getString("picture"))%>')"><img src="../human_pictures/<%=exchange.toHtml(rss.getString("picture"))%>" width="120" height="145"></a></div>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%> </td>	 
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="633" colspan="4"><input name="human_ID" style="width:49%" type="hidden" style="width: 318; ;background-color:#C9E7DC" value="<%=rss.getString("human_ID")%>"><%=rss.getString("human_ID")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","姓名")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_name" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_name"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="sex" style="width:49%">
<%if(rss.getString("sex").equals("男")){%>
  <option selected>男</option>
  <option>女</option>
<%}else{%>
  <option>男</option>
  <option selected>女</option>
<%}%>
 </select></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","机构")%> </td>
 <td  <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rss.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rss.getString("chain_name"))%></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rss.getString("human_major_first_kind_name"))%>&nbsp;</td>
 </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职称")%> </td>
 <td  <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="human_title_class" style="width:49%">
<%
  String sql5 = "select * from hr_config_public_char where kind='职称' order by id" ;
	 ResultSet rs5 = hr_db.executeQuery(sql5) ;
while(rs5.next()){
	if(rs5.getString("type_name").equals(rss.getString("human_title_class"))){%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>" selected><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","EMAIL")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_email" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_email"))%>">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬标准")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="salary_standard" style="width:49%">
	 <option value="未定义/未定义/0"><%=demo.getLang("erp","未定义/0")%></option>
<%
  String sql7 = "select * from hr_salary_standard where check_tag='1' and gar_tag='0' order by standard_ID"  ;
	 ResultSet rs7 = hr_db.executeQuery(sql7) ;
while(rs7.next()){
	if(rs7.getString("standard_ID").equals(rss.getString("salary_standard_ID"))){%>
		<option value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>" selected><%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%></option>
<%}else{%>
	<option value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>"><%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%></option>
<%
	}
}
%>
  </select>&nbsp;</td> 
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_tel" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_tel"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_cellphone" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_cellphone"))%>"> 
 </td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="age" style="width:49%" value="<%=exchange.toHtml(rss.getString("age"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="idcard" style="width:49%" value="<%=exchange.toHtml(rss.getString("idcard"))%>"></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_address" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_address"))%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_postcode" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_postcode"))%>">
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="nationality" style="width:49%">
<%
  String sql18 = "select * from hr_config_public_char where kind='国籍' order by id" ;
	 ResultSet rs18 = hr_db.executeQuery(sql18) ;
while(rs18.next()){
	if(rs18.getString("type_name").equals(rss.getString("nationality"))){%>
		<option value="<%=exchange.toHtml(rs18.getString("type_name"))%>" selected><%=exchange.toHtml(rs18.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs18.getString("type_name"))%>"><%=exchange.toHtml(rs18.getString("type_name"))%></option>
<%
	}
}
%>

  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出生地")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="birthplace" style="width:49%" value="<%=exchange.toHtml(rss.getString("birthplace"))%>"></td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="birthday" style="width:49%" value="<%=exchange.toHtml(birthday)%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","民族")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="race" style="width:49%">
<%
  String sql9 = "select * from hr_config_public_char where kind='民族' order by id" ;
	 ResultSet rs9 = hr_db.executeQuery(sql9) ;
while(rs9.next()){
	if(rs9.getString("type_name").equals(rss.getString("race"))){%>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="religion" style="width:49%">
<%
  String sql10 = "select * from hr_config_public_char where kind='宗教信仰' order by id" ;
	 ResultSet rs10 = hr_db.executeQuery(sql10) ;
while(rs10.next()){
	if(rs10.getString("type_name").equals(rss.getString("religion"))){%>
		<option value="<%=exchange.toHtml(rs10.getString("type_name"))%>" selected><%=exchange.toHtml(rs10.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs10.getString("type_name"))%>"><%=exchange.toHtml(rs10.getString("type_name"))%></option>
<%
	}
}
%>

  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="party" style="width:49%">
<%
  String sql11 = "select * from hr_config_public_char where kind='政治面貌' order by id" ;
	 ResultSet rs11 = hr_db.executeQuery(sql11) ;
while(rs11.next()){
	if(rs11.getString("type_name").equals(rss.getString("party"))){%>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","社会保障号码")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="SIN" style="width:49%" value="<%=exchange.toHtml(rss.getString("SIN"))%>"></td> 
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_degree" style="width:49%">
<%
  String sql12 = "select * from hr_config_public_char where kind='学历' order by id" ;
	 ResultSet rs12 = hr_db.executeQuery(sql12) ;
while(rs12.next()){
	if(rs12.getString("type_name").equals(rss.getString("educated_degree"))){%>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_years" style="width:49%">
<%
  String sql13 = "select * from hr_config_public_char where kind='教育年限' order by id" ;
	 ResultSet rs13 = hr_db.executeQuery(sql13) ;
while(rs13.next()){
	if(rs13.getString("type_name").equals(rss.getString("educated_years"))){%>
		<option value="<%=exchange.toHtml(rs13.getString("type_name"))%>" selected><%=exchange.toHtml(rs13.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs13.getString("type_name"))%>"><%=exchange.toHtml(rs13.getString("type_name"))%></option>
<%
	}
}
%>

  </select></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_major" style="width:49%">
<%
  String sql14 = "select * from hr_config_public_char where kind='学历专业' order by id" ;
	 ResultSet rs14 = hr_db.executeQuery(sql14) ;
while(rs14.next()){
	if(rs14.getString("type_name").equals(rss.getString("educated_major"))){%>
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
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","QQ")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_home_tel" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_home_tel"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开户行")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_bank" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_bank"))%>"></td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","账号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_account" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_account"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","变更人")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="changer" style="width:49%" value="<%=exchange.toHtml(changer)%>"></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="change_time" style="width:49%" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="speciality" style="width:49%">
<%
  String sql15 = "select * from hr_config_public_char where kind='特长' order by id" ;
	 ResultSet rs15 = hr_db.executeQuery(sql15) ;
while(rs15.next()){
	if(rs15.getString("type_name").equals(rss.getString("speciality"))){%>
		<option value="<%=exchange.toHtml(rs15.getString("type_name"))%>" selected><%=exchange.toHtml(rs15.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs15.getString("type_name"))%>"><%=exchange.toHtml(rs15.getString("type_name"))%></option>
<%
	}
}
%>

  </select></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="hobby" style="width:49%">
<%
  String sql16 = "select * from hr_config_public_char where kind='爱好' order by id" ;
	 ResultSet rs16 = hr_db.executeQuery(sql16) ;
while(rs16.next()){
	if(rs16.getString("type_name").equals(rss.getString("hobby"))){%>
		<option value="<%=exchange.toHtml(rs16.getString("type_name"))%>" selected><%=exchange.toHtml(rs16.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs16.getString("type_name"))%>"><%=exchange.toHtml(rs16.getString("type_name"))%></option>
<%
	}
}
%>

  </select></td>
<%
String[] attachment_name1=DealWithString.divide(rss.getString("attachment_name"),20);	
%>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rss.getString("id")%>&tablename=hr_file&fieldname=attachment_name')">
<%=exchange.toHtml(attachment_name1[1])%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","个人履历")%>  &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="history_records"><%=history_records%></textarea>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","家庭关系信息")%>  &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="family_membership"><%=family_membership%></textarea>
</td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","备注")%>  &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 <td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<%
ResultSet rs=rss;	
String nickName="人力资源档案";%>
<%@include file="../../include/cDefineMouC.jsp"%>
<input name="lately_change_time" type="hidden" value="<%=exchange.toHtml(rss.getString("change_time"))%>">
<input name="file_change_amount" type="hidden" value="<%=rss.getString("file_change_amount")%>">
 </table>
 </div>
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
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="change_list.jsp"></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已变更，请返回！")%> </td>
 </tr>
</table>
<%}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
</div>