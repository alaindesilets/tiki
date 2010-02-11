<?php
class TikiWebdav_PathFactories_File implements ezcWebdavPathFactory
{
    protected $baseUri = '';
    protected $baseUriLength = 0;
    protected $collectionPathes = array();
    
    public function __construct()
    {
        global $base_url;
	if ( ( $pos = strpos($base_url, 'webdav.php/') ) !== false ) {
		$this->baseUri = substr($base_url, 0, strpos($base_url, 'webdav.php') + 10);
	} else {
		$this->baseUri = $base_url . 'webdav.php';
	}
	$this->baseUriLength = strlen($this->baseUri);
    }

    public function parseUriToPath( $uri )
    {
	global $tikilib;
	global $filegallib; require_once('lib/filegals/filegallib.php');
	
        $requestPath = rawurldecode( substr( trim( $uri ), $this->baseUriLength ) );

	if ( empty($requestPath) )
	{
		$requestPath = '/';
	}
	elseif ( substr( $requestPath, -1, 1 ) === '/' )
        {
		$this->collectionPathes[substr( $requestPath, 0, -1 )] = true;
        }
        else
        {
		// MSIE sends requests for collections without the '/' at the end
		$objectId = $filegallib->get_objectid_from_virtual_path( $requestPath );
		if ( $objectId && $objectId['type'] == 'filegal' ) {
			$requestPath .= '/';
		}

            // @todo Some clients first send with / and then discover it is not a resource
            // therefore the upper todo might be refined.
            if ( isset( $this->collectionPathes[$requestPath] ) )
            {
                unset( $this->collectionPathes[$requestPath] );
            }
        }

	@file_put_contents('/tmp/tiki4log', "parseUriToPath($uri): $requestPath\n", FILE_APPEND );
	return $requestPath;
    }

    public function generateUriFromPath( $path )
    {
	global $tikilib;
	global $filegallib; require_once('lib/filegals/filegallib.php');

	$result = $this->baseUri . implode( '/', array_map( 'rawurlencode', explode( '/', $path ) ) );

	@file_put_contents('/tmp/tiki4log', "generateUriFromPath($path): $result\n", FILE_APPEND );
	return $result;
    }
}
