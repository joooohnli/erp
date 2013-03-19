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

<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db fund_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String id=request.getParameter("id");
String type_id=request.getParameter("type_id");
String sql1="select count(id) from fund_config_workflow where type_id='"+type_id+"'";
ResultSet rs1 = fund_db.executeQuery(sql1);
int count=0;
if(rs1.next()){
	count=rs1.getInt("count(id)");
}
List fList = (List)new java.util.ArrayList();
int f=0;
String sql="select fund_id from fund_fund where fund_tag!='1' and reason='付款' and fund_execute_tag='1' and (check_tag='1' or check_tag='9')";
ResultSet rs=fund_db1.executeQuery(sql);
while(rs.next()){
	String sql4="select * from fund_details where fund_ID='"+rs.getString("fund_ID")+"'";
	ResultSet rs4 = fund_db.executeQuery(sql4);
	while(rs4.next()){
		if(rs4.getString("execute_check_tag").equals("1")&&!rs4.getString("execute_details_tag").equals("2")){
			if(f==0){
				fList.add(rs4.getString("fund_ID"));
				f++;
			}
			else if(!rs4.getString("fund_ID").equals(fList.get(f-1))){
				fList.add(rs4.getString("fund_ID"));
				f++;
			}
		}		
	}
}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">

<%
if(count==1&&fList.size()>0){
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
	<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onclick=location="pay.jsp"></div></td>
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","尚有等待审核或需重新登记的付款执行单，最后一个审核流程不能删除，请返回。")%></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table> 
 <%}else{%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
	<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" onClick=location="../../../fund_config_workflow_pay_delete_ok?id=<%=id%>&type_id=<%=type_id%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onclick=location="pay.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您确认要删除这个审核流程吗？")%></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<%}
fund_db.close();
fund_db1.close();
%>
</form>
</div>