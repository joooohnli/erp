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
<%nseer_db_backup1 logistics_db = new nseer_db_backup1(application);%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
String id=request.getParameter("id");
String product_logistics_recommend_ID=request.getParameter("product_logistics_recommend_ID");
if(logistics_db.conn((String)session.getAttribute("unit_db_name"))){

try{
	String sql="delete from logistics_product_providers_recommend_details where id='"+id+"'";
		logistics_db.executeUpdate(sql) ;
	String id_chain="";		
	sql="select id from logistics_product_providers_recommend_details where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' and id!='"+id+"'";
	ResultSet rs=logistics_db.executeQuery(sql);
	while(rs.next()){
		id_chain+=","+rs.getString("id");
	}
	if(id_chain.indexOf(",")!=-1){
	String[] id_group=(id_chain.substring(1)).split(",");
	int details_number=0;
	for(int i=0;i<id_group.length;i++){
		details_number=i+1;
		sql="update logistics_product_providers_recommend_details set details_number='"+details_number+"' where id='"+id_group[i]+"'";
		logistics_db.executeUpdate(sql);
	}
	}
			logistics_db.commit();	
			logistics_db.close();
}
catch (Exception ex) {
		ex.printStackTrace();
	}
		response.sendRedirect("productProviders.jsp?product_logistics_recommend_ID="+product_logistics_recommend_ID+"");
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="productProviders.jsp?id=<%=id%>&&product_logistics_recommend_ID=<%=product_logistics_recommend_ID%>">
 </div>
 </td>
 </tr>
 </table>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td> 
 </tr>
 </table>
 </div>
<%}%>