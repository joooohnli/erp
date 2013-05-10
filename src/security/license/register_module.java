package security.license;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.util.StringTokenizer;
import java.io.*;

import include.anti_repeat_submit.Globals;
import include.nseer_cookie.DealWithString;
import include.nseer_cookie.KindDeep;
import include.nseer_cookie.MaxKind;
import include.nseer_cookie.ReadXmlLength;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import include.tree_index.Nseer;
import include.tree_index.businessComment;



public class register_module extends HttpServlet{
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
String mod="/erp/security/license/register_module.jsp";
PrintWriter out=response.getWriter();


 include.nseer_cookie.BrowerVer browercheck = null;
      synchronized (session) {
        browercheck = (include.nseer_cookie.BrowerVer) pageContext.getAttribute("browercheck", PageContext.SESSION_SCOPE);
        if (browercheck == null){
          browercheck = new include.nseer_cookie.BrowerVer();
          pageContext.setAttribute("browercheck", browercheck, PageContext.SESSION_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');

		String strhead = request.getHeader("User-Agent");
		if(strhead.indexOf(browercheck.IE)!=-1){
		 
			 	double ver = Double.parseDouble(strhead.substring(strhead.indexOf("MSIE ")+5,strhead.indexOf(";",strhead.indexOf("MSIE "))));
			 	if(ver <browercheck.IEVer){
			RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/alarm.html");
  dispatcher.include(request,response);
				}
		}

      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<style>\r\n");
      out.write(".nseerGround{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\tleft:1%;\r\n");
      out.write("\theight:100%;\r\n");
      out.write("\twidth:98%;\r\n");
      out.write("\t");
if(strhead.indexOf(browercheck.IE)!=-1){
      out.write("z-index:-1;");
}
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".div_handbook{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\tleft:1%;\r\n");
      out.write("\twidth:98%\r\n");
      out.write("}\r\n");
      out.write("form{\r\n");
      out.write("\tmargin:0;\r\n");
      out.write("}\r\n");
      out.write(".resizeDivClass\r\n");
      out.write("{\r\n");
      out.write("position:relative;\r\n");
      out.write("background-color:#DEDBD6;\r\n");
      out.write("width:2;\r\n");
      out.write("z-index:1;\r\n");
      out.write("left:expression(this.parentElement.offsetWidth-1);\r\n");
      out.write("cursor:e-resize;\r\n");
      out.write("}\r\n");
      out.write("A:visited {\r\n");
      out.write("\tTEXT-DECORATION: none\r\n");
      out.write("}\r\n");
      out.write("A:active {\r\n");
      out.write("\tTEXT-DECORATION: none\r\n");
      out.write("}\r\n");
      out.write("A:hover {\r\n");
      out.write("\tTEXT-DECORATION: underline overline\r\n");
      out.write("}\r\n");
      out.write("A:link {\r\n");
      out.write("\tTEXT-DECORATION: none\r\n");
      out.write("}\r\n");
      out.write(".t {\r\n");
      out.write("\tLINE-HEIGHT: 1.4\r\n");
      out.write("}\r\n");
      out.write("BODY {\r\n");
      out.write("\tFONT-FAMILY: 宋体;\r\n");
      out.write("\tFONT-SIZE: 9pt;\r\n");
      out.write("\tscrollbar-face-color :#F1F1F1;\r\n");
      out.write("\tSCROLLBAR-HIGHLIGHT-COLOR: #F1F1F1;\r\n");
      out.write("\tSCROLLBAR-SHADOW-COLOR: buttonface;\r\n");
      out.write("\tSCROLLBAR-3DLIGHT-COLOR: buttonhighlight;\r\n");
      out.write("\tSCROLLBAR-TRACK-COLOR: #868686\r\n");
      out.write("\tSCROLLBAR-DARKSHADOW-COLOR: buttonshadow;\r\n");
      out.write("\tmargin-left: 0px;\r\n");
      out.write("\tmargin-top: 0px;\r\n");
      out.write("\tmargin-right: 0px;\r\n");
      out.write("\tmargin-bottom: 0px;\r\n");
      out.write("}\r\n");
      out.write("TD {\r\n");
      out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
      out.write("}\r\n");
      out.write("DIV {\r\n");
      out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
      out.write("}\r\n");
      out.write("FORM {\r\n");
      out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
      out.write("}\r\n");
      out.write("OPTION {\r\n");
      out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
      out.write("}\r\n");
      out.write("P {\r\n");
      out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
      out.write("}\r\n");
      out.write("TD {\r\n");
      out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
      out.write("}\r\n");
      out.write("BR {\r\n");
      out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
      out.write("}\r\n");
      out.write(".gray {\r\n");
      out.write("\tCURSOR: hand; FILTER: gray\r\n");
      out.write("}\r\n");
      out.write(".style3 {\r\n");
      out.write("\tfont-size: 16px;\r\n");
      out.write("\tfont-weight: bold;\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE11{\r\n");
      out.write("\tborder: 1px solid;\r\n");
      out.write("\tborder-collapse: collapse;\r\n");
      out.write("\twidth: 95%;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE1{\r\n");
      out.write("\tborder: 1px solid;\r\n");
      out.write("\tborder-collapse: collapse;\r\n");
      out.write("\twidth: 100%;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE2{\r\n");
      out.write("\twidth: 100%;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE3{\r\n");
      out.write("\twidth: 98%;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE4{\r\n");
      out.write("\twidth: 95%;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE5{\r\n");
      out.write("\tborder: 1px solid;\r\n");
      out.write("\tborder-collapse: collapse;\r\n");
      out.write("\twidth: 95%;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE6{\r\n");
      out.write("\twidth: 98.5%;\t\r\n");
      out.write("}\r\n");
      out.write(".TABLE_STYLE7{\r\n");
      out.write("\tborder: 1px solid;\r\n");
      out.write("\tborder-collapse: collapse;\r\n");
      out.write("\twidth: 100%;\t\r\n");
      out.write("}\r\n");
      out.write(".ALL-STYLE{\r\n");
      out.write("\tborder: 1px ridge #666666;\r\n");
      out.write("\tborder-color:#DEDBD6;\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".TR_STYLE1{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".TR_STYLE2{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".style8 {color: #000066}\r\n");
      out.write("\r\n");
      out.write(".TD_HANDBOOK_STYLE1 {\r\n");
      out.write("\tvertical-align : top ;\r\n");
      out.write("\twidth:100%;\r\n");
      out.write("\tcolor:#0000FF;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".TD_STYLE1{\r\n");
      out.write("  background-image:url(/erp/images/bg.gif);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".TD_STYLE2{\r\n");
      out.write("border-spacing: 1px;\r\n");
      out.write("}\r\n");
      out.write(".TD_STYLE3{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".TD_STYLE4{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".TD_STYLE5{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".TD_STYLE6{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".TD_STYLE7{\r\n");
      out.write("  background-image:url(/erp/images/line4.gif);\r\n");
      out.write("}\r\n");
      out.write(".TD_STYLE8{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".SUBMIT_STYLE1{\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".BUTTON_STYLE1{\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("}\r\n");
      out.write(".RESET_STYLE1{\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("}\r\n");
      out.write(".RADIO_STYLE1{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".CHECKBOX_STYLE1{\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".SELECT_STYLE1{\r\n");
      out.write("width:100%;\r\n");
      out.write("}\r\n");
      out.write(".SELECT_STYLE2{\r\n");
      out.write("width:100%;\r\n");
      out.write("}\r\n");
      out.write(".TEXTAREA_STYLE1{\r\n");
      out.write("width:100%;\r\n");
      out.write("}\r\n");
      out.write(".DIV_STYLE1{\r\n");
      out.write("\r\n");
      out.write("float :right ;\r\n");
      out.write("vertical-align : top ;\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".DIV_STYLE2{\r\n");
      out.write("\r\n");
      out.write("float :center ;\r\n");
      out.write("vertical-align : top ;\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(".INPUT_STYLE1{\r\n");
      out.write("width:100%\r\n");
      out.write("}\r\n");
      out.write(".INPUT_STYLE3{\r\n");
      out.write("BORDER-BOTTOM:  1px solid #000000;\r\n");
      out.write("BORDER-left:  0px ;\r\n");
      out.write("BORDER-right:  0px ;\r\n");
      out.write("BORDER-top:  0px ;\r\n");
      out.write("width:100%\r\n");
      out.write("}\r\n");
      out.write(".INPUT_STYLE4{\r\n");
      out.write("BORDER-BOTTOM:  0px;\r\n");
      out.write("BORDER-left:  0px ;\r\n");
      out.write("BORDER-right:  0px ;\r\n");
      out.write("BORDER-top:  0px ;\r\n");
      out.write("width:100%\r\n");
      out.write("}\r\n");
      out.write(".INPUT_STYLE5{\r\n");
      out.write("background-color:#FFFFCC;\r\n");
      out.write("BORDER-BOTTOM:  0px;\r\n");
      out.write("BORDER-left:  0px ;\r\n");
      out.write("BORDER-right:  0px ;\r\n");
      out.write("BORDER-top:  0px ;\r\n");
      out.write("width:100%\r\n");
      out.write("}\r\n");
      out.write(".FILE_STYLE1{\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("}\r\n");
      out.write(".btn3_mouseout {\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("}\r\n");
      out.write(".btn3_mouseover {\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("}\r\n");
      out.write(".btn3_mousedown\r\n");
      out.write("{\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("}\r\n");
      out.write(".btn3_mouseup {\r\n");
      out.write(" BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
      out.write("}\r\n");
      out.write("</STYLE>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");

{
String url_temp="";
String file_url=request.getRequestURI();
for(int i=0;i<file_url.split("/").length-3;i++){
	url_temp+="../";
}

      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(url_temp);
      out.write("javascript/ajax/niceforms.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(url_temp);
      out.write("javascript/include/nseergrid/nseergrid.js\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(url_temp);
      out.write("css/include/nseergrid/nseergrid_workflow.css\" />\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(url_temp);
      out.write("javascript/include/covers/cover.js'></script>\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("if (window.attachEvent)window.attachEvent(\"onload\",function(){document.all('LoadProcess_head').style.visibility =\"hidden\";document.all('mengban_head').style.visibility = \"hidden\";document.all('ifra_head').style.visibility = \"hidden\";});\r\n");
      out.write("if (window.addEventListener)window.addEventListener(\"load\",function(){document.all('LoadProcess_head').style.visibility = \"hidden\";document.all('mengban_head').style.visibility = \"hidden\";document.all('ifra_head').style.visibility = \"hidden\";},false)\r\n");
      out.write("</script>\r\n");
      out.write("<style>\r\n");
      out.write(".mengban_head{ \r\n");
      out.write("position:absolute;\r\n");
      out.write("height:100%;\r\n");
      out.write("z-index:10;\r\n");
      out.write("top:0;\r\n");
      out.write("left:0;\r\n");
      out.write("background-color:#CECECE;\r\n");
      out.write("width:100%;\r\n");
      out.write("visibility: visible;\r\n");
      out.write("filter:alpha(opacity=10);\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("<iframe id=\"ifra_head\" style=\"filter:alpha(opacity=0);position:absolute;width:expression(this.nextSibling.offsetWidth);height:expression(this.nextSibling.offsetHeight);top:expression(this.nextSibling.offsetTop);left:expression(this.nextSibling.offsetLeft);\" frameborder=\"0\" ></iframe>\r\n");
      out.write("<div class=\"mengban_head\" id=\"mengban_head\"></div>\r\n");
      out.write("<div  id=\"LoadProcess_head\" style=\"position:absolute; left:40%; top:111px; width:280px; height:50px; z-index:1;z-index:11;\"> \r\n");
      out.write("  <div align=center style=\"color:#000000;border:1px solid #ffffff;height:50px;padding:5px 0px 0px 0px\" id=\"id2\"><img src=\"");
      out.print(url_temp);
      out.write("images/include/indicator_medium.gif\">请稍候......</div>\r\n");
      out.write("</div>\r\n");
      out.write("<script>setGradient('id2','#BFBBF4','#ffffff',1);</script>\r\n");

}

      out.write("\r\n");
      out.write("<body bgcolor=\"#E9F8F3\" oncontextmenu=\"event.returnValue=true\" style=\"background-image:url(/erp/images/lili.gif)\">\r\n");

String TABLE_STYLE11="bordercolor=#000000 bordercolorlight=#848284 bordercolordark=#ffffff border=1 cellspacing=0 cellpadding=0 align=center";
String TABLE_STYLE1="bordercolor=#25CB0E bordercolorlight=#000000 bordercolordark=#000000 border=0 cellspacing=1 cellpadding=1 bgcolor=#EEEEEE align=center";
String TABLE_STYLE2="";
String TABLE_STYLE3="";
String TABLE_STYLE4="align=center";
String TABLE_STYLE5="bordercolor=#000000 bordercolorlight=#848284 bordercolordark=#eeeeee border=1 cellspacing=0 cellpadding=0 align=center";
String TABLE_STYLE6="align=center";
String TABLE_STYLE7="bordercolor=#25CB0E  bordercolorlight=#000000 bordercolordark=#000000 border=0 cellspacing=1 cellpadding=1 bgcolor=#E3E3E3 align=center";//书签
String TR_STYLE1="height=20";
String TR_STYLE2="height=20 bgcolor=#D2E9FF";
String TD_STYLE1="bordercolorlight=#848284 bordercolordark=#ffffff align=right";
String TD_STYLE2="bordercolor=#DEDBD6 align=left";
String TD_STYLE11="bgcolor=#D2E9FF bordercolorlight=#000000 bordercolordark=#000000 align=left height=20";
String TD_STYLE21="valign=top bgcolor=#ffffff bordercolor=#000000";
String TD_STYLE3="";
String TD_STYLE4="bgcolor=#D2E9FF bordercolorlight=#000000 bordercolordark=#000000 align=right";//档案类
String TD_STYLE5="align=center height=5";
String TD_STYLE6="bordercolor=#DEDBD6 align=right";
String TD_STYLE7="";
String TD_STYLE8="";
String INPUT_STYLE1="";
String INPUT_STYLE3="";
String INPUT_STYLE4="";
String INPUT_STYLE5="";
String SUBMIT_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String BUTTON_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RESET_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String FILE_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RADIO_STYLE1="";
String CHECKBOX_STYLE1="";
String SELECT_STYLE1="";
String SELECT_STYLE2="size=1";
String TEXTAREA_STYLE1="rows=4";
String DIV_STYLE1="";
String DIV_STYLE2="";
String TD_HANDBOOK_STYLE1="";
String table_width="100%";

      out.write('\r');
      out.write('\n');
      out.write('\r');
      out.write('\n');

ServletContext context1=session.getServletContext();
String msg_path=context1.getRealPath("/");//得erp所在路径
String uname1=(String)session.getAttribute("realeditorc");
String url_temp="";
String file_url=request.getRequestURI();
for(int _msg_i=0;_msg_i<file_url.split("/").length-3;_msg_i++){
	url_temp+="../";
}
msg_path=msg_path.replaceAll("\\\\","/")+"xml/include/msg";

      out.write("\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(url_temp);
      out.write("javascript/include/div/alert.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(url_temp);
      out.write("javascript/include/div/divViewChange.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(url_temp);
      out.write("javascript/include/covers/cover.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(url_temp);
      out.write("dwr/engine.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(url_temp);
      out.write("dwr/util.js'></script>\r\n");
      out.write("<script type='text/javascript' src='");
      out.print(url_temp);
      out.write("dwr/interface/OperateXML.js'></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("function msg_close(){\r\n");
      out.write("DWREngine.setAsync(true);\r\n");
      out.write("OperateXML.msgUpdateXml('");
      out.print(msg_path);
      out.write('\\');
      out.write('\\');
      out.print(uname1);
      out.write(".xml','0','tag','0',{callback:function(str){\r\n");
      out.write("document.getElementById('window_id_1').style.display='none';\t\r\n");
      out.write("}});\r\n");
      out.write("DWREngine.setAsync(true);\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<script language=javascript src=\"");
      out.print(url_temp);
      out.write("javascript/winopen/winopen.js\"></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/JavaScript\" src=\"");
      out.print(url_temp);
      out.write("javascript/include/iframe/ifr.js\"></script>\r\n");
      out.write("<link href=\"");
      out.print(url_temp);
      out.write("css/msg/themes/default.css\" rel=\"stylesheet\" type=\"text/css\" ></link>\r\n");
      out.write("<link href=\"");
      out.print(url_temp);
      out.write("css/msg/themes/mac_os_x.css\" rel=\"stylesheet\" type=\"text/css\" ></link>\r\n");
      out.write("<DIV class=dialog id=\"window_id_1\" nseerDef=\"dragAble\" style=\"display:none;FILTER: ;WIDTH: 332px; HEIGHT: 300px;z-index:5\">\r\n");
      out.write("<DIV class=mac_os_x_minimize id=\"collapse\" onclick=\"n_D.minDiv(40)\"  onmouseover=\"n_D.mmcMouseStyle(this);\"></DIV>\r\n");
      out.write("<DIV class=mac_os_x_maximize id=\"expand\" onclick=\"n_D.maxDiv()\"  onmouseover=\"n_D.mmcMouseStyle(this);\"></DIV>\r\n");
      out.write("<DIV class=mac_os_x_close id=window_id_1_close onclick=\"msg_close()\"  onmouseover=\"n_D.mmcMouseStyle(this);\"></DIV>\r\n");
      out.write("<TABLE class=\"top table_window\" id=window_id_1_row1 >\r\n");
      out.write("<TBODY  height=\"100%\">\r\n");
      out.write("<TR>\r\n");
      out.write("<TD class=\"mac_os_x_nw top_draggable\"></TD>\r\n");
      out.write("<TD class=mac_os_x_n>\r\n");
      out.write("<DIV class=\"mac_os_x_title title_window top_draggable\" id=window_id_1_top style=\"text-align:left\">川大科技即时通讯</DIV></TD>\r\n");
      out.write("<TD class=\"mac_os_x_ne top_draggable\"></TD></TR></TBODY></TABLE>\r\n");
      out.write("<TABLE class=\"mid table_window\" id=window_id_1_row2  height=\"80%\">\r\n");
      out.write("<TBODY>\r\n");
      out.write("<TR>\r\n");
      out.write("<TD class=mac_os_x_w></TD>\r\n");
      out.write("<TD class=mac_os_x_content id=window_id_1_table_content vAlign=top>\r\n");
      out.write("<DIV class=mac_os_x_content id=window_id_1_content style=\"WIDTH: 100%; HEIGHT: 100% ;background:#66CCFF;overflow:auto\">\r\n");
      out.write("<script type=\"text/JavaScript\">ifr('");
      out.print(url_temp);
      out.write("/include/msg.jsp','100%','100%','window_id_1');</script>\r\n");
      out.write("</DIV></TD>\r\n");
      out.write("<TD class=mac_os_x_e></TD></TR></TBODY></TABLE>\r\n");
      out.write("<TABLE class=\"bot table_window\" id=window_id_1_row3 width=\"100%\">\r\n");
      out.write("<TBODY>\r\n");
      out.write("<TR>\r\n");
      out.write("<TD class=\"mac_os_x_sw bottom_draggable\"></TD>\r\n");
      out.write("<TD class=\"mac_os_x_s bottom_draggable\">\r\n");
      out.write("<DIV class=status_bar id=window_id_1_bottom><SPAN style=\"FLOAT: left; WIDTH: 1px; HEIGHT: 1px\"></SPAN></DIV></TD>\r\n");
      out.write("<TD class=\"mac_os_x_sizer bottom_draggable\" id=window_id_1_sizer></TD></TR></TBODY></TABLE></DIV>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function msgView(){\r\n");
      out.write("var win=document.getElementById('window_id_1');\r\n");
      out.write("win.style.top=(document.body.clientHeight-parseInt(win.style.height))+'px';\r\n");
      out.write("win.style.left=(document.body.clientWidth-parseInt(win.style.width))+'px';\r\n");
      out.write("win.style.display='block';\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function msgViewClose(){\r\n");
      out.write("var win=document.getElementById('window_id_1');\r\n");
      out.write("win.style.display='none';\r\n");
      out.write("}\r\n");
      out.write("function open_msg(){\r\n");
      out.write("document.getElementById('msm_cont1').value='';\r\n");
      out.write("\r\n");
      out.write("var xmlhttp3;\r\n");
      out.write("if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){\r\n");
      out.write("xmlhttp3=new ActiveXObject(\"Microsoft.XMLHTTP\");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {\r\n");
      out.write("if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("var xm=xmlhttp3.responseText.replace(/(^\\s*)|(\\s*$)/g, \"\").split(',');\r\n");
      out.write("var input_html=\"\";\r\n");
      out.write("for(var i=0;i<xm.length;i++){\r\n");
      out.write("input_html+=\"<INPUT TYPE=\\\"checkbox\\\" NAME=\\\"human_msg_name\\\" value=\"+xm[i].split(\"⊙\")[0]+\" ><A HREF=javascript:winopen(\\'");
      out.print(url_temp);
      out.write("hr/file/query.jsp?human_ID=\"+xm[i].split(\"⊙\")[1]+\"\\')>\"+xm[i].split(\"⊙\")[0]+\"</A>\";\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("document.getElementById('human_msg').innerHTML=input_html;\r\n");
      out.write("Reply(false);\r\n");
      out.write("}else {\r\n");
      out.write("alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};\r\n");
      out.write("xmlhttp3.open(\"POST\", \"");
      out.print(url_temp);
      out.write("include/ajax_query.jsp\", true);\r\n");
      out.write("xmlhttp3.setRequestHeader(\"Content-Type\", \"application/x-www-form-urlencoded\");\t\r\n");
      out.write("xmlhttp3.send();\t\t\t\t\r\n");
      out.write("} else {alert('Can not create XMLHttpRequest object, please check your web browser.');}\r\n");
      out.write("}\r\n");
      out.write("function Reply(msg_tag){\r\n");
      out.write("document.getElementById('msm_cont1').value='';\r\n");
      out.write("if(msg_tag)document.getElementById('human_msg').innerHTML='';\r\n");
      out.write("var msm=document.getElementById('msm1');\r\n");
      out.write("msm.style.display='block';\r\n");
      out.write("var w=(parseInt(document.body.clientWidth)-parseInt(msm.style.width))/2+\"px\";\r\n");
      out.write("var h=(document.body.clientHeight-parseInt(msm.style.height))/2+\"px\";\r\n");
      out.write("msm.style.position='absolute';\r\n");
      out.write("msm.style.top=h;\r\n");
      out.write("msm.style.left=w;\r\n");
      out.write("}\r\n");
      out.write("function send_msm(filename){\r\n");
      out.write("var from_name='';\r\n");
      out.write("var name='");
      out.print(uname1);
      out.write("';\r\n");
      out.write("var cont=document.getElementById('msm_cont1').value;\r\n");
      out.write("cont=cont.replace(/[&]/g,'◎');\r\n");
      out.write("\r\n");
      out.write("if(document.getElementById('human_msg').innerHTML==''){\r\n");
      out.write("from_name=window.frames['ssg_ifr'].document.getElementById('from_name').innerHTML+',';//给谁发送\r\n");
      out.write("}else{\r\n");
      out.write("\r\n");
      out.write("var human_msg_name=document.getElementsByName('human_msg_name');\r\n");
      out.write("\r\n");
      out.write("for(var i=0;i<human_msg_name.length;i++){\r\n");
      out.write("if(human_msg_name[i].checked){\r\n");
      out.write("\r\n");
      out.write("from_name+=human_msg_name[i].value+',';\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("if(from_name==null||from_name==''||from_name==','){\r\n");
      out.write("\r\n");
      out.write("alert('您没有选择目标用户');\r\n");
      out.write("\r\n");
      out.write("return false;\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("if(filename==null||filename==''||filename=='undefined') filename='⊙';\r\n");
      out.write("if(cont==null||cont==''||cont=='undefined')cont='⊙';\r\n");
      out.write("var xmlhttp3;\r\n");
      out.write("if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){\r\n");
      out.write("xmlhttp3=new ActiveXObject(\"Microsoft.XMLHTTP\");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {\r\n");
      out.write("if (xmlhttp3.readyState==4){\r\n");
      out.write("try {\r\n");
      out.write("if(xmlhttp3.status==200) {\r\n");
      out.write("if(filename=='⊙')n_A.divShow('发送成功');\r\n");
      out.write("\r\n");
      out.write("document.getElementById('msm1').style.display='none';\r\n");
      out.write("\r\n");
      out.write("}else {\r\n");
      out.write("alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}\r\n");
      out.write("} catch(exception) {alert(exception);}\r\n");
      out.write("}\r\n");
      out.write("};\r\n");
      out.write("xmlhttp3.open(\"POST\", \"");
      out.print(url_temp);
      out.write("/include/createMsgXml.jsp\", true);\r\n");
      out.write("xmlhttp3.setRequestHeader(\"Content-Type\", \"application/x-www-form-urlencoded\");\t\r\n");
      out.write("xmlhttp3.send('name='+name+'&&cont='+cont+'&&from_name='+from_name+'&&filename='+filename);\t\t\t\t\r\n");
      out.write("} else {alert('Can not create XMLHttpRequest object, please check your web browser.');}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<DIV class=dialog id=\"msm1\" nseerDef=\"dragAble\" style=\"display:none;FILTER: ;WIDTH: 502px; HEIGHT: 400px;z-index:5\" >\r\n");
      out.write("<iframe src=\"javascript:false\" style=\"position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';\"></iframe>\r\n");
      out.write("<DIV class=mac_os_x_minimize id=\"collapse\" onclick=\"n_D.minDiv(40)\"  onmouseover=\"n_D.mmcMouseStyle(this);\"></DIV>\r\n");
      out.write("<DIV class=mac_os_x_maximize id=\"expand\" onclick=\"n_D.maxDiv()\"  onmouseover=\"n_D.mmcMouseStyle(this);\"></DIV>\r\n");
      out.write("<DIV class=mac_os_x_close id=window_id_1_close onclick=\"n_D.closeDiv('hidden')\"  onmouseover=\"n_D.mmcMouseStyle(this);\"></DIV>\r\n");
      out.write("<TABLE class=\"top table_window\" id=window_id_1_row1 >\r\n");
      out.write("<TBODY  height=\"100%\">\r\n");
      out.write("<TR>\r\n");
      out.write("<TD class=\"mac_os_x_nw top_draggable\"></TD>\r\n");
      out.write("<TD class=mac_os_x_n>\r\n");
      out.write("<DIV class=\"mac_os_x_title title_window top_draggable\" id=window_id_1_top style=\"text-align:left\">川大科技即时通讯</DIV></TD>\r\n");
      out.write("<TD class=\"mac_os_x_ne top_draggable\"></TD></TR></TBODY></TABLE>\r\n");
      out.write("<TABLE class=\"mid table_window\" id=window_id_1_row2_a  height=\"80%\">\r\n");
      out.write("<TBODY>\r\n");
      out.write("<TR>\r\n");
      out.write("<TD class=mac_os_x_w></TD>\r\n");
      out.write("<TD class=mac_os_x_content id=window_id_1_table_content vAlign=top>\r\n");
      out.write("<DIV class=mac_os_x_content id=window_id_1_content style=\"WIDTH: 100%; HEIGHT: 100% ;background:#66CCFF;overflow:auto\">\r\n");
      out.write("<table width=\"100%\" height=\"100%\">\r\n");
      out.write("<tr>\r\n");
      out.write("<td>\r\n");
      out.write("<div id=\"human_msg\">\r\n");
      out.write("</div></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr style=\"width:100%\">\r\n");
      out.write("<td style=\"width:100%;height:100%\" colspan=\"2\">\r\n");
      out.write("<textarea  rows=10  style=\"width:100%;height:100%;\" name=\"msm_cont1\"></textarea>\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td  colspan=\"2\" align=\"right\">\r\n");
      out.write("<input type=button ");
      out.print(SUBMIT_STYLE1);
      out.write(" class=\"SUBMIT_STYLE1\" onclick=\"send_msm()\" value=\"发送\">\r\n");
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<div id=\"file_status\"></div>\r\n");
      out.write("</DIV></TD>\r\n");
      out.write("<TD class=mac_os_x_e></TD></TR></TBODY></TABLE>\r\n");
      out.write("<TABLE class=\"bot table_window\" id=window_id_1_row3 width=\"100%\">\r\n");
      out.write("<TBODY>\r\n");
      out.write("<TR>\r\n");
      out.write("<TD class=\"mac_os_x_sw bottom_draggable\"></TD>\r\n");
      out.write("<TD class=\"mac_os_x_s bottom_draggable\">\r\n");
      out.write("<DIV class=status_bar id=window_id_1_bottom><SPAN style=\"FLOAT: left; WIDTH: 1px; HEIGHT: 1px\"></SPAN></DIV></TD>\r\n");
      out.write("<TD class=\"mac_os_x_sizer bottom_draggable\" id=window_id_1_sizer></TD></TR></TBODY></TABLE></DIV>\r\n");
      out.write('\r');
      out.write('\n');
      out.write('\r');
      out.write('\n');
      include.tree_index.businessComment demo = null;
      synchronized (pageContext) {
        demo = (include.tree_index.businessComment) pageContext.getAttribute("demo", PageContext.PAGE_SCOPE);
        if (demo == null){
          demo = new include.tree_index.businessComment();
          pageContext.setAttribute("demo", demo, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');
      include.nseer_cookie.ReadXmlLength xml = null;
      synchronized (pageContext) {
        xml = (include.nseer_cookie.ReadXmlLength) pageContext.getAttribute("xml", PageContext.PAGE_SCOPE);
        if (xml == null){
          xml = new include.nseer_cookie.ReadXmlLength();
          pageContext.setAttribute("xml", xml, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');
 DealWithString DealWithString=new DealWithString(application);
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
      out.write('\r');
      out.write('\n');

String dbase="";
String module="";
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
Nseer n=new Nseer();
String human_name=exchange.unURL(request.getParameter("human_name"));
String human_ID=request.getParameter("human_ID");
String choose_value_group=exchange.unURL(request.getParameter("choose_value_group"));
String choose_value=request.getParameter("choose_value");
MaxKind max=new MaxKind((String)session.getAttribute("unit_db_name"),choose_value.split("/")[0]+"_tree","file_id");
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
path=path+"xml\\hr\\config\\file\\tree-config.xml";
int first_length=2;
int step_length=2;
int kind_rows=KindDeep.getDeep(max.maxValue("file_id"),first_length,step_length);
kind_rows=kind_rows-1;
max.close();

StringTokenizer tokenTO = new StringTokenizer(choose_value,"/"); 
	while(tokenTO.hasMoreTokens()) {
 dbase = tokenTO.nextToken();
		module = tokenTO.nextToken();
		}
if(choose_value_group==null) choose_value_group="";
int a=choose_value_group.indexOf(dbase);
if(a==-1){
	try{

      out.write("\r\n");
      out.write("<form method=\"post\" id=\"keyRegister\" name=\"selectList\" action=\"security_license_register_module_ok\">  \r\n");
      out.write("<table ");
      out.print(TABLE_STYLE2);
      out.write(" class=\"TABLE_STYLE2\">\r\n");
      out.write(" <tr ");
      out.print(TR_STYLE1);
      out.write(" class=\"TR_STYLE1\">\r\n");
      out.write(" <td ");
      out.print(TD_HANDBOOK_STYLE1);
      out.write(" class=\"TD_HANDBOOK_STYLE1\"><div class=\"div_handbook\">");
      out.print(handbook);
      out.write("</div></td>\r\n");
      out.write(" </tr>\r\n");
      out.write("</table>      \r\n");
      out.write("<table ");
      out.print(TABLE_STYLE2);
      out.write(" class=\"TABLE_STYLE2\">\r\n");
      out.write("\t<tr ");
      out.print(TR_STYLE1);
      out.write(" class=\"TR_STYLE1\">\r\n");
      out.write(" <td ");
      out.print(TD_STYLE3);
      out.write(" class=\"TD_STYLE3\">\r\n");
      out.write(" <div ");
      out.print(DIV_STYLE1);
      out.write(" class=\"DIV_STYLE1\"><input type=\"button\" ");
      out.print(BUTTON_STYLE1);
      out.write(" class=\"BUTTON_STYLE1\" value=\"");
      out.print(demo.getLang("erp","全选"));
      out.write("\" id=\"check\" onClick=\"selAl()\">&nbsp;<input type=\"submit\" ");
      out.print(SUBMIT_STYLE1);
      out.write(" class=\"SUBMIT_STYLE1\" value=\"");
      out.print(demo.getLang("erp","提交"));
      out.write("\" name=\"B1\"> <input type=\"button\" ");
      out.print(BUTTON_STYLE1);
      out.write(" class=\"BUTTON_STYLE1\" value=\"");
      out.print(demo.getLang("erp","返回"));
      out.write("\" onClick=\"history.back()\"></div>\r\n");
      out.write(" </td>\r\n");
      out.write(" </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<div id=\"nseer_grid_div\"></div>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("function id_link(link){\r\n");
      out.write("document.location.href=link;\r\n");
      out.write("}\r\n");
      out.write("var nseer_grid = new nseergrid();\r\n");
      out.write("nseer_grid.callname = \"nseer_grid\";\r\n");
      out.write("nseer_grid.parentNode = nseer_grid.$(\"nseer_grid_div\");\r\n");
      out.write("\r\n");
      out.write("nseer_grid.columns =[\r\n");
      out.write(" ");

for(int i=1;i<=kind_rows;i++){
if(i!=kind_rows){
      out.write("\r\n");
      out.write("  {name: '");
      out.print(i);
      out.print(demo.getLang("erp","级模块"));
      out.write("'},\r\n");
}else{
      out.write("\r\n");
      out.write(" {name: '");
      out.print(i);
      out.print(demo.getLang("erp","级模块"));
      out.write("'}\r\n");
}}
      out.write("    \r\n");
      out.write("              \r\n");
      out.write("]\r\n");
      out.write("nseer_grid.column_width=[\r\n");

for(int i=1;i<=kind_rows;i++){
if(i!=kind_rows){
      out.write("\r\n");
      out.write(" 250,\r\n");
}else{
      out.write("\r\n");
      out.write(" 250\r\n");
}}
      out.write("   ];\r\n");
      out.write("nseer_grid.auto='");
      out.print(demo.getLang("erp","3级模块"));
      out.write("';\r\n");
      out.write("nseer_grid.data = [\r\n");

String sql1="select * from "+choose_value.split("/")[0]+"_tree where workflow_tag='0' order by file_id" ;
ResultSet rs1=db.executeQuery(sql1);
rs1.next();
while(rs1.next()){
String file_id=rs1.getString("file_id").trim();
int len=KindDeep.getDeep(file_id,2,2);
len=len-2;
if(!rs1.getString("hreflink").equals("")||rs1.getInt("details_tag")==1){
	String sql="select id from "+choose_value.split("/")[0]+"_view where human_ID='"+human_ID+"' and file_id='"+rs1.getString("file_id")+"'";
	ResultSet rs=db1.executeQuery(sql);
	if(rs.next()){

      out.write('\r');
      out.write('\n');

String str="";	
for(int i=0;i<kind_rows;i++){
if(len==i){
	str+="'<input type=\"checkbox\" name=\"file_id\" value="+rs1.getString("file_id")+" onclick=\"select_value(this)\" checked>"+rs1.getString("file_name")+"',";
}else{
   str+="'',";
}
}
str=str.substring(0,str.length()-1);

      out.write('\r');
      out.write('\n');
      out.write('[');
      out.print(str);
      out.write("],\r\n");
}else{
      out.write('\r');
      out.write('\n');

String str1="";	
for(int i=0;i<kind_rows;i++){
if(len==i){
	str1+="'<input type=\"checkbox\" name=\"file_id\" value="+rs1.getString("file_id")+" onclick=\"select_value(this)\" >"+rs1.getString("file_name")+"',";
}else{
   str1+="'',";
}
}
str1=str1.substring(0,str1.length()-1);

      out.write('\r');
      out.write('\n');
      out.write('[');
      out.print(str1);
      out.write("],\r\n");

}
}}

      out.write("\r\n");
      out.write("['']];\r\n");
      out.write("nseer_grid.init();\r\n");
      out.write("</script>\r\n");
      out.write("<div id=\"drag_div\"></div>\r\n");
      out.write("<div id=\"point_div_t\"></div>\r\n");
      out.write("<div id=\"point_div_b\"></div>\r\n");
      out.write("<input type=\"hidden\" name=\"choose_value_group\" value=\"");
      out.print(exchange.toHtml(choose_value_group));
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"human_ID\" value=\"");
      out.print(human_ID);
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"human_name\" value=\"");
      out.print(exchange.toHtml(human_name));
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"dbase\" value=\"");
      out.print(exchange.toHtml(dbase));
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"module\" value=\"");
      out.print(exchange.toHtml(module));
      out.write("\">\r\n");
      out.write("<input type=\"hidden\" name=\"");
      out.print(Globals.TOKEN_KEY);
      out.write("\" value=\"");
      out.print(session.getAttribute(Globals.TOKEN_KEY));
      out.write("\">\r\n");
      out.write("</form>\r\n");

db.close();
db1.close();
}catch(Exception ex){ex.printStackTrace();}

      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("function select_value(s){\r\n");
      out.write("var value_length=s.value.length;\r\n");
      out.write("if(s.checked){\r\n");
      out.write("var checkbox_array=document.getElementsByTagName('input');\r\n");
      out.write("for(var i=0;i<checkbox_array.length;i++){\r\n");
      out.write("if(checkbox_array[i].type=='checkbox'&&checkbox_array[i].value.substring(0,value_length)==s.value&&checkbox_array[i].value.length>value_length){\r\n");
      out.write("checkbox_array[i].checked=true;\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("}else{\r\n");
      out.write("var checkbox_array=document.getElementsByTagName('input');\r\n");
      out.write("for(var i=0;i<checkbox_array.length;i++){\r\n");
      out.write("if(checkbox_array[i].type=='checkbox'&&checkbox_array[i].value.substring(0,value_length)==s.value&&checkbox_array[i].value.length>value_length){\r\n");
      out.write("checkbox_array[i].checked=false;\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("} \r\n");
      out.write("function selAl(){\r\n");
      out.write("var checkbox_array=document.getElementsByTagName('input');\r\n");
      out.write("if(document.getElementById('check').value=='反选'){\r\n");
      out.write("for(var i=0;i<checkbox_array.length;i++){\r\n");
      out.write("if(checkbox_array[i].type=='checkbox'){\r\n");
      out.write("checkbox_array[i].checked=false;\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("document.getElementById('check').value='全选';\r\n");
      out.write("}else{\r\n");
      out.write("for(var i=0;i<checkbox_array.length;i++){\r\n");
      out.write("if(checkbox_array[i].type=='checkbox'){\r\n");
      out.write("checkbox_array[i].checked=true;\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("document.getElementById('check').value='反选';\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
}else{
      out.write("\r\n");
      out.write("<table ");
      out.print(TABLE_STYLE2);
      out.write(" class=\"TABLE_STYLE2\">\r\n");
      out.write(" <tr ");
      out.print(TR_STYLE1);
      out.write(" class=\"TR_STYLE1\">\r\n");
      out.write(" <td ");
      out.print(TD_HANDBOOK_STYLE1);
      out.write(" class=\"TD_HANDBOOK_STYLE1\"><div class=\"div_handbook\">");
      out.print(handbook);
      out.write("</div></td>\r\n");
      out.write(" </tr>\r\n");
      out.write("</table>\r\n");
      out.write(" <div id=\"nseerGround\" class=\"nseerGround\">\r\n");
      out.write("<table ");
      out.print(TABLE_STYLE2);
      out.write(" class=\"TABLE_STYLE2\">\r\n");
      out.write("\t<tr ");
      out.print(TR_STYLE1);
      out.write(" class=\"TR_STYLE1\">\r\n");
      out.write(" <td ");
      out.print(TD_STYLE3);
      out.write(" class=\"TD_STYLE3\">\r\n");
      out.write(" <div ");
      out.print(DIV_STYLE1);
      out.write(" class=\"DIV_STYLE1\"><input type=\"button\" ");
      out.print(BUTTON_STYLE1);
      out.write(" class=\"BUTTON_STYLE1\" value=\"");
      out.print(demo.getLang("erp","返回"));
      out.write("\" onClick=\"history.back()\"></div>\r\n");
      out.write(" </td>\r\n");
      out.write(" </tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table ");
      out.print(TABLE_STYLE2);
      out.write(" class=\"TABLE_STYLE2\">\r\n");
      out.write("\t<tr ");
      out.print(TR_STYLE1);
      out.write(" class=\"TR_STYLE1\">\r\n");
      out.write("<td ");
      out.print(TD_STYLE3);
      out.write(" class=\"TD_STYLE3\">");
      out.print(module);
      out.print(demo.getLang("erp","已经分配了权限，请返回重新选择！"));
      out.write("</td>\r\n");
      out.write(" </tr>\r\n");
      out.write("</table>\r\n");
      out.write("</div>\r\n");
}


}catch(Exception ex){
	ex.printStackTrace();
}
}
}