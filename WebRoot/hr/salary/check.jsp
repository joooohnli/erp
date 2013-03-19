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
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
	String checker=(String)session.getAttribute("realeditorc");
	String checker_id=(String)session.getAttribute("human_IDD");
	String salary_id=request.getParameter("salary_id");
	String config_id=request.getParameter("config_id");
String sqla="select id from hr_workflow where object_ID='"+salary_id+"' and check_tag='0' and config_id<'"+config_id+"'";
	ResultSet rsa=hr_db.executeQuery(sqla);
	if(!rsa.next()){
 String sql = "select * from hr_file where check_tag='1' and gar_tag='0' and salary_standard_id!='未定义' and salary_tag='1' and human_name!='admin' order by id";
try{
ResultSet rs = hr_db.executeQuery(sql);
%>
<script language="javascript">
function TwoSubmit(){
var form=document.getElementById('salary_register');
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp";
}else{
form.action = "../../hr_salary_check_human_details_ok";
}
form.submit();
}
</script>
<form id="salary_register" method="post" action="../../hr_salary_check_human_details_ok">
<input type="hidden" name="config_id" value="<%=config_id%>">
<input type="hidden" name="salary_id" value="<%=salary_id%>">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked> <%=demo.getLang("erp","未通过")%>&nbsp;<input name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> <%=demo.getLang("erp","通过")%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="TwoSubmit();" value=<%=demo.getLang("erp","确定")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp" /></div></td>
 </tr>
 </table>
<%
String sql1="select type_name from hr_config_public_char where kind='薪酬项目'";
ResultSet rs1 = hr_db1.executeQuery(sql1) ;
int k=0;
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
                       {name: '<%=demo.getLang("erp","档案编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","性别")%>'},
<%rs1.first();for(int i=0;i<k;i++){%>{name: '<%=rs1.getString("type_name")%>'},<%rs1.next();}%>
                       {name: '<%=demo.getLang("erp","奖励金额")%>'},
					   {name: '<%=demo.getLang("erp","销售绩效金额")%>'},
					   {name: '<%=demo.getLang("erp","应扣金额")%>'},
					   {name: '<%=demo.getLang("erp","总金额")%>'}
]
nseer_grid.column_width=[150,60,60,<%rs1.first();for(int i=0;i<k;i++){%>60,<%rs1.next();}%>100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","总金额")%>';
nseer_grid.data = [
<%
double sumtotal=0.0d;
while(rs.next()){%>
  ['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><%=rs.getString("human_ID")%><input type="hidden" value="<%=rs.getString("human_ID")%>" name="human_ID"></div>','<input type="hidden" value="<%=rs.getString("human_name")%>" name="human_name"><%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("sex"))%>',
<%rs1.first();for(int i=0;i<k;i++){
String sql2="select salary from hr_salary_human_details_details where item_name='"+rs1.getString("type_name")+"' and salary_id='"+salary_id+"' and human_ID='"+rs.getString("human_ID")+"'";
ResultSet rs2 = hr_db2.executeQuery(sql2);
if(rs2.next()){sumtotal+=rs2.getDouble("salary");%>'<%=rs2.getString("salary")%>',<%}else{%>'',<%}rs1.next();}
String sql3="select * from hr_salary_human_details where salary_id='"+salary_id+"' and human_id='"+rs.getString("human_ID")+"'";
ResultSet rs3 = hr_db2.executeQuery(sql3);
if(rs3.next()){sumtotal+=rs3.getDouble("bonus_sum")+rs3.getDouble("sale_bonus_sum")-rs3.getDouble("deduct_sum");
%>'<input type="text" name="bonus_sum" value="<%=rs3.getString("bonus_sum")%>">','<input type="text" name="sale_bonus_sum" value="<%=rs3.getString("sale_bonus_sum")%>">','<input type="text" name="deduct_sum" value="<%=rs3.getString("deduct_sum")%>">'<%}else{%>'<input type="text" name="bonus_sum">','<input type="text" name="sale_bonus_sum">','<input type="text" name="deduct_sum">'<%}%>,'<%=sumtotal%>'],
<%}%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
</form>
<%@include file="../../include/head_msg.jsp"%>
<%
}catch(Exception ex){ex.printStackTrace();}
	}else{%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
</table>
</div>
<%}
hr_db.close();
hr_db1.close();
hr_db2.close();
%>
