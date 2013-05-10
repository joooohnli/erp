<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@include file="../include/head.jsp"%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String time_select=request.getParameter("timea");
if(time_select==null) time_select="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
if(time_select.equals("")) time_select=formatter.format(now);
session.setAttribute("time_select",time_select);
%>
		<script type="text/javascript" src="local/webfxlayout.js"></script>
		<script type="text/javascript" src="includes/excanvas.js"></script>
		<script type="text/javascript" src="includes/wz_jsgraphics.js"></script>
		<script type="text/javascript" src="includes/chart.js"></script>
		<script type="text/javascript" src="includes/canvaschartpainter.js"></script>
		<script type="text/javascript" src="includes/jgchartpainter.js.js"></script>
		<script type="text/javascript" src="includes/line.js"></script>
		<script type="text/javascript" src="includes/bar_access.js"></script>
		<script type="text/javascript" src="includes/pie.js"></script>
		<link rel="stylesheet" type="text/css" href="includes/canvaschart.css" />
		<style type="text/css">
			.chart { margin-left: 20px; }
		</style>
	<body onload="demo();">
				<div class="webfx-main-body" id="line" style="position:absolute;top:80px;left:2px;display:block;z-index:3;">
			
			<h3>欢迎使用川大科技系统访问分析图(<%=time_select%>)</h3>
			
			<p>
			<div style="position:absolute;top:35px;left:12px;z-index:100;">（访问次数）</div>
		    <div style="position:absolute;top:455px;left:735px;z-index:100;width:60px;">（小时）</div>
				<div id="chart3" class="chart" style="width: 760px; height: 400px;"></div>
				
			</p>
		</div>
<table width="785">
<tr>
<td <%=TD_STYLE3%> class="TD_STYLE3" ><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","折线图分析")%>" onClick="line();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","柱图分析")%>" onClick="bar();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","饼图分析")%>" onClick="pie();">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","选择日期")%>" onClick=location="query_locate.jsp"></div>
 </td></tr>
 </table>	
<script>
function view_info(info1){
var vheight = window.screen.height-200;
var vwidth =  window.screen.width-200;
var hr=info1;
var file="query_data_list.jsp?hour="+hr;
window.open(file,"","height="+vheight+",width="+vwidth+",top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");	
}
function view_info1(info1){
var vheight = window.screen.height-200;
var vwidth =  window.screen.width-200;
var file="query_data_list.jsp?hour="+info1;
window.open(file,"","height="+vheight+",width="+vwidth+",top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");	
}
function bar()
{   clearInterval(line1);
    clearInterval(pie1);
	var bar=document.getElementById('bar');
	var line=document.getElementById('line');
	var pie=document.getElementById('pie');
	line.style.display='none';
	pie.style.display='none';
	bar.style.display='block';
	bar_access();

}
function pie()
{   clearInterval(line1);
    clearInterval(bar1);
	var pie=document.getElementById('pie');
	var line=document.getElementById('line');
	var bar=document.getElementById('bar');
	line.style.display='none';
	bar.style.display='none';
	pie.style.display='block';
	draw_pie(document.getElementById('time').innerHTML);
}
function line()
{   clearInterval(bar1);
    clearInterval(pie1);
	var pie=document.getElementById('pie');
	var line=document.getElementById('line');
	var bar=document.getElementById('bar');
	line.style.display='block';
	bar.style.display='none';
	pie.style.display='none';
	demo();
}
</script>
<div id="bar"  style="position:absolute;top:80px;left:2px;display:none;z-index:3;">
	<div class="webfx-main-body">
		<h3>欢迎使用川大科技系统访问分析图(<%=time_select%>)</h3>
		<div style="position:absolute;top:35px;left:20px;z-index:100">（访问次数）</div>
		<div style="position:absolute;top:455px;left:745px;z-index:100;width:60px;">（小时）</div>
			<p>
				
				<div id="chart" class="chart" style="width: 760px; height: 400px;"></div>				
			</p>
	</div>	
</div>
<div id="pie" style="width:300px;height:300px;position:absolute;top:80px;left:10px;display:none;z-index:3;">
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<STYLE>
v\:* { Behavior: url(#default#VML) }
o\:* { behavior: url(#default#VML) }
body{font-family:arial}
</STYLE>
<script src=Pie3D.js ></script>
</head>
<div id="time" style="display:none"><%=time_select%></div>
<div id='pieChart'></div>
<script>
function closead(){
	  document.getElementById('div_bar').style.display="none";
  }
</script>
</body>
</html>
</div>
<div id="div_bar" style="width:300px;height:300px;background:#FFFFFF;position:absolute;top:2px;right:20px;display:none;z-index:3;"></div>