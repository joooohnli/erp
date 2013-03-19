/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.validator;

import include.tree_index.businessComment;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;


public class multiLangValidate{
	businessComment demo=new businessComment();
	WebContext ctx = WebContextFactory.get();
	HttpServletRequest request=ctx.getHttpServletRequest();
	public String dwrGetLang(String table_name,String name){
		String lang="";
		demo.setPath(request);
		try{
		lang=demo.getLang(table_name, name);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return lang;
	}
}
