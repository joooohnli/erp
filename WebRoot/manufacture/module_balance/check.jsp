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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db manufacturedb = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String config_id=request.getParameter("config_id");
String manufacture_ID=request.getParameter("manufacture_ID") ;
String procedure_name=exchange.unURL(request.getParameter("procedure_name")) ;
String procedure_ID=request.getParameter("procedure_ID") ;
String register_time=exchange.unURL(request.getParameter("register_time")) ;
String checker=(String)session.getAttribute("realeditorc");
String module_time=request.getParameter("module_time");

String sql9="select * from manufacture_workflow where object_ID='"+manufacture_ID+"' and check_tag='0' and type_id='05' and config_id<'"+config_id+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"'";
ResultSet rs9=manufacturedb.executeQuery(sql9);
if(!rs9.next()){

String sql8="select * from manufacture_module_balance where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"' and check_tag='0'";
ResultSet rs8=manufacture_db.executeQuery(sql8);
if(rs8.next()){
int a=0;
String sql1="select count(*) from manufacture_module_balance_details where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"'";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	a=rs1.getInt("count(*)");
}
try{
String sql="select * from manufacture_module_balance where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"'";
ResultSet rs=manufacture_db.executeQuery(sql);
if(rs.next()){
	String reason=exchange.unHtml(rs.getString("reason"));
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?manufacture_ID=<%=rs.getString("manufacture_ID")%>&config_id=<%=config_id%>&module_time=<%=rs.getString("module_time")%>";
}else{
form.action = "../../manufacture_module_balance_check_ok?manufacture_ID=<%=rs.getString("manufacture_ID")%>&config_id=<%=config_id%>&module_time=<%=rs.getString("module_time")%>";
}
}
</script>
<script language="javascript" src="../../javascript/input_control/check.js"></script>
<script language="javascript">
var count=0;
function CheckForm(TheForm) {
	trimform(TheForm);
	if(count>0) {
 	return false;
 	}
 	count++;
<%for(int j=1;j<a;j++){%>
	if (TheForm.amount<%=j%>.value == ""||!chkfin(TheForm.amount<%=j%>.value)) {
	alert(<%=demo.getLang("erp","请正确填写数量！")%>);
	TheForm.amount<%=j%>.focus();
		count=count-1;
	return(false);
	}	
<%}%>
	return(true);
}
</script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/manufacture/manufacture_module_balance.xml','mutiValidation')&&TwoSubmit(this)">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked> <%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","物料申领/退回登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <input name="register_time" type="hidden" value="<%=exchange.toHtml(rs.getString("register_time"))%>">
 <input name="procedure_ID" type="hidden" value="<%=procedure_ID%>">
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","派工单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><input name="manufacture_ID" type="hidden" value="<%=manufacture_ID%>"><%=manufacture_ID%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","工序名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="procedure_name" type="hidden" value="<%=exchange.toHtml(rs.getString("procedure_name"))%>"><%=exchange.toHtml(rs.getString("procedure_name"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","负责人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="procedure_responsible_person" type="text" value="<%=exchange.toHtml(rs.getString("procedure_responsible_person"))%>"></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","物料名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","物料编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计（元）")%></td>	 
 </tr>
<%
	int i=1;
String sql2="select * from manufacture_module_balance_details where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"' order by details_number";
ResultSet rs2=manufacture_db.executeQuery(sql2);
while(rs2.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" onFocus="this.blur()" type="text" value="<%=exchange.toHtml(rs2.getString("product_name"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID<%=i%>" onFocus="this.blur()" type="text" value="<%=rs2.getString("product_ID")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" onFocus="this.blur()" type="hidden" value="<%=rs2.getString("product_describe")%>"><%=rs2.getString("product_describe")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount<%=i%>" type="text" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs2.getDouble("amount"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit<%=i%>" onFocus="this.blur()" type="text" value="<%=exchange.toHtml(rs2.getString("amount_unit"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price<%=i%>" onFocus="this.blur()" type="text" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs2.getDouble("cost_price"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs2.getDouble("subtotal"))%></td>
 </tr>
<%
	i++;
	}
	manufacture_db.close();
%>
<input name="product_amount" type="hidden" value="<%=a%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" type="text" value="<%=exchange.toHtml(checker)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","申领/退回理由")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="reason"><%=reason%></textarea>
</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
	}
	 manufacture_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	manufacture_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回")%></td>
 </tr>
</table>
</div>

<%}
	 manufacturedb.close();

}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回")%></td>
 </tr>
</table>
</div>
<%}
	 manufacture_db.close();	
%>
