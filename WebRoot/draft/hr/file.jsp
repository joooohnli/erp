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
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hrdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
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
<%
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_ID=request.getParameter("human_id");
if(vt.validata((String)session.getAttribute("unit_db_name"),"hr_file","human_ID",human_ID,"check_tag").equals("5")||vt.validata((String)session.getAttribute("unit_db_name"),"hr_file","human_ID",human_ID,"check_tag").equals("9")){
try{
	String sqll = "select * from hr_file where human_ID='"+human_ID+"'" ;
	ResultSet rss = hrdb.executeQuery(sqll) ;
	if(rss.next()){
	String history_records=exchange.unHtml(rss.getString("history_records"));
	String family_membership=exchange.unHtml(rss.getString("family_membership"));
	String remark=exchange.unHtml(rss.getString("remark"));
	String birthday=rss.getString("birthday");
		if(birthday.equals("1800-01-01")){
			birthday="";
		}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="post">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_hr_file_draft_ok?tag=0','../../xml/hr/hr_file.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_hr_file_check_ok','../../xml/hr/hr_file.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div> 
 </td>
 </tr>
 </table>
<div style="position:absolute;">
<div style="display:block; position:absolute; z-index:10;right:30px; top:43px;"><a href="javascript:winopen('../../hr/file/query_picture.jsp?picture=<%=rss.getString("picture")%>')"><img src="../../hr/human_pictures/<%=exchange.toHtml(rss.getString("picture"))%>" width="120" height="145"></a></div>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="4"><input name="human_ID" type="hidden" style="width: 318; ;background-color:#C9E7DC" value="<%=rss.getString("human_ID")%>"><%=rss.getString("human_ID")%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_name"  style="width:49%" value="<%=exchange.toHtml(rss.getString("human_name"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="sex"  style="width:49%">
<%if(rss.getString("sex").equals("男")){%>
  <option selected><%=demo.getLang("erp","男")%></option>
  <option><%=demo.getLang("erp","女")%></option>
<%}else{%>
  <option><%=demo.getLang("erp","男")%></option>
  <option selected><%=demo.getLang("erp","女")%></option>
<%}%>
 </select></td>
 </tr>
 <input type="hidden" name="oldKind_chain" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>">

<%if(rss.getString("change_tag").equals("0")){%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="36%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" id="fileKind_chain" name="kind_chain" style="width:49%" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>"><input id="fileKind_chain_table" type="hidden" value="hr_config_file_kind"></td>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4" style="width:49%"
onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%
  String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = hr_db.executeQuery(sql4) ;
while(rs4.next()){
	if(rs4.getString("first_kind_ID").equals(rss.getString("human_major_first_kind_ID"))){%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>" selected><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%}else{%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
	}
}
%>

  </select>
  </td>
 </tr> 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5" style="width:49%">
		<option value="<%=rss.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%>"><%=rss.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%></option>
	 changelocation2(check.select4.value) 

 </select>
</td>
<%}else{%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","机构")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="hidden" name="kind_chain" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>"><%=rss.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rss.getString("chain_name"))%></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="hidden" name="select4"  style="width:49%" value="<%=rss.getString("human_major_first_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_first_kind_name"))%>"><%=exchange.toHtml(rss.getString("human_major_first_kind_name"))%>&nbsp;</td>
  </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="hidden" name="select5"  style="width:49%" value="<%=rss.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%>"><%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%></td>
<%}%>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="human_title_class"  style="width:49%">
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
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_email"style="width:49%" value="<%=exchange.toHtml(rss.getString("human_email"))%>">
	 </td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬标准")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="salary_standard" style="width:49%">
	 <option value="未定义/未定义/0"><%=demo.getLang("erp","未定义/0")%></option>
<%
  String sql7 = "select * from hr_salary_standard order by standard_ID" ;
	 ResultSet rs7 = hr_db.executeQuery(sql7) ;
while(rs7.next()){
	if(rs7.getString("standard_ID").equals(rss.getString("salary_standard_ID"))){%>
		<option value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>" selected><%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%></option>
<%}else{%>
		<option value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>"><%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=demo.aformat(rs7.getDouble("salary_sum"))%></option>
<%
	}
}
%>

  </select></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_tel" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_tel"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_cellphone" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_cellphone"))%>"> 
 </td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="age" style="width:49%" value="<%=exchange.toHtml(rss.getString("age"))%>"></td>
  <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="idcard" style="width:49%" value="<%=exchange.toHtml(rss.getString("idcard"))%>"></td>
 </tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1"  name="human_address" type="text" value="<%=exchange.toHtml(rss.getString("human_address"))%>" style="width:49%"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_postcode" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_postcode"))%>" style="width:49%">
 </tr>

<tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp","辅助信息")%></div></td></tr>	

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%></td>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="birthday" style="width:49%" value="<%=exchange.toHtml(birthday)%>"></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" ><%=demo.getLang("erp","民族")%></td>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%></td>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%></td>
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
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="SIN" type="text" style="width:49%" value="<%=exchange.toHtml(rss.getString("SIN"))%>"></td> 
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%></td>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%></td>
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
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%></td>
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
<input type="hidden" name="major_type" value="">
  <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","QQ")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_home_tel"  style="width:49%" value="<%=exchange.toHtml(rss.getString("human_home_tel"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开户行")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_bank" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_bank"))%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","账号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_account" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_account"))%>"></td> <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="register" style="width:49%" value="<%=exchange.toHtml(register)%>"></td> <input type="hidden" name="register_ID" style="width:49%" value="<%=register_ID%>">
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="register_time" type="hidden" style="width:49%" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%></td>
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
	 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%></td>
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
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="javascript:winopenm('../../hr/file/query_attachment.jsp?id=<%=rss.getString("id")%>&tablename=hr_file&fieldname=attachment_name')">
<%=exchange.toHtml(attachment_name1[1])%></a></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","个人履历")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="history_records"><%=history_records%></textarea>
</td>	
<td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","家庭关系信息")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="family_membership"><%=family_membership%></textarea>
</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%">&nbsp;</td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
</tr>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<%
ResultSet rs=rss;	
String nickName="人力资源档案";%>
<%@include file="../../include/cDefineMouC.jsp"%>
 </table>
 </div>
 </form>
 </div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
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
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="file_list.jsp"></div></td>
 </tr>
</table><table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该草稿已重新登记，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%}%>
<script type='text/javascript' src="../../javascript/hr/file/treeBusiness.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>

<div id="nseer1" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">

</div>
</TD>
<TD  background="../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
<script>
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
 Nseer_tree1 = new Tree('Nseer_tree1');
  Nseer_tree1.setParent('nseer1_0')
 Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('hr_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/hr/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/hr/file','hr_config_file_kind','treeButton');
}
</script>