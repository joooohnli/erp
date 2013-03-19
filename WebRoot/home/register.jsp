<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*"%>
<html>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>
<%@include file="head.jsp"%>

 <center>
 <table cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="60"></td>
 </tr>
 </table>
 </center>
</div>

 <center>
 <table width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <p align="center"><b><font color="#800000" size="3"><%=demo.getLang("erp","恩信科技ERP系统使用单位注册")%></b></td>
 </tr>
 </table>
 </center>
</div>
<script language="javascript">
 var count=0;


function checkform() {
if(count>0){
		return false;
	}
	count++;
if ( document.form1.unit_name.value==""){
		alert("请输入使用单位");
		document.form1.unit_name.focus();
		count=count-1;
		return false;
	}
if ( document.form1.unit_id.value==""){
		alert("请输入使用单位简称");
		document.form1.unit_id.focus();
		count=count-1;
		return false;
	}
if ( document.form1.contact_person.value==""){
		alert("请输入联系人");
		document.form1.contact_person.focus();
		count=count-1;
		return false;
	}
if ( document.form1.tel.value==""){
		alert("请输入联系电话");
		document.form1.tel.focus();
		count=count-1;
		return false;
	}
if ( document.form1.email.value==""){
		alert("请输入EMAIL");
		document.form1.email.focus();
		count=count-1;
		return false;
	}

return true;
}
</script>
<script language="javascript">
function jtrim(str)
{ while (str.charAt(0)==" ")
  {str=str.substr(1);} 
 while (str.charAt(str.length-1)==" ")
  {str=str.substr(0,str.length-1);}
 return(str);
}
function prochk()
{
	if (jtrim(document.form1.unit_id.value)=="")
	{	
		alert ("请填写用户名");
		document.form1.unit_id.focus();
	}
	else{
			
			var user = document.form1.unit_id.value;
			window.open("anti_sameunitid.jsp?name="+user+""); 
	}
}
</script>
<form action="../../servlet/home.register_ok" method="post" name="form1" onSubmit="javascript:return checkform(this)">
 <DIV>
 <center>
  <table width="650" height="400" align="center" cellpadding="0" cellspacing="0">
   
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="52"><%=demo.getLang("erp","使用单位")%>：</td>
  <td height="52"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="unit_name" type="text" size="40">&nbsp;*</td>
  </tr>
					 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="52"><%=demo.getLang("erp","使用单位简称")%>：</td> 
  <td height="52"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="unit_id" type="text" size="40">&nbsp;*<a href="javascript:prochk()"><font color="#0000CC"><%=demo.getLang("erp","单位简称是否可用")%></a></td>
  </tr>
					 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="52"><%=demo.getLang("erp","营业执照编码")%>：</td> 
  <td height="52"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="business_license" type="text" size="40">&nbsp;*</td>
  </tr>
					 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="52"><%=demo.getLang("erp","所属行业")%>：</td> 
  <td height="52"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="field_type" style="width:30%">
						<option value="0">生产型</option>
						<option value="1">分销型</option>
						</select>
						</td>
  </tr>
					 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="52"><%=demo.getLang("erp","联系人")%>：</td> 
  <td height="52"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="contact_person" type="text" size="40">&nbsp;*</td>
  </tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="51"><%=demo.getLang("erp","联系电话")%>：</td>
  <td height="51"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="tel" type="text" size="40">&nbsp;*</td>
  </tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="51"><%=demo.getLang("erp","手机")%>：</td> 
  <td height="51"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="cell" type="text" size="40">&nbsp;</td>
  </tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="51"><%=demo.getLang("erp","通讯地址")%>：</td>
  <td height="51"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="address" type="text" size="40">&nbsp;</td>
  </tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="51"><%=demo.getLang("erp","邮编")%>：</td> 
  <td height="51"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="postcode" type="text" size="40"></td>
  </tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="51"><%=demo.getLang("erp","EMAIL")%>：</td> 
  <td height="51"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="email" type="text" size="40">*（<%=demo.getLang("erp","请正确填写，以获得管理员用户名和密码")%>）</td>
  </tr>
						 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td height="51"><%=demo.getLang("erp","输入验证码")%>：</td> 
  <td height="51"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="input_check" type="text" size="40">
 
  <img alt="" src="input_check.jsp"/> 
 
  </td>
  </tr>
					 
   <input type="hidden" name="remark" value=""></td>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td colspan="2" height=51> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="Submit" value="<%=demo.getLang("erp","提交")%>">&nbsp; &nbsp;&nbsp;&nbsp; 
   <input type="reset" name="Submit2" value="<%=demo.getLang("erp","取消")%>"></td>
   </tr>
  </table>
 </CENTER>
 </div>
  </form>
<%@include file="foot.htm"%>
</html>
