/* This notice must be untouched at all times.

wz_jsgraphics.js    v. 2.33
The latest version is available at
http://www.walterzorn.com
or http://www.devira.com
or http://www.walterzorn.de

Copyright (c) 2002-2004 Walter Zorn. All rights reserved.
Created 3. 11. 2002 by Walter Zorn (Web: http://www.walterzorn.com )
Last modified: 24. 10. 2005

Performance optimizations for Internet Explorer
by Thomas Frank and John Holdsworth.
fillPolygon method implemented by Matthieu Haller.

High Performance JavaScript Graphics Library.
Provides methods
- to draw lines, rectangles, ellipses, polygons
	with specifiable line thickness,
- to fill rectangles and ellipses
- to draw text.
NOTE: Operations, functions and branching have rather been optimized
to efficiency and speed than to shortness of source code.

LICENSE: LGPL

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License (LGPL) as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA,
or see http://www.gnu.org/copyleft/lesser.html
*/


function SVGChartPainterFactory() {
	return new SVGChartPainter();
}


function SVGChartPainter() {
	this.base = AbstractChartPainter;
};


SVGChartPainter.prototype = new AbstractChartPainter;


SVGChartPainter.prototype.create = function(el) {
	this.svg = el;
	this.w = this.svg.getAttribute('width');
	this.h = this.svg.getAttribute('height');
};


SVGChartPainter.prototype.init = function(xlen, ymin, ymax, xgd, ygd, bLegendLabels) {
	this.calc(this.w, this.h, xlen, ymin, ymax, xgd, ygd);
};


SVGChartPainter.prototype.drawBackground = function() {
	while (this.svg.firstChild) { this.svg.removeChild(this.svg.lastChild); }
	this._drawRect('white', 0, 0, this.w, this.h);
};


SVGChartPainter.prototype.drawChart = function() {
	if (this.xgrid) {
		for (i = this.xgrid; i < this.w; i += this.xgrid) {
			this._drawRect('silver', 0 + i, 0, 1, this.h-1);
	}	}
	if (this.ygrid) {
		for (i = this.h - this.ygrid; i > 0; i -= this.ygrid) {
			this._drawRect('silver', 1, 0 + i, this.w, 1);
}	}	};


SVGChartPainter.prototype.drawAxis = function() {
	this._drawRect('black', 0, 0, 1, this.h);
	this._drawRect('black', 0, this.h-1, this.w, 1);
};


SVGChartPainter.prototype.drawArea = function(color, values) {

	var i, len, x, y, n, yoffset, path, o;

	/* Determine distance between points and offset */
	n = this.range/this.h;
	yoffset = (this.ymin / n);

	len = values.length;
	if (len) {

		/* Begin line in lower left corner */
		x = 1;
		path = 'M' + x + ',' + (this.h-1);

		/* Determine position of first point and append line to command */
		y = this.h - (values[0] / n) + yoffset;
		path += ' L' + x + ',' + y;

		/* Append commands for succeeding points */
		for (i = 1; i < len; i++) {
			y = this.h - (values[i] / n) + yoffset;
			x += this.xstep;
			path += ' L' + x + ',' + y;
		}

		/* Close path and fill it */
		path += ' L' + x + ',' + (this.h-1) + ' Z';
		o = document.createElementNS('http://www.w3.org/2000/svg', 'path');
		o.setAttribute('stroke', color);
		o.setAttribute('fill', color);
		o.setAttribute('d', path);
		this.svg.appendChild(o);
}	};


SVGChartPainter.prototype.drawLine = function(color, values) {
	var i, len, x, y, n, yoffset, path, o;

	/* Determine distance between points and offset */
	n = this.range/this.h;
	yoffset = (this.ymin / n);

	len = values.length;
	if (len) {

		/* Determine position of first point and start path */
		x = 1;
		y = this.h - (values[0] / n) + yoffset;
		path = 'M' + x + ',' + y;

		/* Append line to commands for succeeding points */
		for (i = 1; i < len; i++) {
			y = this.h - (values[i] / n) + yoffset;
			x += this.xstep;
			path += ' L' + x + ',' + y;
		}

		/* Draw path */
		o = document.createElementNS('http://www.w3.org/2000/svg', 'path');
		o.setAttribute('stroke', color);
		o.setAttribute('fill', 'none');
		o.setAttribute('stroke-width', '1px');
		o.setAttribute('d', path);
		this.svg.appendChild(o);
}	};


SVGChartPainter.prototype.drawBars = function(color, values, xoffset, width) {
	var i, len, x, y, n, yoffset;


	/* Determine distance between points and offset */
	n = this.range/this.h;
	yoffset = (this.ymin / n);

	len = values.length;
	if (len) {

		/* Determine position of each bar and draw it */
		x = xoffset + 1;
		for (i = 0; i < len; i++) {
			y = this.h - (values[i] / n);
			this._drawRect(color, x, y, width, this.h - y);
			x += this.xstep;
}	}	};


SVGChartPainter.prototype._drawRect = function(color, x, y, w, h) {
	var rect;

	rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
	rect.setAttribute('stroke', 'none');
	rect.setAttribute('fill', color);
	rect.setAttribute('x', x + 'px');
	rect.setAttribute('y', y + 'px');
	rect.setAttribute('width', w + 'px');
	rect.setAttribute('height', h + 'px');

	this.svg.appendChild(rect);
};

