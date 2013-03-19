<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="xml" class="include.nseer_cookie.ReadXmlLength" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
</tr>
</table>
<%
String human_ID=request.getParameter("human_ID");
String sql="select * from security_license where human_ID='"+human_ID+"'";
ResultSet rs=db.executeQuery(sql);
if(rs.next()){
%>
<table <%=TABLE_STYLE4%> style="width:98%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","姓名：")%><%=rs.getString("human_name")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","员工档案编号：")%><%=rs.getString("human_ID")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","所在机构：")%><%=rs.getString("chain_name")%>&nbsp;</td>
 </tr>	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","职位分类：")%><%=rs.getString("human_major_first_kind_name")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","职位名称：")%><%=rs.getString("human_major_second_kind_name")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","许可证号码：")%><%=rs.getString("license_code")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","有效期：")%><%=rs.getString("expiry_period")%><%=demo.getLang("erp","(天)")%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
   <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","发放时间：")%><%=rs.getString("register_time")%>&nbsp;</td>
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="5">&nbsp;</td>
 </tr>
</table>
<%
}
	getArryFromValue aa=new getArryFromValue();
	String field_type=(String)session.getAttribute("field_type");
	String[] str=aa.getArryFromOneValue((String)session.getAttribute("unit_db_name"),"document_main","reason","kind","模块",field_type);
	getArryFromValue bb=new getArryFromValue();
	String[] str1=bb.getArryFromOneValue((String)session.getAttribute("unit_db_name"),"document_main","value","kind","模块",field_type);
%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.magin_w='98%';
nseer_grid.magin_h='55%';
nseer_grid.columns =[
  {name: '<%=demo.getLang("erp","模块名称")%>'},
  {name: '<%=demo.getLang("erp","有无权限")%>'},
  {name: '<%=demo.getLang("erp","查看")%>'}            
]
nseer_grid.column_width=[
150,150,150
];
nseer_grid.auto='<%=demo.getLang("erp","模块名称")%>';
nseer_grid.data = [
<%
for(int i=0;i<str.length;i++){
	String table1=str[i]+"_view";
	String group_name=str[i]+"Tree";
		String sql2="select * from "+table1+" where workflow_tag='0' and human_ID='"+human_ID+"'";
	ResultSet rs2=db.executeQuery(sql2);
	if(rs2.next()){
MaxKind max=new MaxKind((String)session.getAttribute("unit_db_name"),table1,"file_id",human_ID);//得表中字段的最长字符串
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");//得erp所在路径
path=path+"xml\\hr\\config\\file\\tree-config.xml";//传入xml读取步长.
int first_length=2;//一级机构步长
int step_length=2;//除一级机构以外的步长
int kind_rows=KindDeep.getDeep(max.maxValue("file_id"),first_length,step_length);//设置机构列数
kind_rows=kind_rows-1;
max.close();//关闭数据库
%>
['<%=str1[i]%>','<%=demo.getLang("erp","有")%>','<div style="text-decoration : underline;color:#3366FF" onclick=winopen("register_license_details.jsp?tablename=<%=str[i]%>&&human_ID=<%=human_ID%>")><%=demo.getLang("erp","查看")%></div>'],
<%
}else{%>
['<%=str1[i]%>','<%=demo.getLang("erp","无")%>',''],
<%}}
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