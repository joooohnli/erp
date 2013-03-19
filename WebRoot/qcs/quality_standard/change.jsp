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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="sum" scope="page" class="finance.Sum"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript" src="../../javascript/qcs/quality_standard/quality_standard.js"></script>
<!--  弹出 计数器层的样式和js -->
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script language="javascript" src="../../javascript/include/div/divViewChange.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
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
String changer=(String)session.getAttribute("realeditorc");
String changer_id=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String change_time=formatter.format(now);
String standard_id = request.getParameter("standard_id");
String sql = "select id,standard_name,product_id,designer,product_name,remark,attachment1,register,register_id,register_time from qcs_quality_standard where standard_id='"+standard_id+"'" ;
ResultSet rs = qcs_db.executeQuery(sql) ;
if(rs.next()){
String standard_name=rs.getString("standard_name");
String product_id=rs.getString("product_id");
String product_name=rs.getString("product_name");
String remark=rs.getString("remark");
String attachment1=rs.getString("attachment1");
String id=rs.getString("id");
String designer=rs.getString("designer");
String register=rs.getString("register");
String register_time=rs.getString("register_time");
String register_id=rs.getString("register_id");
%>
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
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add_button" onclick="addRow('bill_body');" value="添加">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="del_button" onclick="deleteSelect('bill_body')" value=<%=demo.getLang("erp","删除")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="changeOk('mutiValidation');" value=<%=demo.getLang("erp","提交")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value=<%=demo.getLang("erp","返回")%>></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","质量标准")%></b></font></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" value="<%=standard_id%>" id="standard_id" name="standard_id" onfocus="this.blur();";/></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","标准名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="standard_name" type="text" width="100%" value="<%=standard_name%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=product_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="100%" value="<%=product_name%>" readonly /></td>
 </tr>
 <tr>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="designer" name="designer" type="text" width="100%" value="<%=designer%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"></td>
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
sql="select item,item_id,analyse_method,default_basis,ready_basis,quality_method,standard_value,standard_max,standard_min from qcs_quality_standard_details where standard_id='"+standard_id+"'";
rs=qcs_db.executeQuery(sql);
int i=1;
while(rs.next()){
%>
<script>
addRow('bill_body');
document.getElementById('item'+<%=i%>).value='<%=rs.getString("item")%>';
document.getElementById('analyse_method'+<%=i%>).value='<%=rs.getString("analyse_method")%>';
document.getElementById('default_basis'+<%=i%>).value='<%=rs.getString("default_basis")%>';
document.getElementById('ready_basis'+<%=i%>).value='<%=rs.getString("ready_basis")%>';
document.getElementById('quality_method'+<%=i%>).value='<%=rs.getString("quality_method")%>';
document.getElementById('standard_value'+<%=i%>).value='<%=rs.getString("standard_value")%>';
document.getElementById('standard_max'+<%=i%>).value='<%=rs.getString("standard_max")%>';
document.getElementById('standard_min'+<%=i%>).value='<%=rs.getString("standard_min")%>';
document.getElementsByName('item_id')[<%=i-1%>].value='<%=rs.getString("item_id")%>';
</script>
<%
i++;
}
%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=register%>" readonly/><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_id" value="<%=register_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=register_time%>" readonly></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","变更人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="changer" value="<%=changer%>"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="changer_id" value="<%=changer_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","变更时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="change_time" value="<%=change_time%>" readonly></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"></td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%" height="65"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE3%> class="TD_STYLE3" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=exchange.unURL(remark)%></textarea>
</td>
 </tr>
 <%=isPrint.hasOrNot3d(attachment1,"附件&nbsp;&nbsp;&nbsp;","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,id,"qcs_quality_standard")%>

</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<div id="result_div" style="position:absolute;display:none;background:yellow;height:80px; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;"></div>
<div id="m_div" style="position:absolute;display:none;background-image:url(/erp/images/magnifier.gif);height:18px;"></div>
<div id="item_div" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:400px;height:330px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif" ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
<tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE7%> class="TD_STYLE1" width="15%"><%=demo.getLang("erp","质检项目")%></td>
 <td <%=TD_STYLE7%> class="TD_STYLE1" width="10%"><%=demo.getLang("erp","分析方法")%></td>
 <td <%=TD_STYLE7%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","首选质检依据")%></td>
 <td <%=TD_STYLE7%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","备选质检依据")%></td>
 <td <%=TD_STYLE7%> class="TD_STYLE1" width="10%"><%=demo.getLang("erp","质检方法")%></td>
 </tr>
 <%
 sql="select item_name,item_id,analyse_method,default_basis,ready_basis,quality_method from qcs_item order by id";
 rs=qcs_db.executeQuery(sql);
 while(rs.next()){
 %>
 <tr <%=TR_STYLE1%> class="TR_STYLE1" ondblclick="selectIn(this,'<%=rs.getString("item_id")%>');" bgcolor="#ffffff">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("item_name")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("analyse_method")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("default_basis")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("ready_basis")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("quality_method")%></td>
 </tr>
 <%	
 }
 %>
</table>
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
<%}}catch(Exception ex){ex.printStackTrace();}%>