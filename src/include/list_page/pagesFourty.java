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

import java.sql.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
/**
 * 分页标签的程序
 * 
 */
public class pagesFourty extends TagSupport {
private ResultSet rs;
private String strPage;
  private int PageSize;       //页面显示的条数
  private int RowTotalCount=0;//所有记录的条数
   private int PageCount=0;
   private int intPage;
   private int i;
   private int line=0;
   private int index;
   private int last;

   public ResultSet getrs() {
       return this.rs;
   }
   public void setrs(ResultSet rs) {
       this.rs=rs;
   }
   public String getstrPage() {
	   return this.strPage;
   }
   public void setstrPage(String strPage) {
	   this.strPage=strPage;
   }
   public int getPageSize() {
	   return this.PageSize;
   }
   public void setPageSize(int PageSize) {
	   this.PageSize=PageSize;
   }
   public int doStartTag() throws JspException {

   if((strPage == null)||(strPage.equals(""))||strPage.length()>9)
   {
     strPage="1";
     intPage=1;
   }
   else{
    intPage=Integer.parseInt(strPage);
    if( intPage < 1) intPage=1;
    }
   if(rs!=null) {
  	boolean goorback=false;
  	try {
  		goorback=rs.next();
  	} catch (SQLException e) {}
    if(goorback) {
    try {
    rs.last();
    RowTotalCount=rs.getRow();
    PageCount = (RowTotalCount+40-1) /40;
    if( intPage > PageCount )
    intPage = PageCount;
     rs.absolute((intPage-1)*40 + 1);
    } catch (SQLException e) {}
    pageContext.setAttribute("intPage",new Integer(intPage).toString());
    pageContext.setAttribute("PageCount",new Integer(PageCount).toString());
    index= (intPage-1)*40 + 1;
    last= intPage*40 + 1;

    return EVAL_BODY_INCLUDE;
	  } // end of if(goorback)
	  } // end of if(rs!=null)
    return SKIP_BODY;
	}

	public int doAfterBody() throws JspException {
    try{
    rs.next();
    } catch (SQLException e) {}
		index++;
    if ( index < last && index <=RowTotalCount)
         return EVAL_BODY_AGAIN;
		else
		     return SKIP_BODY;
	}
}
