<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db_backup manufacture_db = new nseer_db_backup(application);%>

<%
try{
if(manufacture_db.conn((String)session.getAttribute("unit_db_name"))){
 String manufacture_ID=request.getParameter("manufacture_ID");
	String sql13="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and (procedure_check_tag='1' or procedure_transfer_tag='3') and procedure_finish_tag!='2'";
	ResultSet rs13=manufacture_db.executeQuery(sql13);
	if(rs13.next()){
		manufacture_db.close();
		response.sendRedirect("check.jsp?manufacture_ID="+manufacture_ID+"");
	}else{
	String sql16="update manufacture_manufacture set manufacture_procedure_check_tag='0' where manufacture_ID='"+manufacture_ID+"'";
	manufacture_db.executeUpdate(sql16);
	manufacture_db.close();
	response.sendRedirect("check_list.jsp");
	}
	}else{
	%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="check_list.jsp"></div></td>
 </tr>
 </table>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
 </table>
 </div>
<%}
	 }catch(Exception ex){ex.printStackTrace();}
	%>