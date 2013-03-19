/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function addRow1(evt){//现金流量层的动态添加行
 var sTa=document.getElementById('tablefield2');
 var id_input=sTa.rows.length; 
     tr = document.getElementById('tablefield2').insertRow(sTa.rows.length);  
     tr.height='25';   

tr.insertCell(-1).innerHTML ="<input name='name' id='aaaaa"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;BORDER-left:  1px solid #000000;border-right:  1px solid #000000; border-top:  0px ;\" onFocus=\"fo2(this.id)\" onkeyup=\"inputCancel(this.id)\"><div style=\"CURSOR: hand; display: none; padding-top: 7px; left: 80px; width: 18px; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;\" id='aaaaa_div"+id_input+"' onclick=\"open_cash()\"></div>";

tr.insertCell(-1).innerHTML = "<input name='name' id='bbbbb"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo2(this.id)\" onkeyup=\"inputCancel(this.id)\">";

tr.insertCell(-1).innerHTML = "<input name='name' id='ccccc"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-style: none; border-right: 1px solid #000000; border-bottom:  1px solid #000000;\" onFocus=\"fo2(this.id)\" onkeyup=\"decimalControl(this.id)\">";

for(j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaaaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbbbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccccc'+j;
			}
	   }
	   	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='aaaaa_div'+j;
			}
	   }
    }
	evt.keyCode=9;
  }
  
function addRow2(){//选定科目或聚焦时，现金流量层动态添加行
 var sTa=document.getElementById('tablefield2');
 var id_input=sTa.rows.length; 
     tr = document.getElementById('tablefield2').insertRow(sTa.rows.length);  
     tr.height='25';   

tr.insertCell(-1).innerHTML ="<input name='name' onFocus='this.blur()' id='aaaaa"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  0px;BORDER-left:  1px solid #000000;border-right:  1px solid #000000; border-top:  0px ;\" onFocus=\"fo2(this.id)\" onkeyup=\"inputCancel(this.id)\"><div style=\"CURSOR: hand; display: none; padding-top: 7px; left: 80px; width: 18px; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;\" id='aaaaa_div"+id_input+"' onclick=\"open_cash()\"></div>";

tr.insertCell(-1).innerHTML = "<input name='name' onFocus='this.blur()' id='bbbbb"+id_input+"' type='text' style=\"width: 100%; height: 100%; BORDER-BOTTOM: 0px;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\"  onFocus=\"fo2(this.id)\" onkeyup=\"inputCancel(this.id)\">";

tr.insertCell(-1).innerHTML = "<input name='name' onFocus='this.blur()' id='ccccc"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-style: none; border-right: 1px solid #000000;\" onkeydown=\"decimalControl(this.id)\">";

for(j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaaaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbbbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccccc'+j;
			}
	   }
	   	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='aaaaa_div'+j;
			}
	   }
    }
}

function addRow3(){//双击时现金流量层动态添加行
 var sTa=document.getElementById('tablefield2');
 var id_input=sTa.rows.length; 
     tr = document.getElementById('tablefield2').insertRow(sTa.rows.length);  
     tr.height='25';   

tr.insertCell(-1).innerHTML ="<input name='name' id='aaaaa"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  0px;BORDER-left:  1px solid #000000;border-right:  1px solid #000000; border-top:  0px ;\" onFocus=\"fo2(this.id)\" onkeyup=\"inputCancel(this.id)\"><div style=\"CURSOR: hand; display: none; padding-top: 7px; left: 80px; width: 18px; position: absolute; background-image: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;\" id='aaaaa_div"+id_input+"' onclick=\"open_cash()\"></div>";

tr.insertCell(-1).innerHTML = "<input name='name' id='bbbbb"+id_input+"' type='text' style=\"width: 100%; height: 100%; BORDER-BOTTOM: 0px;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo2(this.id)\" onkeyup=\"inputCancel(this.id)\">";

tr.insertCell(-1).innerHTML = "<input name='name' id='ccccc"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-style: none; border-right: 1px solid #000000;\" onFocus=\"fo2(this.id)\" onkeydown=\"decimalControl(this.id)\">";

for(j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaaaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbbbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccccc'+j;
			}
	   }
	   	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='aaaaa_div'+j;
			}
	   }
    }
 }

function addRow(id_input,evt)   {//加载并创建4行
 var sTa=document.getElementById('tablefield');
     id_input=parseInt(id_input.substring(3))+1;
     tr = document.getElementById('tablefield').insertRow(id_input);  
     tr.height='30';   

	tr.insertCell(-1).innerHTML ="<td width=\"173px\" height='25'><input name='summary' id='ccc"+id_input+"' type='text' style=\"width: 100%; height: 100%; BORDER-BOTTOM:  0px;BORDER-left:  0px ;border-right:  1px solid #000000;BORDER-top:  0px ;\" onkeydown=\"Clear(this.id,event)\" onFocus=\"fo(this.id)\" onkeyup=\"search_suggest(this.id)\" autocomplete=\"off\"><div style=\"CURSOR: hand; display:none; padding-top: 7px; left:130px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;\" id='c_div"+id_input+"' onclick=\"showSummary('ccc"+id_input+"')\"></div></td>";

	tr.insertCell(-1).innerHTML = "<td width=\"332px\" height='25'><input name='file_name1' id='ddd"+id_input+"' type='text' style=\"width: 100%; height: 100%; BORDER-BOTTOM:  0px;BORDER-left:  0px ;border-right:  1px solid #000000;BORDER-top:  0px ;\" onkeydown=\"Clear(this.id,event)\" onFocus=\"fo(this.id)\" onkeyup=\"search_file(this.id)\" autocomplete=\"off\" ondblclick=\"dbclick(this.id)\"><div style=\"CURSOR: hand; display:none; padding-top: 7px;left:420px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;\" id='d_div"+id_input+"' onclick=\"fill('ddd"+id_input+"')\"></div></td>";

	tr.insertCell(-1).innerHTML = "<td width=\"161px\" height='25'><input name='debit' id='aaa"+id_input+"' type='text' maxlength='15' onkeyup=\"match(this.id)\" style=\"width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; padding-top : 10px; padding-right : 1px;\" onkeydown=\"Clear(this.id,event)\"   autocomplete=\"off\" onFocus=\"fo(this.id)\"></td>";

	tr.insertCell(-1).innerHTML = "<td width=\"161px\" height='25'><input name='loan' id='bbb"+id_input+"' type='text' maxlength='15' onkeyup=\"match(this.id)\" style=\"width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; padding-top : 10px; padding-right : 1px;\" onkeydown=\"Excessively(this.id,event)\" autocomplete=\"off\" onFocus=\"fo(this.id)\"></td>";

for(var j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddd'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaa'+j;
			}else if(m==3){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbb'+j;
			}else{
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccc'+j;
			}
	   }
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='c_div'+j;
			}else{
            sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='d_div'+j;
			} 
	   }
    }
  }

function addRow_enter(id_input,evt)   {//凭证登记动态添加行
 var sTa=document.getElementById('tablefield');
     id_input=parseInt(id_input.substring(3))+1;
     tr = document.getElementById('tablefield').insertRow(id_input);  
     tr.height='30';   

	tr.insertCell(-1).innerHTML ="<td width=\"173px\" height='25'><input name='summary' id='ccc"+id_input+"' type='text' style=\"width: 100%; height: 100%; BORDER-BOTTOM:  0px;BORDER-left:  0px ;border-right:  1px solid #000000;BORDER-top:  0px ;\" onkeydown=\"Clear(this.id,event)\" onFocus=\"fo(this.id)\" onkeyup=\"search_suggest(this.id)\" autocomplete=\"off\"><div style=\"CURSOR: hand; display:none; padding-top: 7px; left:130px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;\" id='c_div"+id_input+"' onclick=\"showSummary('ccc"+id_input+"')\"></div></td>";

	tr.insertCell(-1).innerHTML = "<td width=\"332px\" height='25'><input name='file_name1' id='ddd"+id_input+"' type='text' style=\"width: 100%; height: 100%; BORDER-BOTTOM:  0px;BORDER-left:  0px ;border-right:  1px solid #000000;BORDER-top:  0px ;\" onkeydown=\"Clear(this.id,event)\" onFocus=\"fo(this.id)\" onkeyup=\"search_file(this.id)\" autocomplete=\"off\" ondblclick=\"dbclick(this.id)\"><div style=\"CURSOR: hand; display:none; padding-top: 7px;left:420px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;\" id='d_div"+id_input+"' onclick=\"fill('ddd"+id_input+"')\"></div></td>";

	tr.insertCell(-1).innerHTML = "<td width=\"161px\" height='25'><input name='debit' id='aaa"+id_input+"' type='text' maxlength='15' onkeyup=\"match(this.id)\" style=\"width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; padding-top : 10px;padding-right : 1px;\" onkeydown=\"Clear(this.id,event)\"  autocomplete=\"off\" onFocus=\"fo(this.id)\"></td>";

	tr.insertCell(-1).innerHTML = "<td width=\"161px\" height='25'><input name='loan' id='bbb"+id_input+"' type='text' maxlength='15' onkeyup=\"match(this.id)\" style=\"width: 100%; height: 100%; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; padding-top : 10px;padding-right : 1px;\" onkeydown=\"Excessively(this.id,event)\" autocomplete=\"off\" onFocus=\"fo(this.id)\"></td>";

for(var j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddd'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaa'+j;
			}else if(m==3){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbb'+j;
			}else{
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccc'+j;
			}
	   }
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='c_div'+j;
			}else{
            sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='d_div'+j;
			} 
	   }
    }
	document.getElementById('ccc'+id_input).focus();
  }

function addRow_firefox(id_input,evt)   {//凭证登记动态添加行
 var sTa=document.getElementById('tablefield');
     id_input=parseInt(id_input.substring(3))+1;
     tr = document.getElementById('tablefield').insertRow(id_input);  
     tr.height='30';   

	tr.insertCell(-1).innerHTML ="<input name='summary' id='ccc"+id_input+"' type='text' style=\"width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000;border-bottom:  1px solid #000000;\" onkeydown=\"Clear(this.id,event)\" onFocus=\"fo(this.id)\" onkeyup=\"search_suggest(this.id)\" autocomplete=\"off\"><div style=\"CURSOR: hand; display:none; padding-top: 7px; left:130px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;\" id='c_div"+id_input+"' onclick=\"showSummary('ccc"+id_input+"')\"></div>";

	tr.insertCell(-1).innerHTML = "<input name='file_name1' id='ddd"+id_input+"' type='text' style=\"width: 100%; height: 30px;border-style:none;border-right:  1px solid #000000; border-bottom:  1px solid #000000;\" onkeydown=\"Clear(this.id,event)\" onFocus=\"fo(this.id)\" onkeyup=\"search_file(this.id)\" autocomplete=\"off\" ondblclick=\"dbclick(this.id)\"><div style=\"CURSOR: hand; display:none; padding-top: 7px;left:420px; width:18px; height:28; position:absolute; background: url('../../images/finance/search.gif'); background-repeat: no-repeat; background-position: 50% 70%;right:2px; position:absolute; z-index:4;\" id='d_div"+id_input+"' onclick=\"fill('ddd"+id_input+"')\"></div>";

	tr.insertCell(-1).innerHTML = "<input name='debit' id='aaa"+id_input+"' type='text' maxlength='15' onkeyup=\"match(this.id)\" style=\"width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom: 1px solid #000000; padding-top : 10px;padding-right : 1px;\" onkeydown=\"Clear(this.id,event)\" autocomplete=\"off\" onFocus=\"fo(this.id)\">";

	tr.insertCell(-1).innerHTML = "<input name='loan' id='bbb"+id_input+"' type='text' maxlength='15' onkeyup=\"match(this.id)\" style=\"width: 100%; height: 30px; background-image: url('../../images/finance/voucher.bmp'); text-align: Right; border-style: none; border-right:  1px solid #000000; border-bottom: 1px solid #000000; padding-top : 10px;padding-right : 1px;\" onkeydown=\"Excessively_firefox(this.id,event)\"   autocomplete=\"off\" onFocus=\"fo(this.id)\">";

for(var j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddd'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaa'+j;
			}else if(m==3){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbb'+j;
			}else{
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccc'+j;
			}
	   }
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='c_div'+j;
			}else{
            sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='d_div'+j;
			} 
	   }
    }	
  }

  function addRow_multi(evt){
	  for(var i=0;i<4;i++){
		addRow_firefox("abc"+i,evt);
	}
  }