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

public class ValidatorDepend {

  private String name;
  private String[] parameters;  
  
  public ValidatorDepend() {}

  public String getName()  {
    return this.name;
  }

  public void setName(String argName) {
    this.name = argName;
  }

  public String[] getParameters()  {
    return this.parameters;
  }

  public void setParameters(String[] argParameters) {
    this.parameters = argParameters;
  }

}
