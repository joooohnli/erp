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
 * CommonTypeValidator.java
 *
 *
 * Created: Sun Sep 26 16:22:16 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
public class CommonTypeValidator {
 
  public static Integer toInt(String value) {
    if (value == null) {
      return null;
    }

    try {
      return new Integer(value);
    } catch(NumberFormatException e) {
      return null;
    }

  }

  public static Long toLong(String value) {
    if (value == null) {
      return null;
    }

    try {
      return new Long(value);
    } catch(NumberFormatException e) {
      return null;
    }

  }
 
  public static Float toFloat(String value) {
    if (value == null) {
      return null;
    }

    try {
      return new Float(value);
    } catch(NumberFormatException e) {
      return null;
    }

  }

  public static Double toDouble(String value) {
    if (value == null) {
      return null;
    }

    try {
      return new Double(value);
    } catch(NumberFormatException e) {
      return null;
    }

  }


} // CommonTypeValidator
