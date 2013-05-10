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
 <p align="center"><b><font color="#800000" size="3"><%=demo.getLang("erp","川大科技ERP系统使用单位注册")%></b></td>
 </tr>
 </table>
 </center>
</div>
<DIV align="right">
 <TABLE cellpadding="2" width="90%" id="AutoNumber3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="100%" height="455">
 <DIV align="left">
  <TABLE width="98%" height="408" cellpadding="2" id="AutoNumber5">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td width="100%" height="404">
<font size="2">
			 <P style="line-height: 200%"><%=demo.getLang("erp","用户许可协议")%>&nbsp;<br>
 请在安装之前首先阅读《用户许可协议》（以下简称“许可协议”）。“许可协议”是用户（自然人、法人或其他组织）与川大科技就川大科技的软件产品：川大科技ERP软件系列，以下简称“软件产品”的版权所有人四川大学计算机学院（简称“川大科技”）之间的具有法律效力的协议。在您使用本软件产品之前，请务必阅读“许可协议”，任何与许可协议有关的软件、电子文档等都应是按许可协议的条款而授权您使用的，同时许可协议亦适用于任何有关本软件产品的后期发行和升级。您一旦安装、复制、下载、或以其它方式使用本软件产品，即表示您同意接受许可协议各项条款的约束。许可协议与由您签署的通过谈判订立的任何书面协议一样有效。如不同意，请不要使用本软件并确保产品及其组件的完好性。<br>
  <br>
  1.<%=demo.getLang("erp","“软件产品”的定义")%><br>
 本“许可协议”中的“软件产品”是指川大科技享有完全版权的软件程序、承载介质、相关文档、许可证明、辅助设备、产品的外包装等，“软件产品”不包括运行该软件相关的运行环境。为保证“软件产品”正常运行，最终用户应根据川大科技的建议安装必要的运行环境。“软件产品”及相关文档信息如有更改，恕不另行通知。<br>
  <br>
  2．<%=demo.getLang("erp","知识产权")%><br>
 本“软件产品”知识产权归川大科技所有。本软件的结构、组织和代码均为川大科技的知识产权。本软件受中华人民共和国著作权法，相关国际条约及使用本软件国家所适用的法律保护。您不得在“许可协议”许可的范围之外使用该软件，否则将构成对川大科技知识产权的侵犯。川大科技提供的或您获得的有关本软件的任何信息只能由您为“许可协议”许可的目的而使用，在未经授权的情况下不得用于其他商业用途；许可协议对您使用本软件的授权并不意味着川大科技对其享有的知识产权也进行了转让。本产品已提供了所有业务应用源代码，客户、增值服务商、个人均可对该产品进行二次开发并永久使用，您必须同意在川大科技信息化平台基础上进行的二次开发的成果仍然属于川大科技知识产权而非二次开发者知识产权。<br>
  <br>
  3．<%=demo.getLang("erp","软件产品使用")%><br>
 本软件产品受中华人民共和国著作权法及国际著作权条约和中国其它知识产权法及其他国际知识产权条约的保护。只要您遵守许可协议的条款，川大科技即会授予您非独占性的软件许可，并获得业务应用源代码，您可以免费使用该软件，但在使用过程中，如有不适合或缺少功能，使用者可以自行或委托服务商做定制开发，川大科技提供有偿服务包括：开发文档、咨询、培训、实施、安装等服务来保证使用者达到上述目的。<br>
  <br>
  4．<%=demo.getLang("erp","保证")%><br>
 本软件为开源软件，川大科技不承担由于使用软件本身带来经济损失的责任，川大科技不保证本软件没有错误，或者能够不间断的操作；川大科技不保证本软件在任何情况下在任何计算机上均有效；川大科技不就因使用或不能使用本软件而发生的损失，包括但不限于营业利润损失，业务中断、业务信息、文档、数据丢失或其他经济损失承担赔偿责任，即使已通知川大科技有可能发生该损失的，亦是如此。使用者可以将发现的问题以建议报告形式呈交川大科技，川大科技会在对本产品升级时考虑或采纳使用者所反馈的建议。<br>
  <br>
  5.<%=demo.getLang("erp","许可终止")%><br>
 如果您未能遵守许可协议的条款，川大科技有权随时终止授予您的对本软件的使用许可，终止许可后，您应立即将本软件的原文档及所有复制件销毁或返还给川大科技，所被许可的权利将被收回，责令停止损害，并保留追究相关责任的权力。<br>
  <br>
  6．<%=demo.getLang("erp","相关法律")%><br>
 本许可协议适用法律为中华人民共和国《知识产权保护条例》、《版权、著作权法》、《专利法》等法律，并受国际协约条款的保护。<br>
  <br>
  7. <%=demo.getLang("erp","联系")%><br> 
 有任何疑问，请与四川大学计算机学院联系。网址：http://www.nseer.com<br>
 <p style="line-height: 200%" align="center"><input type="button" value="<%=demo.getLang("erp","我同意")%>" onClick=location="register.jsp">&nbsp;<input type="button" value="<%=demo.getLang("erp","我不同意")%>" onClick=location="index.jsp">
  </td>
 </tr>
 </TABLE>
 </DIV>
 <P>　</td>
 </tr>
 </TABLE>
 </DIV>
</TABLE>
 </CENTER>
</DIV>
<%@include file="foot.htm"%>
</html>
