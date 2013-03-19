/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */

package include.nseer_cookie;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class  TreeMiddle
{
public static void wr(PrintWriter printwriter) {

 {
     try{
            
			printwriter.println(ToHTML.toHtml());
            
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }
}}
