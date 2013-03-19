<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.tree_index.*,include.nseer_cookie.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="xml" class="include.nseer_cookie.ReadXmlLength" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../../javascript/winopen/winopen.js"></script>
<%
String human_ID=request.getParameter("human_ID");	
String tablename=request.getParameter("tablename");	
Nseer n=new Nseer();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<%
MaxKind max=new MaxKind((String)session.getAttribute("unit_db_name"),tablename+"_view","file_id",human_ID);
int first_length=2;//一级机构步长
int step_length=2;//除一级机构以外的步长
int kind_rows=KindDeep.getDeep(max.maxValue("file_id"),first_length,step_length);//设置机构列数
kind_rows=kind_rows-1;
max.close();//关闭数据库
%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.magin_h='98%';

nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
 <%
for(int j=1;j<=kind_rows;j++){
if(j!=kind_rows){%>
  {name: '<%=j%><%=demo.getLang("erp","级模块")%>'},
<%}else{%>
 {name: '<%=j%><%=demo.getLang("erp","级模块")%>'}
<%}}%>    
              
]
nseer_grid.column_width=[
<%
for(int j=1;j<=kind_rows;j++){
if(j!=kind_rows){%>
 250,
<%}else{%>
 250
<%}}%>   ];
nseer_grid.auto='<%=demo.getLang("erp","3级模块")%>';
nseer_grid.data = [
<%

String sql1="select * from "+tablename+"_view where workflow_tag='0' and human_ID='"+human_ID+"' order by id" ;
ResultSet rs1=db.executeQuery(sql1);
rs1.next();
while(rs1.next()){
String file_id=rs1.getString("file_id").trim();
int len=KindDeep.getDeep(file_id,2,2);//判断长度,判断属于几级机构.
len=len-2;
if(!rs1.getString("hreflink").equals("")||rs1.getInt("details_tag")==1){
%>
<%
String str11="";	
for(int j=0;j<kind_rows;j++){
if(len==j){
	str11+="'"+rs1.getString("file_name")+"',";
}else{
   str11+="'',";
}
}
str11=str11.substring(0,str11.length()-1);
%>
[<%=str11%>],

<%
}}
%>
['']];

nseer_grid.init();

</script>



<%
db.close();
%>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>