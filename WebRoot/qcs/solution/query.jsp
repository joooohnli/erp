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
<%nseer_db qcs_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="sum" scope="page" class="finance.Sum"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript" src="../../javascript/qcs/solution/solution.js"></script>
<% 
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<%
try{
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String solution_id = request.getParameter("solution_id");
String sql = "select id,checker,check_time,solution_name,product_id,product_name,quality_standard_id,quality_standard_name,register,register_time,designer,remark,attachment1 from qcs_solution where solution_id='"+solution_id+"'" ;
ResultSet rs = qcs_db.executeQuery(sql) ;
if(rs.next()){
String solution_name=rs.getString("solution_name");
String register_time=rs.getString("register_time");
if(register_time.equals("1800-01-01 00:00:00.0")){
register_time="";
}
String check_time=rs.getString("check_time");
if(check_time.equals("1800-01-01 00:00:00.0")){
check_time="";
}
String register=rs.getString("register");
String checker=rs.getString("checker");
String product_id=rs.getString("product_id");
String product_name=rs.getString("product_name");
String designer=rs.getString("designer");
String remark=rs.getString("remark");
String attachment1=rs.getString("attachment1");
String id=rs.getString("id");
String quality_standard_id=rs.getString("quality_standard_id");
String quality_standard_name=rs.getString("quality_standard_name");
String quality_standard=quality_standard_id+"/"+quality_standard_name;
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></div></td>
</tr>
</table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","质检方案")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id="bill_head">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","方案编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" name="solution_id" value="<%=solution_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","方案名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="solution_name" type="text" width="100%" value="<%=solution_name%>" readonly /></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=product_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="100%" value="<%=product_name%>" readonly /></td>
 </tr>
 <tr>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="designer" name="designer" type="text" width="100%" value="<%=designer%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","质量标准")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="designer" name="quality_standard" type="text" width="100%" value="<%=quality_standard%>" readonly /></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="item"><%=demo.getLang("erp","质检项目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="analyse_method"><%=demo.getLang("erp","分析方法")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%" id="default_basis"><%=demo.getLang("erp","首选质检依据")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="14%" id="ready_basis"><%=demo.getLang("erp","备选质检依据")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%" id="quality_method"><%=demo.getLang("erp","质检方法")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="standard_value"><%=demo.getLang("erp","标准值")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="standard_max"><%=demo.getLang("erp","标准上限")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%" id="standard_min"><%=demo.getLang("erp","标准下限")%></td>
 </tr>
</table>
<%
sql="select item,analyse_method,default_basis,ready_basis,quality_method,standard_value,standard_max,standard_min from qcs_solution_details where solution_id='"+solution_id+"'";
rs=qcs_db.executeQuery(sql);
int i=1;
while(rs.next()){
%>
<script>
addRow('bill_body');
var bill_body=document.getElementById('bill_body');
document.getElementById('item'+<%=i%>).value='<%=rs.getString("item")%>';
document.getElementById('analyse_method'+<%=i%>).value='<%=rs.getString("analyse_method")%>';
document.getElementById('default_basis'+<%=i%>).value='<%=rs.getString("default_basis")%>';
document.getElementById('ready_basis'+<%=i%>).value='<%=rs.getString("ready_basis")%>';
document.getElementById('quality_method'+<%=i%>).value='<%=rs.getString("quality_method")%>';
document.getElementById('standard_value'+<%=i%>).value='<%=rs.getString("standard_value")%>';
document.getElementById('standard_max'+<%=i%>).value='<%=rs.getString("standard_max")%>';
document.getElementById('standard_min'+<%=i%>).value='<%=rs.getString("standard_min")%>';
for(var m=0;m<8;m++){
document.getElementById(bill_body.rows[0].cells[m].id+<%=i%>).onfocus=function (){this.blur();};
}
</script>
<%
i++;
}
%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=register%>" readonly/></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=register_time%>" readonly/></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=checker%>" readonly/></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="check_time" value="<%=check_time%>" readonly/></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%" height="65"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" readonly /><%=exchange.unURL(remark)%></textarea>
</td>
 </tr>
 <%=isPrint.printOrNot3(attachment1,"附件&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,id,"qcs_solution","attachment1")%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%}
qcs_db.close();
}catch(Exception e){
e.printStackTrace();
}%>