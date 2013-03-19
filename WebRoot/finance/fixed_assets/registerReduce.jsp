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
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../javascript/finance/fixed_assets/registerReduce.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@include file="../include/head.jsp"%>

<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../css/finance/tabs.css">
 <div id="loaddiv" style="display:none;"></div>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="post">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","增加")%>" onClick="addto()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="deleteRow()" value="<%=demo.getLang("erp","删除")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1" onClick="send();"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="7%"><%=demo.getLang("erp","资产编号")%>:</td>
 <td width="93%"><input type="text" style="width:30%" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="file_id1" name="file_code" onkeyup="search_suggest1(this.id);"></td>
 </tr>
 </table>

<% String table_width="100%";%>
<%@include file="../include/paper_top.html"%>
<table>
<tr height="15px"><td></td></tr>
</table>
<table id="Outer2" align="center" width="95%" bgcolor="#000000" border=0 cellspacing=1 cellpadding=0>
<tr width="100%">
<td width="100%" style="background-color: #E7E7E7" colspan="2">
<div style="overflow-y: auto; overflow-x: hidden; width:100%; height: 400px; background-color: #BBBBB5;" >
<table id="tablefield" width="100%"  bgcolor="black"  border="0" cellspacing="0" cellpadding="0" align="left" >
  <tr height="25" width="100%">
          <td width="13%" <%=TD_STYLE4%> class="TD_STYLE1" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;border-bottom: 1px solid #000000;">
            <p align="center"><%=demo.getLang("erp","资产编号")%></p>
          </td>
          <td width="13%" <%=TD_STYLE4%> class="TD_STYLE1" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
            <p align="center"><%=demo.getLang("erp","资产名称")%></p>
          </td>    
          <td width="13%" <%=TD_STYLE4%> class="TD_STYLE1" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
            <p align="center"><%=demo.getLang("erp","减少日期")%></p>
          </td>
		   <td width="13%" <%=TD_STYLE4%> class="TD_STYLE1" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
            <p align="center"><%=demo.getLang("erp","减少方式")%></p>
          </td>
		   <td width="13%" <%=TD_STYLE4%> class="TD_STYLE1" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
            <p align="center"><%=demo.getLang("erp","清理收入")%></p>
          </td>
		   <td width="13%" <%=TD_STYLE4%> class="TD_STYLE1" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
            <p align="center"><%=demo.getLang("erp","清理费用")%></p>
          </td>
		   <td width="22%" <%=TD_STYLE4%> class="TD_STYLE1" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000;">
            <p align="center"><%=demo.getLang("erp","清理原因")%></p>
          </td>
  </tr>
   </table>
   </div>
   </table>
</form>
<%@include file="../include/paper_bottom.html"%>
</div>

<div style="CURSOR: hand; display: none;padding-top: 6px; width: 18px; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px;" id='ddd_div' onclick="open_tree('nseer2',this,showTree)"></div>

<input type="hidden" id="reduce_way" value="nseer">
<div id="search_suggest" style="display: none; background: yellow; position:absolute; left:0px; top:80px; width: 150px; height: 100px; z-index: 10; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;"></div>

<div style="CURSOR: hand; display: none; width: 18px; position: absolute; background-image: url('../../images/finance/search.gif');" id='search' onclick="open_way()"></div>

<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src="../../javascript/finance/fixed_assets/treeBusiness.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>
<div id="nseer2" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
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
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div  id="nseer2_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;"></div>
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
window.onload=function (){
time();
}

function time(){
var sTa=document.getElementById('tablefield');
for(var i=0;i<sTa.rows.length;i++){
Calendar.setup ({inputField : "ccc"+i, ifFormat : "%Y-%m-%d", showsTime : false, button : "ccc"+i, singleClick : true, step : 1});
}
}
var Nseer_tree2;
function showTree(){
 if(Nseer_tree2=='undefined'||typeof(Nseer_tree2)=='object'){return;}
 Nseer_tree2 = new Tree('Nseer_tree2');
 Nseer_tree2.setParent('nseer2_0');
 Nseer_tree2.setImagesPath('../../images/');
 Nseer_tree2.setTableName('finance_config_assets_fluctuationway');
 Nseer_tree2.setModuleName('../../xml/finance/fixed_assets/fa_fluctuationWay_tree');
 Nseer_tree2.addRootNode('No0','<%=demo.getLang("erp","固定资产增减方法")%>',false,'1',[]);
initMyTree(Nseer_tree2);
createButton('../../xml/finance/fixed_assets/fa_fluctuationWay_tree','finance_config_assets_fluctuationway','treeButton');
}
</script>