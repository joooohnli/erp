<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script src="../../../javascript/table/movetable.js">
</script>
<%
	String sql = "select * from hr_resume where check_tag='1' and excel_tag='2' and (interview_tag='0' or interview_tag='1') order by register_time" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%"> 
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","当前等待面试的简历总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
			 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","搜索")%>" onClick=location="query_locate.jsp"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height=525 colspan="2">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1">
  <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","性别")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","职位类别")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","职位名称")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","毕业院校")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","学历专业")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","通知面试")%></td>
 </tr>
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="../resume/query.jsp?details_number=<%=rs.getString("details_number")%>"><%=rs.getString("human_name")%></a></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("sex")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("age")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("human_major_first_kind_name")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("human_major_second_kind_name")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("college")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("educated_major")%></td>
<%if(rs.getString("interview_tag").equals("4")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","已通知")%></td>
<%}else{%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="query.jsp?details_number=<%=rs.getString("details_number")%>"><%=demo.getLang("erp","通知面试")%></a></td>
<%}%>
 </tr>
</page:pages>
  </table>
  </div>
 
<page:updowntag num="<%=intRowCount%>" file="query_list.jsp"/>
<%	
hr_db.close();
%>