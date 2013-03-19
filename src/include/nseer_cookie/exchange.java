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


public class exchange{
	  public exchange() {}
	  public static String change(String s) {
		  s = toHtml(s);
		  return s;
	  }
	//特殊字符转为Html
	public static String toHtml(String s) {

    s = Replace(s,"<","&lt;");
    s = Replace(s,">","&gt;");
    s = Replace(s,"\t","    ");
    s = Replace(s,"\r\n","\n");
    s = Replace(s,"\n","<br>");
    //s = Replace(s," ","&nbsp;");
    s = Replace(s,"'","&#39;");
    s = Replace(s,"\\","&#92;");
	s = Replace(s,"\"","&quot;");
    
    return s;
    }

	public static String toHtmlFCK(String s) {

    s = Replace(s,"\r\n","\n");
    s = Replace(s,"\n","<br>");
    //s = Replace(s," ","&nbsp;");
    
    return s;
    }
	//逆
    public static String unHtml(String s){
	s = Replace(s,"<br>","\n");
	s = Replace(s,"&nbsp;"," ");
	return s;
  	}

	public static String unHtmls(String s){
	s = Replace(s,"<br>","★");
	s = Replace(s,"&nbsp;","☆");
	s = Replace(s," ","☆");
	return s;
  	}

	public static String toJS(String s) {

	s = Replace(s,"\"","⊙");
    
    return s;
    }

	public static String toHtmlJS(String s) {

    s = Replace(s,"<","&lt;");
    s = Replace(s,">","&gt;");
    s = Replace(s,"\t","    ");
    s = Replace(s,"\r\n","\n");
    s = Replace(s,"\n","<br>");
    //s = Replace(s," ","&nbsp;");
    s = Replace(s,"'","&#39;");
    s = Replace(s,"\\","&#92;");
	s = Replace(s,"\"","⊙");
    
    return s;
    }

	public static String unJS(String s) {

	s = Replace(s,"⊙","\"");
    
    return s;
    }

	public static String toURL(String s){
	s = Replace(s,"<","&lt;");
    s = Replace(s,">","&gt;");
    s = Replace(s,"\t","    ");
    s = Replace(s,"\r\n","\n");
    s = Replace(s,"\n","<br>");
	s = Replace(s," ","☆");
    s = Replace(s,"\"","&quot;");
	s = Replace(s,"%","℅");
	s = Replace(s,"+","⊕");
    s = Replace(s,"&","♀");
	return s;
  	}
	public static String unURL(String s){
	s = Replace(s,"♀","&");
	s = Replace(s,"℅","%");
	s = Replace(s,"⊕","+");
	s = Replace(s,"<br>","\n");
	s = Replace(s,"&lt;","<");
    s = Replace(s,"&gt;",">");
    s = Replace(s,"    ","\t");
    s = Replace(s,"\n","\r\n");    
	s = Replace(s,"☆"," ");
    s = Replace(s,"&quot;","\"");    
	return s;
  	}

  //Replace
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
