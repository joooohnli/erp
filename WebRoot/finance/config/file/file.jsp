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
<%@include file="../../include/head.jsp"%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">&nbsp;</td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseerTree/nseertree.css">
<link rel="stylesheet" type="text/css" href="../../../css/finance/tabs.css">
<!--固定的-->
<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../../javascript/include/covers/cover.js'></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../../javascript/include/div/divcolor.js"></script>
<!--目录不同-->
<script type='text/javascript' src="../../../javascript/finance/config/file/treeBusiness.js"></script>

<TABLE width="90%" height="90%" border=0 cellPadding=0 cellSpacing=0 align="center" bgcolor="#F3F6F7"  class="example" id="example1">
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
<div style="width:100%;height:100%;position:absolute;top:1%;overflow:auto;" >
<div id="Tabs0">
<ul>
<li id="main_cur"><a href="javascript:changeTab('nseer0');"><span><%=demo.getLang("erp","全部科目")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer1');"><span><%=demo.getLang("erp","资产类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer2');"><span><%=demo.getLang("erp","负债类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer3');"><span><%=demo.getLang("erp","权益类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer4');"><span><%=demo.getLang("erp","成本类")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer5');"><span><%=demo.getLang("erp","损益类")%></span></a></li>
</ul>
</div>
<div id="nseer0" style="position:relative;display:block;width:80%;height:expression(this.parentElement.offsetHeight-50);overflow:auto; left:17%;top:70px">
<script>
var Nseer_tree0 = new Tree('Nseer_tree0');
 Nseer_tree0.setImagesPath('../../../images/');
 Nseer_tree0.setTableName('finance_config_file_kind');
 Nseer_tree0.setModuleName('../../../xml/finance/config/file/tag0');//xml文件路径
 Nseer_tree0.addRootNode('No0','<%=demo.getLang("erp","全部科目")%>',false,'1',[]);
 Nseer_tree0.setParent('nseer0');
initMyTree(Nseer_tree0);
createButton('../../../xml/finance/config/file/tag0','finance_config_file_kind','treeButton');
</script>
</div>
<div id="nseer1"  style="position:relative;display:none;width:80%;height:expression(this.parentElement.offsetHeight-120);overflow:auto; left:17%;top:70px">
<script>
var Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setImagesPath('../../../images/');
 Nseer_tree1.setTableName('finance_config_file_kind');
 Nseer_tree1.setCondition('kind_tag=\'1\'');
 Nseer_tree1.setModuleName('../../../xml/finance/config/file/tag1');//xml文件路径
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","资产类")%>',false,'1',[]);
 Nseer_tree1.setParent('nseer1');
initMyTree(Nseer_tree1);
createButton('../../../xml/finance/config/file/tag1','finance_config_file_kind','treeButton');
</script>
</div>
<div id="nseer2"  style="position:relative;display:none;width:80%;height:expression(this.parentElement.offsetHeight-50);overflow:auto; left:17%;top:70px">
<script>
var Nseer_tree2 = new Tree('Nseer_tree2');
 Nseer_tree2.setImagesPath('../../../images/');
 Nseer_tree2.setTableName('finance_config_file_kind');
 Nseer_tree2.setCondition('kind_tag=\'2\'');
 Nseer_tree2.setModuleName('../../../xml/finance/config/file/tag2');//xml文件路径
 Nseer_tree2.addRootNode('No0','<%=demo.getLang("erp","负债类")%>',false,'1',[]);
 Nseer_tree2.setParent('nseer2');
initMyTree(Nseer_tree2);
createButton('../../../xml/finance/config/file/tag2','finance_config_file_kind','treeButton');
</script>
</div>
<div id="nseer3"  style="position:relative;display:none;width:80%;height:expression(this.parentElement.offsetHeight-50);overflow:auto; left:17%;top:70px">
<script>
var Nseer_tree3 = new Tree('Nseer_tree3');
 Nseer_tree3.setImagesPath('../../../images/');
 Nseer_tree3.setTableName('finance_config_file_kind');
 Nseer_tree3.setCondition('kind_tag=\'3\'');
 Nseer_tree3.setModuleName('../../../xml/finance/config/file/tag3');//xml文件路径
 Nseer_tree3.addRootNode('No0','<%=demo.getLang("erp","权益类")%>',false,'1',[]);
 Nseer_tree3.setParent('nseer3');
initMyTree(Nseer_tree3);
createButton('../../../xml/finance/config/file/tag3','finance_config_file_kind','treeButton');
</script>
</div>
<div id="nseer4"  style="position:relative;display:none;width:80%;height:expression(this.parentElement.offsetHeight-50);overflow:auto; left:17%;top:70px">
<script>
var Nseer_tree4 = new Tree('Nseer_tree4');
 Nseer_tree4.setImagesPath('../../../images/');
 Nseer_tree4.setTableName('finance_config_file_kind');
 Nseer_tree4.setCondition('kind_tag=\'4\'');
 Nseer_tree4.setModuleName('../../../xml/finance/config/file/tag4');//xml文件路径
 Nseer_tree4.addRootNode('No0','<%=demo.getLang("erp","成本类")%>',false,'1',[]);
 Nseer_tree4.setParent('nseer4');
initMyTree(Nseer_tree4);
createButton('../../../xml/finance/config/file/tag4','finance_config_file_kind','treeButton');
</script>
</div>
<div id="nseer5"  style="position:relative;display:none;width:80%;height:expression(this.parentElement.offsetHeight-50);overflow:auto; left:17%;top:70px">
<script>
var Nseer_tree5 = new Tree('Nseer_tree5');
 Nseer_tree5.setImagesPath('../../../images/');
 Nseer_tree5.setTableName('finance_config_file_kind');
 Nseer_tree5.setCondition('kind_tag=\'5\'');
 Nseer_tree5.setModuleName('../../../xml/finance/config/file/tag5');//xml文件路径
 Nseer_tree5.addRootNode('No0','<%=demo.getLang("erp","损益类")%>',false,'1',[]);
 Nseer_tree5.setParent('nseer5');
initMyTree(Nseer_tree5);
createButton('../../../xml/finance/config/file/tag5','finance_config_file_kind','treeButton');
</script>
</div>
</div></div>

<TD  background="../../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rbottom.gif"></TD>
    </TR>
  </TBODY>
</TABLE>
</div>
<script>
function changeTab(nseer_d){
	for(var i=0;i<6;i++){
		if(document.getElementById('nseer'+i)!=null&&document.getElementById('nseer'+i)!='undefined'){
			document.getElementById('nseer'+i).style.display='none';
		}
	}
	var div_obj=document.getElementById('Tabs0');
	var lis=div_obj.getElementsByTagName('li');
	for(var i=0;i<lis.length;i++){lis[i].id='';}
	lis[parseInt(nseer_d.substring(5))].id='main_cur';
	document.getElementById(nseer_d).style.display='block';
	document.getElementById('Tabs0').blur();
}
</script>
