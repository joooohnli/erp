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

import java.util.StringTokenizer;

public class analyseString {

	public int ana(String ss, String code) {
		int amount=0;
			StringTokenizer tokenTO = new StringTokenizer(ss, code);
			while (tokenTO.hasMoreTokens()) {
				String ss1 = tokenTO.nextToken();
				amount++;
			}
		amount--;
		return amount;
	}
	
	public boolean common(String abc) {
		boolean flag=true;
		String checkok="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		for(int i=0;i<abc.length();i++){
			if(checkok.indexOf(abc.substring(i,i+1))==-1){
				flag=false;
				break;
			}
		}
		return flag;
	}

	public String anas(String ss, String code1, String code2) {
		int amount=0;
		String[] aa=new String[1000];
		String bb="";
			StringTokenizer tokenTO = new StringTokenizer(ss, code1);
			while (tokenTO.hasMoreTokens()) {
				aa[amount] = tokenTO.nextToken();
				amount++;
			}
		for(int i=0;i<amount;i++){
			bb=bb+aa[i]+code2;
		}
		bb=bb.substring(0,bb.length()-code2.length());
		return bb;
	}
	
	public String encode(String source){
		String[] word1={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}; 
		String[] word2={"_a","_b","_c","_d","_e","_f","_g","_h","_i","_j","_k","_l","_m","_n","_o","_p","_q","_r","_s","_t","_u","_v","_w","_x","_y","_z"}; 
		for(int i=0;i<word1.length;i++){
			source=source.replaceAll(word1[i],word2[i]); 
		}
		return source;
	}
	
	public static void main(String[] args){
		analyseString demo=new analyseString();
    }
}