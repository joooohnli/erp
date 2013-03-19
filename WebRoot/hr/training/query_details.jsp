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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
String id=request.getParameter("id");
try{
	String sql1 = "select * from hr_assign where id='"+id+"'" ;
	ResultSet rs = hr_db.executeQuery(sql1) ;
	if(rs.next()){
		String check_tag="";
		String execute_tag="";
		String fund_pre_tag="";
		String color="#FF9A31";
		if(rs.getString("check_tag").equals("9")){
		check_tag="审核未通过";
		color="red";
		}else if(rs.getString("check_tag").equals("0")){
		check_tag="等待审核";
		}else if(rs.getString("check_tag").equals("1")){
		check_tag="审核通过";
		color="3333FF";
		}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
 </div></td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7"><%=rs.getString("human_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原I级机构")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("first_kind_name")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原II级机构")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("second_kind_name")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","原III级机构")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("third_kind_name")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_name" type="hidden" value="<%=rs.getString("human_name")%>"><%=rs.getString("human_name")%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","原职位分类")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("human_major_first_kind_name")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","原职位名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("human_major_second_kind_name")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原薪酬类别")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("major_type")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原薪酬标准")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("salary_standard_name")%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新I级机构")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("new_first_kind_name")%></td>
<td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新II级机构")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("new_second_kind_name")%></td>
<td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","新III级机构")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("new_third_kind_name")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%">&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","新职位分类")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("new_human_major_first_kind_name")%>
<td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","新职位名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("new_human_major_second_kind_name")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新薪酬类别")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("new_major_type")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新薪酬标准")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("new_salary_standard_name")%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("register")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("register_time")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("checker")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("check_time")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%" height="65"><%=demo.getLang("erp","调动原因")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7"><%=rs.getString("remark1")%>&nbsp;</td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%" height="65"><%=demo.getLang("erp","审核意见")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7"><%=rs.getString("remark2")%>&nbsp;</td>
	</tr> 
 </table>
 </div>
<%
}
		hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>