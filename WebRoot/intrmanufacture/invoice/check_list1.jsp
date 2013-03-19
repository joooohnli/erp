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
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db intrmanufacture_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/intrmanufacture/intrmanufacture_intrmanufacture.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
String tablename="intrmanufacture_intrmanufacture";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='2' and excel_tag='2' and invoice_tag!='3' and invoice_check_tag='1'";
String queue="order by check_time";
String validationXml="../../xml/intrmanufacture/intrmanufacture_intrmanufacture.xml";
String nickName="委外执行单";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","等待发票信息登记审核的委外执行单总数：");
%>
<%@include file="../../include/search.jsp"%>
<% 
try{
if(intRowCount!=0){
	session.setAttribute("task_content","none");
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from intrmanufacture_config_workflow where type_id='06'";
ResultSet rs=intrmanufacture_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
rs = intrmanufacture_db.executeQuery(sql_search) ;
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%>  class="TD_STYLE3"><%=demo.getLang("erp","等待审核：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 </table>
 <div id="nseer_grid_div"></div>
 <script type="text/javascript">

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","委外执行单编号")%>'}, 
<%
for(int i=1;i<workflow_amount;i++){
		String title="流程"+i;
%>
					   {name: '<%=demo.getLang("erp",title)%>'},

	<%
}
	String title="流程"+workflow_amount;

%> 
                           {name: '<%=demo.getLang("erp",title)%>'}
]
nseer_grid.column_width=[200,<%for(int i=1;i<workflow_amount;i++){%>70,<%}%>70];
nseer_grid.auto='<%=demo.getLang("erp","委外执行单编号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String sql1="select id from intrmanufacture_workflow where object_ID='"+rs.getString("intrmanufacture_ID")+"' and check_tag='0' and invoice_time='"+rs.getString("invoice_time")+"'";
ResultSet rs2=intrmanufacture_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id,invoice_time from intrmanufacture_workflow where object_ID='"+rs.getString("intrmanufacture_ID")+"' and invoice_time='"+rs.getString("invoice_time")+"' order by id";
	rs2=intrmanufacture_db1.executeQuery(sql1);
%>
['<%=rs.getString("intrmanufacture_ID")%>'
<%
for(int i=1;i<=workflow_amount;i++){
	String status="";
	if(rs2.next()){
			if(rs2.getString("check_tag").equals("0")){
			status="无权限";
		}else if(rs2.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs2.getString("check_tag").equals("9")){
			status="未通过";
			}
			if(rs2.getString("check_tag").equals("0")&&rs2.getString("describe1").indexOf(register_ID)!=-1){
%>
,'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("check.jsp?intrmanufacture_ID=<%=rs.getString("intrmanufacture_ID")%>&invoice_time=<%=rs2.getString("invoice_time")%>&config_ID=<%=rs2.getString("config_ID")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%}%>
</page:pages>
['']];

nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>

<%
}else{
%>
<table valign="center">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td><%session.removeAttribute("task_content");%></td>
</tr>
</table>
<%
}
intrmanufacture_db.close();
intrmanufacture_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>