/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.users_lock;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.StringTokenizer;
import java.util.Map;
/**
 * 用户过滤器:
 * 如果用户的数量超过限制,不能正常登录
 *
 */

public class UserLimitedFilter implements Filter {
    private FilterConfig filterConfig=null;
    private int limitation=5;
    private int current=0;
    private String urls=null;
	public void doFilter(ServletRequest request, ServletResponse response,
	                     FilterChain chain) throws IOException,ServletException {
      if(filterConfig==null) {
		  return;
	  }
      Map users=(Map) filterConfig.getServletContext().getAttribute("user");
      if (users!=null) {
         current=users.size();
      }

	  //对于几个特殊的页面，不需要用户数过滤束缚
	  //
	  if(isSpecial((HttpServletRequest)request)){
		//呵呵，什么也不干
	  } else if(current>=limitation){
		  PrintWriter out=response.getWriter();
		  response.setContentType("text/html; charset=GB2312");

          out.println("<head>");
          out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
          out.println("<meta name=\"GENERATOR\" content=\"Microsoft FrontPage 5.0\">");
          out.println("<meta name=\"ProgId\" content=\"FrontPage.Editor.Document\">");
          out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
          out.println("<META HTTP-EQUIV=\"Cache-Control\" CONTENT=\"no-cache\">");
          out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"0\">");
          out.println("<title>欢迎进入川大科技客户关系管理系统</title>");
          out.println("<STYLE>");
          out.println("A:visited {");
          out.println("	TEXT-DECORATION: none");
          out.println("}");
          out.println("A:active {");
          out.println("	TEXT-DECORATION: none");
          out.println("}");
          out.println("A:hover {");
          out.println("	TEXT-DECORATION: underline overline");
          out.println("}");
          out.println("A:link {");
          out.println("	TEXT-DECORATION: none");
          out.println("}");
          out.println(".t {");
          out.println("	LINE-HEIGHT: 1.4");
          out.println("}");
          out.println("BODY {");
          out.println("	FONT-FAMILY: 宋体;");
          out.println("	FONT-SIZE: 9pt;");
          out.println("	SCROLLBAR-HIGHLIGHT-COLOR: buttonface;");
          out.println("	SCROLLBAR-SHADOW-COLOR: buttonface;");
          out.println("	SCROLLBAR-3DLIGHT-COLOR: buttonhighlight;");
          out.println("	SCROLLBAR-TRACK-COLOR: #eeeeee;");
          out.println("	SCROLLBAR-DARKSHADOW-COLOR: buttonshadow;");
          out.println("	margin-left: 0px;");
          out.println("	margin-top: 0px;");
          out.println("	margin-right: 0px;");
          out.println("	margin-bottom: 0px;");
          out.println("}");
          out.println("TD {");
          out.println("	FONT-FAMILY: 宋体; FONT-SIZE: 9pt");
          out.println("}");
          out.println("DIV {");
          out.println("	FONT-FAMILY: 宋体; FONT-SIZE: 9pt");
          out.println("}");
          out.println("FORM {");
          out.println("	FONT-FAMILY: 宋体; FONT-SIZE: 9pt");
          out.println("}");
          out.println("OPTION {");
          out.println("	FONT-FAMILY: 宋体; FONT-SIZE: 9pt");
          out.println("}");
          out.println("P {");
          out.println("	FONT-FAMILY: 宋体; FONT-SIZE: 9pt");
          out.println("}");
          out.println("TD {");
          out.println("	FONT-FAMILY: 宋体; FONT-SIZE: 9pt");
          out.println("}");
          out.println("BR {");
          out.println("	FONT-FAMILY: 宋体; FONT-SIZE: 9pt");
          out.println("}");
          out.println("INPUT {");
          out.println("	BORDER-BOTTOM-COLOR: #cccccc; BORDER-BOTTOM-WIDTH: 1px; BORDER-LEFT-COLOR: #cccccc;  BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #cccccc; BORDER-RIGHT-WIDTH: 1px;  BORDER-TOP-COLOR: #cccccc; BORDER-TOP-WIDTH: 1px; FONT-SIZE: 9pt; HEIGHT: 18px;  PADDING-BOTTOM: 1px; PADDING-LEFT: 1px; PADDING-RIGHT: 1px; PADDING-TOP: 1px");
          out.println("}");
          out.println("TEXTAREA {");
          out.println("	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px;  BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000;  BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 9pt");
          out.println("}");
          out.println("SELECT {");
          out.println("	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px;  BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000;  BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 9pt");
          out.println("}");
          out.println("</STYLE>");
          out.println("<!--end css info-->");
          out.println("<META content=\"Microsoft FrontPage 4.0\" name=GENERATOR>");
          out.println("");
          out.println("<STYLE>");
          out.println(".gray {");
          out.println("	CURSOR: hand; FILTER: gray");
          out.println("}");
          out.println(".style3 {");
          out.println("	font-size: 16px;");
          out.println("	font-weight: bold;");
          out.println("}");
          out.println(".unnamed1 {");
          out.println("	border: 1px solid #006600;");
          out.println("}");
          out.println(".unnamed2 {");
          out.println("	border: 1px ridge #666666;");
          out.println("}");
          out.println(".style8 {color: #000066}");
          out.println("</STYLE>");
          out.println("</head>");
          out.println("<Script Langvage=javascript>");
          out.println("function KeyDown(){");
          out.println("if ((window.event.altKey)&&");
          out.println("((window.event.keyCode==37)||(window.event.keyCode==39))){");
          out.println("alert(\"请不要使用ALT+方向键前进或后退网页！\");");
          out.println("event.returnValue=false;");
          out.println("}");
          out.println("");
          out.println("if ((event.keyCode==8)||(event.keyCode==116)||(event.ctrlKey && event.keyCode==82)){");
          out.println("event.keyCode=0;");
          out.println("event.returnValue=false;");
          out.println("}");
          out.println("if ((event.ctrlKey)&&(event.keyCode==78))");
          out.println("event.returnValue=false;");
          out.println("if ((event.shiftKey)&&(event.keyCode==121))");
          out.println("event.returnValue=false;");
          out.println("if (window.event.srcElement.tagName == \"A\" && window.event.shiftKey)");
          out.println("window.event.returnValue = false;");
          out.println("if ((window.event.altKey)&&(window.event.keyCode==115)){");
          out.println("window.showModelessDialog(\"about:blank\",\"\",\"dialogWidth:1px;dialogheight:1px\");");
          out.println("return false;}");
          out.println("}");
          out.println("</script>");
          out.println("<body bgcolor=\"#EFEFEF\" onkeydown=\"KeyDown()\" oncontextmenu=\"event.returnValue=true\">");
          out.println("<div align=\"center\">");
          out.println("  <center>");
          out.println("  <table border=\"0\" cellpadding=\"2\" width=\"650\" height=\"10\">");
          out.println("    <tr>");
          out.println("      <td height=\"15\"></td>");
          out.println("    </tr>");
          out.println("  </table>");
          out.println("  </center>");
          out.println("</div>");
          out.println("");
          out.println("<div align=\"center\">");
          out.println("  <center>");
          out.println("  <table border=\"0\" cellpadding=\"2\" width=\"650\">");
          out.println("    <tr>");
          out.println("      <td height=\"10\"></td>");
          out.println("    </tr>");
          out.println("  </table>");
          out.println("  </center>");
          out.println("</div>");
          out.println("<div align=\"center\">");
          out.println("  <center>");
          out.println("  <table border=\"0\" cellpadding=\"2\" width=\"650\">");
          out.println("    <tr>");
          out.println("      <td height=\"5\"></td>");
          out.println("    </tr>");
          out.println("  </table>");
          out.println("  </center>");
          out.println("</div>");
          out.println("<p>　</p>");
          out.println("<p>　</p>");
          out.println("<p>　</p>");
          out.println("	<div align=\"center\">");
          out.println("  <table border=\"0\" cellpadding=\"2\" width=\"650\">");
          out.println("    <tr>");
          out.println("      <td width=\"100%\">");
          out.println("        <p align=\"center\">对不起，您的用户数已经达到最大值！</td>");
          out.println("    </tr>");
          out.println("  </table>");
          out.println("</div>");
          out.println("<div align=\"center\">");
          out.println("  <center>");
          out.println("  <table border=\"0\" cellpadding=\"2\" width=\"650\">");
          out.println("    <tr>");
          out.println("      <td height=\"5\"></td>");
          out.println("    </tr>");
          out.println("  </table>");
          out.println("  </center>");
          out.println("</div>");

		  out.flush();
		  return;
	  } 
	  chain.doFilter(request,response);
    }

  public void init(FilterConfig filterConfig) {

    String li=(String)filterConfig.getServletContext().getAttribute(
                                                    "numberLimitation");
    try {    
      limitation=Integer.parseInt(li);      
    } catch (Exception e) {
      limitation=5;
    } // end of try-catch
    this.filterConfig=filterConfig;
    if((urls=filterConfig.getInitParameter("urls"))==null) {
       urls="    ";
    }
  }

  public boolean isSpecial(HttpServletRequest request) {
    String url=request.getRequestURI();
    StringTokenizer st=new StringTokenizer(urls,",");
    while (st.hasMoreElements()){
      if(url.indexOf(st.nextToken())!=-1){
        return true;
      }
    } 
    return false;
  }

  public void destroy() {
    this.filterConfig = null;
  }
}
