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
<script language="javascript" src="../../javascript/include/div/divViewChange.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css" />
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">

<script type="text/javascript" src="../../javascript/include/nseergrid/nseergrid.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseergrid/nseergrid.css" />
<script type="text/javascript" src="../../javascript/include/search/ajaxDiv.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/ResultKey.js'></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/ajax/niceforms.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>

<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sample_id=request.getParameter("sample_id");
try{
	String sql = "select id,quality_type,apply_id,sampling_person,sampling_time,register,register_time,attachment1,remark from qcs_sample where sample_id='"+sample_id+"' and check_tag='1'";
	ResultSet rs = qcs_db.executeQuery(sql) ;
    if(rs.next()){
    String id=rs.getString("id");
    String quality_type=rs.getString("quality_type");
    String apply_id=rs.getString("apply_id");
    String sampling_person=rs.getString("sampling_person");
    String sampling_time=rs.getString("sampling_time");
    String register=rs.getString("register");
    String register_time=rs.getString("register_time");
    String attachment1=rs.getString("attachment1");
    String remark=rs.getString("remark");
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
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","样品登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sample_id" name="sample_id" type="text" width="100%" value="<%=sample_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_type" name="quality_type" type="text" width="100%" value="<%=quality_type%>"  readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="apply_id" name="apply_id" type="text" width="100%" value="<%=apply_id%>" readonly/></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","取样人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_person" name="sampling_person" type="text" width="37%" value="<%=sampling_person%>" readonly/></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","取样时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_time" name="sampling_time" type="text" width="37%" value="<%=sampling_time%>" readonly/></td>
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
 <div style="overflow:scroll;width:100%;height:130px;">
<table <%=TABLE_STYLE5%> style="width:200%;border-collapse: collapse;border: 1px solid;" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="sample_lable" name="sample_lable"><%=demo.getLang("erp","样品标签号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="product_id" name="product_id"><%=demo.getLang("erp","产品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="product_name" name="product_name"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="amount_unit" name="amount_unit"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="sumtotal" name="sumtotal"><%=demo.getLang("erp","总数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="sampling_amount" name="sampling_amount"><%=demo.getLang("erp","取样数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="view_cycle" name="view_cycle"><%=demo.getLang("erp","观察周期(天)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="deposit_limit" name="deposit_limit"><%=demo.getLang("erp","保存期限(天)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="deposit_place" name="deposit_place"><%=demo.getLang("erp","存放位置")%></td>
 </tr>
</table>
</div>
</td>
</tr>
</table>
<script>
<%
sql="select * from qcs_sample_details where sample_id='"+sample_id+"' order by details_number";
rs=qcs_db.executeQuery(sql);
int i=1;
while(rs.next()){
%>
	addRow('bill_body');
	var table_obj=document.getElementById('bill_body');
	document.getElementById(table_obj.rows[0].cells[0].id+'<%=i%>').value='<%=rs.getString("sample_lable")%>';
	document.getElementById(table_obj.rows[0].cells[0].id+'<%=i%>').onfocus=function(){this.blur();};
   	document.getElementById(table_obj.rows[0].cells[1].id+'<%=i%>').value='<%=rs.getString("product_id")%>';
	document.getElementById(table_obj.rows[0].cells[1].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[2].id+'<%=i%>').value='<%=rs.getString("product_name")%>';
	document.getElementById(table_obj.rows[0].cells[2].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[3].id+'<%=i%>').value='<%=rs.getString("amount_unit")%>';
	document.getElementById(table_obj.rows[0].cells[3].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[4].id+'<%=i%>').value='<%=rs.getString("sumtotal")%>';
	document.getElementById(table_obj.rows[0].cells[4].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[5].id+'<%=i%>').value='<%=rs.getString("sampling_amount")%>';
	document.getElementById(table_obj.rows[0].cells[5].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[6].id+'<%=i%>').value='<%=rs.getString("view_cycle")%>';
	document.getElementById(table_obj.rows[0].cells[6].id+'<%=i%>').onfocus=function(){this.blur();};
    document.getElementById(table_obj.rows[0].cells[7].id+'<%=i%>').value='<%=rs.getString("deposit_limit")%>';  
	document.getElementById(table_obj.rows[0].cells[7].id+'<%=i%>').onfocus=function(){this.blur();};  
    document.getElementById(table_obj.rows[0].cells[8].id+'<%=i%>').value='<%=rs.getString("deposit_place")%>';
	document.getElementById(table_obj.rows[0].cells[8].id+'<%=i%>').onfocus=function(){this.blur();};
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
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" readonly/><%=exchange.unURL(remark)%></textarea></td>
</tr>
 <%=isPrint.printOrNot3(attachment1,"附件&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,id,"qcs_sample_view","attachment1")%>
<%
	sql="select count(id) from qcs_sample_view where sample_id='"+sample_id+"'";
	rs=qcs_db.executeQuery(sql);
	int k=1;
	if(rs.next()){
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","周期检验次数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input style="width:10%;color:blue;cursor:hand;" onclick="showYahoo();" <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="view_times" name="view_times" type="text" value="<%=rs.getInt("count(id)")%>" readonly /></td>
 </tr>
 <%}%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>



<div id="bill_div" class="nseer_div" nseerDef="dragAble" style="width:710px;height:420px;display:none;">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD> 
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div style="width:100%;height:100%;background:#E8E8E8">
<div id="tabsF">
<ul>
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","样品周期检验")%></span></a></li>
</ul>
</div>
<div id="nseer_grid_div" style="position:absolute;top:57px;left:12px;width:700px;height:200px;display:block;"></div>
</div>
 </TD>
<TD  background="../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>

<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.magin_h = "50%";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","质检申请单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
					   {name: '<%=demo.getLang("erp","观察时间")%>'},
					   {name: '<%=demo.getLang("erp","查看详细")%>'}
]
nseer_grid.column_width=[100,150,180,180,60];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<%
sql	="select apply_id,product_id,product_name,view_time from qcs_sample_view where sample_id='"+sample_id+"'";
 rs=qcs_db.executeQuery(sql);
 while(rs.next()){
%>
['<%=rs.getString("apply_id")%>','<%=rs.getString("product_id")%>','<%=rs.getString("product_name")%>','<%=rs.getString("view_time")%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query_details.jsp?sample_id=<%=sample_id%>&&view_time=<%=rs.getString("view_time")%>")><%=demo.getLang("erp","查看详细")%></div>'],
<%
k++;
}%>
['']];
nseer_grid.init();
</script>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<script>
function showYahoo(){
	document.getElementById('bill_div').style.display='block';
}
</script>
<%
}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该样品登记单已不存在！")%></td>
 </tr>
 </table>
 </div>
<%
}qcs_db.close();
}catch (Exception ex){
//out.println("error"+ex);
}
%>
