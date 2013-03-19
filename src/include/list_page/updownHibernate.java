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
import filetree.NseerFileTree;
/**
 * 分页显示的辅助程序
 * 用作跳页
 */
public class updownHibernate extends TagSupport {

   private String file="";
   private String sql="";
   private int num=0;
   private int intPage=0;
   private int pageRow=0;

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

   public int getIntPage() {
     return intPage;
   }

   public void setIntPage(int intPage) {
     this.intPage=intPage;
   }

    public int getPageRow() {
     return pageRow;
   }

   public void setPageRow(int pageRow) {
     this.pageRow=pageRow;
   }

    public String getSql() {
     return sql;
   }

   public void setSql(String sql) {
	   this.sql=sql;
   }

   public int doStartTag() throws JspException {

  int PageCount=(num+pageRow-1) /pageRow;
  HttpServletRequest request=(HttpServletRequest) pageContext.getRequest();
  businessComment demo=new businessComment();
  demo.setPath(request);
  String escape_sql=NseerFileTree.escape(sql);
   try {
		 pageContext.getOut().print(demo.getLang("erp","总数：")+num+demo.getLang("erp","例")+" &nbsp;&nbsp;&nbsp;");
   if (intPage> 1) {
         pageContext.getOut().print("<A href=\""+file+"?page="+new Integer(intPage-1).toString()+"&&nseer_sql="+escape_sql+"\"><font color=\"#000000\">"+demo.getLang("erp","上一页")+"</font></A> &nbsp;&nbsp;&nbsp;");
    }
         pageContext.getOut().print(demo.getLang("erp","当前第")+intPage+demo.getLang("erp","页")+"  &nbsp;&nbsp;&nbsp;");
   if (intPage < PageCount) {
         pageContext.getOut().print("<A href=\""+file+"?page="+new Integer(intPage+1).toString()+"&&nseer_sql="+escape_sql+"\"><font color=\"#000000\">"+demo.getLang("erp","下一页")+"</font></A> &nbsp;&nbsp;&nbsp;");
    }
         pageContext.getOut().print(demo.getLang("erp","共")+PageCount+demo.getLang("erp","页")+"  &nbsp;&nbsp;&nbsp;"+demo.getLang("erp","跳到第")+" <input id=nseer_page type=text class=input1 size=1> "+demo.getLang("erp","页")+"&nbsp;&nbsp;"+"<img  src=\"/erp/images/go.bmp\" width=18 height=18 border=0 onclick=\"nseer_href()\">");	 
		 pageContext.getOut().print("<script>function nseer_href(){window.location.href='query_list.jsp?page='+document.getElementById('nseer_page').value+'&&nseer_sql="+escape_sql+"'}</script>");

   } catch(Exception ioException) {
	   System.err.println("Exception thrown ");
	   throw new JspException(ioException);
   }
   return SKIP_BODY;
  }
}
