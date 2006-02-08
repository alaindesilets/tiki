<?php
// $Header: /cvsroot/tikiwiki/tiki/lib/html2pdf/converter.class.php,v 1.1.1.1 2006-02-08 11:02:03 nikchankov Exp $

class Converter {
  function create() {
    if (function_exists('iconv')) {
      return new IconvConverter;
    } else {
      return new PurePHPConverter;
    }
  }
}

class IconvConverter {
  function to_utf8($html, $encoding) {
    return iconv(strtoupper($encoding), "UTF-8", $html);
  }
}

class PurePHPConverter {
  function to_utf8($html, $encoding) {
    global $g_utf8_converters;
    
    if ($encoding === 'iso-8859-1') {
      return utf8_encode($html);
    } elseif ($encoding === 'utf-8') {
      return $html;
    } elseif(isset($g_utf8_converters[$encoding])) {
      return something_to_utf8($html, $g_utf8_converters[$encoding][0]);
    } else {
      die("Unsupported encoding detected: '$encoding'");
    };
  }
}
?>