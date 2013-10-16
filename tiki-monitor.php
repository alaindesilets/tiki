<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

require_once ('tiki-setup.php');
//TODO Use a pref to handle the list
if (!empty($tikiMonitorRestriction)) {
	if (is_array($tikiMonitorRestriction)) {
		if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) && !empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
			$aListIp = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
			$sIpToCheck = $aListIp[0];
		} elseif (isset($_SERVER['REMOTE_ADDR']) && !empty($_SERVER['REMOTE_ADDR'])) {
			$sIpToCheck = $_SERVER['REMOTE_ADDR'];
		} else {
			$sIpToCheck = null;
		}
		if (in_array($sIpToCheck, $tikiMonitorRestriction) === false) {
			header('location: index.php');
		}
	} else {
		echo tra("\$tikiMonitorRestriction need to be an array");
		exit;
	}
}
$opcode_cache = null;
$stat_flag = null;
$opcode_stats = array(
	'warning_check' => false,
	'warning_fresh' => false,
	'warning_ratio' => false,
	'warning_starve' => false,
	'warning_low' => false,
	'warning_xcache_blocked' => false,
);

if ( function_exists('apc_sma_info') && ini_get('apc.enabled') ) {
	$opcode_cache = 'APC';

	$sma = apc_sma_info();
	$mem_total = $sma['num_seg'] * $sma['seg_size'];

	$cache = apc_cache_info(null, true);
	$hit_total = $cache['num_hits'] + $cache['num_misses'];

	$stat_flag = 'apc.stat';
	$opcode_stats = array(
		'memory_used' => ( $mem_total - $sma['avail_mem'] ) / $mem_total,
		'memory_avail' => $sma['avail_mem'] / $mem_total,
		'memory_total' => $mem_total,
		'hit_hit' => $cache['num_hits'] / $hit_total,
		'hit_miss' => $cache['num_misses'] / $hit_total,
		'hit_total' => $hit_total,
	);
} elseif ( function_exists('xcache_info') && ( ini_get('xcache.cacher') == '1' || ini_get('xcache.cacher') == 'On' ) ) {
	$opcode_cache = 'XCache';

	if ( ini_get('xcache.admin.enable_auth') == '1' || ini_get('xcache.admin.enable_auth') == 'On' ) {
		$opcode_stats['warning_xcache_blocked'] = true;
	} else {
		$stat_flag = 'xcache.stat';
		$opcode_stats = array(
			'memory_used' => 0,
			'memory_avail' => 0,
			'memory_total' => 0,
			'hit_hit' => 0,
			'hit_miss' => 0,
			'hit_total' => 0,
		);

		foreach (range(0, xcache_count(XC_TYPE_PHP) - 1) as $index) {
			$info = xcache_info(XC_TYPE_PHP, $index);

			$opcode_stats['hit_hit'] += $info['hits'];
			$opcode_stats['hit_miss'] += $info['misses'];
			$opcode_stats['hit_total'] += $info['hits'] + $info['misses'];

			$opcode_stats['memory_used'] += $info['size'] - $info['avail'];
			$opcode_stats['memory_avail'] += $info['avail'];
			$opcode_stats['memory_total'] += $info['size'];
		}

		$opcode_stats['memory_used'] /= $opcode_stats['memory_total'];
		$opcode_stats['memory_avail'] /= $opcode_stats['memory_total'];
		$opcode_stats['hit_hit'] /= $opcode_stats['hit_total'];
		$opcode_stats['hit_miss'] /= $opcode_stats['hit_total'];
	}
} elseif ( function_exists('wincache_ocache_fileinfo') && ( ini_get('wincache.ocenabled') == '1') ) {
	$opcode_cache = 'WinCache';

	$stat_flag = 'wincache.ocenabled';
	$opcode_stats = array(
		'memory_used' => 0,
		'memory_avail' => 0,
		'memory_total' => 0,
		'hit_hit' => 0,
		'hit_miss' => 0,
		'hit_total' => 0,
		);

	$info = wincache_ocache_fileinfo();
	$opcode_stats['hit_hit'] = $info['total_hit_count'];
	$opcode_stats['hit_miss'] = $info['total_miss_count'];
	$opcode_stats['hit_total'] = $info['total_hit_count'] + $info['total_miss_count'];

	$memory = wincache_ocache_meminfo();
	$opcode_stats['memory_avail'] = $memory['memory_free'];
	$opcode_stats['memory_total'] = $memory['memory_total'];
	$opcode_stats['memory_used'] = $memory['memory_total'] - $memory['memory_free'];

	$opcode_stats['memory_used'] /= $opcode_stats['memory_total'];
	$opcode_stats['memory_avail'] /= $opcode_stats['memory_total'];
	$opcode_stats['hit_hit'] /= $opcode_stats['hit_total'];
	$opcode_stats['hit_miss'] /= $opcode_stats['hit_total'];
} elseif ( function_exists('opcache_get_status') && ( ini_get('opcache.enable') == '1') ) {
	$opcode_cache = 'OPCache';
	$status = opcache_get_status();
	$opcode_stats['memory_total'] = $status['memory_usage']['free_memory'] + $status['memory_usage']['used_memory'] + $status['memory_usage']['wasted_memory'];
	$opcode_stats['memory_avail'] = $status['memory_usage']['free_memory'];
	$opcode_stats['memory_used'] = $status['memory_usage']['used_memory'];

	$opcode_stats['memory_used'] /= $opcode_stats['memory_total'];
	$opcode_stats['memory_avail'] /= $opcode_stats['memory_total'];

	$opcode_stats['hit_total'] = $status['opcache_statistics']['hits'];
	$opcode_stats['hit_miss'] = (100 - $status['opcache_statistics']['opcache_hit_rate'] ) / 100;
	$opcode_stats['hit_hit'] = $status['opcache_statistics']['opcache_hit_rate'] / 100;
}

// Make results easier to read
$opcode_stats['memory_used'] = round($opcode_stats['memory_used'], 2);
$opcode_stats['memory_avail'] = round($opcode_stats['memory_avail'], 2);
$opcode_stats['hit_hit'] = round($opcode_stats['hit_hit'], 2);
$opcode_stats['hit_miss'] = round($opcode_stats['hit_miss'], 2);


if ( $stat_flag ) {
	$opcode_stats['warning_check'] = (bool) ini_get($stat_flag);
}

if ( isset($opcode_stats['hit_total']) ) {
	$opcode_stats = array_merge(
		$opcode_stats,
		array(
			'warning_fresh' => $opcode_stats['hit_total'] < 10000,
			'warning_ratio' => $opcode_stats['hit_hit'] < 0.8,
		)
	);
}

if ( isset($opcode_stats['memory_total']) ) {
	$opcode_stats = array_merge(
		$opcode_stats,
		array(
			'warning_starve' => $opcode_stats['memory_avail'] < 0.2,
			'warning_low' => $opcode_stats['memory_total'] < 60*1024*1024,
		)
	);
}

# TODO: The results will be wrong for WinCache
# The following is the relevant snippet from
# admin/include_performance.php
$txtUsed = tr('Used');
$txtAvailable = tr('Available');
if ($opcode_cache == 'WinCache') {
	// Somehow WinCache seems to flip the representations
	$txtAvailable = tr('Used');
	$txtUsed = tr('Available');
}

$result['OPCodeCache'] = $opcode_cache;
$result['OpCodeStats'] = $opcode_stats;

include_once ('installer/installlib.php');
$installer = new Installer;
$result['DbRequiresUpdate'] = $installer->requiresUpdate();

$result['SearchIndexRebuildLast'] = $tikilib->get_preference('unified_last_rebuild');

$display = json_encode($result);
echo $display;
