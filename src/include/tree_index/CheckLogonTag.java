/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.tree_index;

import include.nseer_cookie.MathString;
import include.nseer_cookie.MaxKind;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

public final class CheckLogonTag extends TagSupport
{

    private String a;
    private String database;

    public CheckLogonTag()
    {
        a = "act";
    }

    public int doEndTag()
        throws JspException
    {
        boolean flag = false;
        HttpSession httpsession = pageContext.getSession();
        HttpServletRequest httpservletrequest = (HttpServletRequest)pageContext.getRequest();
        ServletContext servletcontext = httpsession.getServletContext();
        String s = (String)httpsession.getAttribute("usernamec");
        String count = (String)servletcontext.getAttribute((String)httpsession.getAttribute("unit_id"));
        if(httpsession != null && httpsession.getAttribute("human_IDD") != null && servletcontext.getAttribute(s) != null)
        {
            String s1 = a(httpservletrequest.getRequestURI());
            if((new Right(database)).hasRight((String)httpsession.getAttribute("unit_db_name"),(String)httpsession.getAttribute("human_IDD"),s1))
                flag = true;
        }
        if(flag)
            return 6;
        try
        {
            httpservletrequest.setCharacterEncoding("UTF-8");
            pageContext.getOut().print("<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">");
            pageContext.getOut().print("</head><body>");
            pageContext.getOut().print("<font color=black size=2>对不起，您没有得到授权，请返回。<input type=button value=返回 name=B1 style=width: 100; height: 14 onClick=history.back()></font>");
            pageContext.getOut().print("</body></html>");
        }
        catch(IOException ioexception)
        {
            throw new JspException(ioexception.toString());
        }
        return 5;
    }

    public int doStartTag()
        throws JspException
    {
        return 0;
    }

    public String getDatabase()
    {
        return database;
    }

    private String a(String s)
    {
        int i = s.lastIndexOf("/");
        s=s.substring(0,i+1);
        if(s.substring(i+1).indexOf("_") != -1)
            return s.substring(0, i+1)+s.substring(i+1).substring(0,s.substring(i+1).indexOf("_"));
        int j = s.indexOf(".");
        if(j != -1)
            return s.substring(0, j);
        else
            return s;
    }

    public String getName()
    {
        return a;
    }

    public void setDatabase(String s)
    {
        database = s;
    }

    public void setName(String s)
    {
        a = s;
    }
}
