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
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ValidatorDup4 extends HttpServlet {

	public void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
		try{
			businessComment demo=new businessComment();
               demo.setPath(request);
			response.setContentType("text/html;charset=UTF-8");
			HttpSession session=request.getSession();
			PrintWriter out=response.getWriter();
			String valued=request.getParameter("valued");
			String values=request.getParameter("valuea");
			String value=request.getParameter("validator_dup");
			String table_name=request.getParameter("valueb");
			String fn=request.getParameter("valuec");

			ValidatorDupBean4 vdb=new ValidatorDupBean4();
			if(vdb.isDup(session,table_name,fn,value,values,valued)){
				out.println(demo.getLang("erp","输入内容重复！"));
			}
		}catch(Exception ex){
		ex.printStackTrace();
		}
	}
}
