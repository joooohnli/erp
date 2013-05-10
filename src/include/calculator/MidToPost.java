/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *这个文件是恩信科�?ERP软件的组成部分�??
 *版权�?有（C�?2006-2010 四川大学计算机学院/http://www.nseer.com
 *
 *这一程序是自由软件，你可以遵照自由软件基金会出版的GNU通用公共许可
 *证条款来修改和重新发布这�?程序。或者用许可证的第二版，或�?�（根据你的�?
 *择）用任何更新的版本�?
 *
 *发布这一程序的目的是希望它有用，但没有任何担保�?�甚至没有�?�合特定�?
 *的的隐含的担保�?�更详细的情况请参阅GNU通用公共许可证�??
 *你应该已经和程序�?起收到一份GNU通用公共许可证的副本。如果还没有�?
 *写信给：
 *The Free Software Foundation, Inc., 675 Mass Ave, Cambridge,
 *MA02139, USA
 */
package include.calculator;
import java.util.ArrayList;
import java.util.Stack;
import java.util.StringTokenizer;
/**
 * 中缀表达式转化为后缀表达式的算法
 *
 * 将中�?表达式转换为后缀表达式的算法思想�?
 * 当读到数字直接�?�至输出队列�?
 * 当读到运算符t时，
 *�?a.将栈中所有优先级高于或等于t的运算符弹出，�?�到输出队列中；
 *�?b.t进栈
 * 读到左括号时总是将它压入栈中
 * 读到右括号时，将靠近栈顶的第�?个左括号上面的运算符全部依次弹出，�?�至输出队列后，再丢弃左括号�?
 *
 * 中缀表达式全部读完后，若栈中仍有运算符，将其送到输出队列�?
 */
public class MidToPost {

  String[] _toks; // 符号列表

  public MidToPost(String expression) {
        // 构�?�符号列�?
        ArrayList list = new ArrayList();
        StringTokenizer tokenizer
              = new StringTokenizer(expression);
        while (tokenizer.hasMoreTokens()) {
            list.add(tokenizer.nextToken());
        }
        _toks = (String[])
          list.toArray(new String[list.size()]);
  }

  public String execute() {
	  Stack stack = new Stack();
	  String result="";
    for (int i = 0; i < _toks.length; i++) {
    String tok = _toks[i];
    // 以�??$’开头的是变�?
    if (tok.startsWith("$")) {
			result+=tok;
		} else{
			char opchar = tok.charAt(0);
      int op = "+-*/()（）".indexOf(opchar);
      if (op == -1) {
      // 常量
        result+=tok+" ";
      } else {
				if(stack.empty()) {
					stack.push(opchar+"");
				} else {
					//如果是运算符
					if(isOperator(opchar)){//
                        while(!stack.empty()&&first(((String)stack.peek()).charAt(0))>=first(opchar)){
						  result+=stack.pop()+" ";
						}
			      stack.push(opchar+"");
			    } else if(opchar=='('||opchar=='（'){//对于输入全角情况括号的处�?
						stack.push(opchar+"");
				} else if(opchar==')'||opchar=='）') {
						int index;
						if((index=stack.search("("))!=-1){
						 while(!((String)stack.peek()).equals("(")) {
						   result+=stack.pop()+" ";
						 }
						 stack.pop();
						}else if((index=stack.search("��?"))!=-1){//对于输入全角情况括号的处�?
						 while(!((String)stack.peek()).equals("��")) {
						   result+=stack.pop()+" ";
						 }
						 stack.pop();
						}
				}
				}//end of else
			}
		}
	}//end of first for
	 while(!stack.empty()) {
		 result+=stack.pop()+" ";
	 }
	 return result;
	}


  private boolean isOperator(char ch) {
	  return(("+-*/".indexOf(ch)==-1)?false:true);
	}

  private int first(char c) { int p=-1;
    switch(c) { case '*': p=2; break;
      case '/': p=2; break;
      case '+': p=1; break;
      case '-': p=1; break;
      case '(': p=0; break;
      case '（':p=0; break;
      case '=': p=-1; break;
   }
   return(p);
  }

  public static void main(String[] args) {
	}
}
