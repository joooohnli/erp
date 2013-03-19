/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.list_page;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import javax.servlet.http.HttpServletRequest;
import include.tree_index.businessComment;
/**
 * 分页显示的辅助程序
 * 用作跳页
 */
public class updownPagePa extends TagSupport {
   private String para="";
   private String file="";
   int num=0;
   public String getFile() {
     return file;
   }

   public void setFile(String file) {
     this.file=file;
   }

   public String getPara() {
     return para;
   }

   public void setPara(String para) {
     this.para=para;
   }

   public int getNum() {
     return num;
   }

   public void setNum(int num) {
     this.num=num;
   }

   public int doStartTag() throws JspException {




  int intPage=1;
  int PageCount=1;
  HttpServletRequest request=(HttpServletRequest) pageContext.getRequest();
  businessComment demo=new businessComment();
  demo.setPath(request);
  if(pageContext.getAttribute("intPage")!=null) {
  intPage=Integer.parseInt((String)pageContext.getAttribute("intPage"));
  pageContext.removeAttribute("intPage");
  }
  if(pageContext.getAttribute("PageCount")!=null) {
  PageCount=Integer.parseInt((String)pageContext.getAttribute("PageCount"));
  pageContext.removeAttribute("PageCount");
  }
   try {
		    pageContext.getOut().print("<div style=\"position:absolute;bottom:0px;\"><form action=\""+file+"\">"+
					                         demo.getLang("erp","总数：")+num+demo.getLang("erp","例")+" &nbsp;&nbsp;&nbsp;");
   if (intPage> 1) {
         pageContext.getOut().print("<A href=\""+file+"&&page="+
                                    new Integer(intPage-1).toString()+
                                    "\"><font color=\"#000000\">"+demo.getLang("erp","上一页")+"</font></A> &nbsp;&nbsp;&nbsp;");
    }
         pageContext.getOut().print(demo.getLang("erp","当前第")+intPage+demo.getLang("erp","页")+"  &nbsp;&nbsp;&nbsp;");
   if (intPage < PageCount) {
         pageContext.getOut().print("<A href=\""+file+"&&page="+new Integer(intPage+1).toString()+
                                    "\"><font color=\"#000000\">"+demo.getLang("erp","下一页")+"</font></A> &nbsp;&nbsp;&nbsp;");
    }

int v=file.indexOf("?");
String file_str=file.substring(v+1,file.length());
String [] name_value=file_str.split("&&");
String str1="";
for(int i=0;i<name_value.length;i++){

str1+="<input type=\"hidden\" name=\""+name_value[i].split("=")[0]+"\" value=\""+name_value[i].split("=")[1]+"\">";

}

         pageContext.getOut().print(demo.getLang("erp","共")+PageCount+demo.getLang("erp","页")+"  &nbsp;&nbsp;&nbsp;"+
                                    "<form action=\""+file+"\">"+
                                    demo.getLang("erp","跳到第")+" <input name=page type=text class=input1 size=1 onkeyup=\"_nseer_pageVali(this);\"> "+demo.getLang("erp","页")+"&nbsp;&nbsp;"+str1+
									"<input type=image src=\"/erp/images/go.bmp\" width=18 height=18 border=0></div><script>function _nseer_pageVali(o){if(isNaN(parseInt(o.value))){o.value='';}else{o.value=''+parseInt(o.value);}}</script>");
   } catch(Exception ioException) {
	   System.err.println("Exception thrown ");
	   throw new JspException(ioException);
   }
   return SKIP_BODY;
  }
}
