<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_db.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../../javascript/winopen/winopen.js"></script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" action="../../../hr_engage_interview_query_ok" onSubmit="return doValidate('../../../xml/hr/hr_resume.xml','mutiValidation')">
<%
String details_number=request.getParameter("details_number");
try{
	String sql = "select * from hr_resume where details_number='"+details_number+"'" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
	if(rs.next()){
		String remark=exchange.unHtml(rs.getString("remark"));
			String birthday="";
	if(!rs.getString("birthday").equals("0000-00-00")) birthday=rs.getString("birthday");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table width="100%" cellpadding="2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","通知")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" style="width: 50; " onClick="javascript:winopen('query_print.jsp?details_number=<%=details_number%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td> 
 </tr> 
 </table>
 <table width="100%" bordercolorlight=#333333 bordercolordark=#efefef class="TABLE-STYLE">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("human_major_first_kind_name")%>&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("human_major_second_kind_name")%></td>
<td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","招聘类型")%></td>
 <td colspan="2" <%=TD_STYLE2%> class="TD_STYLE2" width="24.5%"><%=rs.getString("engage_type")%></td>
	 <td width="13%" rowspan="6" <%=TD_STYLE2%> class="TD_STYLE2"><a href="query_picture.jsp?picture=<%=rs.getString("picture")%>" target="_blank"><img src="../../human_pictures/<%=rs.getString("picture")%>" width="110" height="128"></a></td>
 </tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="details_number" type="hidden" width="100%" value="<%=rs.getString("details_number")%>"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="details_number" type="hidden" width="100%" value="<%=rs.getString("details_number")%>"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_name" type="hidden" width="100%" value="<%=rs.getString("human_name")%>"><%=rs.getString("human_name")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("sex")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td width="24.5%" colspan="2" <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("human_email")%>&nbsp;</td>
	 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("human_tel")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("human_home_tel")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td width="24.5%" colspan="2" <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("human_cellphone")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%></td>
 <td width="24.5%" colspan="3" <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("human_address")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td width="24.5%" colspan="2" <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("human_postcode")%>&nbsp;</td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("nationality")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出生地")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("birthplace")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="24.5%" colspan="2"><%=birthday%>&nbsp;</td> 
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","民族")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("race")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("religion")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="24.5%" colspan="2"><%=rs.getString("party")%>&nbsp;</td> 
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("idcard")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("age")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","毕业院校")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("college")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("engage_type")%>&nbsp;</td>  
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("educated_years")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("educated_major")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬要求")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("demand_salary_standard")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","注册时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("register_time")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("speciality")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("hobby")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","推荐人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("checker")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","推荐时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("check_time")%>&nbsp;</td>
 </tr>
<%
String attachment_name1="";
String attachment_name2="";
StringTokenizer tokenTO = new StringTokenizer(rs.getString("attachment_name"),"_"); 
 while(tokenTO.hasMoreTokens()) {
  attachment_name1 = tokenTO.nextToken();
				attachment_name2=tokenTO.nextToken();
		}	
%>
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td colspan="7" <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%"><a href="javascript:winopen('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=hr_resume&fieldname=attachment_name')">
<%=attachment_name2%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","个人履历")%> &nbsp; </td>
<td colspan="7" <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%"><%=rs.getString("history_records")%>&nbsp;</td>
	</tr> 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","筛选推荐意见")%> &nbsp; </td>
<td colspan="7" <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%"><%=rs.getString("remark1")%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td colspan="7" <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
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
</form>