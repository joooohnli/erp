/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.query;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.lang.reflect.Method;
public class ValidataTag1{

	public String tag ;
	private String dbase="";
	private String className="";
	private String field1="";
	private String field2="";
	private String fieldValue="";



//传入crm_file 返回CrmFile
public static String Transform(String data) {
String[] mtid ={"_a+","_b+","_c+","_d+","_e+","_f+","_g+","_h+","_i+","_j+","_k+","_l+","_m+","_n+","_o+","_p+","_q+","_r+","_s+","_t+","_u+","_v+","_w+","_x+","_y+","_z+"};
String[] replaceValue ={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
String temp=data;
temp = Replace(temp,"_ID","_id");
String s="";
for(int i=0;i<mtid.length;i++)
{
   String regEx=mtid[i];
	Pattern p=Pattern.compile(regEx);
	Matcher m=p.matcher(temp);
	s=m.replaceAll(replaceValue[i]);
	temp=s;
}
String   alpha  =  s.substring(0,1);   
alpha   =  alpha.toUpperCase(); 
s=alpha+s.substring(1,s.length());
 return s;
}

//传入data_value 返回dataValue
public static String Transform1(String data) {
	
data=data.toLowerCase();
String[] mtid ={"_a+","_b+","_c+","_d+","_e+","_f+","_g+","_h+","_i+","_j+","_k+","_l+","_m+","_n+","_o+","_p+","_q+","_r+","_s+","_t+","_u+","_v+","_w+","_x+","_y+","_z+"};
String[] replaceValue ={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
String temp=data;
temp = Replace(temp,"_ID","_id");
String s="";
for(int i=0;i<mtid.length;i++)
{
   String regEx=mtid[i];
	Pattern p=Pattern.compile(regEx);
	Matcher m=p.matcher(temp);
	s=m.replaceAll(replaceValue[i]);
	temp=s;
}

 return s;
}

//传入data_value 返回getDataValue
public static String Transform2(String data) {
	String field="get"+Transform(data);
	return field;
}


public static String Replace(String source,String oldString,String newString) {
	if(source == null) return null;
	 StringBuffer output = new StringBuffer();
		int lengOfsource = source.length();
		 int lengOfold = oldString.length();
		 int posStart = 0;
		  int pos;
		while((pos = source.indexOf(oldString,posStart)) >= 0) {
		      output.append(source.substring(posStart,pos));
		      output.append(newString);
		      posStart = pos + lengOfold;
		 }
		    if(posStart < lengOfsource) {
		      output.append(source.substring(posStart));
		    }
	 return output.toString();
}
}