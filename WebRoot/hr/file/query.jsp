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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"> <div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String human_ID=request.getParameter("human_ID");
try{
	String sql = "select * from hr_file where human_ID='"+human_ID+"'" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
	if(rs.next()){
		String major_change_time=rs.getString("change_time");
		if(major_change_time.equals("1800-01-01 00:00:00.0")){
			major_change_time=rs.getString("register_time");
		}
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
		String birthday=rs.getString("birthday");
		if(birthday.equals("1800-01-01")){
			birthday="";
		}
%>
<style>
body {
	font-family: Arial,"宋体";
	font-size:9pt;
}
td { font-size:12px;;
}
.mousehand{
	cursor:hand;
}
	

table.TabBarLevel1 td{
 border:0px solid #CCCCCC;
 height:20px;
 background-color:#66ccff;
}


table.TabBarLevel1 td.Selected{
 border-bottom-width:0px;
 background-color:orange;
}
table.TabBarLevel1 td.Black{
 border-left-width:0px;
 border-top-width:0px;
 border-right-width:0px;
 background-color:#eeeeee;
}

table.Content{
 border-left:1px solid #CCCCCC;
 border-right:1px solid #CCCCCC;
 border-bottom:1px solid #CCCCCC;
}
</style>
<body onload="changeTab('nseer0')">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="打印" style="width: 50; " onClick="javascript:winopen('query_print.jsp?human_ID=<%=human_ID%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"> 
 </td>
 </tr>
</table>
<table style="width:100%;top:2%;">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">
<div id="Tabs0">
<ul>
<li id="main_cur"><a href="javascript:changeTab('nseer0');"><span><%=demo.getLang("erp","全部信息")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer1');"><span><%=demo.getLang("erp","主信息")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer2');"><span><%=demo.getLang("erp","辅助信息")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer3');"><span><%=demo.getLang("erp","动态信息")%></span></a></li>
</ul>
<%@include file="../../include/cDefineMouT.jsp"%>
</div>
	</td>
  </tr>
</table>

<div id="nseer1" style="display:none;position:absolute;">
<div style="display:block; position:absolute; z-index:10;right:30px; top:43px;"><a href="javascript:winopen('query_picture.jsp?picture=<%=exchange.toHtml(rs.getString("picture"))%>')"><img src="../human_pictures/<%=exchange.toHtml(rs.getString("picture"))%>" width="120" height="145"></a></div>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>	 
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="4"><%=rs.getString("human_ID")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("sex"))%>&nbsp;</td>


 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","机构")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_title_class"))%></td>
 </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_email"))%>&nbsp;</td>
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬标准")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("salary_standard_name"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_cellphone"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("age"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("idcard"))%>&nbsp;</td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_address"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("human_postcode"))%>&nbsp;</td>
 </tr>
 </table>
 </div>
<div id="nseer2" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
<tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("nationality"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出生地")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("birthplace"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(birthday)%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","民族")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><%=exchange.toHtml(rs.getString("race"))%>&nbsp;</td>
 
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("religion"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("party"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","社会保障号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("SIN"))%>&nbsp;</td> 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("educated_degree"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("educated_years"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("educated_major"))%>&nbsp;</td>
 
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","QQ")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_home_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开户行")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("human_bank"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","账号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_account"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("speciality"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("hobby"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2">&nbsp;</td>
 </tr>
 </table>
  </div>
   <div id="nseer3" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","动态信息")%></div></td></tr>
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","基本薪酬总额")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getDouble("demand_salary_sum")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","实发薪酬总额")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><%=rs.getDouble("paid_salary_sum")%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训次数累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="../training/query_list.jsp?keyword_chain=<%=rs.getString("human_ID")%>"><%=rs.getString("training_amount")%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","激励次数累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><a href="../bonus/query_list.jsp?keyword_chain=<%=rs.getString("human_ID")%>"><%=rs.getString("bonus_amount")%></a>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","调动次数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="../major_change/query_list.jsp?keyword_chain=<%=rs.getString("human_ID")%>"><%=rs.getString("major_change_amount")%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案变更累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><a href="javascript:winopen('change_file_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&human_ID=<%=rs.getString("human_ID")%>')"><%=rs.getString("file_change_amount")%></a>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","最近变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="javascript:winopen('change_file_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&human_ID=<%=rs.getString("human_ID")%>')"><%=exchange.toHtml(lately_change_time)%></a>&nbsp;</td>
<%
    String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=hr_file&fieldname=attachment_name')">
<%=exchange.toHtml(attachment_name1[1])%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"  width="11%"><%=demo.getLang("erp","个人履历")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("history_records")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp","家庭关系信息")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><%=rs.getString("family_membership")%>&nbsp;</td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"  width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("remark")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2">&nbsp;</td>
	</tr>
	</table>
	</div>
<div id="nseer0" style="display:none;position:absolute;">
<div style="display:block; position:absolute; z-index:10;right:30px; top:43px;"><a href="javascript:winopen('query_picture.jsp?picture=<%=exchange.toHtml(rs.getString("picture"))%>')"><img src="../human_pictures/<%=exchange.toHtml(rs.getString("picture"))%>" width="120" height="145"></a></div>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 


 <tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","全部信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>	 
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="633" colspan="4"><%=rs.getString("human_ID")%>&nbsp;</td>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("sex"))%>&nbsp;</td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","机构")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_title_class"))%></td>
 </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_email"))%>&nbsp;</td>
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬标准")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("salary_standard_name"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_cellphone"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("age"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("idcard"))%>&nbsp;</td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_address"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("human_postcode"))%>&nbsp;</td>
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("nationality"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出生地")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("birthplace"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(birthday)%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","民族")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><%=exchange.toHtml(rs.getString("race"))%>&nbsp;</td>
 
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("religion"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("party"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","社会保障号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("SIN"))%>&nbsp;</td> 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("educated_degree"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("educated_years"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("educated_major"))%>&nbsp;</td>
 
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","QQ")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_home_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","开户行")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("human_bank"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","账号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_account"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="2"><%=exchange.toHtml(rs.getString("speciality"))%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("hobby"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2">&nbsp;</td>
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="5"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","动态信息")%></div></td></tr>
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","基本薪酬总额")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getDouble("demand_salary_sum")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","实发薪酬总额")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><%=rs.getDouble("paid_salary_sum")%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","培训次数累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="../training/query_list.jsp?keyword_chain=<%=rs.getString("human_ID")%>"><%=rs.getString("training_amount")%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","激励次数累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><a href="../bonus/query_list.jsp?keyword_chain=<%=rs.getString("human_ID")%>"><%=rs.getString("bonus_amount")%></a>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","调动次数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="../major_change/query_list.jsp?keyword_chain=<%=rs.getString("human_ID")%>"><%=rs.getString("major_change_amount")%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案变更累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><a href="javascript:winopen('change_file_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&human_ID=<%=rs.getString("human_ID")%>')"><%=rs.getString("file_change_amount")%></a>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","最近变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a href="javascript:winopen('change_file_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&human_ID=<%=rs.getString("human_ID")%>')"><%=exchange.toHtml(lately_change_time)%></a>&nbsp;</td>
<%
    attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=hr_file&fieldname=attachment_name')">
<%=exchange.toHtml(attachment_name1[1])%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"  width="11%"><%=demo.getLang("erp","个人履历")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("history_records")%>&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"  width="11%"><%=demo.getLang("erp","家庭关系信息")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2"><%=rs.getString("family_membership")%>&nbsp;</td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7"  width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("remark")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"  colspan="2">&nbsp;</td>
	</tr>
<%
String nickName="人力资源档案";%>
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
  </div>
<div id="nseer4" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
</div>
<%
}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该员工档案尚不存在，请返回。")%></td>
 </tr>
</table>
<%
	 }
hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</div>