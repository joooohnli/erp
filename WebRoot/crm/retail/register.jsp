<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%counter count=new counter(application);%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link href="../../javascript/table/onlineEditTable.css" type="text/css" rel="stylesheet">
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript">
function delSelect(){
 var checkboxs = document.getElementsByName("checkbox");
 var table = document.getElementById("tableOnlineEdit");
 var tr = table.getElementsByTagName("tr");
 for (var i=0; i<checkboxs.length; i++) {
 if(tr.length==2){
 checkboxs[i].checked = false;
 return;
 }
 if(checkboxs[i].checked==true){
 removeTr(checkboxs[i]);
 i=-1;
 }
 }
}

function removeTr(obj) {
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
</script>
<script language="javascript">
 var onecount;
 subcat = new Array();
 <% int i=0;
 String sql="select id,human_ID,chain_name from hr_file where check_tag='1' and human_major_first_kind_name='销售' order by chain_ID";
 ResultSet rs=hr_db.executeQuery(sql); 
 while(rs.next()) {%> 
 subcat[<%=i++%>] = new 
 Array("<%=rs.getString("id")%>","<%=rs.getString("human_ID")%>","<%=rs.getString("chain_name")%>");
 <%
	 }
 %> 
 onecount=<%=i%>;
 function changelocation(locationid)
  {
  mutiValidation.sales_ID.length = 0;  
  var locid=locationid;
  var i;
  mutiValidation.sales_ID.options[mutiValidation.sales_ID.length]=new Option("",""); 
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){mutiValidation.sales_ID.options[mutiValidation.sales_ID.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则sales_ID选择全部值
  else if (subcat[i][2] == locid)
  { 
   mutiValidation.sales_ID.options[mutiValidation.sales_ID.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }
</script>
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
<form id="mutiValidation" method="POST" action="register_getpara.jsp" onSubmit="return doValidate('../../xml/crm/crm_order.xml','mutiValidation')">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="winopen('register_product_list.jsp')" value="<%=demo.getLang("erp","添加商品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除商品")%>"> 
  <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","预览")%>"></div></td>
 </tr>
 </table> 
<%
String third_kind_name="";
String register_ID=(String)session.getAttribute("human_IDD");
String register=(String)session.getAttribute("realeditorc");
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","零售单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会员编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="customer_ID" value="01050000000000000000"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","零售店")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="stock_name" 
onChange="changelocation(mutiValidation.stock_name.options[mutiValidation.stock_name.selectedIndex].value)" style="width=100%;">
 <option value="">&nbsp;</option>
<%
  String sql2 = "select * from hr_config_file_kind where describe3='是' order by chain_ID" ;
	 ResultSet rs2 = hr_db.executeQuery(sql2) ;
while(rs2.next()){%>
		<option value="<%=exchange.toHtml(rs2.getString("chain_name"))%>"><%=exchange.toHtml(rs2.getString("chain_name"))%></option>
<%
}
		hr_db.close();
%>
  </select></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table id=tableOnlineEdit <%=TABLE_STYLE5%> class="TABLE_STYLE5">
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","点选")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","折扣（%）")%></td>
 </tr>
 <tr style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID" width="100%" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" width="100%" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span name="product_describe_ok" style="width:120px;background:#ffffff"></span><input type="hidden" name="product_describe" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" width="100%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit" width="100%" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="list_price" width="100%" onFocus="this.blur()"><input name="cost_price" type="hidden" width="100%"><input name="real_cost_price" type="hidden" width="100%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="off_discount" width="100%" value="0"></td>
 </tr>
</thead>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","销售编号")%>：</td>
     <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="sales_ID" style="width=100%;"><script language = "JavaScript">
	//if (mutiValidation.stock_name.value){ 如果stock_name没做出选择时，想让sales_ID的值为空，则加上这个条件
	 changelocation(mutiValidation.stock_name.value)
 //}
 </script>
 </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","收银员")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register" type="hidden" width="100%" value="<%=exchange.toHtml(register)%>"><%=exchange.toHtml(register)%></td>
 </tr>	
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="8" width="89%">
 <textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
 </td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>