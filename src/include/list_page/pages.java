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
public class pages extends TagSupport {
   private ResultSet rs;
   private String strPage;
   private int PageCount=0;
   private int intPage;

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
   public int doStartTag() throws JspException {
	   if(strPage!=null&&strPage.indexOf("⊙")!=-1){
		   PageCount=new Integer(strPage.split("⊙")[1]);
		   strPage=strPage.split("⊙")[0];
	   }else{
		   PageCount=200000000;
		   strPage="1";
	   }
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
    if( intPage > PageCount )
    intPage = PageCount;
    } catch (Exception e) {}
    pageContext.setAttribute("intPage",new Integer(intPage).toString());
    pageContext.setAttribute("PageCount",new Integer(PageCount).toString());

    return EVAL_BODY_INCLUDE;
	  } // end of if(goorback)
	  } // end of if(rs!=null)
    return SKIP_BODY;
	}

	public int doAfterBody() throws JspException {
	  	boolean goorback=false;
    try{
    	goorback=rs.next();
    } catch (SQLException e) {}
    if ( goorback)
         return EVAL_BODY_AGAIN;
		else
		     return SKIP_BODY;
	}
}
