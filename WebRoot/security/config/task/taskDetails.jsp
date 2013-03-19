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
<%nseer_db document_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<script language="javascript">
function $() {
 var elements = new Array();
 for (var i = 0; i < arguments.length; i++) {
 var element = arguments[i];
 if (typeof element == 'string')
 element = document.getElementById(element);
 if (arguments.length == 1) 
 return element;
 elements.push(element);
 }
 return elements;
}
var selectAll='<%=demo.getLang("erp","全选")%>';
var cancelAll='<%=demo.getLang("erp","取消")%>';

function selAl(obj){
	var col=obj.elements["check"];
 for(var i=0;i<obj.elements.length;i++){
 if(obj.elements[i].tagName.toLowerCase()=="input" && obj.elements[i].type=="checkbox"){
 if(col.value==selectAll){
 obj.elements[i].checked=true;
 }else{
 obj.elements[i].checked=false;
 }
  
 }
 } 
 if($('taskDetails').childNodes.length<=1) return;
 col.value=col.value==cancelAll?selectAll:cancelAll;
}

function init(l,sl){
 var cols=l;
 sl.check.disabled=cols.childNodes.length>1?false:true;
 sl.check.value=selectAll;
}
window.onload=function(){
	init($("taskDetails"),document.selectList);
}
</SCRIPT>
<form id="taskDetails" class="x-form" method="post" action="../../../security_config_task_taskDetails_register_ok">

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name="check" onClick="selAl(this.form)">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确定")%>"></div></td>
</tr>
</table>
<% 
 String sql = "select * from document_second where ((second_kind_ID like '%审核') and head_file like 'check_list%') or first_kind_name='alarm' order by main_kind_name";
 ResultSet rs = document_db.executeQuery(sql) ;
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
int k=0;
String first_module="";
String group_name="";
%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","主模块")%>'},
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","任务")%>'}
                  ]
nseer_grid.column_width=[200,100,300];
nseer_grid.auto='<%=demo.getLang("erp","任务")%>';
nseer_grid.data = [
<%
while(rs.next()){
	if(!rs.getString("main_kind_ID").equals(first_module)){
			k++;
		first_module=rs.getString("main_kind_ID");
		group_name=rs.getString("main_kind_name")+"Tree";
		%> 
	['<INPUT onclick=selAll<%=k%>(this.form) type="button" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name="check<%=k%>">&nbsp;<%=demo.getLang(group_name,rs.getString("main_kind_ID"))%>',
	<%}else{%>
	['',
	<%}
if(rs.getString("task_tag").equals("1")){%>
	'<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col<%=k%>" value=<%=rs.getString("id")%> checked>',
	<%}else{%>
	'<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col<%=k%>" value=<%=rs.getString("id")%>>',
<%}%>	
'<%=demo.getLang(group_name,rs.getString("main_kind_ID"))%>--<%=demo.getLang(group_name,rs.getString("first_kind_ID"))%>--<%=demo.getLang(group_name,rs.getString("second_kind_ID"))%>'],
<%
}
%>
['']];

nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<input type="hidden" name="cols_number" value="<%=k%>"> 
<%document_db.close();%>
<%@include file="../../../include/head_msg.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
var col='';
function $() {
 var elements = new Array();
 for (var i = 0; i < arguments.length; i++) {
 var element = arguments[i];
 if (typeof element == 'string')
 element = document.getElementById(element);
 if (arguments.length == 1) 
 return element;
 elements.push(element);
 }
 return elements;
}

var selectAll='<%=demo.getLang("erp","全选")%>';
var cancelAll='<%=demo.getLang("erp","取消")%>';
<%
for(int j=1;j<=k;j++){
	%>

function selAll<%=j%>(obj){
	 col=obj.elements["check<%=j%>"];
 for(var i=0;i<obj.elements.length;i++){
 if(obj.elements[i].tagName.toLowerCase()=="input" && obj.elements[i].type=="checkbox" && obj.elements[i].name=="col<%=j%>"){
 if(col.value==selectAll){
 obj.elements[i].checked=true;
 }else{
 obj.elements[i].checked=false;
 }
  
 }
 } 
 if($('taskDetails').childNodes.length<=1) return;
 col.value=col.value==cancelAll?selectAll:cancelAll;
}

function selAl(obj){
	 col=obj.elements["check"];
 for(var i=0;i<obj.elements.length;i++){
 if(obj.elements[i].tagName.toLowerCase()=="input" && obj.elements[i].type=="checkbox"){
 if(col.value==selectAll){
 obj.elements[i].checked=true;
 }else{
 obj.elements[i].checked=false;
 }
  
 }
 } 
 
 col.value=col.value==cancelAll?selectAll:cancelAll;
}

<%}%>
function init(l,sl){
 var cols=l;

}
window.onload=function(){
	init($("taskDetails"),document.selectList);
}
</script>