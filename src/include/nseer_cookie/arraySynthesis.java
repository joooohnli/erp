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
import java.util.ArrayList;
public class arraySynthesis{               //合成数组,去掉重复元素。
	public String[] getArraySynthesis(String[] a,String[] b) 
	{
		ArrayList c = new ArrayList();       
		for(int i=0;i<a.length;i++){
			c.add(c.size(),a[i]);
		}
		for(int i=0;i<b.length;i++){
			c.add(c.size(),b[i]);
		}                                  //以上两个循环是将两个数组累加到list "C"里。
		ArrayList d = new ArrayList();     //定义一个空的list "D"。
		for(int i=0;i<c.size();i++){
			if(!d.contains(c.get(i))){     //将C的元素逐个跟D中的元素比，如果与D中的都不重复就加到D中。
               d.add(c.get(i));
			}
        }
		String[] f=new String[d.size()];   //定义一个返回数组。
		for(int i=0;i<d.size();i++){     
			f[i]=(String)d.get(i);
		}                                  //将D的元素赋值给返回数组F
		return f;                          
	}
	public static void main(String[] args){
		String[] a={"a","b","c","d","e"};
		String[] b={"a","b","c","d","f","g","r","k","a"};
		arraySynthesis demo=new arraySynthesis();
		for(int i=0; i<demo.getArraySynthesis(a, b).length;i++){
			//System.out.println(demo.getArraySynthesis(a, b)[i]);
		}
    }
}
