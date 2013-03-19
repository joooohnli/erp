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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
try{
String workflow_url_temp="";
String workflow_file_url=request.getRequestURI();
for(int i=0;i<workflow_file_url.split("/").length-3;i++){
	workflow_url_temp+="../";
}
%>
<link rel="stylesheet" type="text/css" href="<%=workflow_url_temp%>css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="<%=workflow_url_temp%>css/include/nseer_cookie/xml-css.css"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="timeLocateValidation" class="x-form" method="post" action="<%=list_file%>"> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","查询")%>">&nbsp<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="<%=first_file%>"></div>
 </td>
 </tr>
 </table>
<link rel="stylesheet" type="text/css" media="all" href="<%=workflow_url_temp%>javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript">
 var onecount2;
 subcat2 = new Array();
	 subcat22 = new Array();
 <% int k=0;
	 int p=0;
 String sql8="select id,first_kind_name,second_kind_name from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rs8=hr_db.executeQuery(sql8); 
 while(rs8.next()) {
		 p=k++;
		 %> 
 subcat2[<%=p%>] = new 
 Array("<%=rs8.getString("id")%>","<%=rs8.getString("first_kind_name")%>/<%=rs8.getString("second_kind_name")%>","<%=rs8.getString("first_kind_name")%>");

	 subcat22[<%=p%>] = new 
 Array("<%=rs8.getString("id")%>","<%=rs8.getString("first_kind_name")%>/<%=rs8.getString("second_kind_name")%>","<%=rs8.getString("first_kind_name")%>");
 <%
	 }
 %> 
 
 onecount2=<%=k%>;
 function changelocation2(locationid)
  {
  timeLocateValidation.select5.length = 0; 
 
  var locid=locationid;
  var k;
  timeLocateValidation.select5.options[timeLocateValidation.select5.length]=new Option("",""); 
  for (k=0;k < onecount2; k++)
  {
 		 if(locid==""||locid==null){timeLocateValidation.select5.options[timeLocateValidation.select5.length]=
 			 new Option(subcat22[k][1],subcat2[k][1]);}//如果select1为空，则select5选择全部值
  else if (subcat2[k][2] == locid)
  { 
   timeLocateValidation.select5.options[timeLocateValidation.select5.length] = new Option(subcat22[k][1], 
 subcat2[k][1]);
  } 
  } 
 }

</script>
<input type="hidden" name="id" value="<%=id%>">

<input type="hidden" name="type_id" value="<%=type_id%>">
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请选择机构名称")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="40%"><input id="fileKind_chain" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:30%" name="fileKind_chain" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off"><input id="fileKind_chain_table" type="hidden" value="hr_config_file_kind"></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请选择职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4" style="width: 30%;" onChange="changelocation2(timeLocateValidation.select4.options[timeLocateValidation.select4.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%
  String sql4 = "select first_kind_name from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = hr_db.executeQuery(sql4) ;
while(rs4.next()){%>
		<option value="<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
}
		hr_db.close();
%>

  </select></td> 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请选择职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5" style="width: 30%;"><script language = "JavaScript">
	//if (timeLocateValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation2(timeLocateValidation.select4.value)
 //}
 </script>
 </select>
</td> 
 </tr>
 </table> 
</form>
</div>
<script type='text/javascript' src='<%=workflow_url_temp%>dwr/engine.js'></script>
<script type='text/javascript' src='<%=workflow_url_temp%>dwr/util.js'></script>
<script type='text/javascript' src='<%=workflow_url_temp%>dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="<%=workflow_url_temp%>javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='<%=workflow_url_temp%>javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='<%=workflow_url_temp%>dwr/interface/Multi.js'></script>
<script type='text/javascript' src='<%=workflow_url_temp%>dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='<%=workflow_url_temp%>dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='<%=workflow_url_temp%>javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='<%=workflow_url_temp%>dwr/interface/kindCounter.js'></script>
<script type='text/javascript' src="<%=workflow_url_temp%>javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src="<%=workflow_url_temp%>javascript/logistics/config/workflow/treeBusiness.js"></script>
<script type='text/javascript' src='<%=workflow_url_temp%>javascript/include/div/divLocate.js'></script>
<link rel="stylesheet" type="text/css" media="all" href="<%=workflow_url_temp%>javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="<%=workflow_url_temp%>javascript/calendar/cal.js"></script>

<div id="nseer1" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="<%=workflow_url_temp%>images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="<%=workflow_url_temp%>images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="<%=workflow_url_temp%>images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="<%=workflow_url_temp%>images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","恩信科技开源ERP")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
</div>
</TD>
<TD  background="<%=workflow_url_temp%>images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="<%=workflow_url_temp%>images/bg_0lbottom.gif" ></TD>
      <TD background="<%=workflow_url_temp%>images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="<%=workflow_url_temp%>images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
<script>
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
 Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setParent('nseer1_0');
 Nseer_tree1.setImagesPath('<%=workflow_url_temp%>images/');
 Nseer_tree1.setTableName('hr_config_file_kind');
 Nseer_tree1.setModuleName('<%=workflow_url_temp%>xml/include/config/workflow');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('<%=workflow_url_temp%>xml/include/config/workflow','hr_config_file_kind','treeButton');
}
</script>
<%
}catch(Exception ex){ex.printStackTrace();}
%>