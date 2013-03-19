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
<%nseer_db_backup design_db = new nseer_db_backup(application);%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
String id=request.getParameter("id");
String module_id=request.getParameter("module_id");
String design_ID=request.getParameter("design_ID");
try{
if(design_db.conn((String)session.getAttribute("unit_db_name"))){
	String sql1="update design_module set check_tag='0',change_tag='1' where id='"+module_id+"'";
	design_db.executeUpdate(sql1);
	String sql0="delete from design_module_details where id='"+id+"'";
	design_db.executeUpdate(sql0);
	double cost_price_sum=0.0;
    sql1="select * from design_module_details where design_ID='"+design_ID+"'";
	ResultSet rs2=design_db.executeQuery(sql1) ;
	while(rs2.next()){
		cost_price_sum+=rs2.getDouble("subtotal");
	}
	List rsList = GetWorkflow.getList(design_db, "design_config_workflow", "03");
	String[] elem=new String[3];
	String sql2="";
	if(rsList.size()==0){
		sql2="update design_module set cost_price_sum='"+cost_price_sum+"',check_tag='1',change_tag='1' where design_ID='"+design_ID+"'";
		design_db.executeUpdate(sql2) ;
	}else{
		sql2="delete from design_workflow where object_ID='"+design_ID+"'";
		design_db.executeUpdate(sql2) ;
		sql2="update design_module set cost_price_sum='"+cost_price_sum+"',check_tag='0',change_tag='1' where design_ID='"+design_ID+"'";
		design_db.executeUpdate(sql2) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
			elem=(String[])ite.next();
			sql2 = "insert into design_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"','03')" ;
			design_db.executeUpdate(sql2) ;
		}
	}	
design_db.close();
response.sendRedirect("change.jsp?id="+module_id+"&design_ID="+design_ID+"");
}else{%>
<%@include file="../include/head.jsp"%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td> 
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="change.jsp?id=<%=module_id%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td> 
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
 </div>
<%}}
catch (Exception ex) {
		ex.printStackTrace();
	}%>

