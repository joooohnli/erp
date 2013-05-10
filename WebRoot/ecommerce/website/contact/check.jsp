<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head.jsp"%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%issPrint issPrint=new issPrint(request);%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db ecommerce_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<link rel="stylesheet" type="text/css" href="../../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<script language="javascript" src="../../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/input_control/focus.css">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<%
String checker=(String)session.getAttribute("realeditorc");
String checker_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String contact_ID=request.getParameter("contact_ID");
String config_ID=request.getParameter("config_ID");

String sql9="select * from ecommerce_workflow where object_ID='"+contact_ID+"' and check_tag='0' and config_ID<'"+config_ID+"'";
ResultSet rs9=ecommerce_db1.executeQuery(sql9);
if(!rs9.next()){

if(vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_contact","contact_ID",contact_ID,"check_tag").equals("0")){
try{
	String sqll = "select * from ecommerce_contact where contact_ID='"+contact_ID+"'" ;
	ResultSet rss = ecommerce_db1.executeQuery(sqll) ;
	while(rss.next()){
%>


<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_ID=<%=config_ID%>&contact_ID=<%=rss.getString("contact_ID")%>";
}else{
form.action = "../../../ecommerce_website_contact_check_ok?config_ID=<%=config_ID%>&contact_ID=<%=rss.getString("contact_ID")%>";
}
}
</script>
<form id="mutiValidation" method="post" onSubmit="return doValidate('../../../xml/ecommerce/ecommerce_contact.xml','mutiValidation')&&TwoSubmit(this)" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input id="filekind_chain" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:60%" name="filekind_chain" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>"><input id="filekind_chain_table" type="hidden" value="hr_config_file_kind"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="tel" style="width:60%" value="<%=exchange.toHtml(rss.getString("tel"))%>"></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","传真")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="fax" style="width:60%" value="<%=exchange.toHtml(rss.getString("fax"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="email" style="width:60%" value="<%=exchange.toHtml(rss.getString("email"))%>"></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="postcode" style="width:60%" value="<%=exchange.toHtml(rss.getString("postcode"))%>">
 </td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="address" style="width:60%" value="<%=exchange.toHtml(rss.getString("address"))%>">
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务1")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1"  name="qq1" type="text" style="width:60%" value="<%=exchange.toHtml(rss.getString("qq1"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务2")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1"  name="qq2" type="text" style="width:60%" value="<%=exchange.toHtml(rss.getString("qq2"))%>"></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务3")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1"  name="qq3" type="text" style="width:60%" value="<%=exchange.toHtml(rss.getString("qq3"))%>"></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","在线服务4")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1"  name="qq4" type="text" style="width:60%" value="<%=exchange.toHtml(rss.getString("qq4"))%>"></td>
 </tr>
<%=issPrint.hasOrNot33(rss.getString("attachment1"),"附件","1",response,TR_STYLE1,TD_STYLE4,TD_STYLE21,FILE_STYLE1,rss.getString("id"),"ecommerce_contact")%>	 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(checker)%></td> 
 <input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="hidden" name="checker" value="<%=checker%>">
 <input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="hidden" name="checker_ID" value="<%=exchange.toHtml(checker)%>">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 </table>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
}
ecommerce_db.close();
ecommerce_db1.close();
}
catch (Exception ex){
out.println("error"+ex);
}				 
}else{
ecommerce_db.close();
ecommerce_db1.close(); 
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回！")%></td>
 </tr>
 </table>
<%}}else{
ecommerce_db.close();
ecommerce_db1.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回！")%></td>
 </tr> 
</table>

<%}%>
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>

<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../../javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='../../../dwr/interface/kindCounter.js'></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src="../../../javascript/ecommerce/treeBusiness.js"></script>
<script type='text/javascript' src='../../../javascript/include/div/divLocate.js'></script>

<div id="nseer1" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"  onmouseover="n_D.mmcMouseStyle(this);"></div>
 <div id="nseer1_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
</div>
</TD>
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
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
  Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setParent('nseer1_0');
 Nseer_tree1.setImagesPath('../../../images/');
 Nseer_tree1.setTableName('hr_config_file_kind');
 Nseer_tree1.setModuleName('../../../xml/ecommerce/website/contact');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../../xml/ecommerce/website/contact','hr_config_file_kind','treeButton');
}
</script>