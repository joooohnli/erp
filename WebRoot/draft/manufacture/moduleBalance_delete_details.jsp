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
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String id=request.getParameter("id");
String manufacture_ID=request.getParameter("manufacture_ID") ;
String procedure_ID=request.getParameter("procedure_ID") ;
String procedure_name=request.getParameter("procedure_name") ;
String register_time=request.getParameter("register_time") ;
String module_time=request.getParameter("module_time") ;
if(manufacture_db.conn((String)session.getAttribute("unit_db_name"))){

	String sql="delete from manufacture_module_balance_details where id='"+id+"'";
		manufacture_db.executeUpdate(sql) ;
	double cost_price_sum=0.0d;
	String id_chain="";	
	sql="select subtotal,id from manufacture_module_balance_details where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and module_time='"+module_time+"' and id!='"+id+"'";
	ResultSet rs=manufacture_db.executeQuery(sql);
	while(rs.next()){
		cost_price_sum+=rs.getDouble("subtotal");
		id_chain+=","+rs.getString("id");
	}
	if(!id_chain.equals("")){
	String[] id_group=(id_chain.substring(1)).split(",");
	int details_number=0;
	for(int i=0;i<id_group.length;i++){
		details_number=i+1;
		sql="update manufacture_module_balance_details set details_number='"+details_number+"' where id='"+id_group[i]+"'";
		manufacture_db.executeUpdate(sql);
	}
	}
	sql="update manufacture_module_balance set module_cost_price_sum='"+cost_price_sum+"' where manufacture_ID='"+manufacture_ID+"' and procedure_ID='"+procedure_ID+"' and module_time='"+module_time+"'";
	manufacture_db.executeUpdate(sql) ;
		manufacture_db.close();
response.sendRedirect("moduleBalance.jsp?manufacture_ID="+manufacture_ID+"&procedure_ID="+procedure_ID+"&procedure_name="+toUtf8String.utf8String(procedure_name)+"&module_time="+module_time);
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
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="moduleBalance.jsp?manufacture_ID=<%=manufacture_ID%>&procedure_ID=<%=procedure_ID%>&procedure_name=<%=procedure_name%>&module_time=<%=module_time%>"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%}%>