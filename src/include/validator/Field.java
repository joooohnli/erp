/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.validator;

/**
 * Field.java
 *
 *
 * Created: Sun Sep 26 16:01:59 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
public class Field {

  private String name;
  private String[] value;

  public Field() {
    
  } // Field constructor

  public String getName()  {
    return this.name;
  }

  public void setName(String argName) {
    this.name = argName;
  }

  public String[] getValue()  {
    return this.value;
  }

  public void setValue(String[] argValue) {
    this.value = argValue;
  }
  
} // Field
