<?php

function smarty_function_payment( $params, $smarty ) {
	global $tikilib;
	global $paymentlib; require_once 'lib/payment/paymentlib.php';
	$invoice = (int) $params['id'];

	$objectperms = Perms::get( 'payment', $invoice );
	$info = $paymentlib->get_payment( $invoice );

	// Unpaid payments can be seen by anyone as long as they no the number
	// Just like your bank account, anyone can drop money in it.
	if( $info && $info['state'] == 'outstanding' || $info['state'] == 'overdue' || $objectperms->payment_view ) {
		$info['fullview'] = $objectperms->payment_view;
		$smarty->assign( 'payment_info', $info );
		$smarty->assign( 'payment_detail', $tikilib->parse_data( htmlspecialchars($info['detail']) ) );
		return $smarty->fetch( 'tiki-payment-single.tpl' );
	} else {
		return tra('This invoice does not exist or is in limited access.');
	}
}
