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

public class ValidatorField {
  
  private String name;
  private String displayName;
  private ValidatorDepend[] depends;

  public ValidatorField() {}

  public String getName()  {
    return this.name;
  }

  public void setName(String argName) {
    this.name = argName;
  }

  public String getDisplayName()  {
    return this.displayName;
  }

  public void setDisplayName(String argDisplayName) {
    this.displayName = argDisplayName;
  }

  public ValidatorDepend[] getDepends()  {
    return this.depends;
  }

  public void setDepends(ValidatorDepend[] argDepends) {
    this.depends = argDepends;
  }

}
