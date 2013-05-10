<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
try{
String file_url_sb=request.getRequestURI();
String url_temp_sb="";
for(int i=0;i<file_url_sb.split("/").length-3;i++){
	url_temp_sb+="../";
}
%>
<div id="search_result" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="<%=url_temp_sb%>images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="<%=url_temp_sb%>images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(20)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","在结果中搜索")%>" onclick="n_S.resultFormSubmit('<%=fileName%>','<%=inputTextId3%>','<%=inputTextId2%>','<%=validationXml%>','1');"></div>
 </td>
 </tr>
 </table>
<table style="width:98%" <%=TABLE_STYLE1%> class="TABLE_STYLE1">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="30%"><%=demo.getLang("erp","请输入关键字")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><input id="<%=inputTextId3%>" name="<%=inputTextId3%>" type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width: 60%"></td> 
 </tr>
 </table>
</div>
</TD>
<TD  background="<%=url_temp_sb%>images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0lbottom.gif" ></TD>
      <TD background="<%=url_temp_sb%>images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>

<%
Vector types=mask.getColumnAttributes("type");
Vector requireds=mask.getColumnAttributes("required");
Vector names=mask.getColumnAttributes("name");
Vector columns1=mask.getColumnAttributes("usedTag");
Vector columns=mask.getColumnAttributes("nick");
Vector services=mask.getColumnAttributes("service");
%>
<form id="mutiValidation" method="POST" action="<%=fileName%>?<%=searchTag%>=1&readXml=n">
 <div id="search_advance" nseerDef="dragAble" style="position:absolute;left:200px;top:100px;display:none;width:500px;height:350px;overflow:hidden;z-index:1;background:#E8E8E8;">
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="<%=url_temp_sb%>images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="<%=url_temp_sb%>images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(20)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3" > 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" onclick="n_S.advanceSubmit('<%=validationXml%>','mutiValidation');"></div>
 </td>
 </tr>
 </table>
<table style="width:98%" <%=TABLE_STYLE1%> class="TABLE_STYLE1" id="table_advance">
 <tr id="tr0" <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="15%" style="text-align:center"><%=demo.getLang("erp","字符条件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="35%"><select type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="str_select" name="str_select" style="width: 90%" onchange="n_S.selectChange(this.id);">
 <option value=""></option>
 <%
 String strs="⊙◎";
 String times="⊙◎";
 String nums="⊙◎";
	int a1=0;
while(a1<columns1.size()){
	if(!((String)columns1.elementAt(a1)).equals("n")&&((String)types.elementAt(a1)).equals("字符")&&((String)services.elementAt(a1)).equals("b")){
		strs+="⊙"+(String)names.elementAt(a1)+"◎"+(String)columns.elementAt(a1);
	%>
	<option value="<%=(String)names.elementAt(a1)%>"><%=(String)columns.elementAt(a1)%></option>
<%}a1++;}%>
 
 </select></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="45%" colspan="3"><input type="text" style="background-color:#FFFFCC;width:100%;BORDER: 1px #C9E1FA solid;" name="keyword1" onfocus="this.blur();"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="5%"><img src="<%=url_temp_sb%>images/add_blue.png" id="add0_str" onclick="n_S.addRow('table_advance',this.id,'<%=strs%>');">&nbsp;<img src="<%=url_temp_sb%>images/remove_blue.png" id="remove0_str" onclick="n_S.delRow('table_advance',this.id);"></td>
 </tr>
 <tr id="tr1" <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="15%" style="text-align:center"><%=demo.getLang("erp","时间区间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="35%"><select type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="time_select" name="time_select" style="width: 90%" onchange="n_S.selectChange(this.id);">
 <option value=""></option>
 <%
 int a2=0;
while(a2<columns1.size()){
	if(!((String)columns1.elementAt(a2)).equals("n")&&((String)types.elementAt(a2)).equals("时间")&&((String)services.elementAt(a2)).equals("b")){
		times+="⊙"+(String)names.elementAt(a2)+"◎"+(String)columns.elementAt(a2);
	%>
	<option value="<%=(String)names.elementAt(a2)%>"><%=(String)columns.elementAt(a2)%></option>
<%}a2++;}%>
 </select></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="20%"><input type="text" style="background-color:#DDFCB4;width:100%;BORDER: 1px #C9E1FA solid;"  name="timea" onfocus="this.blur();"></td>
 <td align="center" <%=TD_STYLE11%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp","至")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="20%"><input type="text"  style="background-color:#DDFCB4;width:100%;BORDER: 1px #C9E1FA solid;" name="timeb" onfocus="this.blur();"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="5%"><img src="<%=url_temp_sb%>images/add_blue.png" id="add1_time" onclick="n_S.addRow('table_advance',this.id,'<%=times%>');">&nbsp;<img src="<%=url_temp_sb%>images/remove_blue.png" id="remove1_time" onclick="n_S.delRow('table_advance',this.id);"></td>
 </tr>
 <tr id="tr2" <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="15%" style="text-align:center"><%=demo.getLang("erp","数值区间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="35%"><select type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="num_select" name="num_select" style="width: 90%" onchange="n_S.selectChange(this.id);">
 <option value=""></option>
 <%
	int a3=0;
while(a3<columns1.size()){
	if(!((String)columns1.elementAt(a3)).equals("n")&&((String)types.elementAt(a3)).equals("数值")&&((String)services.elementAt(a3)).equals("b")){
		nums+="⊙"+(String)names.elementAt(a3)+"◎"+(String)columns.elementAt(a3);
	%>
	<option value="<%=(String)names.elementAt(a3)%>"><%=(String)columns.elementAt(a3)%></option>
<%}a3++;}%>
 </select></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="20%"><input type="text" style="background-color:#FFC993;width:100%;BORDER: 1px #C9E1FA solid;" name="numa"  onfocus="this.blur();"></td>
 <td align="center" <%=TD_STYLE11%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp","至")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="20%"><input type="text" style="background-color:#FFC993;width:100%;BORDER: 1px #C9E1FA solid;" name="numb"  onfocus="this.blur();"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="5%"><img src="<%=url_temp_sb%>images/add_blue.png" id="add2_num" onclick="n_S.addRow('table_advance',this.id,'<%=nums%>');">&nbsp;<img src="<%=url_temp_sb%>images/remove_blue.png" id="remove2_num" onclick="n_S.delRow('table_advance',this.id);"></td>
 </tr>
 </table>
</div>
</TD>
<TD  background="<%=url_temp_sb%>images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0lbottom.gif" ></TD>
      <TD background="<%=url_temp_sb%>images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="<%=url_temp_sb%>images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
</form>
<%}catch(Exception ex){ex.printStackTrace();}%>