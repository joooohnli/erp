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
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@include file="../../include/head.jsp"%>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseerTree/nseertree.css">
<!--固定的-->
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">&nbsp;</td>
 </tr>
 </table>
<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../../javascript/include/covers/cover.js'></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../../javascript/include/div/divcolor.js"></script>
<!--目录不同-->
<script type='text/javascript' src="../../../javascript/finance/config/fixed_assets/fluctuationWay/treeBusiness.js"></script>
 <TABLE width="80%" height="90%" border=0 cellPadding=0 cellSpacing=0 align="center" bgcolor="#F3F6F7"  class="example" id="example1">
 <script>
setGradient('example1','#A5E3FF','#ffffff',0);
</script>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../../images/bg_03.gif"></TD>
 <TD>
<div id="nseer1" style="position:relative;display:block;width:80%;height:expression(this.parentElement.offsetHeight-50);overflow:auto; left:17%;top:0px"></div>
</div>
<TD  background="../../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rbottom.gif"></TD>
    </TR>
  </TBODY>
</TABLE>
<script>
if (window.attachEvent) window.attachEvent("onload",addTree);
if (window.addEventListener)window.addEventListener("load",addTree,false);
var Nseer_tree1;
function addTree(){
 Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setImagesPath('../../../images/');
 Nseer_tree1.setTableName('finance_config_assets_fluctuationway');
 Nseer_tree1.setModuleName('../../../xml/finance/config/fixed_assets/fluctuationWay');//xml文件路径
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
 Nseer_tree1.setParent('nseer1');
initMyTree(Nseer_tree1);
createButton('../../../xml/finance/config/fixed_assets/fluctuationWay','finance_config_assets_fluctuationway','treeButton');
}
</script>