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

import com.lowagie.text.*;

public class printPDF {
	
Document document=null;

public Document print_type_across(String print_type,int print_left,int print_right,int print_top,int print_bottom) {

try {
	
if(print_type.equals("A0"))document= new Document(PageSize.A0.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A1"))document= new Document(PageSize.A1.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A2"))document= new Document(PageSize.A2.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A3"))document= new Document(PageSize.A3.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A4"))document= new Document(PageSize.A4.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A5"))document= new Document(PageSize.A5.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A6"))document= new Document(PageSize.A6.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A7"))document= new Document(PageSize.A7.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A8"))document= new Document(PageSize.A8.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("A9"))document= new Document(PageSize.A9.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("B0"))document= new Document(PageSize.B0.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("B1"))document= new Document(PageSize.B1.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("B2"))document= new Document(PageSize.B2.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("B3"))document= new Document(PageSize.B3.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("B4"))document= new Document(PageSize.B4.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("B5"))document= new Document(PageSize.B5.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_A"))document= new Document(PageSize.ARCH_A.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_B"))document= new Document(PageSize.ARCH_B.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_C"))document= new Document(PageSize.ARCH_C.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_D"))document= new Document(PageSize.ARCH_D.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_E"))document= new Document(PageSize.ARCH_E.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("FLSA"))document= new Document(PageSize.FLSA.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("FLSE"))document= new Document(PageSize.FLSE.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("NOTE"))document= new Document(PageSize.NOTE.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("_11X17"))document= new Document(PageSize._11X17.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("LETTER"))document= new Document(PageSize.LETTER.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("HALFLETTER"))document= new Document(PageSize.HALFLETTER.rotate(), print_left, print_right, print_top, print_bottom);
if(print_type.equals("LEDGER"))document= new Document(PageSize.LEDGER.rotate(), print_left, print_right, print_top, print_bottom);		
          

			} catch (Exception e) {
				e.printStackTrace();
			}
return document;
		}
		
		
public Document print_type_vertical(String print_type,int print_left,int print_right,int print_top,int print_bottom) {

try {
if(print_type.equals("A0"))document= new Document(PageSize.A0, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A1"))document= new Document(PageSize.A1, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A2"))document= new Document(PageSize.A2, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A3"))document= new Document(PageSize.A3, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A4"))document= new Document(PageSize.A4, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A5"))document= new Document(PageSize.A5, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A6"))document= new Document(PageSize.A6, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A7"))document= new Document(PageSize.A7, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A8"))document= new Document(PageSize.A8, print_left, print_right, print_top, print_bottom);
if(print_type.equals("A9"))document= new Document(PageSize.A9, print_left, print_right, print_top, print_bottom);
if(print_type.equals("B0"))document= new Document(PageSize.B0, print_left, print_right, print_top, print_bottom);
if(print_type.equals("B1"))document= new Document(PageSize.B1, print_left, print_right, print_top, print_bottom);
if(print_type.equals("B2"))document= new Document(PageSize.B2, print_left, print_right, print_top, print_bottom);
if(print_type.equals("B3"))document= new Document(PageSize.B3, print_left, print_right, print_top, print_bottom);
if(print_type.equals("B4"))document= new Document(PageSize.B4, print_left, print_right, print_top, print_bottom);
if(print_type.equals("B5"))document= new Document(PageSize.B5, print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_A"))document= new Document(PageSize.ARCH_A, print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_B"))document= new Document(PageSize.ARCH_B, print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_C"))document= new Document(PageSize.ARCH_C, print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_D"))document= new Document(PageSize.ARCH_D, print_left, print_right, print_top, print_bottom);
if(print_type.equals("ARCH_E"))document= new Document(PageSize.ARCH_E, print_left, print_right, print_top, print_bottom);
if(print_type.equals("FLSA"))document= new Document(PageSize.FLSA, print_left, print_right, print_top, print_bottom);
if(print_type.equals("FLSE"))document= new Document(PageSize.FLSE, print_left, print_right, print_top, print_bottom);
if(print_type.equals("NOTE"))document= new Document(PageSize.NOTE, print_left, print_right, print_top, print_bottom);
if(print_type.equals("_11X17"))document= new Document(PageSize._11X17, print_left, print_right, print_top, print_bottom);
if(print_type.equals("LETTER"))document= new Document(PageSize.LETTER, print_left, print_right, print_top, print_bottom);
if(print_type.equals("HALFLETTER"))document= new Document(PageSize.HALFLETTER, print_left, print_right, print_top, print_bottom);
if(print_type.equals("LEDGER"))document= new Document(PageSize.LEDGER, print_left, print_right, print_top, print_bottom);
          

			} catch (Exception e) {
				e.printStackTrace();
			}
return document;
		}
	}

