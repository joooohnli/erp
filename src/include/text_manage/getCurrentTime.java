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
/**
 * <p>Title:get current time/p>
 * <p>Description:</p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author yu
 * @version 1.0
 */
  public class getCurrentTime {

  public String getCurrentTime() {
  java.util.Date now=new java.util.Date();
  java.text.SimpleDateFormat formater =new java.text.SimpleDateFormat("yyyy-MM-dd-HHmmSS");
  String time=formater.format(now);
  return time;
  }
  public String getCurrent() {
  java.util.Date now=new java.util.Date();
  java.text.SimpleDateFormat formater =new java.text.SimpleDateFormat("yyyy-MM-dd");
  String time=formater.format(now);
  return time;
  }
  public String getYear() {
  java.util.Date now=new java.util.Date();
  java.text.SimpleDateFormat formater =new java.text.SimpleDateFormat("yyyy");
  String time=formater.format(now);
  return time;
  }
}
