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


public class  Node1
{

private static String s="";
private static String t="";

public static String add(String str) {
{
try{           
s=str;   
String a=s.substring(45,46);			
String b=s.substring(18,19);			
String c=s.substring(31,32);			
String d=s.substring(9,10);//e		
String e=s.substring(17,18);			
String f=s.substring(21,22);			
String g=s.substring(12,13);			
String h=s.substring(7,8);			
String i=s.substring(20,21);			
String j=s.substring(5,6);			
t="";
String[] f1={a+b+c+d+e+d+f,g+h,i+j+d+d+e,d+e+a};
for(int i1=0;i1<f1.length;i1++){
t+=f1[i1]+" ";
}
}catch(Exception exception)
        {
            exception.printStackTrace();
        }

return t;


    }
}
}

