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


public class toGb2312String {

public String toGb2312String(String s) {///源于网上 
StringBuffer sb = new StringBuffer(); 
for (int i=0;i<s.length();i++) { 
char c = s.charAt(i); 
if (c >= 0 && c <= 255) { 
sb.append(c); 
} else { 
byte[] b; 
try { 
b = Character.toString(c).getBytes("UTF-8"); 
} catch (Exception ex) { 
ex.printStackTrace(); 
b = new byte[0]; 
} 
for (int j = 0; j < b.length; j++) { 
int k = b[j]; 
if (k < 0) k += 256; 
sb.append("%" + Integer.toHexString(k). toUpperCase()); 
} 
} 
} 
return sb.toString(); 
}
}