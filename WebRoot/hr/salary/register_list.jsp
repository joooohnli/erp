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
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hr_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hr_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 String tablename="hr_file";
%>
<script src="../../javascript/table/movetable.js"></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%

String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and gar_tag='0' and human_name!='admin' and salary_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/hr/hr_file.xml";
String nickName="人力资源档案";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的人力资源档案总数：");
%>
<%@include file="../../include/search.jsp"%>
<% 
try{
ResultSet rs = hr_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","提交")+"\">";
%>
<form id="salary_register" method="post" action="../../hr_salary_register_human_details_ok" onsubmit="">
<%@include file="../../include/search_top.jsp"%>
<%
String sql1="select type_name from hr_config_public_char where kind='薪酬项目'";
ResultSet rs1 = hr_db1.executeQuery(sql1) ;
int k=0,t=0;
while(rs1.next()){k++;}
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
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","档案编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","性别")%>'},
<%rs1.first();for(int i=0;i<k;i++){%>{name: '<%=rs1.getString("type_name")%>'},<%rs1.next();}%>
                       {name: '<%=demo.getLang("erp","奖励金额")%>'},
					   {name: '<%=demo.getLang("erp","销售绩效金额")%>'},
					   {name: '<%=demo.getLang("erp","应扣金额")%>'}
]
nseer_grid.column_width=[100,150,60,60,<%rs1.first();for(int i=0;i<k;i++){%>60,<%rs1.next();}%>100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","销售绩效金额")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%if(!rs.getString("salary_standard_id").equals("未定义")){%>
<%if(rs.getString("salary_tag").equals("0")){%>
  ['<input type="checkbox" name="checkbox" value="<%=t%>" style="height:10">','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><%=rs.getString("human_ID")%><input type="hidden" value="<%=rs.getString("human_ID")%>" name="human_ID"></div>','<input type="hidden" value="<%=rs.getString("human_name")%>" name="human_name"><%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("sex"))%>',
<%rs1.first();for(int i=0;i<k;i++){
String sql2="select salary from hr_salary_standard_details where item_name='"+rs1.getString("type_name")+"' and standard_id='"+rs.getString("salary_standard_id")+"'";
ResultSet rs2 = hr_db2.executeQuery(sql2);
if(rs2.next()){
%>'<%=rs2.getString("salary")%>',<%}else{%>'',<%}rs1.next();}%>'<input type="text" name="bonus_sum">','<input type="text" name="sale_bonus_sum">','<input type="text" name="deduct_sum">'],
<%t++;%>
<%}%>
<%}else{%>
['<%=demo.getLang("erp","未定义薪酬标准")%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><font color="#FF9966"><%=rs.getString("human_ID")%></font></div>','<input type="hidden" value="<%=rs.getString("human_name")%>" name="human_name"><%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("sex"))%>',
<%for(int i=0;i<k;i++){%>'',<%}%>'','',''],
<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
</form>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
hr_db.close();
hr_db1.close();
hr_db2.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<script>
function salary_submit(){
	var checkbox=document.getElementsByName('checkbox');
	alert();
}
</script>