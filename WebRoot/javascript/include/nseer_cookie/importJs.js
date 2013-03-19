function importJs(s_src){
	//alert(s_src);
	var s_script=document.getElementsByTagName('script');
	for(var i=0;i<s_script.length;i++){
		if(s_script[i].src==s_src){
			return;
		}
	}
	var n_head = document.getElementsByTagName('head')[0];
	var n_script = document.createElement('script');
	n_script.type = "text/javascript";
	n_script.src = s_src;
	n_head.appendChild(n_script);
}
function importMyJs(){
importJs('../../javascript/finance/voucher_add.js');
importJs('../../dwr/engine.js');
importJs('../../dwr/util.js');
importJs('../../dwr/interface/NseerTreeDB.js');
importJs('../../dwr/interface/Multi.js');
importJs('../../dwr/interface/multiLangValidate.js');
importJs('../../javascript/include/covers/cover.js');
importJs('../../dwr/interface/validateV7.js');
importJs('../../javascript/include/nseerTree/nseertree.js');
importJs('../../javascript/finance/voucher/treeBusiness.js');
importJs('../../javascript/calendar/cal.js');
importJs('../../javascript/finance/voucher.js');
importJs('../../javascript/finance/voucher_ajax.js');
importJs('../../javascript/finance/voucher_del.js');
importJs('../../javascript/finance/voucher_set.js');
importJs('../../javascript/finance/voucher_write.js');
importJs('../../javascript/finance/voucher_closeshow.js');
importJs('../../javascript/finance/voucher_focus.js');
importJs('../../javascript/include/nseer_cookie/firefox.js');
importJs('../../javascript/include/nseerTree/initNseertree.js');
importJs('../../javascript/include/nseerTree/nodeOperate.js');
importJs('../../javascript/include/nseerTree/nseertreeButton.js');
importJs('../../javascript/include/nseerTree/nseerReadTreeXml.js');
importJs('../../javascript/include/nseerTree/nseerReadTableXml.js');
importJs('../../javascript/include/validate/validation-framework.js');
importJs('../../javascript/include/nseer_cookie/firefox.js');
importJs('../../javascript/include/div/divViewChange.js');
}