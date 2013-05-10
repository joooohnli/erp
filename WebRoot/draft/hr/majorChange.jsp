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
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<%
try{%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db hr_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<%
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_ID=request.getParameter("human_ID");
String major_time=request.getParameter("major_time");
String vt_sql="select * from hr_major_change where human_ID='"+human_ID+"' and major_time='"+major_time+"' and (check_tag='5' or check_tag='9')";
ResultSet rs = hr_db.executeQuery(vt_sql);
if(rs.next()){
	String lately_change_time="";
String file_change_amount="";
String major_change_amount="";
String sql1="select * from hr_file where human_ID='"+human_ID+"'";
ResultSet rs1= hr_db1.executeQuery(sql1) ;
if(rs1.next()){
	lately_change_time=rs1.getString("change_time");
	file_change_amount=rs1.getString("file_change_amount");
	major_change_amount=rs1.getString("major_change_amount");
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_hr_majorChange_draft_ok','../../xml/hr/hr_major_change.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_hr_majorChange_check_ok','../../xml/hr/hr_major_change.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div></td> 
 </tr> 
 </table>
<input type="hidden" name="major_time" value="<%=major_time%>">
<input type="hidden" name="major_type" value="">
<table <%=TABLE_STYLE7%> class="TABLE_STYLE5" style="width:100%;" id=theObjTable>
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="3"><input name="human_ID" type="hidden" value="<%=rs.getString("human_ID")%>"><%=rs.getString("human_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input  name="old_kind_chain" type="hidden" value="<%=rs.getString("chain_id")%> <%=exchange.toHtml(rs.getString("chain_name"))%>"><%=rs.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_name" type="hidden" value="<%=exchange.toHtml(rs.getString("human_name"))%>"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_first_kind" type="hidden"   style="width:70%" value="<%=rs.getString("human_major_first_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_major_second_kind" type="hidden" style="width:70%" value="<%=rs.getString("human_major_second_kind_ID")%>/<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","原薪酬标准")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="salary_standard" type="hidden"  style="width:70%" value="<%=rs.getString("salary_standard_ID")%>/<%=exchange.toHtml(rs.getString("salary_standard_name"))%>/<%=rs.getString("salary_standard_name")%>"><%=demo.aformat(rs.getDouble("salary_sum"))%></td>	
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新薪酬标准")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="new_salary_standard" style="width:49%">
	 <option value="未定义/未定义/0">未定义/0</option>
<%
  String sql7 = "select * from hr_salary_standard where check_tag='1' order by standard_ID" ;
	 ResultSet rs7 = hr_db1.executeQuery(sql7) ;
	 String selected="";
while(rs7.next()){
	if(rs.getString("new_salary_standard_ID").equals(rs7.getString("standard_ID"))){selected="selected";}
%>
		<option value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>" <%=selected%>><%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=demo.aformat(rs7.getDouble("salary_sum"))%></option>
<%
}
%>
  </select>
 </td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input id="fileKind_chain" name="kind_chain" style="width:70%" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:80%" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rs.getString("new_chain_id")%> <%=exchange.toHtml(rs.getString("new_chain_name"))%>"><input id="fileKind_chain_table" type="hidden" value="hr_config_file_kind"></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr>
	<script language="javascript">
 var onecount2;
 subcat2 = new Array();
 <% int k=0;
 String sql8a="select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rs8a=hr_db1.executeQuery(sql8a); 
 while(rs8a.next()) {%> 
 subcat2[<%=k++%>] = new 
 Array("<%=rs8a.getString("id")%>","<%=rs8a.getString("second_kind_ID")%>/<%=rs8a.getString("second_kind_name")%>","<%=rs8a.getString("first_kind_ID")%>/<%=rs8a.getString("first_kind_name")%>");
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
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4"   style="width:70%"
onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%selected="";
  String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = hr_db1.executeQuery(sql4) ;
while(rs4.next()){
	if(rs.getString("new_human_major_first_kind_ID").equals(rs4.getString("first_kind_ID"))){selected="selected";}else{selected="";}
	%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>" <%=selected%>><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
}
%>

  </select></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","新职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5"  style="width:70%">
 <%selected="";
 sql4 = "select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID" ;
rs4 = hr_db1.executeQuery(sql4) ;
while(rs4.next()){
	if(rs.getString("new_human_major_second_kind_ID").equals(rs4.getString("second_kind_ID"))&&rs.getString("new_human_major_first_kind_ID").equals(rs4.getString("first_kind_ID"))){selected="selected";}else{selected="";}
	%>
		<option value="<%=rs4.getString("second_kind_ID")%>/<%=exchange.toHtml(rs4.getString("second_kind_name"))%>" <%=selected%>><%=rs4.getString("second_kind_ID")%>/<%=exchange.toHtml(rs4.getString("second_kind_name"))%></option>
<%
}
%>
changelocation2(mutiValidation.select4.value)
 </select></td>
  </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="hidden" name="register" value="<%=register%>"><%=register%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="hidden" name="register_time" value="<%=time%>"><%=time%>&nbsp;</td>
  </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","调动原因")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark1" value="<%=rs.getString("remark1")%>"><%=exchange.unHtml(rs.getString("remark1"))%></textarea>
</td>	
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"></td>
	</tr> 
 </table>
<input name="lately_change_time" type="hidden" style="width:49%" value="<%=lately_change_time%>">
<input name="file_change_amount" type="hidden" style="width:49%" value="<%=file_change_amount%>">
<input name="major_change_amount" type="hidden" style="width:49%" value="<%=major_change_amount%>">
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<%
	hr_db.close();
	hr_db1.close();
}else{
	hr_db.close();
	hr_db1.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="majorChange_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已提交审核，请返回！")%></td>
 </tr>
</table>
<%}%>
</form>
</div>
<%
}catch (Exception ex){
ex.printStackTrace();
}%>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>
<script type='text/javascript' src="../../javascript/hr/file/treeBusiness.js"></script>

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
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
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
  Nseer_tree1.setParent('nseer1_0')
 Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('hr_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/hr/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/hr/file','hr_config_file_kind','treeButton');
}
</script>