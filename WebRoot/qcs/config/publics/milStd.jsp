<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*,include.nseer_cookie.*"%>
<%@include file="../../include/head_list.jsp"%>


<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/milStd.js'></script>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<script type="text/javascript" src="../../../javascript/include/div/divViewChange.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src='../../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src="../../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type='text/javascript' src='../../../javascript/include/covers/cover.js'></script>
<link rel="stylesheet" type="text/css" href="../../../css/qcs/config/config.css">
<%
try{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr> 
</table>
<div id="Tabs1">
<ul>
<li id="main_cur"><a href="javascript:window.location.href='milStd.jsp?group_id=1';"><span style="font-size:9pt;"><%=demo.getLang("erp","MIL-STD-105E表(放宽)")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:window.location.href='milStd.jsp?group_id=2';"><span style="font-size:9pt;"><%=demo.getLang("erp","MIL-STD-105E表(正常)")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:window.location.href='milStd.jsp?group_id=3';"><span style="font-size:9pt;"><%=demo.getLang("erp","MIL-STD-105E表(加严)")%></span></a></li>
</ul>
</div>
<script>
function changeTab(nseer_d){
	var div_obj=document.getElementById('Tabs1');
	var lis=div_obj.getElementsByTagName('li');
	for(var i=0;i<lis.length;i++){lis[i].id='';}
	lis[nseer_d-1].id='main_cur';
	document.getElementById('Tabs1').blur();
}
</script>
<%String group_id=request.getParameter("group_id");
if(group_id==null||group_id.equals("")){
group_id="1";
}
%>
<script language="javascript">
function id_link(type_id,group_id){
DWREngine.setAsync(false);
milStd.getValue(type_id,group_id,{callback:function(array){
readXml('../../../css/qcs/config/config.css','../../../xml/qcs/config/publics/milStd.xml','0');
for(var i=0;i<array.length;i++){
var tr_obj = document.getElementById('tr'+i);
var td_array = tr_obj.getElementsByTagName('td');
td_array[0].innerHTML=array[i][0];
td_array[1].innerHTML=array[i][1];
td_array[2].innerHTML=array[i][2];
}
}});
DWREngine.setAsync(true);
}
</script>
<body onload="changeTab('<%=group_id%>')">
<div id="nseer_grid_div" style="position:absolute;top:47px;"></div>
<script type="text/javascript">
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","编号")%>'},
                       {name: '<%=demo.getLang("erp","字码")%>'},
                       {name: '<%=demo.getLang("erp","样本量")%>'},
                       {name: '<%=demo.getLang("erp","查看")%>'}
                       ]
nseer_grid.column_width=[200,200,100,80];
nseer_grid.auto='<%=demo.getLang("erp","字码")%>';
nseer_grid.data = [];
DWREngine.setAsync(false);
milStd.getTypeGroup('<%=group_id%>',{callback:function(array){
for(var i=0;i<array.length;i++){
nseer_grid.data[i]=[array[i][0],array[i][1],array[i][2],'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("'+array[i][0]+'","<%=group_id%>")><%=demo.getLang("erp","查看")%></div>'];
}
}});
DWREngine.setAsync(true);
nseer_grid.data[nseer_grid.data.length]=[''];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
<%
}
catch (Exception ex){
out.println("error"+ex);
}
%>
