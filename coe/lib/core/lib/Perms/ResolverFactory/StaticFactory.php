<?php

require_once 'lib/core/lib/Perms/ResolverFactory.php';

/**
 * Simple factory always providing the same resolver. Used to provide
 * a grant-all resolver to admin users.
 */
class Perms_ResolverFactory_StaticFactory implements Perms_ResolverFactory
{
	private $key;
	private $resolver;

	function __construct( $key, $resolver ) {
		$this->key = $key;
		$this->resolver = $resolver;
	}

	function bulk( array $baseContext, $bulkKey, array $values ) {
		return array();
	}

	function getHash( array $context ) {
		return $this->key;
	}

	function getResolver( array $context ) {
		return $this->resolver;
	}
}