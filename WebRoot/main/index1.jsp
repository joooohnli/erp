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
	import="include.nseer_db.*,java.sql.*" import="java.util.*"
	import="java.io.*" import="java.text.*"%>
<jsp:useBean id="browercheck" scope="session"
	class="include.nseer_cookie.BrowerVer" />
<%
	nseer_db erp_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
	if (session.getAttribute("human_IDD") == null)
		response.sendRedirect("../home/login.jsp");
%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	demo.setPath(request);
%>
<html>
	<head>
		<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
		<meta name="ProgId" content="FrontPage.Editor.Document">
		<title><%=demo.getLang("erp", "欢迎使用川大科技信息化平台")%></title>
		<script language="JavaScript"
			type="text/Ja
	function MM_reloadPage(init) { //reloads the window if Nav4 resized
		if (init == true)
			with (navigator) {
				if ((appName == "
			Netscape") && (parseInt(appVersion) ==
			4)) {
					document.MM_pgW=innerWidth; document.MM_pgH=innerHeight;
			onresize=MM_reloadPage; }
			}
		else
			if (innerWidth !=document.MM_pgW
			|| innerHeight !=document.MM_pgH)location.reload();}
	MM_reloadPage(true
);
//--
</script>


		function onClose() { if (window.screenTop > 10000) { var targeturl =
		"auto_logout.jsp" newwin = window.open("", "",
		"scrollbars,Toolbar=yes") if (document.all) { newwin.moveTo(0, 0)
		newwin.resizeTo(80, 60) } newwin.location = targeturl } }
		window.onunload = o nClose

		</Script>

		<%
			String user_ID = (String) session.getAttribute("human_IDD");
			int i = 0;
			int x = 0;
			int mod_amount = 0;
			nseer_db db = new nseer_db((String) session
					.getAttribute("unit_db_name"));
			nseer_db db1 = new nseer_db((String) session
					.getAttribute("unit_db_name"));
			String sqla = "select * from document_main where value!='开发管理' order by id";
			ResultSet rsa = db.executeQuery(sqla);
			while (rsa.next()) {
				String reason = rsa.getString("reason");
				if (reason.equals("design") || reason.equals("stock") || reason.equals("drugstore")) {
					String tablename = reason + "_view";
					String sql1 = "select * from " + tablename
							+ " where human_ID='" + user_ID + "'";
					ResultSet rs1 = db1.executeQuery(sql1);
					if (rs1.next()
							&& !rsa.getString("reason").equals("erpPlatform")
							&& !rsa.getString("reason").equals("draft")
							&& !rsa.getString("reason").equals("garbage")) {
						mod_amount++;
					}
				}
			}
			//int circle=(mod_amount+13)/14;

			//int a=22*circle;
			int height = 65;
		%>
	</head>
	<%
		erp_db.close();
		db.close();
		db1.close();
	%>
	<frameset rows="<%=height%>,*,20" framespacing="0" border="1"
		onunload="onClose()" id="indexFrm">
		<frame src="index_top1.jsp" name="top" frameborder="no" scrolling="no"
			marginwidth="1" marginheight="1" target="a">
		<frame src="index_middle1.jsp" name="a" frameborder="no"
			marginwidth="1" marginheight="1">
		<frame src="index_bottom1.jsp" name="bottom" frameborder="no"
			scrolling="no" marginwidth="1" marginheight="1" target="bottom">
		<noframes>
			<body topmargin="0" leftmargin="0" bgcolor="#b5daff">


			</body>
		</noframes>
	</frameset>
</html>