<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*,include.nseer_cookie.*,java.text.*"
	import="java.util.*" import="java.io.*"
	import="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML"
	scope="page" />
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 %>
<%@include file="../include/head.jsp"%>
<script>
function closediv(){
	var loaddiv=document.getElementById("loaddiv");
	loaddiv.style.display="none";
}
</script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript"
	src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseer_cookie/xml-css.css" />
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseerTree/nseertree.css">
<script type='text/javascript'
	src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
<script type='text/javascript'
	src='../../javascript/include/div/divLocate.js'></script>

<body>

	<div id="toolTipLayer" style="position: absolute; visibility: hidden"></div>
	<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
			<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
				<div class="div_handbook"><%=handbook%></div>
			</td>
		</tr>
	</table>
	<div id="nseerGround" class="nseerGround">
		<form id="mutiValidation" class="x-form" method="post"
			action="../../design_file_register_ok"
			onSubmit="return doValidate('../../xml/design/design_file.xml','mutiValidation')">
			<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE3%> class="TD_STYLE3">
						<div id="loaddiv"
							style="display: none; border: 1px solid red; height: 20px; background-color: #FF0033; width: 58%; float: left;"></div>
						<div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../design_file_register_draft_ok','../../xml/design/design_file.xml'",request)%>&nbsp;
							<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1"
								value="<%=demo.getLang("erp","提交")%>" name="B1">
							&nbsp;
							<input <%=RESET_STYLE1%> class="RESET_STYLE1" type="reset"
								value="<%=demo.getLang("erp","清除")%>">
						</div>
					</td>
				</tr>
			</table>
			<%
String time="";
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String file1=path+"xml/design/design_file.xml";
List returnList=OperateXML.returnList(file1,"name","mutiValidation","name","name","required","n");
%>

			<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
				<tr style="background-image: url(../../images/line.gif)">
					<td colspan="4">
						<div style="width: 100%; height: 12; padding: 3px;"><%=demo.getLang("erp","主信息")%></div>
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">
						<font color=red>*</font><%=demo.getLang("erp","药品名称")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
						<input id="validator_dup" type="text" <%=INPUT_STYLE1%>
							class="INPUT_STYLE1" style="width: 80%" name="product_name">
						<a
							href="javascript:ajax_validation('mutiValidation','validator_dup','design_file','product_name','../../vdf','product_ID','query.jsp',this)"
							onMouseOver="toolTip('<%=demo.getLang("erp","该功能用于检验产品信息是否重复！")%>',this)"
							onMouseOut="toolTip()"><img src="../../images/dup.gif"
								width="15" height="14" align="center" border="0"> </a>
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生产厂商")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="factory_name" style="width: 80%">
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">
						<font color=red>*</font><%=demo.getLang("erp","产品分类")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							id="kind_chain" name="fileKind_chain" style="width: 80%"
							onFocus="showKind('nseer1',this,showTree)"
							onkeyup="search_suggest(this.id)" autocomplete="off"
							onchange="clear_human()">
						<input id="kind_chain_table" type="hidden"
							value="design_config_file_kind">
					</td>


					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品简称")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="product_nick" style="width: 49%">
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">
						<font color=red>*</font><%=demo.getLang("erp","市场单价(元)")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="list_price" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">
						<font color=red>*</font><%=demo.getLang("erp","计划成本单价")%>
					</td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="cost_price"
							type="text" style="width: 49%">
					</td>
				</tr>

				<!--
				add by john
				-->
				<tr>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">
					<font color=red>*</font><%=demo.getLang("erp","保质期(天)")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="quality_guarantee_period" style="width: 49%">
					</td>
				</tr>
				<tr>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","规格")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="product_specification" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","批号")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="product_batch_number" style="width: 49%">
					</td>
				</tr>
				<tr>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","包装单位")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="product_packing_unit" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","发药单位")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="product_dispensing_unit" style="width: 49%">
					</td>
				</tr>
				<tr>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","医疗保险类别")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="product_medical_insurance_categories" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","处方标志")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="product_prescription_marks" style="width: 49%">
					</td>
				</tr>

				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","用途类型")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type"
							style="width: 49%">
							<%
String field_type=(String)session.getAttribute("field_type");
String sql4="";
if(field_type.equals("0")){
	sql4 = "select * from design_config_public_char where kind='产品用途' order by id";
}else{
	sql4 = "select * from design_config_public_char where kind='产品用途' and describe1='1' order by id";
}
	 ResultSet rs4 = design_db.executeQuery(sql4) ;
while(rs4.next()){%>
							<option value="<%=exchange.toHtml(rs4.getString("type_name"))%>"><%=exchange.toHtml(rs4.getString("type_name"))%></option>
							<%
}
%>

						</select>
						<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=OperateXML.returnTag(returnList,"product_class")%><%=demo.getLang("erp","档次级别")%></td>
						<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
							<select <%=SELECT_STYLE1%> class="SELECT_STYLE1"
								name="product_class" style="width: 49%">
								<%
  String sql5 = "select * from design_config_public_char where kind='档次级别' order by type_ID" ;
	 ResultSet rs5 = design_db.executeQuery(sql5) ;
while(rs5.next()){%>
								<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5.getString("type_name"))%></option>
								<%
}
design_db.close();	
%>

							</select>
						</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计量单位")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="personal_unit" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","计量值")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="personal_value" style="width: 49%">
					</td>
				</tr>
				<tr style="background-image: url(../../images/line.gif)">
					<td colspan="4">
						<div style="width: 100%; height: 12; padding: 3px;"><%=demo.getLang("erp","辅助信息")%></div>
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","保修期")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="warranty" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","替代品名称")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="twin_name" style="width: 49%">
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","替代品编号")%>
					</td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="twin_ID" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生命周期(年)")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="lifecycle" style="width: 49%">
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">

					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","单位")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							name="amount_unit" style="width: 49%">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品经理")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="select4"
							name="select4" type="text" style="width: 49%"
							onfocus="loadAjaxDiv('select4','kind_chain',event);this.blur();"
							value="" readonly />
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">
					<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","供应商集合")%>
						&nbsp;
					</td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1"
							name="provider_group"></textarea>
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","产品描述")%>
						&nbsp;
					</td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1"
							name="product_describe"></textarea>
					</td>
				</tr>
				<tr <%=TR_STYLE1%> class="TR_STYLE1">

					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
							style="width: 49%" name="register"
							value="<%=exchange.toHtml(operator)%>">
					</td>
					<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","建档时间")%></td>
					<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
						<input name="register_time" type="hidden" width="100%"
							value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>

				</tr>

				<jsp:useBean id="mask" class="include.operateXML.Reading" />
				<jsp:setProperty name="mask" property="file"
					value="xml/design/design_file.xml" />
				<%String nickName="产品档案";%>
				<%@include file="../../include/cDefineMou.jsp"%>

			</table>
			<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
				value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
		</form>
	</div>
	<script type='text/javascript'
		src='../../javascript/include/div/alert.js'></script>
	<script type="text/javascript"
		src="../../javascript/include/draft_gar/divReconfirm.js"></script>
	<script type='text/javascript' src='../../dwr/engine.js'></script>
	<script type='text/javascript' src='../../dwr/util.js'></script>
	<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
	<script type='text/javascript'
		src="../../javascript/include/nseerTree/nseertree.js"></script>
	<script type='text/javascript'
		src='../../javascript/include/div/divViewChange.js'></script>
	<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
	<script type='text/javascript'
		src='../../dwr/interface/multiLangValidate.js'></script>
	<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
	<script type='text/javascript'
		src='../../javascript/include/covers/cover.js'></script>
	<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
	<script type="text/javascript"
		src="../../javascript/include/validate/validation-framework.js"></script>
	<script type='text/javascript'
		src="../../javascript/design/file/treeBusiness.js"></script>
	<script type="text/javascript"
		src="../../javascript/design/file/responsible.js"></script>
	<link rel="stylesheet" type="text/css"
		href="../../css/include/nseer_cookie/ajaxDiv.css" />
	<div id="nseer1" nseerDef="dragAble"
		style="position: absolute; left: 300px; top: 100px; display: none; width: 450px; height: 300px; overflow: hidden; z-index: 1; background: #E8E8E8;">
		<iframe src="javascript:false"
			style="position: absolute; visibility: inherit; top: 0px; left: 0px; width: 100%; height: 100%; z-index: -1; filter ='progid: DXImageTransform.Microsoft.Alpha (   style =   0, opacity =   0 ) ';"></iframe>
		<TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
			<TBODY>
				<TR>
					<TD width="1%" height="1%">
						<IMG src="../../images/bg_0ltop.gif">
					</TD>
					<TD width="100%" background="../../images/bg_01.gif"></TD>
					<TD width="1%" height="1%">
						<IMG src="../../images/bg_0rtop.gif">
					</TD>
				</TR>
				<TR>
					<TD background="../../images/bg_03.gif"></TD>
					<TD>
						<div class="cssDiv1">
							<div class="cssDiv2">
								恩信科技开源ERP
							</div>
						</div>
						<div class="cssDiv3" onclick="n_D.closeDiv('hidden')"
							onmouseover="n_D.mmcMouseStyle(this);"></div>
						<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"
							onmouseover="n_D.mmcMouseStyle(this);"></div>
						<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"
							onmouseover="n_D.mmcMouseStyle(this);"></div>
						<div id="nseer1_0"
							style="position: absolute; left: 10px; top: 40px; width: 100%; height: 89%; overflow: auto;">
						</div>
					</TD>
					<TD background="../../images/bg_04.gif"></TD>
				</TR>
				<TR>
					<TD width="1%" height="1%">
						<IMG src="../../images/bg_0lbottom.gif">
					</TD>
					<TD background="../../images/bg_02.gif"></TD>
					<TD width="1%" height="1%">
						<IMG src="../../images/bg_0rbottom.gif">
					</TD>
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
 Nseer_tree1.setTableName('design_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/design/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/design/file','design_config_file_kind','treeButton');
}
</script>