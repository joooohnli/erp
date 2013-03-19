<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*,include.get_name_from_ID.getNameFromID"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%isPrint isPrint=new isPrint(request);%>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../javascript/qcs/sample/sample.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/qcs/purchase/purchase.css" />
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sample_id=request.getParameter("sample_id");
String view_time=request.getParameter("view_time");
try{
	String sql = "select * from qcs_sample_view where sample_id='"+sample_id+"' and view_time='"+view_time+"'";
	ResultSet rs = qcs_db.executeQuery(sql) ;
    if(rs.next()){
    String id=rs.getString("id");
    String apply_id=rs.getString("apply_id");
    String view_cycle=rs.getString("view_cycle");
    String product_id=rs.getString("product_id");
    String product_name=rs.getString("product_name");
    String quality_type=rs.getString("quality_type");
    String solution=rs.getString("solution");
    String register=rs.getString("register");
    String register_time=rs.getString("register_time");
    String attachment1=rs.getString("attachment1");
    String remark=rs.getString("remark");
    String last_view_time=rs.getString("remark");
%>
<%String table_width1="820px";%>
<form id="sample_check" METHOD="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","样品检验登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","样品登记单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sample_id" name="sample_id" type="text" width="100%" value="<%=sample_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="apply_id" name="apply_id" type="text" width="100%" value="<%=apply_id%>" readonly /></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","观察周期(天)")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="view_cycle" name="view_cycle" type="text" width="100%" value="<%=view_cycle%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","上次观察时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="last_view_time" name="last_view_time" type="text" width="100%" value="<%=last_view_time%>" readonly /></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品编号")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="37%" value="<%=product_id%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="37%" value="<%=product_name%>"/></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检方式")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_type" name="quality_type" type="text" width="37%" value="<%=quality_type%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检方案")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_solution" name="quality_solution" type="text" width="37%" value="<%=solution%>" readonly/></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","本次观察时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="view_time" name="view_time" type="text" width="37%" value="<%=view_time%>" /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr>
 <td>
 <div style="overflow:scroll;width:100%;height:200px;">
<table <%=TABLE_STYLE5%> style="border-collapse: collapse;border: 1px solid;" id="bill_body">
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%" id="item" name="item"><%=demo.getLang("erp","质检项目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%" id="quality_method" name="quality_method"><%=demo.getLang("erp","质检方法")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%" id="standard_value" name="standard_value"><%=demo.getLang("erp","标准值")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%" id="standard_max" name="standard_max"><%=demo.getLang("erp","标准上限")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%" id="standard_min" name="standard_min"><%=demo.getLang("erp","标准下限")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%" id="view_value" name="view_value"><%=demo.getLang("erp","观察值")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%" id="view_result" name="view_result"><%=demo.getLang("erp","观察结果")%></td>
 </tr>
</table>
</div>
</td>
</tr>
</table>
<script>
<%
sql="select * from qcs_sample_view_details where sample_id='"+sample_id+"' and view_time='"+view_time+"' order by details_number";
rs=qcs_db.executeQuery(sql);
int i=1;
while(rs.next()){
%>
	addRow('bill_body');
	var table_obj=document.getElementById('bill_body');
	document.getElementById(table_obj.rows[0].cells[0].id+'<%=i%>').value='<%=rs.getString("item")%>';
	document.getElementById(table_obj.rows[0].cells[0].id+'<%=i%>').onfocus=function(){this.blur();};
   	document.getElementById(table_obj.rows[0].cells[1].id+'<%=i%>').value='<%=rs.getString("quality_method")%>';
	document.getElementById(table_obj.rows[0].cells[1].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[2].id+'<%=i%>').value='<%=rs.getString("standard_value")%>';
	document.getElementById(table_obj.rows[0].cells[2].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[3].id+'<%=i%>').value='<%=rs.getString("standard_max")%>';
	document.getElementById(table_obj.rows[0].cells[3].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[4].id+'<%=i%>').value='<%=rs.getString("standard_min")%>';
	document.getElementById(table_obj.rows[0].cells[4].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[5].id+'<%=i%>').value='<%=rs.getString("view_value")%>';
	document.getElementById(table_obj.rows[0].cells[5].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[6].id+'<%=i%>').value='<%=rs.getString("view_result")%>';
	document.getElementById(table_obj.rows[0].cells[6].id+'<%=i%>').onfocus=function(){this.blur();};
<%
i++;
}
%>
</script>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register" name="register" type="text" width="37%" value="<%=register%>" readonly /></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register_time" name="register_time" type="text" width="37%" value="<%=register_time%>" readonly /></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" readonly/><%=remark%></textarea></td>
 </tr>
 <%=isPrint.printOrNot3(attachment1,"附件&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,id,"qcs_sample_view","attachment1")%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<%
}
	qcs_db.close();
}catch (Exception ex){
//out.println("error"+ex);
}
%>
