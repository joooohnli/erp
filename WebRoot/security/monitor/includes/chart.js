var CHART_LINE    =  1;
var CHART_AREA    =  2;
var CHART_BAR     =  3;
var CHART_STACKED =  4;
var _horiz= 0;
var y_horiz= 0;

var nn= 0;
var access_num=0;
var element_link;



function Chart(el) {
	nn= 0;
	access_num=0;
	this._cont             = el;
	this._yMin             = null;
	this._yMax             = null;
	this._xGri     = 0;
	this._yGr     = 0;
	this._flags            = 0;
	this._series           = new Array();
	this._labelPrecision   = 0;
	this._horizontalLabels = new Array();
	this._barWidth;
	this._barDistance      = 2;
	this._bars             = 0;
	this._showLegend       = true;
	
	if ((typeof CanvasChartPainterFactory != 'undefined') && (window.CanvasRenderingContext2D)) {
		this._painterFactory = CanvasChartPainterFactory;
	}
	else if (typeof JsGraphicsChartPainterFactory != 'undefined') {
		this._painterFactory = JsGraphicsChartPainterFactory;
	}
	else { this._painterFactory = null; }
}


Chart.prototype.setPainterFactory = function(f) {
	this._painterFactory = f;
};


Chart.prototype.setVerticalRange = function(min, max) {
	this._yMin = min;
	this._yMax = max;
};


Chart.prototype.setLabelPrecision = function(precision) {
	this._labelPrecision = precision;
};


Chart.prototype.setShowLegend = function(b) {
	this._showLegend = b;
};

Chart.prototype.setHorizontalLabels = function(labels) {
	this._horizontalLabels = labels;
	_horiz=labels.length;
		
};


Chart.prototype.setDefaultType = function(flags) {
	this._flags = flags;
};


Chart.prototype.setBarWidth = function(width) {
	this._barWidth = width;
};


Chart.prototype.setBarDistance = function(distance) {
	this._barDistance = distance;
};


Chart.prototype.add = function(label, color, values, flags) {
	var o, offset;
    //alert(values);
	if (!flags) { flags = this._flags; }
	if ((flags & CHART_BAR) == CHART_BAR) { offset = this._barDistance + this._bars * (this._barWidth + this._barDistance); this._bars++; }
	else { offset = 0; }
	o = new ChartSeries(label, color, values, flags, offset);
	this._series.push(o);
};


Chart.prototype.draw = function() {
	var painter, i, o, o2, len, xlen, ymin, ymax, series, type, self, bLabels;
	
	if (!this._painterFactory) { return; }

	/* Initialize */
	series = new Array();
	stackedSeries = new Array();
	xlen = 0;
	ymin = this._yMin;
	ymax = this._yMax;

	/* Separate stacked series (as they need processing). */
	for (i = 0; i < this._series.length; i++) {
		o = this._series[i]
		if ((o.flags & CHART_STACKED) == CHART_STACKED) { series.push(o); }
	}

	/* Calculate values for stacked series */
	for (i = series.length - 2; i >= 0; i--) {
		o  = series[i].values;
		o2 = series[i+1].values;
		len = (o2.length > o.length)?o2.length:o.length;
		//alert(len);
		for (j = 0; j < len; j++) {
			if ((o[j]) && (!o2[j])) { continue; }
			if ((!o[j]) && (o2[j])) { o[j] = o2[j]; }
			else { o[j] = parseInt(o[j]) + parseFloat(o2[j]); }
	}	}

	/* Append non-stacked series to list */
	for (i = 0; i < this._series.length; i++) {
		o = this._series[i]
		if ((o.flags & CHART_STACKED) != CHART_STACKED) { series.push(o); }
	}

	/* Determine maximum number of values, ymin and ymax */
	for (i = 0; i < series.length; i++) {
		o = series[i]
		if (o.values.length > xlen) { xlen = o.values.length; }
		for (j = 0; j < o.values.length; j++) {
			if ((o.values[j] < ymin) || (ymin == null))  { ymin = o.values[j]; }
			if (o.values[j] > ymax) { ymax = o.values[j]; }
	}	}

	/*
	 * For bar only charts the number of charts is the same as the length of the
	 * longest series, for others combinations it's one less. Compensate for that
	 * for bar only charts.
	 */
	if (this._series.length == this._bars) {
		xlen++;
		this._xGri++;
	}

	/*
	 * Determine whatever or not to show the legend and axis labels
	 * Requires density and labels to be set.
	 */
	bLabels = ( (this._horizontalLabels.length >= this._xGri));
	//alert(bLabels);
	/* Create painter object */
	painter = this._painterFactory();
	painter.create(this._cont);


	/* Initialize painter object */
	painter.init(xlen, ymin, ymax, this._xGri, this._yGr, bLabels);

	/* Draw chart */
	painter.drawBackground();

	/*
	 * If labels and grid density where specified, draw legend and labels.
	 * It's drawn prior to the chart as the size of the legend and labels
	 * affects the size of the chart area.
	 */
	if (this._showLegend) { painter.drawLegend(series); }
	if (bLabels) {
		painter.drawVerticalAxis(this._yGr, this._labelPrecision);//画竖线标注
		painter.drawHorizontalAxis(xlen, this._horizontalLabels, this._xGri, this._labelPrecision);//画横线标注
	}
	/* Draw chart */
	painter.drawChart();

	/* Draw series */
	for (i = 0; i < series.length; i++) {
		type = series[i].flags & ~CHART_STACKED;
		switch (type) {
			case CHART_LINE: painter.drawLine(series[i].color, series[i].values); break;
			case CHART_AREA: painter.drawArea(series[i].color, series[i].values); break;
			case CHART_BAR:  painter.drawBars(series[i].color, series[i].values, xlen-1, series[i].offset, this._barWidth); break;
			default: ;
		};
	}
	painter.drawAxis();
};
function ChartSeries(label, color, values, flags, offset) {
	this.label  = label;
	this.color  = color;
	this.values = values;
	this.flags  = flags;
	this.offset = offset;
}
function AbstractChartPainter() {
};

AbstractChartPainter.prototype.calc = function(w, h, xlen, ymin, ymax, xgd, ygd) {
	this.range = ymax - ymin;
	this.xstep = w / (xlen - 1);
	this.xgrid = (xgd)?w / (xgd - 1):0;
	this.ygrid = (ygd)?h / (ygd - 1):0;
	this.ymin  = ymin;
	this.ymax  = ymax;
};


AbstractChartPainter.prototype.create = function(el) {};
AbstractChartPainter.prototype.init = function(xlen, ymin, ymax, xgd, ygd, bLabels) {};
AbstractChartPainter.prototype.drawLegend = function(series) {};
AbstractChartPainter.prototype.drawVerticalAxis = function(ygd, precision) {};
AbstractChartPainter.prototype.drawHorizontalAxis = function(xlen, labels, xgd, precision) {};
AbstractChartPainter.prototype.drawAxis = function() {};
AbstractChartPainter.prototype.drawBackground = function() {};
AbstractChartPainter.prototype.drawChart = function() {};
AbstractChartPainter.prototype.drawArea = function(color, values) {};
AbstractChartPainter.prototype.drawLine = function(color, values) {};
AbstractChartPainter.prototype.drawBars = function(color, values, xlen, xoffset, width) {};
