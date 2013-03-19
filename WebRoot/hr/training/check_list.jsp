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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hr_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"> <div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script src="../../javascript/table/movetable.js">
</script>
<%try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from hr_config_workflow where type_id='05'";
ResultSet rs=hr_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
sql = "select * from hr_file left join hr_training on hr_file.human_ID=hr_training.human_ID where hr_training.check_tag='0' order by hr_file.register_time" ;
rs = hr_db.executeQuery(sql) ;
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
int pageSize=25;
String pageSize_temp=request.getParameter("pageSize");
if(pageSize_temp!=null&&!pageSize_temp.equals("")){pageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(pageSize).toString());
String strPage = request.getParameter("page");
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&(strPage.equals("")||!validata.validata(strPage))){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(maxPage>0&&Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
strPage=strPage+"⊙"+maxPage;
%> 
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">  
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  </table>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","档案编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","性别")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
					   {name: '<%=demo.getLang("erp","职称")%>'},
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
nseer_grid.column_width=[180,100,50,100,70,
<%
for(int i=1;i<workflow_amount;i++){
%>					   70,
<%
}
%> 
                           70	
];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
 <%
String sql1="select id,training_time from hr_workflow where object_ID='"+rs.getString("human_ID")+"' and check_tag='0' and type_id='05'";
ResultSet rs2=hr_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id,training_time from hr_workflow where object_ID='"+rs.getString("human_ID")+"' and training_time='"+rs2.getString("training_time")+"' and type_id='05' order by id";
	rs2=hr_db1.executeQuery(sql1);
%> ['<%=rs.getString("human_ID")%>','<%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("sex"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=exchange.toHtml(rs.getString("human_title_class"))%>'
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
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?human_ID=<%=rs.getString("human_ID")%>&&config_id=<%=rs2.getString("config_id")%>&&training_time=<%=rs2.getString("training_time")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
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
<page:updowntag num="<%=intRowCount%>" file="check_list.jsp"/>
<%	
hr_db.close();
hr_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>

