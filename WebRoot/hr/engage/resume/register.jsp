<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%counter count=new counter(application);%>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript" src="../../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/input_control/focus.css">
<script language="javascript">
 var onecount2;
 subcat2 = new Array();
 <% int k=0;
 String sql8="select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rs8=hr_db.executeQuery(sql8); 
 while(rs8.next()) {%> 
 subcat2[<%=k++%>] = new 
 Array("<%=rs8.getString("id")%>","<%=rs8.getString("second_kind_ID")%>/<%=rs8.getString("second_kind_name")%>","<%=rs8.getString("first_kind_ID")%>/<%=rs8.getString("first_kind_name")%>");
 <%
	 }
 %>  
 onecount2=<%=k%>; 
 function changelocation2(locationid)
  {
  mutiValidation.select5.length = 0;  
  var locid=locationid;
  var k;
  mutiValidation.select5.options[mutiValidation.select5.length]=new Option("",""); 
  for (k=0;k < onecount2; k++)
  {
 		 if(locid==""||locid==null){mutiValidation.select5.options[mutiValidation.select5.length]=
 			 new Option(subcat2[k][1],subcat2[k][1]);}//如果select1为空，则select5选择全部值
  else if (subcat2[k][2] == locid)
  { 
   mutiValidation.select5.options[mutiValidation.select5.length] = new Option(subcat2[k][1], 
 subcat2[k][1]);
  } 
  } 
 }

</script>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="POST" action="../../../hr_engage_resume_register_picture" onSubmit="return doValidate('../../../xml/hr/hr_resume.xml','mutiValidation')">    
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
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
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4" style="width:49%"
onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%
  String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = hr_db.executeQuery(sql4) ;
while(rs4.next()){%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
}
%>
  </select>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5" style="width:49%"><script language = "JavaScript">
	//if (mutiValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation2(mutiValidation.select4.value)
 //}
 </script>
 </select>
</td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_name" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="sex" style="width:49%">
  <option>男</option>
  <option>女</option>
 </select></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="24.5%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_email"  style="width:49%">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","招聘类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="engage_type" style="width:49%">
  <option><%=demo.getLang("erp","社会招聘")%></option>
  <option><%=demo.getLang("erp","校园招聘")%></option>
 </select></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_tel"  style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="24.5%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_cellphone"  style="width:49%"> 
 </td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="age" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="idcard" style="width:49%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="24.5%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_address" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="24.5%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_postcode" style="width:49%">
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_home_tel" style="width:49%"></td>
  <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
 </tr>

<tr style="background-image:url(../../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp","辅助信息")%></div></td></tr>	
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="nationality" style="width:49%">
<%
  String sql18 = "select * from hr_config_public_char where kind='国籍' order by id" ;
	 ResultSet rs18 = hr_db.executeQuery(sql18) ;
while(rs18.next()){%>
		<option value="<%=exchange.toHtml(rs18.getString("type_name"))%>"><%=exchange.toHtml(rs18.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出生地")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="birthplace"  style="width:49%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="24.5%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="birthday"  style="width:49%"></td> 
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","民族")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="race" style="width:49%">
<%
  String sql9= "select * from hr_config_public_char where kind='民族' order by id" ;
	 ResultSet rs9 = hr_db.executeQuery(sql9) ;
while(rs9.next()){%>
		<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>"><%=exchange.toHtml(rs9.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="religion" style="width:49%">
<%
  String sql10= "select * from hr_config_public_char where kind='宗教信仰' order by id" ;
	 ResultSet rs10 = hr_db.executeQuery(sql10) ;
while(rs10.next()){%>
		<option value="<%=exchange.toHtml(rs10.getString("type_name"))%>"><%=exchange.toHtml(rs10.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="24.5%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="party" style="width:49%">
<%
  String sql11= "select * from hr_config_public_char where kind='政治面貌' order by id" ;
	 ResultSet rs11 = hr_db.executeQuery(sql11) ;
while(rs11.next()){%>
		<option value="<%=exchange.toHtml(rs11.getString("type_name"))%>"><%=exchange.toHtml(rs11.getString("type_name"))%></option>
<%
}
%>
  </select></td> 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","毕业院校")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="college" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_degree" style="width:49%">
<%
  String sql12= "select * from hr_config_public_char where kind='学历' order by id" ;
	 ResultSet rs12 = hr_db.executeQuery(sql12) ;
while(rs12.next()){%>
		<option value="<%=exchange.toHtml(rs12.getString("type_name"))%>"><%=exchange.toHtml(rs12.getString("type_name"))%></option>
<%
}
%>
  </select></td>  
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_years" style="width:49%">
<%
  String sql13= "select * from hr_config_public_char where kind='教育年限' order by id" ;
	 ResultSet rs13 = hr_db.executeQuery(sql13) ;
while(rs13.next()){%>
		<option value="<%=exchange.toHtml(rs13.getString("type_name"))%>"><%=exchange.toHtml(rs13.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_major" style="width:49%">
<%
  String sql14= "select * from hr_config_public_char where kind='学历专业' order by id" ;
	 ResultSet rs14 = hr_db.executeQuery(sql14) ;
while(rs14.next()){%>
		<option value="<%=exchange.toHtml(rs14.getString("type_name"))%>"><%=exchange.toHtml(rs14.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬要求")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="demand_salary_standard" style="width:49%"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","注册时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="register_time" type="hidden"  style="width:49%" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="speciality" style="width:49%">
<%
  String sql15= "select * from hr_config_public_char where kind='特长' order by id" ;
	 ResultSet rs15 = hr_db.executeQuery(sql15) ;
while(rs15.next()){%>
		<option value="<%=exchange.toHtml(rs15.getString("type_name"))%>"><%=exchange.toHtml(rs15.getString("type_name"))%></option>
<%
}
%>
  </select></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="hobby" style="width:49%">
<%
  String sql16= "select * from hr_config_public_char where kind='爱好' order by id" ;
	 ResultSet rs16 = hr_db.executeQuery(sql16) ;
while(rs16.next()){%>
		<option value="<%=exchange.toHtml(rs16.getString("type_name"))%>"><%=exchange.toHtml(rs16.getString("type_name"))%></option>
<%
}
hr_db.close();
%>
  </select></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td height="65" <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","个人履历")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="history_records"></textarea>
</td>
 <td height="65" <%=TD_STYLE4%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
</tr>
 </table>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
</form>
</div>