<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="POST" onSubmit="return doValidate('../../xml/hr/hr_major_change.xml','mutiValidation')&&TwoSubmit(this)">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../hr_major_change_register_draft_ok','../../xml/hr/hr_major_change.xml'",request)%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()">
 </div></td>
 </tr>
</table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript">
function TwoSubmit(form){
form.action = "../../hr_major_change_register_ok";
}
 var onecount2;
 subcat2 = new Array();
 <% int k=0;
 String sql8="select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rs8=hr_db.executeQuery(sql8); 
 while(rs8.next()) {%> 
 subcat2[<%=k++%>] = new 
 Array("<%=rs8.getString("id")%>","<%=rs8.getString("second_kind_ID")%>/<%=rs8.getString("second_kind_name")%>","<%=rs8.getString("first_kind_ID")%>/<%=rs8.getString("first_kind_name")%>");
 <%
	 }
 %>  
 onecount2=<%=k%>; 
 function changelocation2(locationid)
  {
  mutiValidation.select5.length = 0; 
  var locid=locationid;
  var k;
  mutiValidation.select5.options[mutiValidation.select5.length]=new Option("",""); 
  for (k=0;k < onecount2; k++)
  {
 		 if(locid==""||locid==null){mutiValidation.select5.options[mutiValidation.select5.length]=
 			 new Option(subcat2[k][1],subcat2[k][1]);}//如果select1为空，则select5选择全部值
  else if (subcat2[k][2] == locid)
  { 
   mutiValidation.select5.options[mutiValidation.select5.length] = new Option(subcat2[k][1], 
 subcat2[k][1]);
  } 
  } 
 }
</script>
<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_ID=request.getParameter("human_ID");
try{
	String sqll = "select * from hr_file where human_ID='"+human_ID+"'" ;
	ResultSet rss = hr_db.executeQuery(sqll) ;
	if(rss.next()){
%>
<input type="hidden" name="major_type" value="">
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="3"><input name="human_ID" type="hidden"  style="width:70%" value="<%=rss.getString("human_ID")%>"><%=rss.getString("human_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input  name="old_kind_chain" type="hidden" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>"><%=rss.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rss.getString("chain_name"))%></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_name" type="hidden"  style="width:70%" value="<%=exchange.toHtml(rss.getString("human_name"))%>"><%=exchange.toHtml(rss.getString("human_name"))%>&nbsp;</td>
	</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_first_kind" type="hidden"   style="width:70%" value="<%=rss.getString("human_major_first_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_first_kind_name"))%>"><%=exchange.toHtml(rss.getString("human_major_first_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_second_kind" type="hidden" style="width:70%" value="<%=rss.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%>"><%=exchange.toHtml(rss.getString("human_major_second_kind_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原薪酬标准")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="salary_standard" type="hidden"  style="width:70%" value="<%=rss.getString("salary_standard_ID")%>/<%=exchange.toHtml(rss.getString("salary_standard_name"))%>/<%=rss.getString("salary_sum")%>"><%=exchange.toHtml(rss.getString("salary_standard_name"))%>&nbsp;</td>	
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input id="kind_chain" name="kind_chain" style="width:70%" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:80%" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off"><input id="kind_chain_table" type="hidden" value="hr_config_file_kind"></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4"   style="width:70%"
onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%
  String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = hr_db.executeQuery(sql4) ;
while(rs4.next()){%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
}
%>
  </select></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5"  style="width:70%"><script language = "JavaScript">
	//if (mutiValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation2(mutiValidation.select4.value)
 //}
 </script>
 </select>
</td>
  </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新薪酬标准")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1"   style="width:70%" name="new_salary_standard">
	 <option value="未定义/未定义/0"><%=demo.getLang("erp","未定义/0")%></option>
<%
  String sql7 = "select * from hr_salary_standard where check_tag='1' order by standard_ID" ;
	 ResultSet rs7 = hr_db.executeQuery(sql7) ;
while(rs7.next()){%>
		<option value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>"><%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%></option>
<%
}
%>
  </select></td>	
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1"  style="width:70%" type="text" name="register" value="<%=exchange.toHtml(register)%>"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="register_time"  style="width:70%" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"> &nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"> &nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","调动原因")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark1"></textarea>
</td>
<td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"> &nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"> &nbsp;</td>
	</tr> 
 </table>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%}
			 hr_db.close();
}
catch (Exception ex){ex.printStackTrace();
}				 
%>
</form>
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type='text/javascript' src="../../javascript/hr/file/treeBusiness.js"></script>
<script type="text/javascript" src="../../javascript/hr/file/register.js"></script>
<div id="nseer1" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
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
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
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
<script>
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
 Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setParent('nseer1_0');
 Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('hr_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/hr/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/hr/file','hr_config_file_kind','treeButton');
}
</script>