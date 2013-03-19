<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*" import="com.fredck.FCKeditor.*"%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="test" class="include.multilanguage.GetLang" scope="page"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<form id="mutiValidation" method="POST" action="../../ecommerce_comment_register_ok" onSubmit="return doValidate('../../xml/ecommerce/ecommerce_comment.xml','mutiValidation')" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../ecommerce_comment_register_draft_ok','../../xml/ecommerce/ecommerce_comment.xml'",request)%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>"></div></td>
</tr>
</table>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","反馈信息")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","姓名")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="name"></td> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","性别")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" size="1" name="sex"><option><%=demo.getLang("erp","男")%></option>
  <option><%=demo.getLang("erp","女")%></option>
  		  </select></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","单位")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="company"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","地址")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="address"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","电话")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="tel"></td> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","Email")%>&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="email"></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","反馈信息分类")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="kind">
  <%
  String sql6 = "select * from ecommerce_config_public_char where kind='反馈信息分类' order by id" ;
	 ResultSet rs6 = ecommerce_db.executeQuery(sql6) ;
while(rs6.next()){%>
		<option value="<%=exchange.toHtml(rs6.getString("type_name"))%>"><%=exchange.toHtml(rs6.getString("type_name"))%></option>
<%
}
ecommerce_db.close();
%>

  </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","反馈时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" name="write_time" value="<%=time%>"><%=time%></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","信息内容")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%> 
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea id="comment" name="comment" cols="122" rows="30"></textarea>
<script type="text/javascript">
 var oFCKeditor = new FCKeditor('comment') ;
 oFCKeditor.BasePath = "/erp/" ;
 oFCKeditor.Height = 400;
 oFCKeditor.ToolbarSet = "Default" ; 
 oFCKeditor.ReplaceTextarea();
</script>
</td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea style="width:100%" id="comment" name="comment" cols="122" rows="30"></textarea></td>
<%}%>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","附件")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file"></td>
</tr>
</table>
 <%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>