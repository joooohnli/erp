// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Outter.java

/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_import;

import java.io.FileInputStream;
import java.io.PrintStream;
import java.text.*;
import java.util.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public class Outter extends Path
{

    private String fileName;
    private HSSFWorkbook wb;
    private String message;

    public Outter()
    {
        fileName = null;
        wb = null;
        message = "";
    }

    private boolean blankTitle()
    {
        Vector vector = getTablesName();
        for(int i = 0; i < vector.size(); i++)
        {
            HSSFSheet hssfsheet = wb.getSheetAt(i);
            HSSFRow hssfrow = hssfsheet.getRow(0);
            if(hssfrow == null)
            {
                message += "有空标题的情况,或者空的SHEET";
                return true;
            }
            Iterator iterator = hssfrow.cellIterator();
            int j;
            for(j = 0; iterator.hasNext(); j++)
            {
                HSSFCell hssfcell = (HSSFCell)iterator.next();
            }

            for(int k = 0; k < j - 1; k++)
            {
                HSSFCell hssfcell1 = hssfrow.getCell((short)k);
                if(hssfcell1 == null)
                    return true;
                if(hssfcell1.getCellType() != 1)
                {
                    message += (String)vector.elementAt(i) + "的第" + (k + 1) + "列的标题类型不对<br>";
                    return true;
                }
                if(hssfcell1.getCellType() == 3)
                {
                    message += (String)vector.elementAt(i) + "的第" + (k + 1) + "列的标题为空<br>";
                    return true;
                }
            }

        }

        return false;
    }

    private void chop()
    {
        Vector vector = getTablesName();
        try
        {
            for(int i = 0; i < vector.size(); i++)
            {
                boolean flag = true;
                HSSFSheet hssfsheet = wb.getSheetAt(i);
                int j = getColumnCount(hssfsheet);
                for(int k = 0; k < j; k++)
                    if(isBlankColumn(k, hssfsheet))
                        removeColumn(k, hssfsheet);

                int l = getRowCount((String)vector.elementAt(i));
                for(int i1 = 0; i1 < l; i1++)
                {
                    HSSFRow hssfrow = hssfsheet.getRow(i1);
                    if(isBlankRow(hssfrow))
                        hssfsheet.removeRow(hssfrow);
                }

            }

        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }

    private String getCellType(HSSFCell hssfcell)
    {
        HSSFDataFormat hssfdataformat = wb.createDataFormat();
        HSSFCellStyle hssfcellstyle = hssfcell.getCellStyle();
        short word0 = hssfcellstyle.getDataFormat();
        String s = hssfdataformat.getFormat(word0);
        String s1 = "";
        switch(hssfcell.getCellType())
        {
        case 0: // '\0'
            if(s.indexOf("0_") == 0 || s.indexOf("0;") == 0 || s.indexOf("#,##0_") == 0 || s.indexOf("#,##0;") == 0 || s.equals("0"))
            {
                s1 = "INT";
                break;
            }
            if(s.equals("yyyy\\-mm\\-dd") || s.equals("yyyy-mm-dd") || s.equals("yyyy/mm/dd") || s.equals("m/d/yy") || s.equals("0x1f"))
            {
                s1 = "DATE";
                break;
            }
            if(s.indexOf("#,##0.") == 0 || s.indexOf("0.0") == 0)
            {
                s1 = "DOUBLE";
                break;
            }
            if(s.equals("General"))
                s1 = "INT1";
            else
                s1 = "NUMBERIC";
            break;

        case 1: // '\001'
            if(s.equals("General"))
            {
                s1 = "STRING";
                break;
            }
            if(s.equals("@"))
            {
                s1 = "STRING";
                break;
            }
            if(s.indexOf("0_") == 0 || s.indexOf("0;") == 0 || s.indexOf("#,##0_") == 0 || s.indexOf("#,##0;") == 0 || s.equals("0"))
            {
                s1 = "INT";
                break;
            }
            if(s.indexOf("#,##0.") == 0 || s.indexOf("0.0") == 0)
                s1 = "DOUBLE";
            else
                System.out.println(s);
            break;

        case 3: // '\003'
            s1 = "BLANK";
            break;

        case 2: // '\002'
            s1 = "FORMULA";
            break;

        case 5: // '\005'
            s1 = "ERROR";
            break;

        case 4: // '\004'
        default:
            s1 = "UNKNOWN";
            break;
        }
        return s1;
    }

    private int getColumnCount(HSSFSheet hssfsheet)
    {
        HSSFRow hssfrow = hssfsheet.getRow(0);
        Iterator iterator = hssfrow.cellIterator();
        int i;
        for(i = 0; iterator.hasNext(); i++)
        {
            HSSFCell hssfcell = (HSSFCell)iterator.next();
        }

        return i;
    }

    public String getItemType(String s, String s1)
        throws Exception
    {
        int i = getItemsName(s1).indexOf(s);
        if(i == -1)
            throw new Exception("Item not found");
        HSSFSheet hssfsheet = wb.getSheetAt(getTablesName().indexOf(s1));
        HashMap hashmap = new HashMap();
        for(int j = 1; j < getRowCount(s1); j++)
        {
            HSSFRow hssfrow = hssfsheet.getRow(j);
            HSSFCell hssfcell = hssfrow.getCell((short)i);
            String s2 = getCellType(hssfcell);
            if(!hashmap.containsKey(s2))
                hashmap.put(s2, new Integer(1));
            else
                hashmap.put(s2, new Integer(((Integer)hashmap.get(s2)).intValue() + 1));
        }

        Set set = hashmap.keySet();
        Iterator iterator = set.iterator();
        Integer integer = new Integer(0);
        String s3 = "BLANK";
        int k = 0;
        while(iterator.hasNext()) 
        {
            String s4 = (String)iterator.next();
            if(k == 0)
            {
                integer = (Integer)hashmap.get(s4);
                s3 = s4;
                k++;
            } else
            if(integer.compareTo((Integer)hashmap.get(s4)) < 0)
            {
                integer = (Integer)hashmap.get(s4);
                s3 = s4;
            }
        }
        return s3;
    }

    public Vector getItemValues(String s, String s1)
        throws Exception
    {
        Vector vector = new Vector();
        int i = getItemsName(s1).indexOf(s);
        if(i == -1)
            throw new Exception("Item not found");
        HSSFSheet hssfsheet = wb.getSheetAt(getTablesName().indexOf(s1));
        Iterator iterator = hssfsheet.rowIterator();
        int j = 0;
        while(iterator.hasNext()) 
            if(hssfsheet != null)
            {
                HSSFRow hssfrow = (HSSFRow)iterator.next();
                HSSFCell hssfcell = hssfrow.getCell((short)i);
                if(j > 0 && hssfcell != null)
                    pump(vector, hssfcell, getItemType(s, s1));
                j++;
            }
        return vector;
    }

    public Vector getItemsName(String s)
        throws Exception
    {
        Vector vector = new Vector();
        int i = getTablesName().indexOf(s);
        if(i == -1)
            throw new Exception("Table not found");
        HSSFSheet hssfsheet = wb.getSheetAt(i);
        HSSFRow hssfrow = hssfsheet.getRow(0);
        if(hssfrow == null)
            return null;
        Iterator iterator = hssfrow.cellIterator();
        int j;
        for(j = 0; iterator.hasNext(); j++)
        {
            HSSFCell hssfcell = (HSSFCell)iterator.next();
        }

        for(int k = 0; k < j; k++)
        {
            HSSFCell hssfcell1 = hssfrow.getCell((short)k);
            if(isBlankColumn(k, hssfsheet) && hssfcell1 != null)
                removeColumn(k, hssfsheet);
            if(hssfcell1 != null)
                pump(vector, hssfcell1);
        }

        return vector;
    }

    public String getMessage()
    {
        return message + "，文件的格式不符合导入要求，请仔细检查。";
    }

    public int getRowCount(String s)
        throws Exception
    {
        int i = getTablesName().indexOf(s);
        if(i == -1)
            throw new Exception("Table not found");
        HSSFSheet hssfsheet = wb.getSheetAt(i);
        Iterator iterator = hssfsheet.rowIterator();
        int j = 0;
        while(iterator.hasNext()) 
        {
            HSSFRow hssfrow = (HSSFRow)iterator.next();
            if(hssfrow != null)
                j++;
        }
        return j;
    }

    private int getRowCount(HSSFSheet hssfsheet)
    {
        Iterator iterator = hssfsheet.rowIterator();
        int i = 0;
        while(iterator.hasNext()) 
        {
            HSSFRow hssfrow = (HSSFRow)iterator.next();
            if(hssfrow != null)
                i++;
        }
        return i;
    }

    public Vector getRowItemsValues(String s, int i)
        throws Exception
    {
        Vector vector = new Vector();
        int j = getTablesName().indexOf(s);
        if(j == -1)
            throw new Exception("Table not found");
        HSSFSheet hssfsheet = wb.getSheetAt(j);
        HSSFRow hssfrow = hssfsheet.getRow((short)i);
        Iterator iterator = hssfrow.cellIterator();
        int k;
        for(k = 0; iterator.hasNext(); k++)
        {
            HSSFCell hssfcell = (HSSFCell)iterator.next();
        }

        for(int l = 0; l < k; l++)
        {
            HSSFCell hssfcell1 = hssfrow.getCell((short)l);
            pump(vector, hssfcell1);
        }

        return vector;
    }

    public Vector getTablesName()
    {
        Vector vector = new Vector();
        for(int i = 0; i < wb.getNumberOfSheets(); i++)
            vector.addElement(wb.getSheetName(i));

        return vector;
    }

    public boolean hasBlank()
    {
        for(int i = 0; i < wb.getNumberOfSheets(); i++)
        {
            HSSFSheet hssfsheet = wb.getSheetAt(i);
            String s = wb.getSheetName(i);
            for(int j = 0; j < getRowCount(hssfsheet); j++)
            {
                HSSFRow hssfrow = hssfsheet.getRow(j);
                for(int k = 0; k < getColumnCount(hssfsheet); k++)
                {
                    HSSFCell hssfcell = hssfrow.getCell((short)k);
                    if(hssfcell == null)
                    {
                        message += s + "有的行或者列(列" + (k + 1) + ":行" + (j + 1) + ")为空(" + s + "记录总行数是" + getRowCount(hssfsheet) + "吗?)<br>";
                        return true;
                    }
                }

            }

        }

        return false;
    }

    private boolean isBlankColumn(int i, HSSFSheet hssfsheet)
    {
        int j = getRowCount(hssfsheet);
        for(int k = 0; k < j; k++)
        {
            HSSFRow hssfrow = hssfsheet.getRow(k);
            if(hssfrow == null)
                return true;
            HSSFCell hssfcell = hssfrow.getCell((short)i);
            if(hssfcell == null)
                return true;
            if(hssfcell.getCellType() != 3)
                return false;
        }

        return true;
    }

    private boolean isBlankRow(HSSFRow hssfrow)
    {
        if(hssfrow == null)
            return true;
        Iterator iterator = hssfrow.cellIterator();
        int i;
        for(i = 0; iterator.hasNext(); i++)
        {
            HSSFCell hssfcell = (HSSFCell)iterator.next();
        }

        for(int j = 0; j < i; j++)
        {
            HSSFCell hssfcell1 = hssfrow.getCell((short)j);
            if(hssfcell1 == null)
                return true;
            if(hssfcell1.getCellType() != 3)
                return false;
        }

        return true;
    }

    public boolean isMerged()
    {
        for(int i = 0; i < wb.getNumberOfSheets(); i++)
        {
            HSSFSheet hssfsheet = wb.getSheetAt(i);
            if(hssfsheet.getNumMergedRegions() > 0)
            {
                message += "有列合并的情况<br>";
                return true;
            }
        }

        return false;
    }

    public static void main(String args[])
    {
        Outter outter = new Outter();
        String s = "oo1.xls";
        outter.setFile(s);
        try
        {
            outter.reparedOut();
            System.out.println("rowcount:" + outter.getRowCount("Sheet1"));
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        if(!outter.validate())
        {
            System.out.println("message:" + outter.getMessage());
        } else
        {
            Vector vector = outter.getTablesName();
            try
            {
                for(int i = 0; i < vector.size(); i++)
                {
                    System.out.println("vt:" + vector.elementAt(i));
                    System.out.println("rownum=" + outter.getRowCount((String)vector.elementAt(i)));
                    Vector vector1 = outter.getItemsName((String)vector.elementAt(i));
                    for(int j = 0; j < vector1.size(); j++)
                    {
                        Vector vector2 = outter.getItemValues((String)vector1.elementAt(j), (String)vector.elementAt(i));
                        for(int k = 0; k < vector2.size(); k++)
                            System.out.println("value:" + vector2.elementAt(k));

                    }

                }

            }
            catch(Exception exception1)
            {
                exception1.printStackTrace();
            }
        }
    }

    private void pump(Vector vector, HSSFCell hssfcell)
    {
        String s = getCellType(hssfcell);
        if(s.equals("INT"))
        {
            DecimalFormat decimalformat = new DecimalFormat("##");
            String s1 = String.valueOf(decimalformat.format(hssfcell.getNumericCellValue()));
            vector.addElement(s1);
        } else
        if(s.equals("DOUBLE"))
        {
            DecimalFormat decimalformat1 = new DecimalFormat("##.##");
            String s2 = String.valueOf(decimalformat1.format(hssfcell.getNumericCellValue()));
            vector.addElement(s2);
        } else
        if(s.equals("STRING"))
            vector.addElement(hssfcell.getStringCellValue());
        else
        if(s.equals("DATE"))
        {
            SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy-MM-dd");
            String s3 = String.valueOf(simpledateformat.format(hssfcell.getDateCellValue()));
            vector.addElement(s3);
        }
    }

    private void pump(Vector vector, HSSFCell hssfcell, String s)
    {
        String s1 = getCellType(hssfcell);
        if(s1.equals("INT"))
        {
            DecimalFormat decimalformat = new DecimalFormat("##");
            String s2 = String.valueOf(decimalformat.format(hssfcell.getNumericCellValue()));
            vector.addElement(s2);
        } else
        if(s1.equals("INT1"))
        {
            DecimalFormat decimalformat1 = new DecimalFormat("##");
            String s3 = String.valueOf(decimalformat1.format(hssfcell.getNumericCellValue()));
            vector.addElement(s3);
        } else
        if(s1.equals("DOUBLE"))
        {
            DecimalFormat decimalformat2 = new DecimalFormat("##.##");
            String s4 = String.valueOf(decimalformat2.format(hssfcell.getNumericCellValue()));
            vector.addElement(s4);
        } else
        if(s1.equals("STRING"))
            vector.addElement(hssfcell.getStringCellValue());
        else
        if(s1.equals("DATE"))
        {
            SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy-MM-dd");
            String s5 = String.valueOf(simpledateformat.format(hssfcell.getDateCellValue()));
            vector.addElement(s5);
        } else
        if(s1.equals("BLANK"))
            if(s.equals("STRING"))
                vector.addElement(" ");
            else
            if(s.equals("INT"))
                vector.addElement(new Integer(0));
            else
            if(s.equals("DOUBLE"))
                vector.addElement(new Double(0.0D));
            else
            if(s.equals("DATE"))
                vector.addElement("0000-00-00");
            else
            if(s.equals("UNKNOWN"))
                vector.addElement(" ");
    }

    private void removeColumn(int i, HSSFSheet hssfsheet)
    {
        for(int j = 0; j < getRowCount(hssfsheet); j++)
        {
            HSSFRow hssfrow = hssfsheet.getRow(j);
            HSSFCell hssfcell = hssfrow.getCell((short)i);
            if(hssfrow != null)
                hssfrow.removeCell(hssfcell);
        }

    }

    public void reparedOut()
        throws Exception
    {
        if(fileName == null)
            throw new Exception("Exception: File should be asigned!");
        try
        {
            FileInputStream fileinputstream = new FileInputStream(fileName);
            POIFSFileSystem poifsfilesystem = new POIFSFileSystem(fileinputstream);
            wb = new HSSFWorkbook(poifsfilesystem);
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }

    public void setFile(String s)
    {
        fileName = getPath() + "/conf/excel_import/" + s;
    }

    public boolean validate()
    {
        return !isMerged() && !hasBlank() && !blankTitle() && validateValue();
    }

    public boolean validateType(HSSFCell hssfcell, String s, String s1)
    {
        try
        {
            String s2 = getItemType(s, s1);
            switch(hssfcell.getCellType())
            {
            case 1: // '\001'
                if(s2.equals("INT") || s2.equals("DOUBLE") || s2.equals("DATE"))
                    return false;
                break;
            }
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean validateValue()
    {
        for(int i = 0; i < wb.getNumberOfSheets(); i++)
        {
            HSSFSheet hssfsheet = wb.getSheetAt(i);
            String s = wb.getSheetName(i);
            for(int j = 1; j < getRowCount(hssfsheet); j++)
            {
                HSSFRow hssfrow = hssfsheet.getRow(j);
                HSSFRow hssfrow1 = hssfsheet.getRow(0);
                for(int k = 0; k < getColumnCount(hssfsheet); k++)
                {
                    HSSFCell hssfcell = hssfrow1.getCell((short)k);
                    String s1 = hssfcell.getStringCellValue();
                    HSSFCell hssfcell1 = hssfrow.getCell((short)k);
                    if(!validateType(hssfcell1, s1, s))
                    {
                        message += "第" + (k + 1) + "列 : 第" + (j + 1) + "行变量类型不符合<br>";
                        return false;
                    }
                }

            }

        }

        return true;
    }
}
