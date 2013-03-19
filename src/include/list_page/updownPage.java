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
public class updownPage extends TagSupport {

   private String file="";
   int num=0;
   public String getFile() {
     return file;
   }

   public void setFile(String file) {
     this.file=file;
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
  int pageSize=25;
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
  if(pageContext.getAttribute("pageSize")!=null) {
	  pageSize=Integer.parseInt((String)pageContext.getAttribute("pageSize"));
	  pageContext.removeAttribute("pageSize");
 }
   try {

	   int[] op_value={25,30,35};
	   String ops="";
	   for(int i=0;i<op_value.length;i++){
		   String selected="";
		   if(pageSize==op_value[i]){
			   selected="selected";
		   }
		   ops+="<option value=\""+op_value[i]+"\" "+selected+">"+op_value[i]+"</option>";
	   }
		    pageContext.getOut().print("<div style=\"position:absolute;bottom:0px;\"><form  id=\"_nseer_page_form\" action=\""+file+"\">&nbsp;&nbsp;"+
					                         demo.getLang("erp","总数：")+num+demo.getLang("erp","例")+" &nbsp;&nbsp;&nbsp;"+demo.getLang("erp","每页显示")+" &nbsp;<select name=\"pageSize\" style=\"width:40px;height:18px;\" onchange=\"document.getElementById('_nseer_page_form').submit();\">"+ops+"</select> &nbsp;"+demo.getLang("erp","条")+" &nbsp;&nbsp;&nbsp;");
   if (intPage> 1) {
         pageContext.getOut().print("<A href=\""+file+"?page="+
                                    new Integer(intPage-1).toString()+
                                    "&&pageSize="+new Integer(pageSize).toString()+"\"><font color=\"#000000\">"+demo.getLang("erp","上一页")+"</font></A> &nbsp;&nbsp;&nbsp;");
    }
         pageContext.getOut().print(demo.getLang("erp","当前第")+intPage+demo.getLang("erp","页")+"  &nbsp;&nbsp;&nbsp;");
   if (intPage < PageCount) {
         pageContext.getOut().print("<A href=\""+file+"?page="+new Integer(intPage+1).toString()+
                                    "&&pageSize="+new Integer(pageSize).toString()+"\"><font color=\"#000000\">"+demo.getLang("erp","下一页")+"</font></A> &nbsp;&nbsp;&nbsp;");
    }
         pageContext.getOut().print(demo.getLang("erp","共")+PageCount+demo.getLang("erp","页")+"  &nbsp;&nbsp;&nbsp;"+
                                    "<form id=\"_nseer_page_form\" action=\""+file+"\">"+
                                    demo.getLang("erp","跳到第")+" <input name=page type=text class=input1 size=1 onkeyup=\"_nseer_pageVali(this);\"> "+demo.getLang("erp","页")+"&nbsp;&nbsp;"+
                                    "<input type=image src=\"/erp/images/go.bmp\" width=18 height=18 border=0>&nbsp;&nbsp;"+"</div><script>function _nseer_pageVali(o){if(isNaN(parseInt(o.value))){o.value='';}else{o.value=''+parseInt(o.value);}}</script>");
   } catch(Exception ioException) {
	   System.err.println("Exception thrown ");
	   throw new JspException(ioException);
   }
   return SKIP_BODY;
  }
}
