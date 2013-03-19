/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.text_manage;
  import java.io.*;
 /**
  * <p>Title:divide a big file into many small files;</p>
  * <p>Description:</p>
  * <p>Copyright: Copyright (c) 2003</p>
  * <p>Company: </p>
  * @author yu
  * @version 1.0
 */
  public class fileDivider {


    public String[] fileDivider(String filename,String[] files) {

      String[] result=files;
      String time=new getCurrentTime().getCurrentTime();
      String s=new String();
      int i=0;
      try {
	BufferedReader in=
	  new BufferedReader(new FileReader(filename));
	BufferedWriter oout=
	  new BufferedWriter(new FileWriter(files[0]+"-"+time+".txt"));
	while((s=in.readLine())!=null) {
	  if(!s.equals("~")) {
	    oout.write(s);
	    oout.newLine();
	  } else {
	    oout.flush();
	    oout.close();
	    i++;
	    result[i]=files[i]+"-"+time+".txt";
	    oout=new BufferedWriter(new FileWriter(result[i]));
	  }
	}//end of while
	result[0]=files[0]+"-"+time+".txt";
	oout.flush();
	oout.close();
      } catch (FileNotFoundException e) {
      } catch (IOException e) {}
      return result;
    }

  }
