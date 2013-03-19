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
<%nseer_db_backup manufacture_db1 = new nseer_db_backup(application);%>

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String id=request.getParameter("id");
String design_ID=request.getParameter("design_ID");
String procedure_id=request.getParameter("procedure_id");
if(manufacture_db.conn((String)session.getAttribute("unit_db_name"))&&manufacture_db1.conn((String)session.getAttribute("unit_db_name"))){
try{
	double cost_price_sum=0.0d;
	double cost_price_suma=0.0d;
	String sql2="select * from manufacture_design_procedure_details where id='"+id+"'";
	ResultSet rs2=manufacture_db.executeQuery(sql2) ;
	if(rs2.next()){
		String sql3="delete from manufacture_design_procedure_module_details where design_ID='"+design_ID+"' and procedure_name='"+rs2.getString("procedure_name")+"'";
			manufacture_db1.executeUpdate(sql3) ;
		String sql4="select cost_price_sum from manufacture_design_procedure where design_ID='"+design_ID+"'";
		ResultSet rs4=manufacture_db1.executeQuery(sql4) ;
		if(rs4.next()){
			cost_price_sum=rs4.getDouble("cost_price_sum");
			}
				cost_price_suma=cost_price_sum-rs2.getDouble("labour_hour_amount")*rs2.getDouble("cost_price");
					sql4="update manufacture_design_procedure set cost_price_sum='"+cost_price_suma+"' where design_ID='"+design_ID+"'";
						manufacture_db.executeUpdate(sql4) ;

	}
	String sql="delete from manufacture_design_procedure_details where id='"+id+"'";
	manufacture_db.executeUpdate(sql) ;
	manufacture_db.close();
	manufacture_db1.close();
}
catch (Exception ex) {
		out.println("error"+ex);
	}
response.sendRedirect("designProcedure.jsp?design_ID="+design_ID+"");
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
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="designProcedure.jsp?design_ID=<%=design_ID%>"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
 </table>
<%}%>