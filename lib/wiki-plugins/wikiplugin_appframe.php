<?php
// (c) Copyright 2002-2012 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function wikiplugin_appframe_info()
{
	return array(
		'name' => tra('Application Frame'),
		'description' => tra('Creates a frame to assemble custom applications in. Components in the frame will be various wiki pages and modules.'),
		'prefs' => array('wikiplugin_appframe'),
		'format' => 'html',
		'introduced' => 9,
		'documentation' => 'PluginAppFrame',
		'filter' => 'wikicontent',
		'body' => tr('Application layout'),
		'params' => array(
			'min' => array(
				'required' => false,
				'name' => tr('Minimal height'),
				'description' => tr('Prevent the frame from becoming any shorter than the specified size.'),
				'default' => 300,
				'filter' => 'int',
			),
			'hideleft' => array(
				'requred' => false,
				'name' => tr('Hide left column'),
				'description' => tr('Hide the left column when the application frame is in use to provide more space to the application.'),
				'default' => 'n',
				'options' => array(
					array('value' => 'n', 'text' => tr('No')),
					array('value' => 'y', 'text' => tr('Yes')),
				),
			),
			'hideright' => array(
				'requred' => false,
				'name' => tr('Hide right column'),
				'description' => tr('Hide the right column when the application frame is in use to provide more space to the application.'),
				'default' => 'n',
				'options' => array(
					array('value' => 'n', 'text' => tr('No')),
					array('value' => 'y', 'text' => tr('Yes')),
				),
			),
			'fullpage' => array(
				'required' => false,
				'name' => tr('Full page'),
				'description' => tr('Occupy the complete content area of the page.'),
				'default' => 'n',
				'options' => array(
					array('value' => 'n', 'text' => tr('No')),
					array('value' => 'y', 'text' => tr('Yes')),
				),
			),
			'absolute' => array(
				'required' => false,
				'name' => tr('Absolute Position'),
				'description' => tr('Position the app frame to use absolute position and really use all available space.'),
				'default' => 'n',
				'options' => array(
					array('value' => 'n', 'text' => tr('No')),
					array('value' => 'y', 'text' => tr('Yes')),
				),
			),
			'top' => array(
				'required' => false,
				'name' => tr('Top'),
				'description' => tr('When using absolute mode, leave some space for the header at the top.'),
				'default' => 0,
				'filter' => 'int',
			),
		),
	);
}

function wikiplugin_appframe($data, $params)
{
	$minHeight = isset($params['min']) ? (int) $params['min'] : 300;
	$fullPage = 0;
	if (isset($params['fullpage']) && $params['fullpage'] == 'y') {
		$fullPage = 1;
	}

	$absolute = isset($params['absolute']) ? $params['absolute'] == 'y' : false;
	$top = isset($params['top']) ? $params['top'] : 0;

	$headerlib = TikiLib::lib('header');

	if (isset($params['hideleft']) && $params['hideleft'] == 'y') {
		$headerlib->add_js(
<<<JS
hideCol('col2','left', 'col1');
JS
);
	}

	if (isset($params['hideright']) && $params['hideright'] == 'y') {
		$headerlib->add_js(
<<<JS
hideCol('col3','right', 'col1');
JS
);
	}

	if ($absolute) {
		$headerlib->add_js(
<<<JS
$('#appframe')
	.css('position', 'absolute')
	.css('top', $top)
	.css('left', 0)
	.css('bottom', 0)
	.css('right', 0)
	;
JS
);
	} else {
		$headerlib->add_js(
<<<JS
$(window).resize(function () {
	var viewportHeight = $(window).height(), appframe = $('#appframe'), footerSize, centerHeader, surplus, target;
	appframe.height(0);

	centerHeader = $('#appframe').position().top - $('#tiki-center').position().top;
	surplus = $('#show-errors-button').height();
	footerSize = $('#footer').height() + $('#tiki-center').height() - centerHeader + surplus;
	target = viewportHeight - appframe.position().top - footerSize;

	var min = $minHeight;
	if (target < min) {
		target = min;
	}

	appframe.height(target);
	$('#appframe .tab').each(function () {
		$(this).data('available-height', $('#appframe').height() - $(this).position().top).addClass('height-size');
	});
});
$('#appframe .tab').parent().each(function () {
	var tabs = $(this).children('.tab').wrapAll('<div class="tabs" style="height: 100%;"/>');
	var list = $('<ul/>');
	tabs.parent().prepend(list);
	tabs.each(function () {
		var link = $('<a/>').attr('href', '#' + $(this).attr('id')).text($(this).data('label'));
		list.append($('<li/>').append(link));
	});
	tabs.parent().tabs();
});
$('#appframe .accordion').wrapAll('<div/>').parent().accordion({
	autoHeight: false
});

if ($fullPage) {
	$('#role_main').append($('#appframe'));
	$('#role_main').children().not($('#appframe')).remove();
}

$(window).resize();
JS
);
	}

	$matches = WikiParser_PluginMatcher::match($data);
	foreach ($matches as $plugin) {
		if ($output = wikiplugin_appframe_execute($plugin)) {
			$plugin->replaceWith($output);
		}
	}

	$data = $matches->getText();

	return <<<HTML
<div id="appframe">$data</div>
HTML;
}

function wikiplugin_appframe_execute($plugin)
{
	$name = $plugin->getName();
	$body = $plugin->getBody();
	$params = WikiParser_PluginArgumentParser::parse($plugin->getArguments());

	if (! in_array($name, array('tab', 'column', 'page', 'module'))) {
		return null;
	}

	$function = 'wikiplugin_appframe_' . $name;
	return $function($body, new JitFilter($params), $plugin->getStart());
}

function wikiplugin_appframe_tab($data, $params, $start)
{
	return <<<TAB
<div id="apptab-$start" class="tab" data-label="{$params->label->text()}" style="height: 100%;">$data</div>
TAB;
}

function wikiplugin_appframe_column($data, $params, $start)
{
	$width = $params->width->int() . '%';
	return <<<COLUMN
<div style="width: {$width}; float: left; height: 100%;">$data</div>
COLUMN;
}

function wikiplugin_appframe_page($data, $params, $start)
{
	$tikilib = TikiLib::lib('tiki');
	$info = $tikilib->get_page_info($params->name->pagename());

	if (! $info) {
		return null;
	}

	$keys = array();
	$replacements = array();
	foreach ($params as $key => $value) {
		$keys[] = "{{{$key}}}";
		$replacements[] = $value;
	}
	$info['data'] = str_replace($keys, $replacements, $info['data']);

	return "~/np~{$info['data']}~np~";
}

function wikiplugin_appframe_module($data, $params, $start)
{
	$modlib = TikiLib::lib('mod');
	$moduleName = $params->name->word();
	$label = $params->label->text();

	if (! $label) {
		$info = $modlib->get_module_info($moduleName);

		if (! $info ) {
			return null;
		}

		$label = $info['name'];
	}

	$data = $modlib->execute_module(
					array('name' => $moduleName, 'params' => array_merge($params->none(), array('nobox' => 'y', 'notitle' => 'y')))
	);

	if (! $data) {
		return null;
	}

	return <<<MODULE
<h4 class="accordion">{$label}</h4>
<div class="accordion">
	$data
</div>
MODULE;
}

