<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*" import="com.fredck.FCKeditor.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@ page import="include.nseer_cookie.iisPrint"%>
<%iisPrint iisPrint=new iisPrint(request);%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db ecommerce_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%
String checker_ID=(String)session.getAttribute("human_IDD");
String checker=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register_time="";
String news_ID=request.getParameter("news_ID");
if(vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_news","news_ID",news_ID,"check_tag").equals("5")||vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_news","news_ID",news_ID,"check_tag").equals("9")){
try{
	String sqll = "select * from ecommerce_news where news_ID='"+news_ID+"'" ;
	ResultSet rss = ecommerce_db1.executeQuery(sqll) ;
	while(rss.next()){
	String content=rss.getString("content");
if(rss.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rss.getString("register_time");
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="mutiValidation" method="post" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_ecommerce_news_draft_ok?news_ID="+rss.getString("news_ID")+"&"+Globals.TOKEN_KEY+"="+session.getAttribute(Globals.TOKEN_KEY)+"','../../xml/ecommerce/ecommerce_news.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_ecommerce_news_check_ok?news_ID=<%=rss.getString("news_ID")%>&<%=Globals.TOKEN_KEY%>=<%=session.getAttribute(Globals.TOKEN_KEY)%>','../../xml/ecommerce/ecommerce_news.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div>
 </td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","新 闻")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","新闻标题")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="topic" value="<%=rss.getString("topic")%>">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","新闻分类")%>：</td>
  <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" id="filekind_chain" <%=INPUT_STYLE3%> class="INPUT_STYLE3" style="width:80%" name="filekind_chain" onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rss.getString("chain_id")+" "+exchange.toHtml(rss.getString("chain_name"))%>"><input id="filekind_chain_table" type="hidden" value="ecommerce_config_news_kind"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","新闻内容")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea id="content" name="content" cols="122" rows="30"><%=content%></textarea>
<script type="text/javascript">
 var oFCKeditor = new FCKeditor('content') ;
 oFCKeditor.BasePath = "/erp/" ;
 oFCKeditor.Height = 400;
 oFCKeditor.ToolbarSet = "Default" ; 
 oFCKeditor.ReplaceTextarea();
</script>
</td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE7" colspan="4"><textarea style="width:100%" id="content" name="content" cols="122" rows="30"><%=content%></textarea></td>
<%}%>
 </tr>
<%=iisPrint.hasOrNot7(rss.getString("attachment1"),"图片1","1",response,rss.getString("id"),FILE_STYLE1,"ecommerce_news")%>
<%=iisPrint.hasOrNot7(rss.getString("attachment2"),"图片2","2",response,rss.getString("id"),FILE_STYLE1,"ecommerce_news")%>
<%=iisPrint.hasOrNot7(rss.getString("attachment3"),"图片3","3",response,rss.getString("id"),FILE_STYLE1,"ecommerce_news")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" name="register"  value="<%=rss.getString("register")%>"><%=exchange.toHtml(rss.getString("register"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" name="register"  value="<%=rss.getString("register_time")%>"><%=exchange.toHtml(rss.getString("register_time"))%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <input type="hidden" name="checker_ID" value="<%=checker_ID%>"><input type="hidden" name="checker" value="<%=exchange.toHtml(checker)%>">
 <input  name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>">
 </tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
 </div>
 </form>
<%
	ecommerce_db.close();	
}
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
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="news_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该草稿已重新提交，请返回！")%></td>
 </tr>
</table>
</div>
<%}%>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
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
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src="../../javascript/ecommerce/news/treeBusiness.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
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
 Nseer_tree1.setTableName('ecommerce_config_news_kind');
 Nseer_tree1.setModuleName('../../xml/ecommerce/news');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/ecommerce/news','ecommerce_config_news_kind','treeButton');
}
</script>