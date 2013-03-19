/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.ajax;

import java.io.*;

import java.util.*;

import javax.servlet.*;

import javax.servlet.http.*;

public class GetXml extends HttpServlet {

private static final String CONTENT_TYPE = "text/html; charset=UTF-8";

public void init() throws ServletException {

}

public void doGet(HttpServletRequest request, HttpServletResponse response) throws

ServletException, IOException {

String action = request.getParameter("action");

if (action.equals("add")){

addXml(request,response);

}

}


protected void addXml(HttpServletRequest request,

HttpServletResponse response) throws

ServletException, IOException {


String uniqueID = storeEmployee();


StringBuffer xml = new StringBuffer("<result><uniqueID>");

xml.append(uniqueID);

xml.append("</uniqueID>");

xml.append("<status>1</status>");

xml.append("</result>");

sendResponse(response, xml.toString());

}

private void sendResponse(HttpServletResponse response, String responseText)throws IOException {

response.setContentType("text/xml");

response.getWriter().write(responseText);

}


private String storeEmployee() {

String uniqueID = "";

Random randomizer = new Random(System.currentTimeMillis());

for (int i = 0; i < 8; i++) {

uniqueID += randomizer.nextInt(9);

}
return uniqueID;

}


}


