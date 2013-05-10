/*  *this file is part of nseer erp  *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com  *  *This program is free software; you can redistribute it and/or  *modify it under the terms of the GNU General Public License  *as published by the Free Software Foundation; either  *version 2 of the License, or (at your option) any later version.  */var doc = document;
eval('var document = doc');
function nseergrid() {
	this.callname = "nseer";
	this.width = 0;
	this.useTag = null;
	this.sortTag = 0;
	this.scroll_w = 21;
	this.title_alt = '川大科技信息化平台';
	this.magin_h = w() || '85%';
	this.magin_w = '98%';
	this.imgPath = null;
	this.moveTag = 0;
	this.color1 = '#FFFFFF';
	this.firstdata1 = "<tr><td>&nbsp;</td></tr>";
	this.selectTag = null;
	this.tempWidth = 0;
	this.height = 0;
	this.rid = "nseergrid";
	this.columns = [];
	this.column_width = [];
	this.auto = null;
	this.data = [];
	this.t_tag = 0;
	this.v = 0;
	function w() {
		this.magin_h = null;
		if (screen.width == 1280 && screen.height == 1024) {
			this.magin_h = '90%';
		}
		if (screen.width == 1024 && screen.height == 768) {
			this.magin_h = '85%';
		}
		return this.magin_h;
	}
	;
	this.dblclick_fun = function() {
	};
	this.contextmenu_fun = function() {
	};
	this.parentNode = document.body;
	this.d = document;
	this.$ = function(o) {
		return document.getElementById(o);
	};
	this.int = function(o) {
		return parseInt(o);
	};
	var nseerframediv = null;
	var str_array = [ 1, 3, 5, 7 ];
	var dh = this;
	var zerobj = null;
	var leftobj = null;
	var titleobj = null;
	var dataobj = null;
	var nseer_xbar = null;
	var nseer_ybar = null;
	var nseer_xybar = null;
	var tag = 0;
	var data_a = new Array();
	var event_obj;
	var del_row_id;
	var title_alt;
	var ml = 0;
	var ow = 0;
	var tdobj = null;
	var nowrow = null;
	var tag1 = 100 - 80;
	var changeposv = true;
	this.init = function() {
		if (this.t_tag == 0) {
			this.magin_w = parseInt(this.magin_w.substring(0,
					this.magin_w.length - 1));
			this.magin_h = parseInt(this.magin_h.substring(0,
					this.magin_h.length - 1));
		}
		var width_sum = 0;
		for ( var i = 0; i < this.column_width.length; i++) {
			width_sum += this.column_width[i];
		}
		if (isIE()) {
			var o_width = (this.hobj('clientWidth') * this.magin_w / 100) - 4;
		} else {
			var o_width = this.hobj('clientWidth') - this.magin_w - 54;
		}
		var z = this.column_width.length - 1;
		var int_data = "";
		if (this.columns.length > 0) {
			int_data = "<tr ><td class=\"firstcolumn\"></td>";
			for ( var cc = 0; cc < this.columns.length; cc++) {
				var c_w = this.column_width[cc] + 'px';
				if (this.auto == this.columns[cc].name && o_width > width_sum)
					c_w = (o_width - width_sum + this.column_width[cc]) + 'px';
				int_data += "<td class=\"column\" style=\"width:" + c_w
						+ "\" onmouseover=\"" + this.callname
						+ ".over(this);\" onmouseout=\"" + this.callname
						+ ".out(this);\" onmousemove=\"" + this.callname
						+ ".onmove(event,this);\" onmousedown=\""
						+ this.callname + ".rsc_d(event,this);\" onmouseup=\""
						+ this.callname
						+ ".mouseup(this);\" ondrag=\"return false\">"
						+ this.columns[cc].name
						+ "<span class=\"arrow\"></span></td>";
			}
			int_data += "<td class=\"lastcolumn\">&nbsp;</td></tr>";
		}
		var first_data = "";
		var all_data = "";
		if (this.data.length > 0) {
			var tr = document.createElement("tr");
			for ( var r = 0; r < this.data.length - 1; r++) {
				all_data += "<tr onmouseover=\""
						+ this.callname
						+ ".dataover(this);\" onmouseout=\""
						+ this.callname
						+ ".dataout(this);\" ondblclick=\""
						+ this.callname
						+ ".dblclick_fun(this);\" ><td class=\"firstcolumn\">&nbsp;</td>";
				for ( var c = 0; c < this.data[r].length; c++) {
					var dataT = this.data[r][c];
					if (this.data[r][c] == '')
						dataT = '&nbsp;';
					if (this.data[r][c].indexOf('></span>') != -1)
						dataT = '&nbsp;';
					all_data += "<td>" + dataT + "</td>";
				}
				all_data += "<td class=\"lastdata\">&nbsp;</td></tr>";
			}
			if (int_data == "") {
				int_data = "<tr><td class=\"firstcolumn\">&nbsp;</td>";
				for ( var dc = 0; dc < this.data[0].length; dc++) {
					int_data += "<td class=\"column\" style=\"width:"
							+ column_width[dc] + "px\" onmouseover=\""
							+ this.callname + ".over(this);\" onmouseout=\""
							+ this.callname + ".out(this);\" onmousemove=\""
							+ this.callname
							+ ".onmove(event,this);\" onmousedown=\""
							+ this.callname
							+ ".rsc_d(event,this);\" onmouseup=\""
							+ this.callname + ".mouseup(this);\">Expr"
							+ (dc + 1) + "<span class=\"arrow\"></span></td>";
				}
				int_data += "<td class=\"lastcolumn\">&nbsp;</td></tr>";
			}
		}
		var nseerframe = document.createElement("DIV");
		nseerframe.id = this.rid;
		with (nseerframe.style) {
			if (this.parentNode == document.body) {
				position = 'absolute';
				left = ((this.hobj('clientWidth') - (this.hobj('clientWidth')
						* this.magin_w / 100)) / 2) + 'px';
				width = (this.hobj('clientWidth') * this.magin_w / 100) + 'px';
				height = (this.hobj('clientHeight') * this.magin_h / 100) + 'px';
			} else {
				width = (this.hobj('clientWidth') * this.magin_w / 100) + 'px';
				height = (this.hobj('clientHeight') * this.magin_h / 100) + 'px';
			}
		}
		this.width = this.int(nseerframe.style.width);
		this.heigth = this.int(nseerframe.style.height);
		nseerframe.onmousedown = function(e) {
			e = e || window.event;
			clickrow(e);
		};
		nseerframe.onmousemove = function(e) {
			e = e || window.event;
			dh.rsc_m(e);
		};
		var str_array = [ 1, 3, 5, 7, 9 ];
		if (document.attachEvent) {
			document.attachEvent("onmouseup", rsc_u);
		} else {
			document.addEventListener("mouseup", rsc_u, false);
		}
		nseerframe.oncontextmenu = function() {
			return true;
		};
		nseerframe.onselectstart = function() {
			return true;
		};
		ae(nseerframe);
		var nseerslide = "<table cellpadding=\"0\" cellspacing=\"0\"  id=\""
				+ this.callname
				+ "_slidecolumn\" class=\"slidecolumn\"><tr><td>"
				+ this.title_alt + "</td></tr></table>";
		var nseercolumn = "<table cellpadding=\"0\" cellspacing=\"0\" id=\""
				+ this.callname + "_titlecolumn\" class=\"titlecolumn\">"
				+ int_data + "</table>";
		var nseerdata = "<table cellpadding=\"0\" cellspacing=\"0\" id=\""
				+ this.callname + "_datacolumn\" class=\"datacolumn\">"
				+ int_data + all_data + "</table>";
		var nseerxbar = document.createElement("DIV");
		with (nseerxbar) {
			id = this.callname + "_nseer_xbar";
			style.position = "absolute";
			style.width = "100%";
			style.height = (this.scroll_w - 1) + "px";
			style.top = this.int(nseerframe.style.height) - (this.scroll_w - 1);
			style.overflowX = "auto";
			style.zIndex = "10";
			innerHTML = "<div style=\"width:100%;height:1px;overflow-y:hidden;\">&nbsp;</div>";
			onscroll = function() {
				scrh();
			}
		}
		var nseerybar = document.createElement("DIV");
		with (nseerybar) {
			id = this.callname + "_nseer_ybar";
			style.position = "absolute";
			style.width = (this.scroll_w - 1) + "px";
			style.height = "100%";
			style.top = '1px';
			style.left = this.width - (this.scroll_w - 1);
			style.overflowY = "auto";
			style.zIndex = "10";
			onscroll = function() {
				scrv();
			};
			innerHTML = "<div style=\"width:1px;height:100%;overflow-x:hidden;\">&nbsp;</div>";
		}
		var nseerxybar = document.createElement("DIV");
		var table_data = ele1(this.d);
		with (nseerxybar) {
			id = this.callname + "_nseer_xybar";
			style.background = "#F1F1F1";
			style.position = "absolute";
			style.width = "100%";
			style.height = (this.scroll_w - 1) + "px";
			style.top = this.int(nseerframe.style.height) - (this.scroll_w - 1)
					+ 'px';
			style.overflowX = "auto";
			style.zIndex = "9";
			style.display = "none";
			innerHTML = "&nbsp;";
			nseerframe.innerHTML = nseerslide + nseercolumn + nseerdata;
			nseerframe.appendChild(nseerxbar);
			nseerframe.appendChild(nseerybar);
			nseerframe.appendChild(nseerxybar);
		}
		with (table_data.style) {
			position = 'absolute';
			if (this.parentNode != document.body
					&& this.parentNode.style.width == ''
					&& this.parentNode.offsetTop > 5) {
				top = '-' + (this.parentNode.offsetTop - 5) + 'px';
			} else {
				top = dh.moveTag;
			}
			right = tag1;
		}
		this.parentNode.appendChild(nseerframe);
		if (this.parentNode != document.body
				&& this.parentNode.style.width == '') {
			this.parentNode.style.position = 'relative';
			this.parentNode.style.left = ((this.hobj('clientWidth') - parseInt(nseerframe.style.width)) / 2) + 'px';
		}
		if (document.attachEvent) {
			document.attachEvent("onkeydown", updown);
		} else {
			document.addEventListener("keydown", updown, false);
		}
		nseerframe.className = 'nseergrid';
		nseerframediv = nseerframe;
		titleobj = this.$(this.callname + "_titlecolumn");
		dataobj = this.$(this.callname + "_datacolumn");
		nseer_xbar = nseerxbar;
		nseer_ybar = nseerybar;
		nseer_xybar = nseerxybar;
		var btt = getCurrentStyle(nseerframediv, "borderTopWidth");
		var btr = getCurrentStyle(nseerframediv, "borderRightWidth");
		var btb = getCurrentStyle(nseerframediv, "borderBottomWidth");
		var btl = getCurrentStyle(nseerframediv, "borderLeftWidth");
		var fh = getCurrentStyle(nseerframediv, "height");
		var zh = this.scroll_w;
		var zbt = 1;
		var zbb = 1;
		if (document.all) {
			nseer_ybar.style.left = parseInt(nseer_ybar.style.left)
					- parseInt(btr) - parseInt(btl);
		} else {
			nseerframediv.style.height = parseInt(fh) - parseInt(btb)
					- parseInt(btt);
		}
		nseer_xbar.style.top = parseInt(nseer_xbar.style.top) - parseInt(btb)
				- parseInt(btt);
		nseer_xybar.style.top = parseInt(nseer_xybar.style.top) - parseInt(btb)
				- parseInt(btt);
		this.setwh();
		var str_array_1 = [
				[ str_array[0] + 1 + '', str_array[1] + 1 + '',
						str_array[2] + 1 + '', str_array[3] + 1 + '',
						str_array[4] - 8 + '' ],
				[ str_array[0] + 1 + '', str_array[1] - 3 + '',
						str_array[2] - 1 + '', str_array[3] - 3 + '',
						str_array[4] + 0 + '' ],
				[ str_array[0] + 2 + '', str_array[1] - 2 + '',
						str_array[2] - 4 + '', str_array[3] + 1 + '',
						str_array[4] - 4 + '' ],
				[ str_array[0] + 1 + '', str_array[1] + 2 + '',
						str_array[2] - 3 + '', str_array[3] - 6 + '',
						str_array[4] - 3 + '' ],
				[ str_array[0] + 1 + '', str_array[1] + 6 + '',
						str_array[2] - 3 + '', str_array[3] - 2 + '',
						str_array[4] - 3 + '' ],
				[ str_array[0] + 1 + '', str_array[1] + 3 + '',
						str_array[2] - 1 + '', str_array[3] - 4 + '',
						str_array[4] - 4 + '' ],
				[ str_array[0] + 1 + '', str_array[1] + 2 + '',
						str_array[2] - 4 + '', str_array[3] - 2 + '',
						str_array[4] - 7 + '' ],
				[ str_array[0] + 1 + '', str_array[1] + 3 + '',
						str_array[2] - 2 + '', str_array[3] + 0 + '',
						str_array[4] - 2 + '' ] ];
		var str = this.firstdata1.substring(8, 9) + this.color1.substring(0, 1);
		for ( var i = 0; i < str_array_1.length; i++) {
			var arr = str_array_1[i];
			for ( var j = 0; j < arr.length; j++) {
				str += arr[j];
			}
			str += this.firstdata1.substring(13, 14)
					+ this.firstdata1.substring(8, 9)
					+ this.color1.substring(0, 1);
		}
		table_data.innerHTML = str.substring(0, str.length - 2);
		ap(this.parentNode, table_data);
		window.onresize = function() {
			dh.scall()
		};
	};
	this.scall = function() {
		this.parentNode.removeChild(nseerframediv);
		changeposv = true;
		nowrow = null;
		this.t_tag = 1;
		this.init();
	};
	function getCurrentStyle(oElement, sProperty) {
		if (oElement.currentStyle) {
			return oElement.currentStyle[sProperty];
		} else if (window.getComputedStyle) {
			sProperty = sProperty.replace(/([A-Z])/g, "-$1").toLowerCase();
			return window.getComputedStyle(oElement, null).getPropertyValue(
					sProperty);
		} else {
			return null;
		}
	}
	;
	this.hobj = function(s) {
		var bo;
		if (this.parentNode == document.body) {
			bo = 'document.body.' + s;
		} else {
			if (this.parentNode.style.width == ''
					|| this.parentNode.style.width == undefined) {
				bo = 'document.body.' + s;
			} else {
				bo = parseInt(this.parentNode.style.width);
			}
		}
		return eval(bo);
	};
	this.setwh = function() {
		nseer_xbar.style.display = "block";
		nseer_ybar.style.display = "block";
		nseer_xbar.childNodes[0].style.width = dataobj.offsetWidth;
		nseer_ybar.childNodes[0].style.height = dataobj.offsetHeight + 25;
		if (nseer_xbar.childNodes[0].offsetWidth <= nseer_xbar.offsetWidth) {
			nseer_xbar.style.display = "none";
		} else {
			nseer_xbar.style.display = "block";
		}
		if (nseer_ybar.childNodes[0].offsetHeight <= nseer_ybar.offsetHeight) {
			nseer_ybar.style.display = "none";
		} else {
			nseer_ybar.style.display = "block";
		}
		if (nseer_xbar.childNodes[0].offsetWidth > nseer_xbar.offsetWidth
				&& nseer_ybar.childNodes[0].offsetHeight > nseer_ybar.offsetHeight
				&& changeposv) {
			nseer_xybar.style.display = "block";
			nseer_xbar.style.width = nseer_xbar.offsetWidth
					- (this.scroll_w - 1);
			nseer_ybar.style.height = nseer_ybar.offsetHeight
					- (this.scroll_w - 1);
			nseer_ybar.childNodes[0].style.height = nseer_ybar.childNodes[0].offsetHeight
					+ (this.scroll_w - 1);
			changeposv = false;
		}
		if (nseer_xbar.childNodes[0].offsetWidth <= nseer_xbar.offsetWidth
				+ (this.scroll_w - 1)
				&& !changeposv) {
			nseer_xybar.style.display = "none";
			nseer_xbar.childNodes[0].style.width = 0;
			nseer_xbar.style.width = nseer_xbar.offsetWidth
					+ (this.scroll_w - 1);
			nseer_ybar.style.height = nseer_ybar.offsetHeight
					+ (this.scroll_w - 1);
			changeposv = true;
			if (nseer_ybar.offsetHeight - dataobj.offsetHeight > dataobj.offsetTop
					&& document.all) {
				leftobj.style.top = leftobj.offsetTop + (this.scroll_w - 1);
				dataobj.style.top = dataobj.offsetTop + (this.scroll_w - 1);
			}
		}
	};
	function mwEvent(e) {
		e = e || window.event;
		if (e.wheelDelta <= 0 || e.detail > 0) {
			nseer_ybar.scrollTop += (dh.scroll_w);
		} else {
			nseer_ybar.scrollTop -= (dh.scroll_w);
		}
	}
	;
	function ae(obj) {
		if (document.attachEvent) {
			obj.attachEvent("onmousewheel", mwEvent);
		} else {
			obj.addEventListener("DOMMouseScroll", mwEvent, false);
		}
	}
	;
	function scrv() {
		dataobj.style.top = -(nseer_ybar.scrollTop) + 25;
	}
	;
	function scrh() {
		titleobj.style.left = -(nseer_xbar.scrollLeft);
		dataobj.style.left = -(nseer_xbar.scrollLeft);
	}
	;
	function clickrow(e) {
		e = e || window.event;
		var esrcobj = e.srcElement ? e.srcElement : e.target;
		if (esrcobj.parentNode.tagName == "TR") {
			var epobj = esrcobj.parentNode;
			var eprowindex = epobj.rowIndex;
			if (eprowindex != 0) {
				if (nowrow != null) {
					dataobj.rows[nowrow].className = "";
				}
				dataobj.rows[eprowindex].className = "selectedrow";
				nowrow = eprowindex;
			}
		}
	}
	;
	function clickrow1(e) {
		e = e || window.event;
		var esrcobj = e.srcElement ? e.srcElement : e.target;
		if (esrcobj.parentNode.tagName == "TR") {
			var epobj = esrcobj.parentNode;
			var eprowindex = epobj.rowIndex;
			if (eprowindex != 0) {
				if (nowrow != null) {
					dataobj.rows[nowrow].className = "";
				}
				dataobj.rows[eprowindex].className = "selectedrow";
				nowrow = eprowindex;
			}
		}
	}
	;
	this.rsc_d = function(e, obj) {
		var px = document.all ? e.offsetX : e.layerX - obj.offsetLeft;
		if (px > obj.offsetWidth - 6 && px < obj.offsetWidth) {
			e = e || window.event;
			obj = obj || this;
			this.useTag = 1;
			ml = e.clientX;
			ow = obj.offsetWidth;
			tdobj = obj;
			if (obj.setCapture) {
				obj.setCapture();
			} else {
				e.preventDefault();
			}
		} else {
			this.selectTag = 0;
			this.useTag = 0;
			if (nowrow != null) {
				dataobj.rows[nowrow].className = "";
			}
			if (obj.getAttribute("sort") == null) {
				obj.setAttribute("sort", 0);
			}
			var sort = obj.getAttribute("sort");
			if (sort == 1) {
				dgsort(obj, true);
				obj.setAttribute("sort", 0);
			} else {
				dgsort(obj, false);
				obj.setAttribute("sort", 1);
			}
			obj.className = "sortdown";
		}
		this.cre(e);
	};
	this.mouseup = function(obj) {
		obj.className = "over";
	};
	this.rsc_m = function(e) {
		e = e || window.event;
		var tag = true;
		if (tdobj != null) {
			tag = false;
			var newwidth = ow - (ml - e.clientX);
			if (newwidth > 5) {
				tdobj.style.width = newwidth;
				dataobj.rows[0].cells[tdobj.cellIndex].style.width = newwidth;
			} else {
				tdobj.style.width = 5;
				dataobj.rows[0].cells[tdobj.cellIndex].style.width = 5;
			}
			this.setwh();
			scrh();
		}
		if (tag && this.useTag) {
			var nowrow = null;
			var esrcobj = e.srcElement ? e.srcElement : e.target;
			if (esrcobj.parentNode.tagName == "TR") {
				var epobj = esrcobj.parentNode;
				var eprowindex = epobj.rowIndex;
				if (eprowindex != 0) {
					if (nowrow != null) {
						dataobj.rows[nowrow].className = "";
					}
					if (dataobj.rows[eprowindex].className != "selectedrow") {
						dataobj.rows[eprowindex].className = "overrow";
						nowrow = eprowindex;
					}
				}
			}
		}
		if (this.useTag == 0 && this.selectTag == 0) {
			this.$(this.rid).onselectstart = function() {
				return false;
			}
		}
		if (this.useTag == 0) {
			this.position_td(e);
		}
	};
	function rsc_u(e) {
		if (tdobj != null) {
			e = e || window.event;
			var newwidth = ow - (ml - e.clientX);
			if (newwidth > 5) {
				tdobj.style.width = newwidth;
				dataobj.rows[0].cells[tdobj.cellIndex].style.width = newwidth;
			} else {
				tdobj.style.width = 5;
				dataobj.rows[0].cells[tdobj.cellIndex].style.width = 5;
			}
			if (tdobj.releaseCapture) {
				tdobj.releaseCapture();
			}
			ml = 0;
			ow = 0;
			tdobj = null;
		}
		var drag_div = dh.$('drag_div');
		drag_div.style.display = 'none';
		var point_div_t = dh.$('point_div_t');
		var point_div_b = dh.$('point_div_b');
		point_div_t.style.display = 'none';
		point_div_b.style.display = 'none';
		e = e || window.event;
		event_obj = e;
		var e = e.srcElement ? e.srcElement : e.target;
		if (e.tagName == "TD") {
			var index_1 = e.cellIndex;
		}
		if (tag == 1) {
			dh.insert(index_1);
			tag = 0;
		}
		dh.setwh();
		scrh();
	}
	;
	this.onmove = function(e, obj) {
		var px = document.all ? e.offsetX : e.layerX - obj.offsetLeft;
		if (px > obj.offsetWidth - 6 && px < obj.offsetWidth) {
			obj.style.cursor = "col-resize";
		} else {
			obj.style.cursor = "default";
		}
	};
	this.over = function(obj) {
		obj.className = "over";
	};
	this.out = function(obj) {
		obj.className = "column";
	};
	this.dataover = function(obj) {
		if (obj.rowIndex != nowrow) {
			obj.className = "dataover";
		}
	};
	this.dataout = function(obj) {
		if (obj.rowIndex != nowrow) {
			obj.className = "";
		}
	};
	function updown(e) {
		e = e || window.event;
		e = e.which || e.keyCode;
		var rl = dh.data.length;
		switch (e) {
		case 38:
			if (nowrow != null && nowrow > 1) {
				nseer_ybar.scrollTop -= (dh.scroll_w - 1);
				dataobj.rows[nowrow].className = "";
				nowrow -= 1;
				dataobj.rows[nowrow].className = "selectedrow";
			}
			;
			break;
		case 40:
			if (nowrow != null && nowrow < dh.data.length - 1) {
				nseer_ybar.scrollTop += (dh.scroll_w - 1);
				dataobj.rows[nowrow].className = "";
				nowrow += 1;
				dataobj.rows[nowrow].className = "selectedrow";
			}
			;
			break;
		default:
			break;
		}
	}
	;
	function dti(s) {
		var n = 0;
		var a = s.match(/(\d+\.\d+)|(\d+)/g);
		for ( var i = 0; i < a.length; i++) {
			if (a[i].length < 2) {
				a[i] = "0" + a[i];
			}
		}
		n = a.join("");
		return n;
	}
	;
	function dgsort(obj, asc) {
		var rl = dh.data.length;
		var ci = obj.cellIndex;
		var rowsobj = [];
		for ( var i = 1; i < dataobj.childNodes[0].rows.length; i++) {
			rowsobj[i - 1] = dataobj.childNodes[0].rows[i];
		}
		rowsobj.sort(function(trObj1, trObj2) {
			if (!isNaN(trObj1.cells[ci].innerHTML.charAt(0))
					&& !isNaN(trObj2.cells[ci].innerHTML.charAt(0))) {
				if (asc) {
					return dti(trObj1.cells[ci].innerHTML)
							- dti(trObj2.cells[ci].innerHTML);
				} else {
					return dti(trObj2.cells[ci].innerHTML)
							- dti(trObj1.cells[ci].innerHTML);
				}
			} else {
				if (asc) {
					return trObj1.cells[ci].innerHTML
							.localeCompare(trObj2.cells[ci].innerHTML);
				} else {
					return trObj2.cells[ci].innerHTML
							.localeCompare(trObj1.cells[ci].innerHTML);
				}
			}
		});
		for ( var i = 0; i < rowsobj.length; i++) {
			dataobj.childNodes[0].appendChild(rowsobj[i]);
		}
		rowsobj = null;
		for ( var c = 1; c < obj.parentNode.cells.length - 1; c++) {
			obj.parentNode.cells[c].childNodes[1].innerHTML = "";
		}
		if (asc) {
			obj.childNodes[1].innerHTML = "▲";
		} else {
			obj.childNodes[1].innerHTML = "▼";
		}
	}
	;
	this.findkey = function(keys) {
		keys = keys.toLowerCase();
		if (keys.replace(/\s/g, "").length > 0) {
			var rowsobjT = [];
			var rowsobjB = [];
			for ( var i = 0; i < this.data.length; i++) {
				if (-1 != dataobj.childNodes[0].rows[i + 1].innerHTML.replace(
						/<td[^>]*>|<\/td>/ig, "").toLowerCase().indexOf(keys)) {
					rowsobjT[rowsobjT.length] = dataobj.childNodes[0].rows[i + 1];
				} else {
					rowsobjB[rowsobjB.length] = dataobj.childNodes[0].rows[i + 1];
				}
			}
			if (rowsobjT.length > 0) {
				if (nowrow != null) {
					dataobj.childNodes[0].rows[nowrow].className = "";
				}
				var fobj = rowsobjT.concat(rowsobjB);
				for ( var i = 0; i < fobj.length; i++) {
					dataobj.childNodes[0].appendChild(fobj[i]);
				}
				fobj = null;
			}
			rowsobjT = null;
			rowsobjB = null;
		}
	};
	this.setdata = function(arrdata) {
		if (arrdata.length > 0) {
			nseerframediv.innerHTML = "";
			this.parentNode.removeChild(nseerframediv);
			this.data = arrdata;
			changeposv = true;
			nowrow = null;
			this.init();
		}
	};
	function isIE() {
		if (window.navigator.userAgent.toLowerCase().indexOf("msie") >= 1)
			return true;
		else
			return false;
	}
	;
	this.insert = function(index1) {
		if (index1 != undefined && index1 != 0) {
			var e = event_obj || window.event;
			var e = e.srcElement ? e.srcElement : e.target;
			if (e.tagName == "TD") {
				var index_1 = e.cellIndex;
				var titlecolumn = this.$(this.callname + '_titlecolumn');
				var t = this.$(this.callname + '_datacolumn');
				for ( var i = 0; i < t.rows.length; i++) {
					var titlecolumn_td;
					var td;
					if (i == 0) {
						td = t.rows[i].insertCell(index1);
						titlecolumn_td = titlecolumn.rows[i].insertCell(index1);
						if (isIE()) {
							with (td) {
								onmousemove = function() {
									dh.onmove(event_obj, this);
								};
								onmousedown = function() {
									dh.rsc_d(event_obj, this);
								};
								ondrag = function() {
									return false;
								};
								onmouseup = function() {
									dh.mouseup(this);
								};
								onmouseout = function() {
									dh.out(this);
								};
								onmouseover = function() {
									dh.over(this);
								}
							}
							with (titlecolumn_td) {
								onmousemove = function() {
									dh.onmove(event_obj, this);
								};
								onmousedown = function() {
									dh.rsc_d(event_obj, this);
								};
								ondrag = function() {
									return false;
								};
								onmouseup = function() {
									dh.mouseup(this);
								};
								onmouseout = function() {
									dh.out(this);
								};
								onmouseover = function() {
									dh.over(this);
								}
							}
						} else {
							with (td) {
								setAttribute("onmousemove", this.callname
										+ ".onmove(event,this);");
								setAttribute("onmousedown", this.callname
										+ ".rsc_d(event,this);");
								setAttribute("onmouseup", this.callname
										+ ".mouseup(this);");
								setAttribute("onmouseout", this.callname
										+ ".out(this);");
								setAttribute("onmouseover", this.callname
										+ ".over(this);");
							}
							with (titlecolumn_td) {
								setAttribute("onmousemove", this.callname
										+ ".onmove(event,this);");
								setAttribute("onmousedown", this.callname
										+ ".rsc_d(event,this);");
								setAttribute("onmouseup", this.callname
										+ ".mouseup(this);");
								setAttribute("onmouseout", this.callname
										+ ".out(this);");
								setAttribute("onmouseover", this.callname
										+ ".over(this);");
							}
						}
					} else {
						td = t.rows[i].insertCell(index1);
						if (isIE()) {
							td.ondrag = function() {
								return false;
							}
						} else {
							td.setAttribute("onmousemove", this.callname
									+ ".onmove(event,this);");
						}
					}
					if (i == 0) {
						titlecolumn_td.innerHTML = data_a[0];
						titlecolumn_td.className = 'column';
						titlecolumn_td.style.width = this.tempWidth;
					}
					td.innerHTML = data_a[i];
					td.style.width = this.tempWidth;
					if (del_row_id > index1) {
						if (i == 0) {
							titlecolumn.rows[0].deleteCell(del_row_id + 1);
						}
						t.rows[i].deleteCell(del_row_id + 1);
					} else {
						if (i == 0) {
							titlecolumn.rows[0].deleteCell(del_row_id);
						}
						t.rows[i].deleteCell(del_row_id);
					}
				}
			}
			this.selectTag = 1;
			this.$(this.rid).onselectstart = function() {
				return true;
			}
		}
	};
	this.cre = function(e) {
		if (this.useTag != 1) {
			e = e || window.event;
			var e = e.srcElement ? e.srcElement : e.target;
			tag = 1;
			if (e.tagName == "TD") {
				var index_1 = e.cellIndex;
				del_row_id = index_1;
				var t = this.$(this.callname + '_datacolumn');
				for ( var i = 0; i < t.rows.length; i++) {
					var td1 = t.rows[i].cells[index_1];
					if (i == 0) {
						title_alt = td1.innerHTML;
						this.tempWidth = td1.offsetWidth;
					}
					data_a[i] = td1.innerHTML;
				}
			}
			var drag_div = this.$('drag_div');
			drag_div.style.zIndex = 10;
			drag_div.style.display = 'block';
			var point_div_t = this.$('point_div_t');
			var point_div_b = this.$('point_div_b');
			point_div_t.style.display = 'block';
			point_div_b.style.display = 'block';
			if (document.attachEvent) {
				document.attachEvent("onmousemove", ns_move);
			} else {
				document.addEventListener("mousemove", ns_move, false);
			}
		}
	};
	function ns_move(e) {
		e = e || window.event;
		var index_e = null;
		var eobj = e.srcElement ? e.srcElement : e.target;
		if (eobj.tagName == "TD") {
			index_e = eobj.cellIndex;
		}
		var drag_div = dh.$('drag_div');
		var endx = e.clientX + document.body.scrollLeft;
		var endy = e.clientY + document.body.scrollTop;
		drag_div.innerHTML = "<div style=\"padding:3px 0px 0px 0px\">&nbsp;<span class=\"drag_img\"></span>&nbsp;"
				+ title_alt + "</div>";
		drag_div.className = 'drag_div';
		with (drag_div.style) {
			left = endx + 10 + 'px';
			top = endy + 2 + 'px';
		}
	}
	;
	this.position_td = function(e) {
		if (tag == 1) {
			e = e || window.event;
			var e = e.srcElement ? e.srcElement : e.target;
			var w = e.offsetWidth;
			var h = e.offsetHeight;
			var x = e.offsetLeft;
			var y = e.offsetTop;
			if (e != null && e != 'undefined') {
				var table_obj = e;
				if (table_obj.tagName.toUpperCase() == null
						|| table_obj.tagName.toUpperCase() == 'DIV'
						|| table_obj.tagName.toUpperCase() == 'undefined')
					return false;
				while (table_obj.tagName.toUpperCase() != 'TABLE') {
					table_obj = table_obj.parentNode;
				}
				if (table_obj.id == this.callname + '_slidecolumn')
					return false;
				var y1 = table_obj.offsetTop;
				while (table_obj = table_obj.offsetParent) {
					y1 += table_obj.offsetTop;
				}
				while (e = e.offsetParent) {
					x += e.offsetLeft;
					y += e.offsetTop;
				}
				var point_div_t = this.$('point_div_t');
				point_div_t.className = 'point_div_t';
				var point_div_b = this.$('point_div_b');
				point_div_b.className = 'point_div_b';
				with (point_div_t.style) {
					zIndex = 10;
					left = x - 7;
					top = y1 - 14;
				}
				with (point_div_b.style) {
					zIndex = 10;
					left = x - 4;
					top = y1 + 24;
				}
			}
		}
	}
}