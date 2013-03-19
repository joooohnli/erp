/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.calculator;
//SimpleCalculator.java
import java.util.ArrayList;
import java.util.Stack;
import java.util.StringTokenizer;

/**
 * 运用后缀表达式进行计算的具体做法
 * 建立一个栈S
 * 从左到右读后缀表达式，读到数字就将它转换为数值压入栈S中，
 * 读到运算符则从栈中依次弹出两个数分别到Y和X，然后以“X 运算符 Y”的形式计算机出结果，再压加栈S中
 * 如果后缀表达式未读完，就重复上面过程，最后输出栈顶的数值则为结束
 */
public class SimpleCalculator implements Calculator {
    String[] _toks; // 符号列表

    public SimpleCalculator(String expression) {
        // 构造符号列表
        ArrayList list = new ArrayList();
        StringTokenizer tokenizer
              = new StringTokenizer(expression);
        while (tokenizer.hasMoreTokens()) {
            list.add(tokenizer.nextToken());
        }
        _toks = (String[])
          list.toArray(new String[list.size()]);
    }

    // 将变量值代入表达式中的变量，
    // 然后返回表达式的计算结果
    public double evaluate(double[] args) {
        Stack stack = new Stack();
        for (int i = 0; i < _toks.length; i++) {
         String tok = _toks[i];
         // 以‘$’开头的是变量
         if (tok.startsWith("$")) {
             int varnum = Integer.parseInt(tok.substring(1));
             stack.push(new Double(args[varnum]));
         } else {
             char opchar = tok.charAt(0);
             int op = "+-*/".indexOf(opchar);
             if (op == -1) {
                 // 常量
                 stack.push(Double.valueOf(tok));
             } else {
                 // 操作符
                 double arg2 = ((Double) stack.pop()).doubleValue();
                 double arg1 = ((Double) stack.pop()).doubleValue();
                 switch (op) {
                     // 对栈顶的两个值执行指定的操作
                     case 0:
                         stack.push(new Double(arg1 + arg2));
                         break;
                     case 1:
                         stack.push(new Double(arg1 - arg2));
                         break;
                     case 2:
                         stack.push(new Double(arg1 * arg2));
                         break;
                     case 3:
                         stack.push(new Double(arg1 / arg2));
                         break;
                     default:
                         throw new RuntimeException
                             ("操作符不合法: " + tok);
                 }
             }
         }
       }
     return ((Double) stack.pop()).doubleValue();
    }

    public double evaluate() {
        Stack stack = new Stack();
        for (int i = 0; i < _toks.length; i++) {
         String tok = _toks[i];
         // 以‘$’开头的是变量
         if (tok.startsWith("$")) {
         } else {
             char opchar = tok.charAt(0);
             int op = "+-*/".indexOf(opchar);
             if (op == -1) {
                 // 常量
                 stack.push(Double.valueOf(tok));
             } else {
                 // 操作符
                 double arg2 = ((Double) stack.pop()).doubleValue();
                 double arg1 = ((Double) stack.pop()).doubleValue();
                 switch (op) {
                     // 对栈顶的两个值执行指定的操作
                     case 0:
                         stack.push(new Double(arg1 + arg2));
                         break;
                     case 1:
                         stack.push(new Double(arg1 - arg2));
                         break;
                     case 2:
                         stack.push(new Double(arg1 * arg2));
                         break;
                     case 3:
                         stack.push(new Double(arg1 / arg2));
                         break;
                     default:
                         throw new RuntimeException
                             ("操作符不合法: " + tok);
                 }
             }
         }
       }
     return ((Double) stack.pop()).doubleValue();
    }

    public static void main(String[] args) {
			double[] ag=new double[]{3,6};
		}
}
