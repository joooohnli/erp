// Description: Valid check for JavaScript
// Usage: <script type=text/javascript src=/check.js></script>
// Function Listing:
//  function chkdate(yearStr, monthStr, dayStr)
//  function chkdatestr(checkStr)
//  function chkemail(checkStr)
//  function chkfloat(checkStr)
//  function chkinteger(checkStr)
//  function chklength(checkStr)
//  function chkname(checkStr)
//  function chknegative(checkStr)
//  function chknostring(checkStr, forbidStr)
//  function chknumber(checkStr)
//  function chkpasswd(checkStr)
//  function chkphone(checkStr)
//  function chkquot(checkStr)
//  function chksafe(checkStr)
//  function chkspace(checkStr)
//  function chkstring(checkStr, checkOK)
//  function trim(w)
//  function trimform(TheForm)


//函数名：chkdate
//功能介绍：检查是否为合法日期
//参数说明：要检查的字符串年、月、日
//返 回 值：false:不是  true:是
function chkdate(yearStr, monthStr, dayStr) {
  var checkOK = "1234567890";
  if ( !chkstring(yearStr, checkOK) ||
       !chkstring(monthStr, checkOK) ||
       !chkstring(dayStr, checkOK) )
    return(false);

  testday = new Date();
  testday.setFullYear(yearStr, monthStr-1, dayStr);
  var tmpy = testday.getFullYear();
  var tmpm = testday.getMonth() + 1;
  var tmpd = testday.getDate();
  if (tmpy == yearStr && tmpm == monthStr && tmpd == dayStr) {
    return(true);
  } else {
    return(false);
  }
}


//函数名：chkdateStr
//功能介绍：检查是否为合法日期
//参数说明：要检查的字符串YYYY-MM-DD
//返 回 值：false:不是  true:是
function chkdatestr(checkStr) {
  var tmpy = "";
  var tmpm = "";
  var tmpd = "";
  var checkCode = 0;
  for (i=0; i<checkStr.length ;i++) {
    ch = checkStr.charAt(i);
    if (ch == '-') checkCode++;
    if (checkCode > 2) return(false);
    else if (checkCode == 0 && ch != '-') tmpy += ch;
    else if (checkCode == 1 && ch != '-') tmpm += ch;
    else if (checkCode == 2 && ch != '-') tmpd += ch;
  }
  if (chknumber(tmpy) && tmpy.length == 2) {
    if (tmpy > 70) tmpy = "19" + tmpy;
    else tmpy = "20" + tmpy;
  }
  return(chkdate(tmpy, tmpm, tmpd));
}


//函 数 名：chkemail
//功能介绍：检查是否为合法的Email Address
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
//校验规则：不能以.或@开头和/或结尾，不能包含1个以上@，形如*@(*.)*
function chkemail(checkStr) {
  var checkOK = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@._-";
  var allValid = false;
  var checkCode = 0;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (ch == "@") {
      if (checkCode == 0 && i > 0) {
        checkCode = 1;
      } else {
        break;
      }
    }
    if (ch == ".") {
      if (i == 0 || i == checkStr.length - 1) {
        break;
      } else if (checkStr.charAt(i+1) == '.') {
        break;
      } else if (checkCode == 0) {
        if (checkStr.charAt(i+1) == '@') {
          break;
        }
      } else if (checkCode == 1) {
        if (checkStr.charAt(i-1) == '@') {
          break;
        } else {
          checkCode = 2;
        }
      }
    }
    chValid = false;
    for (j = 0; j < checkOK.length; j++) {
      if (ch == checkOK.charAt(j)) {
        chValid = true;
        break;
      }
    }
    if (!chValid) break;
    if (i == checkStr.length - 1 && checkCode == 2) {
      allValid = true;
      break;
    }
  }
  return(allValid);
}


//函 数 名：chkfloat
//功能介绍：检查是否为小数
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkfloat(checkStr) {
  if (chknumber(checkStr) && checkStr.indexOf(".") >= 0) {
    return(true);
  } else {
    return(false);
  }
}


//函 数 名：chkinteger
//功能介绍：检查是否为数字
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkinteger(checkStr) {
  var checkOK = "0123456789+-";
  var allValid = true;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (checkOK.indexOf(ch) == -1) {
      allValid = false;
      break;
    }
    if ((ch == '+' || ch == '-') && i > 0) {
      allValid = false;
      break;
    }
  }
  return(allValid);
}


//函 数 名：chklength
//功能介绍：检查字符串的长度
//参数说明：要检查的字符串
//返 回 值：字节长度值
function chklength(checkStr) {
  var n = 0;
  for(i=0; i<checkStr.length; i++) {
    chcode = checkStr.charCodeAt(i);
    if (chcode >=0  && chcode <= 255) {
      n++;
    } else {
      n += 2;
    }
  }
  return(n);
}


//函 数 名：chkname
//功能介绍：检查是否符合名称要求
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkname(checkStr) {
  var forbidStr = "0123456789`~!@#$%^￥&*()_-+=|\\{}[];:,<>?/\"";
  return(!chknostring(checkStr, forbidStr));
}


//函 数 名：chknegative
//功能介绍：检查是否为负数
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chknegative(checkStr) {
  if (chknumber(checkStr) && checkStr.charAt(0) == '-') {
    return(true);
  } else {
    return(false);
  }
}


//函 数 名：chknostring
//功能介绍：检查是否含非法字符
//参数说明：要检查的字符串，合法的字符串集合
//返 回 值：false:不是  true:是
function chknostring(checkStr, forbidStr) {
  var allValid = false;
  if (typeof(checkStr) != "string" || typeof(forbidStr) != "string") return(false);
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (forbidStr.indexOf(ch) >= 0) {
      allValid = true;
      break;
    }
  }
  return(allValid);
}


//函 数 名：chknumber
//功能介绍：检查是否为数字
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chknumber(checkStr) {
  var checkOK = "0123456789.+-,:";
  var allValid = true;
  var checkCode = 0;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (checkOK.indexOf(ch) == -1) {
      allValid = false;
      break;
    }
    if ((ch == '+' || ch == '-') && i > 0) {
      allValid = false;
      break;
    }
    if (ch == '.') {
      checkCode += 1;
      if (checkCode > 1) {
        allValid = false;
        break;
      }
    }
  }
  return(allValid);
}


//函 数 名：chkpasswd
//功能介绍：检查是否符合密码要求
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkpasswd(checkStr) {
  var checkOK ="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-.";
  return(chkstring(checkStr, checkOK));
}


//函 数 名：checkphone
//功能介绍：检查是否为电话号码
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkphone(checkStr) {
  var checkOK = "0123456789-()# ,;:";
  return(chkstring(checkStr, checkOK));
}


//函 数 名：chkquot
//功能介绍：检查是否含有引号（单引号和/或双引号）
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkquot(checkStr) {
  var allValid = false;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (ch == "'" || ch == '"') {
      allValid = true;
      break;
    }
  }
  return(allValid);
}


//函 数 名：chksafe
//功能介绍：检查是否含有&;`'\"|*?~<>^()[]{}$\n\r
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chksafe(checkStr) {
  var allValid = true;
  var forbidStr = new Array ("&", ";", "`", "'", "\"", "|", "*", "?", "~", "<", ">", "^", "(", ")", "[", "]", "{", "}", "$", "\n", "\r");
  m = forbidStr.length;
  n = checkStr.length;
  for (i=0; i<m; i++) {
    for (j=0; j<n; j++) {
      ch1 = checkStr.charAt(j);
      ch2 = forbidStr[i];
      if (ch1 == ch2) {
        allValid = false;
        break;
      }
    }
  }
  return(allValid);
}


//函 数 名：chkspace
//功能介绍：检查是否含有空格
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkspace(checkStr) {
  var allValid = false;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (ch == " " || ch == "　") {
      allValid = true;
      break;
    }
  }
  return(allValid);
}


//函 数 名：chkstring
//功能介绍：检查是否全部合法
//参数说明：要检查的字符串，合法的字符串集合
//返 回 值：false:不是  true:是
function chkstring(checkStr, checkOK) {
  var allValid = true;
  if (typeof(checkStr) != "string" || typeof(checkOK) != "string") return(false);
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (checkOK.indexOf(ch) == -1) {
      allValid = false;
      break;
    }
  }
  return(allValid);
}


//函 数 名：trim
//功能介绍：删除两端的空格符号（全角和／或半角）
//参数说明：要处理的字符串
//返 回 值：处理后的字符串
function trim(w) {
  while (w.length>0 && (w.substr(0,1)==' ' || w.substr(0,1)=='　')) w=w.substr(1);
  while (w.length>0 && (w.substr(w.length-1)==' ' || w.substr(w.length-1)=='　')) w=w.substr(0,w.length-1);
  return(w);
}


//函 数 名：trimform
//功能介绍：对表单内所有text类型做trim操作
//参数说明：要处理的表单名
//返 回 值：false:失败  true:成功
function trimform(TheForm) {
  if (typeof(TheForm) != "object") return(false);
  for (var i=0; i<TheForm.elements.length; i++) {
    var e = TheForm.elements[i];
    if (e.type == 'text') {
      e.value = trim(e.value);
    }
  }
  return(true);
}


//函 数 名：chkint
//功能介绍：检查是否为正整数
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkint(checkStr) {
  var checkOK = "0123456789";
  var allValid = true;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (checkOK.indexOf(ch) == -1) {
      allValid = false;
      break;
    }
    if ((ch == '+' || ch == '-') && i > 0) {
      allValid = false;
      break;
    }
  }
  return(allValid);
}


//函 数 名：chkfin
//功能介绍：检查是否为实数
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkfin(checkStr) {
  var checkOK = "0123456789.,-";
  var allValid = true;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (checkOK.indexOf(ch) == -1) {
      allValid = false;
      break;
    }
    if ((ch == '+' || ch == '-') && i > 0) {
      allValid = false;
      break;
    }
  }
  return(allValid);
}

//函 数 名：chkusername
//功能介绍：检查是否为合法用户名
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkusername(checkStr) {
  var checkOK = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  var allValid = true;
  for (i = 0; i < checkStr.length; i++) {
    ch = checkStr.charAt(i);
    if (checkOK.indexOf(ch) == -1) {
      allValid = false;
      break;
    }
    if ((ch == '+' || ch == '-') && i > 0) {
      allValid = false;
      break;
    }
  }
  return(allValid);
}
//

//函 数 名：chkformula
//功能介绍：检查是否符合公式要求
//参数说明：要检查的字符串
//返 回 值：false:不是  true:是
function chkname(checkStr) {
  var forbidStr = "`~!@#$%^&_=|\\{}[];:,<>?￥\"";
  return(!chknostring(checkStr, forbidStr));
}