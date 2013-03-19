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
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db intrmanufacture_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/intrmanufacture/intrmanufacture_contact.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="intrmanufacture_contact";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2'";
String queue="order by contact_time";
String validationXml="../../xml/intrmanufacture/intrmanufacture_contact.xml";
String nickName="委外厂商档案";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的委外厂商联络总数：");
%>
<%@include file="../../include/search.jsp"%>
<% 
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from intrmanufacture_config_workflow where type_id='04'";
ResultSet rs=intrmanufacture_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
rs= intrmanufacture_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","联络单编号")%>'},
                       {name: '<%=demo.getLang("erp","委外厂商名称")%>'},
                       {name: '<%=demo.getLang("erp","联络理由")%>'},
	                   {name: '<%=demo.getLang("erp","联络理由编码")%>'},
					   {name: '<%=demo.getLang("erp","被联络人")%>'},
					   {name: '<%=demo.getLang("erp","联络人")%>'},
	     			   {name: '<%=demo.getLang("erp","联络时间")%>'},
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
nseer_grid.column_width=[180,100,100,100,100,100,160,<%for(int i=1;i<workflow_amount;i++){%>70,<%}%>70];
nseer_grid.auto='<%=demo.getLang("erp","委外厂商名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String contact_time="";
if(rs.getString("contact_time").equals("0000-00-00")){
contact_time="";
}else{
contact_time=rs.getString("contact_time");
}
String sql1="select id from intrmanufacture_workflow where object_ID='"+rs.getString("contact_ID")+"' and describe1 like '%"+register_ID+"%' and check_tag='0'";
ResultSet rs2=intrmanufacture_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from intrmanufacture_workflow where object_ID='"+rs.getString("contact_ID")+"' order by id";
	rs2=intrmanufacture_db1.executeQuery(sql1);
%>
['<%=rs.getString("contact_ID")%>','<%=exchange.toHtml(rs.getString("provider_name"))%>','<%=exchange.toHtml(rs.getString("reason"))%>','<%=rs.getString("reasonexact")%>','<%=exchange.toHtml(rs.getString("person_contacted"))%>','<%=exchange.toHtml(rs.getString("contact_person"))%>','<%=exchange.toHtml(contact_time)%>'
<%
for(int i=1;i<=workflow_amount;i++){
	String status="";
	if(rs2.next()){
			if(rs2.getString("check_tag").equals("0")){
			status="未审核";
			}else if(rs2.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs2.getString("check_tag").equals("9")){
			status="未通过";
			}
			if(rs2.getString("check_tag").equals("0")&&rs2.getString("describe1").indexOf(register_ID)!=-1){
			status="未审核";	
%>
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?contact_ID=<%=rs.getString("contact_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%
}
%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
intrmanufacture_db.close();
intrmanufacture_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>