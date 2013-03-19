/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.calculator;

/**
 * 将"one+two*three"类型的字符串表达式
 * 中变量替换后
 * 转化成“1+2*3”类型的字符串表达式
 **/
public class Change {
    private String word=null;
    public Change(String word){
	this.word=word;
    }
/**
*定义替换的方法
*/
    public String execute(String[] str1,
			  String[] str2){
	if(str1.length==str2.length){
	for(int i=0;i<str1.length;i++){
            replace(str1[i],str2[i]);
	}
	}
	return word;
    }
/**
*是execute的辅助方法
*/
    public void replace(String str1,
			String str2){
	int index=0;
	String temp="";
	if((index=word.indexOf(str1))!=-1){//如果str1在表达式中
	    if(index>0){				//如果str1不在表达式的开头
		temp+=word.substring(0,index)+str2;//截取前半部分表达式并把str1替换为数值str2
	      	word=word.substring(index+str1.length(),word.length());//截取在str1后面部分的表达式
		word=temp+word;
	    }else if(index==0){//如果str1在表达式的开头
		temp+=str2;//换开头部分
		word=word.substring(str1.length(),word.length());//截取在str1后面部分的表达式
		word=temp+word;
	    }
	    //由于可能出现重复的变量，所以这里使用了迭代递归
	    replace(str1,str2);
	}else {
		return;
	}
    }
    public static void main(String[] args){
	String one=" 10 ";
	String[] str1=new String[]{"three","one","five","two"};
	//变量替换时变量两侧加空格
        String[] str2=new String[]{" 3 ",one," 5 "," 2 "};
    }
}


