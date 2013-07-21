<?php

function module_cart_info() {
	return array(
		'name' => tra('Cart'),
		'description' => tra('Displays the content of the cart, allows to modify quantities and proceed to payment.'),
		'prefs' => array( 'payment_feature' ),
	);
}

function module_cart( $mod_reference, $module_params ) {
	global $smarty, $access;
	global $cartlib; require_once 'lib/payment/cartlib.php';

	if( isset( $_POST['update'], $_POST['cart'] ) ) {
		foreach( $_POST['cart'] as $code => $quantity ) {
			$cartlib->update_quantity( $code, $quantity );
		}

		$access->redirect( $_SERVER['REQUEST_URI'], tra('The quantities in your cart were updated.') );
	}

	if( isset( $_POST['checkout'] ) ) {
		$invoice = $cartlib->request_payment();
	
		if( $invoice ) {
			$access->redirect( 'tiki-payment.php?invoice=' . intval( $invoice ), tr('The order was recorded and is now awaiting payment. Reference number is %0.', $invoice) );
		}
	}

	$smarty->assign( 'cart_total', $cartlib->get_total() );
	$smarty->assign( 'cart_content', $cartlib->get_content() );
}
