<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db_backup manufacture_db = new nseer_db_backup(application);%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String apply_ID=request.getParameter("apply_ID");
String id=request.getParameter("id");
if(manufacture_db.conn((String)session.getAttribute("unit_db_name"))){
try{
	String sql="select * from manufacture_apply where apply_ID='"+apply_ID+"'";
	ResultSet rs=manufacture_db.executeQuery(sql) ;
	int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
	if(intRowCount==1){
		 sql="update manufacture_apply set product_ID='' where apply_ID='"+apply_ID+"'";
			manufacture_db.executeUpdate(sql) ;
	}else{
		 sql="delete from manufacture_apply where id='"+id+"'";
			manufacture_db.executeUpdate(sql) ;
	}
manufacture_db.close();
}
catch (Exception ex) {
		out.println("error"+ex);
	}
response.sendRedirect("apply.jsp?apply_ID="+apply_ID+"");
}else{
	%>
	<%@include file="../include/head.jsp"%>
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
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="apply.jsp?apply_ID=<%=apply_ID%>"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
</table>
</div>
<%}%>