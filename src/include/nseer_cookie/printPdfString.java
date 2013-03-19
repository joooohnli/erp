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


public class printPdfString{
	
public String printString_four(String print_string,String name1,String customer_name,String name2,String customer_ID) {

String string_length="";
try {//都不带下划线
byte[]   byteStr=print_string.getBytes();
if(byteStr.length<=4)
{
string_length=name1+customer_name+"                                                                       "+name2+customer_ID;
}
else if(byteStr.length>4&&byteStr.length<=6)
{
string_length=name1+customer_name+"                                                                   "+name2+customer_ID;
}
else if(byteStr.length>6&&byteStr.length<=8)
{
string_length=name1+customer_name+"                                                                 "+name2+customer_ID;
}
else if(byteStr.length>14&&byteStr.length<=16)
{
string_length=name1+customer_name+"                                         "+name2+customer_ID;	
}
else if(byteStr.length>10&&byteStr.length<=14)
{
string_length=name1+customer_name+"                                               "+name2+customer_ID;	
}
else if(byteStr.length>8&&byteStr.length<=10)
{
string_length=name1+customer_name+"                                                           "+name2+customer_ID;	
}
else if(byteStr.length>16&&byteStr.length<=18)
{
string_length=name1+customer_name+"                                 "+name2+customer_ID;	
}
else if(byteStr.length>18&&byteStr.length<=20)
{
string_length=name1+customer_name+"                             "+name2+customer_ID;	
}
else if(byteStr.length>20&&byteStr.length<=22)
{
string_length=name1+customer_name+"                         "+name2+customer_ID;	
}
else if(byteStr.length>22&&byteStr.length<=24)
{
string_length=name1+customer_name+"                     "+name2+customer_ID;	
}
} catch (Exception e) {
				e.printStackTrace();
			}
return string_length;
}
		




public String printString_three(String print_string,String name1,String sales_name,String name2,String sales_ID) {

String string_length="";
try {//都不带下划线
//print_string为三个汉字
byte[]   byteStr1=print_string.getBytes();
//System.out.println(byteStr1.length);
if(byteStr1.length<=4)
{
string_length=name1+sales_name+"	                                                                             "+name2+sales_ID;
}
else if(byteStr1.length>4&&byteStr1.length<=6)
{
string_length=name1+sales_name+"                                                                 "+name2+sales_ID;
}
else if(byteStr1.length>6&&byteStr1.length<=8)
{
string_length=name1+sales_name+"                                                               "+name2+sales_ID;
}
else if(byteStr1.length>14&&byteStr1.length<=16)
{
string_length=name1+sales_name+"                                       "+name2+sales_ID;	
}
else if(byteStr1.length>10&&byteStr1.length<=14)
{
string_length=name1+sales_name+"                                             "+name2+sales_ID;	
}
else if(byteStr1.length>8&&byteStr1.length<=10)
{
string_length=name1+sales_name+"                                                         "+name2+sales_ID;	
}
else if(byteStr1.length>16&&byteStr1.length<=18)
{
string_length=name1+sales_name+"                               "+name2+sales_ID;	
}
else if(byteStr1.length>18&&byteStr1.length<=20)
{
string_length=name1+sales_name+"                           "+name2+sales_ID;	
}
else if(byteStr1.length>20&&byteStr1.length<=22)
{
string_length=name1+sales_name+"                       "+name2+sales_ID;	
}
else if(byteStr1.length>22&&byteStr1.length<=24)
{
string_length=name1+sales_name+"                   "+name2+sales_ID;	
}
          

			
			} catch (Exception e) {
				e.printStackTrace();
			}
return string_length;
		}







	}

