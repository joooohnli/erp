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
<script language="javascript" src="../../javascript/qcs/sampling_standard/register.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divDisappear.js"></script>
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
String standard_id = request.getParameter("standard_id");
String sql = "select id,checker,check_time,checker_id,standard_name,sampling_method,designer,quality_level,mil_std,aql,remark,attachment1 from qcs_sampling_standard where standard_id='"+standard_id+"'" ;
ResultSet rs = qcs_db.executeQuery(sql) ;
if(rs.next()){
String standard_name=rs.getString("standard_name");
String check_time=rs.getString("check_time");
if(check_time.equals("1800-01-01 00:00:00.0")){
check_time="";
}
String checker_id=rs.getString("checker_id");
String checker=rs.getString("checker");
String sampling_method=rs.getString("sampling_method");
String designer=rs.getString("designer");
String remark=rs.getString("remark");
String attachment1=rs.getString("attachment1");
String id=rs.getString("id");
String quality_level=rs.getString("quality_level");
String mil_std=rs.getString("mil_std");
String AQL=rs.getString("aql");
if(quality_level.equals("")){
}
%>
<body onload="locateSelectDiv()">
<form id="mutiValidation" method="POST" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="hidden" id="formula_button"><input type="hidden" id="add_button"><input type="hidden" id="del_button"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","抽样标准")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id="bill_head">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","标准编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" name="standard_id" value="<%=standard_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","标准名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="standard_name" type="text" width="100%" value="<%=standard_name%>" readonly /></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","抽样方法")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3"  id="method_id" name="method_name" type="text" width="100%" value="<%=sampling_method%>" readonly />
  </td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="designer" type="text" width="100%" value="<%=designer%>" readonly /></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%" id="batch"><%=demo.getLang("erp","批量数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%" id="sample"><%=demo.getLang("erp","样本数")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="14%" id="formula"><%=demo.getLang("erp","抽样公式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%" id="accept"><%=demo.getLang("erp","允收数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%" id="reject"><%=demo.getLang("erp","拒收数")%></td>
 </tr>
</table>
<script>
	 initBillHead('method_id','bill_head','bill_body');
<%	String sampling_method1=sampling_method.split("/")[1];
	if(sampling_method1.equals("国标")||sampling_method1.equals("自定义")){%>
	 document.getElementById('level_id').value='<%=quality_level%>';
	 document.getElementById('level_id').onfocus=function(){ document.getElementById('level_id').blur();};
	 document.getElementById('level_id_div').style.display='none';
	 document.getElementById('class_id').value='<%=mil_std%>';
	 document.getElementById('class_id').onfocus=function(){ document.getElementById('class_id').blur();};
	 document.getElementById('class_id_div').style.display='none';
	 document.getElementById('aql_id').value='<%=AQL%>';
	 document.getElementById('aql_id').onfocus=function(){ document.getElementById('aql_id').blur();};
	 document.getElementById('aql_id_div').style.display='none';
	 
<%}%>
<% String sql1 = "select * from qcs_sampling_standard_details where standard_id='"+standard_id+"' order by id" ;
	 ResultSet rs1 = qcs_db.executeQuery(sql1) ;
	 int m=0;
	 while(rs1.next()){
%>
	 addRow('bill_body');
	 var bill_body=document.getElementById('bill_body');
	  document.getElementById(bill_body.rows[0].cells[0].id+<%=m+1%>).value='<%=rs1.getString("batch")%>';
	  document.getElementById(bill_body.rows[0].cells[0].id+<%=m+1%>).onfocus=function (){this.blur();};
	  <%if(sampling_method1.equals("国标")){%>
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).value='<%=rs1.getString("sample_code")%>';
	 document.getElementById(bill_body.rows[0].cells[0].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).value='<%=rs1.getString("sampling_amount")%>'
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).onfocus=function (){this.blur();}
	 document.getElementById(bill_body.rows[0].cells[4].id+<%=m+1%>).onfocus=function (){this.blur();};;
	  <%}else if(sampling_method1.equals("固定数量")){%>
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).value='<%=rs1.getString("sampling_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).value='<%=rs1.getString("accept_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).value='<%=rs1.getString("reject_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).onfocus=function (){this.blur();};
	  <%}else{%>
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).value='<%=rs1.getString("sampling_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[1].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).value='<%=rs1.getString("sampling_formula")%>';
	 document.getElementById(bill_body.rows[0].cells[2].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).value='<%=rs1.getString("accept_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[3].id+<%=m+1%>).onfocus=function (){this.blur();};
	 document.getElementById(bill_body.rows[0].cells[4].id+<%=m+1%>).value='<%=rs1.getString("reject_amount")%>';
	 document.getElementById(bill_body.rows[0].cells[4].id+<%=m+1%>).onfocus=function (){this.blur();};
	  <%}%>
	 	 
<%
m++;
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=checker%>" readonly /><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker_id" value="<%=checker_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="check_time" value="<%=check_time%>" readonly /></td>
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
 <%=isPrint.printOrNot3(attachment1,"附件&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,id,"qcs_sampling_standard","attachment1")%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<%}
qcs_db.close();
}catch(Exception e){
e.printStackTrace();
}%>