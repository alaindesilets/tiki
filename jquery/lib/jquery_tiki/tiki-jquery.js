// $Id$
// JavaScript glue for JQuery (1.2.6) in TikiWiki (3.0)

var $jq = jQuery.noConflict();

$jq(document).ready( function() { // JQuery's DOM is ready event - before onload

	// override existing show/hide routines here
	show = function (foo,f,section) {
		if ($jq("#" + foo).hasClass("tabcontent")) {
			showJQ("#" + foo, jqueryTiki.effect_tabs, jqueryTiki.effect_tabs_speed, jqueryTiki.effect_tabs_direction);
		} else {
			showJQ("#" + foo, jqueryTiki.effect, jqueryTiki.effect_speed, jqueryTiki.effect_direction);
		}
		if (f) { setCookie(foo, "o", section); }
	}
	
	hide = function (foo,f, section) {
		if ($jq("#" + foo).hasClass("tabcontent")) {
			hideJQ("#" + foo, jqueryTiki.effect_tabs, jqueryTiki.effect_tabs_speed, jqueryTiki.effect_tabs_direction);
		} else {
			hideJQ("#" + foo, jqueryTiki.effect, jqueryTiki.effect_speed, jqueryTiki.effect_direction);
		}
		if (f) {
			var wasnot = getCookie(foo, section, 'x') == 'x';
			setCookie(foo, "c", section);
			if (wasnot) {
				history.go(0);	// ik!
			}
		}
	}
	
	// flip function... unfortunately didn't use show/hide (ay?)
	
	flip = function (foo,style) {
		if ($jq("#" + foo).css("display") == "none") {
			show(foo);
			setCookie('show_' + escape(foo),'y');
		} else {
			hide(foo);
			setCookie('show_' + escape(foo), 'n');
		}
	}

	/* toggle CSS (tableless) layout columns */
	toggleCols = function (id,zeromargin,maincol) {	// TODO (it properly!)
		var showit = 'show_' + escape(id);
		if (!zeromargin) zeromargin = '';
		if (!id) id = '';
		if (!maincol) maincol = 'col1';
		if (document.getElementById(id).style.display == "none") {
			show(id);
			setCookie(showit,'y');
		} else {
			hide(id);
			setCookie(showit,'n');
		}
	}


	
	// handle JQ effects
	
	showJQ = function (selector, effect, speed, dir) {
		if (effect == 'none') {
			$jq(selector).show();
		} else if (effect == '' || effect == 'normal') {
			$jq(selector).show(speed);
		} else if (effect == 'slide') {
			$jq(selector).slideDown(speed);
		} else if (effect == 'fade') {
			$jq(selector).fadeIn(speed);
		} else if (effect.match(/(.*)_ui$/).length > 1) {
			$jq(selector).show(effect.match(/(.*)_ui$/)[1], {direction: dir }, speed);
		} else {
			$jq(selector).show();
		}
	}
	
	hideJQ = function (selector, effect, speed, dir) {
		if (effect == 'none') {
			$jq(selector).hide();
		} else if (effect == '' || effect == 'normal') {
			$jq(selector).hide(speed);
		} else if (effect == 'slide') {
			$jq(selector).slideUp(speed);
		} else if (effect == 'fade') {
			$jq(selector).fadeOut(speed);
		} else if (effect.match(/(.*)_ui$/).length > 1) {
			$jq(selector).hide(effect.match(/(.*)_ui$/)[1], {direction: dir }, speed);
		} else {
			$jq(selector).hide();
		}
	}
	
	// tooltip functions and setup
	if (jqueryTiki.tooltips) {	// apply "cluetips" to all .tips class anchors
		$jq('a.tips').cluetip({splitTitle: '|', showTitle: false, width: '150px'});
		$jq('a.titletips').cluetip({splitTitle: '|'});
	}
});
