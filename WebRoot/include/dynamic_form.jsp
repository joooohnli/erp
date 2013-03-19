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
<form id="list" method="POST" action="<%=add_action%>">
 <div id="register" nseerDef="dragAble" style="position:absolute;left:100px;top:100px;display:none;width:600px;height:350px;overflow:hidden;z-index:1;background:#E8E8E8;">
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(20)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3" > 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" type="button" value="<%=demo.getLang("erp","保存")%>" onclick="dynamicSubmit('','list');"></div>
 </td>
 </tr>
 </table>
<table style="width:98%" <%=TABLE_STYLE1%> class="TABLE_STYLE1" id="dynamic_table">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <%
 for(int i=0;i<fields.length;i++){
 %>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="<%=100/attrs.length%>%"><%=demo.getLang("erp",fields[i])%></td>
 <%}%>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<%
 for(int i=0;i<attrs.length;i++){
	 if(attrs[i].equals("input")){%>
	 <td <%=TD_STYLE21%> class="TD_STYLE2" width="<%=100/attrs.length%>%"><input type="text" name=<%=field_names[i]%> style="width:100%;" <%String html_event="";for(int m=0;m<colEvenet.length;m++){if(i==Integer.parseInt(colEvenet[m].split("⊙")[0])){html_event=colEvenet[m].split("⊙")[1];}}%><%=html_event%>></td>
	<% }
	 else if(attrs[i].equals("textarea")){%>
	 <td <%=TD_STYLE21%> class="TD_STYLE2" width="<%=100/attrs.length%>%"><textarea type="text" name=<%=field_names[i]%> style="width:100%;" <%String html_event="";for(int m=0;m<colEvenet.length;m++){if(i==Integer.parseInt(colEvenet[m].split("⊙")[0])){html_event=colEvenet[m].split("⊙")[1];}}%><%=html_event%>></textarea></td>
	<% }else if(attrs[i].indexOf(",")!=-1){		 
	%>
	<td <%=TD_STYLE21%> class="TD_STYLE2" width="<%=100/attrs.length%>%"><select type="text" name=<%=field_names[i]%> style="width:100%;" <%String html_event="";for(int m=0;m<colEvenet.length;m++){if(i==Integer.parseInt(colEvenet[m].split("⊙")[0])){html_event=colEvenet[m].split("⊙")[1];}}%><%=html_event%>>
	  <!-- <option value=""></option> -->
<%
		 for(int j=0;j<attrs[i].split(",").length;j++){
		 %>
		 <option value="<%=attrs[i].split(",")[j]%>"><%=attrs[i].split(",")[j]%></option>
		 <%}%>
		 </select></td>
		 <%
		 }
 }%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="5%"><img src="../../images/add_blue.png" onclick="addRow('dynamic_table',this);">&nbsp;<img src="../../images/remove_blue.png" onclick="delRow('dynamic_table',this);"></td>
 </tr>
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
</form>








<form id="delete_form" method="POST" action="<%=del_action%>">
 <div id="delete" class="nseer_div" nseerDef="dragAble" style="position:absolute;left:100px;top:100px;display:none;width:500px;height:250px;">
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
<div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%>
</div>
</div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>

<div style="width:100%;height:100%;background:#E8E8E8">
<div id="tabsF">
<ul>
<li id="current"><a href="javascript:void(0);"><span align="center"><%=demo.getLang("erp","删除字段")%></span></a></li>
</ul>
</div>

<div class="cssDiv8">
 
<table id="table1" class="nseer_table1" width="100%" border="0" cellspacing="1" cellpadding="1" >
	<tr id="tr1">
		<td id="td1">
		</td>
		<td id="td2">
		</td>
	</tr>
	<tr id="tr1">
		<td id="td1">			
		</td>
		<td id="td2"><div align="right"><INPUT <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" type="button" value="<%=demo.getLang("erp","确定")%>" onclick="del_cols('','delete_form','<%=span_name%>');"><INPUT <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" type="button" value="<%=demo.getLang("erp","取消")%>" onclick="n_D.closeDiv('hidden');"></div>
		</td>
	</tr>
	<tr id="tr2">
		<td id="td3" width="30%">
		<%=demo.getLang("erp","您确认删除所选记录吗?")%>
		</td>
		</tr>
	
</table>
</div>
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
</form>