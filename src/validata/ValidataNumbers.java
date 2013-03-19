/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package validata;

public class ValidataNumbers{
	  public boolean bool ;
	  public boolean flag ;
	  public ValidataNumbers(){
	  	
	  	}
	  public boolean validata(String[] s){
	 	 for(int j=0;j<s.length;j++){  
	      int x =0;
	      int y=0;
		  if(!s[j].equals("")){
	  	   char[] chars = s[j].toCharArray();
           if(chars[0]=='.'){
           	x++;
           	y++;
           }else if(chars[0] =='+'||chars[0] =='-'||(chars[0] >='0'&&chars[0] <='9')){
           	x++;
           }
             for(int i=1;i<chars.length;i++){
          	   if(chars[i] =='.'){
          	   		y++;
                   x++; 
                  }else if((chars[i] >='0'&&chars[i] <='9')||chars[i] ==','){
                  	x++;
                  }
                }
                 if(x == chars.length&&y<=1){ 
                    flag = true; 
                    }else{
                    	flag=false;
						break;
                    	}
	  }else{
			flag=false;
			break;
	  }
		 }
         return flag;
   }   		
}