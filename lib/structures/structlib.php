<?php

class StructLib extends TikiLib {
	function StructLib($db) {
		# this is probably uneeded now
		if (!$db) {
			die ("Invalid db object passed to StructLib constructor");
		}

		$this->db = $db;
	}

	function s_export_structure($structure) {
		global $exportlib, $tikidomain;

		global $dbTiki;
		include_once ('lib/wiki/exportlib.php');
		$zipname = "$structure.zip";
		include_once ("lib/tar.class.php");
		$tar = new tar();
		$pages = $this->s_get_structure_pages($structure);

		foreach ($pages as $page) {
			$data = $exportlib->export_wiki_page($page, 0);

			$tar->addData($page, $data, date("U"));
		}

		$tar->toTar("dump/$tikidomain" . $structure . ".tar", FALSE);
		header ("location: dump/$tikidomain$structure.tar");
		return '';
	}

	/** /brief Get a list of all pages referenced by a structure
  */
  function s_get_structure_pages($structure_id) {

		$query  = "select `page_ref_id`, `pageName`, `page_alias` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id and `page_ref_id`=?";
		$result = $this->query($query,array($structure_id));

		if ($res = $result->fetchRow()) {
			$page_ref_id = $res['page_ref_id'];
			$pageName = $res['pageName'];
			$page_id = $res['page_alias'];

			$ret = $this->s_populate_structure_pages($page_ref_id, $pageName, $page_alias);
		}

		return $ret;
	}

  /** Iterative function to construct a list of all pages in a structure 
  */
	function s_populate_structure_pages($parent_id, $pageName, $page_alias) {
		$ret = array($parent_id, $pageName, $page_alias);

		$query  = "select `page_ref_id`, `pageName`, `page_alias` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `parent_id`=? order by ".$this->convert_sortmode("pos_asc");
		$result = $this->query($query,array($structure_id));

		while ($res = $result->fetchRow()) {
			$page_ref_id = $res['page_ref_id'];
			$pageName = $res['pageName'];
			$page_id = $res['page_alias'];

			$ret[] = array($page_ref_id, $pageName, $page_alias);
			$ret2 = $this->s_populate_structure_pages($page_ref_id, $pageName, $page_alias);

			if (count($ret2) > 0) {
				$ret = array_merge($ret, $ret2);
			}
		}

		return $ret;
	}

	function s_export_structure_tree($structure, $level = 0) {

		$query = "select `page` from `tiki_structures` where `parent`=? order by ".$this->convert_sortmode("pos_asc");
		$result = $this->query($query,array($structure));

		if ($level == 0) {
			print ($structure);

			print ("\n");
			$this->s_export_structure_tree($structure, $level + 1);
		} else {
			while ($res = $result->fetchRow()) {
				for ($i = 0; $i < $level; $i++) {
					print (" ");
				}

				$page = $res['page'];
				print ($page);
				print ("\n");
				$this->s_export_structure_tree($page, $level + 1);
			}
		}
	}

	function s_remove_page($page_ref_id, $delete) {
		// Now recursively remove

		$query = "select `page_ref_id`, ts.`page_id`, `pageName` from `tiki_structures` as ts, `tiki_pages` as tp where tp.`page_id`=ts.`page_id` and `parent_id`=?";
		$result = $this->query($query,array($page_ref_id));

		while ($res = $result->fetchRow()) {
			$this->s_remove_page($res["page_ref_id"], $delete);
		}

		if ($delete) {
  		$query = "select count(*) from `tiki_structures` where `page_id`=?";
	  	$count = $this->getOne($query, array($res["page_id"]));
      if ($count = 1) {
			  $this->remove_all_versions($res["pageName"]);
      }
		}

		$query = "delete from `tiki_structures` where `page_ref_id`=?";
		$result = $this->query($query, array($page_ref_id));

		return true;
	}

	function s_create_page($parent_id, $after_ref_id, $name, $alias) {

    // If the page doesn't exist then create the page!
		if (!$this->page_exists($name)) {
			$now = date("U");

			$this->create_page($name, 0, '', $now, 'created from stucture', 'system', '0.0.0.0', '');
		}
    //Get the page Id
		$query = "select `page_id` from `tiki_pages` where `pageName`=?";
		$page_id = $this->getOne($query,array($name));

		if (isset($after_ref_id)) {
			$max = $this->getOne("select `pos` from `tiki_structures` where `page_ref_id`=?",array($after_ref_id));
		} else {
			$max = 0;
		}

		if ($max > 0) {
			//If max is 5 then we are inserting after position 5 so we'll insert 5 and move all
			// the others
			$query = "update `tiki_structures` set `pos`=`pos`+1 where `pos`>? and `parent_id`=?";
			$result = $this->query($query,array($max, $parent_id));
		}

		$max++;
		$query = "insert into `tiki_structures`(`parent_id`,`page_id`,`page_alias`,`pos`) values(?,?,?,?)";
		$result = $this->query($query,array($parent_id,$page_id,$alias,$max));
	}


	function get_subtree($page_ref_id, $level = 0, $parent_pos = '') {
    $ret = array();
    $pos = 1;
    //The structure page is used as a title
    if ($level == 0) {
      $struct_info = $this->get_page_info($page_ref_id);
      $aux["first"]       = true;
      $aux["last"]        = true;
      $aux["pos"]         = '';
      $aux["page_ref_id"] = $struct_info["page_ref_id"];
      $aux["pageName"]    = $struct_info["pageName"];
      $aux["page_alias"]  = $struct_info["page_alias"];
      $ret[] = $aux;
      $level++;
    }

		//Get all child nodes for this page_ref_id
    $query = "select `page_ref_id`, `page_alias`, `pageName`";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id` = tp.`page_id` and `parent_id`=? order by `pos` asc";
		$result = $this->query($query,array($page_ref_id));
		
    $subs = array();
    $row_max = $result->numRows();
		while ($res = $result->fetchRow()) {
      //Add
      $aux["first"]       = ($pos == 1);
      $aux["last"]        = false;
      $aux["page_ref_id"] = $res["page_ref_id"];
      $aux["pageName"]    = $res["pageName"];
      $aux["page_alias"]  = $res["page_alias"];
      if (strlen($parent_pos) == 0) {
         $aux["pos"] = "$pos";
      }
      else {
         $aux["pos"] = $parent_pos . '.' . "$pos";
      }
      $ret[] = $aux;

      //Recursively add any child nodes
			$subs = $this->get_subtree($res["page_ref_id"], ($level + 1), $aux["pos"]);
      if(isset($subs)) {
        $ret = array_merge($ret, $subs);
      }
      // Insert a dummy entry to close table/list
      if ($pos == $row_max) {
        $aux["first"] = false;
        $aux["last"]  = true;
        $ret[] = $aux;
      }

      $pos++;
		}
		return $ret;
	}

  /**Returns an array of page_info arrays
   
     This can be used to construct a path from the 
     structure head to the requested page. 
  */
	function get_structure_path($page_ref_id) {
    $structure_path = array();
		$page_info = $this->get_page_info($page_ref_id);

		if ($page_info["parent_id"]) {
      $structure_path = $this->get_structure_path($page_info["parent_id"]);
    }
    $structure_path[] = $page_info;
    return $structure_path;
	}

  /**Returns a structure_info array
 
     See get_page_info for details of array  
  */
	function get_structure_info($page_ref_id) {
		$parent_id = $this->getOne("select `parent_id` from `tiki_structures` where `page_ref_id`=?", array($page_ref_id));

		if (!$parent_id)
			return $this->get_page_info($page_ref_id);

		return $this->get_structure_info($parent_id);
	}

  /**Returns an array of info about the parent 
     page_ref_id
 
     See get_page_info for details of array  
  */
	function get_parent_info($page_ref_id) {
		// Try to get the parent of this page
		$parent_id = $this->getOne("select `parent_id` from `tiki_structures` where `page_ref_id`=?",array($page_ref_id));
    
    if (!$parent_id)
      return null;
		return ($this->get_page_info($parent_id));
	}

	/** Return an array of page info
  */
	function get_page_info($page_ref_id) {
    $ret = array();
		$query =  "select `pos`, `page_ref_id`, `parent_id`, ts.`page_id`, `pageName`, `page_alias` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `page_ref_id`=?";
    $result = $this->query($query,array($page_ref_id));
    if($res = $result->fetchRow()) {
      $ret["pos"] = $res["pos"];
      $ret["page_ref_id"] = $res["page_ref_id"];
      $ret["parent_id"] = $res["parent_id"];
      $ret["page_id"] = $res["page_id"];
      $ret["pageName"] = $res["pageName"];
      $ret["page_alias"] = $res["page_alias"];
      return $ret; 
    }
    else {
      return null;
    }
	}

	// no html ! to rewritte !
	function get_subtree_toc($page_ref_id, &$html, $level = '') {

		$ret = array();
		$first = true;
		//$level++;
		$sublevel = 0;
		$query  = "select `page_ref_id`, `pageName`, `page_alias` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `parent_id`=? order by ".$this->convert_sortmode("pos_asc");
		$result = $this->query($query,array($page_ref_id));
		$subs = array();

		while ($res = $result->fetchRow()) {
			if ($first) {
				$html .= '<ul>';

				$first = false;
			}

			$sublevel++;

			if ($level) {
				$plevel = $level . '.' . $sublevel;
			} else {
				$plevel = $sublevel;
			}

      $child_id = $res["page_ref_id"];
			$html .= "<li style='list-style:disc outside;'><a class='link' href='tiki-index.php?page_ref_id=$child_id'>$plevel&nbsp;";
      $pageAlias = $res["page_alias"];
      if (empty($pageAlias)) {
        $html .= $res["pageName"];
      }
      else {
        $html .= $pageAlias;
      }
			$html .= "</a></li>";

			$subs[] = $this->get_subtree_toc($child_id, $html, $plevel);
		}

		if (!$first) {
			$html .= '</ul>';
		}

		$aux["name"] = $page_ref_id;
		$aux["cant"] = count($subs);
		$aux["pages"] = $subs;
		$ret[] = $aux;
		return $ret;
	}

	function get_subtree_toc_slide($structure, $page, &$html, $level = '') {

		$ret = array();
		$first = true;
		//$level++;
		$sublevel = 0;
		$query = "select `page`, `page_alias` from `tiki_structures` where `parent`=? order by ".$this->convert_sortmode("pos_asc");
		$result = $this->query($query,array($page));
		$subs = array();

		while ($res = $result->fetchRow()) {
			if ($first) {
				$html .= '<ul>';

				$first = false;
			}

			$sublevel++;

			if ($level) {
				$plevel = $level . '.' . $sublevel;
			} else {
				$plevel = $sublevel;
			}

			$upage = urlencode($res["page"]);
			$html .= "<li style='list-style:disc outside;'><a class='link' href='tiki-slideshow2.php?page=$upage'>$plevel&nbsp;";
			$pageAlias = $res["page_alias"];
      if (empty($pageAlias)) {
        $html .= $res["page"];
      }
      else {
        $html .= $pageAlias;
      }
//$html.="&nbsp;[<a class='link' href='tiki-index.php?page=${res["page"]}'>view</a>|<a  class='link' href='tiki-editpage.php?page=${res["page"]}'>edit</a>]";
			$html .= "</a></li>";

			$subs[] = $this->get_subtree_toc($structure, $res["page"], $html, $plevel);
		}

		if (!$first) {
			$html .= '</ul>';
		}

		$aux["name"] = $page;
		$aux["cant"] = count($subs);
		$aux["pages"] = $subs;
		$ret[] = $aux;
		return $ret;
	}

	function page_is_in_structure($pageName) {
    $query  = "select count(*) ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `pageName`=?";
		$cant = $this->getOne($query,array($pageName));
		return $cant;
	}
	
  //Is this page the head page for a structure?
	function get_struct_ref_if_head($pageName) {
    $query =  "select `page_ref_id` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `parent_id` is null and `pageName`=?";
		$page_ref_id = $this->getOne($query,array($pageName));
		return $page_ref_id;
	}
	
	function get_next_page($page_ref_id, $deep = true) {
		
		// If we have children then get the first child
		if ($deep) {
			$query  = "select `page_ref_id`, `pageName`, `page_alias` ";
      $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
      $query .= "where ts.`page_id`=tp.`page_id` and `parent_id`=? ";
      $query .= "order by ".$this->convert_sortmode("pos_asc");
			$result1 = $this->query($query,array($page_ref_id));

			if ($result1->numRows()) {
				$res = $result1->fetchRow();
				$next_page["page_ref_id"] = $res["page_ref_id"];
				$next_page["pageName"] = $res["pageName"];
				$next_page["page_alias"] = $res["page_alias"];

				return $next_page;
			}
		}

		// Try to get the next page with the same parent as this
    $page_info = $this->get_page_info($page_ref_id);
    $parent_id = $page_info["parent_id"];
    $page_pos = $page_info["pos"];

		if (!$parent_id)
			return null;

		$query  = "select `page_ref_id`, `pageName`, `page_alias` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `parent_id`=? and `pos`>? ";
    $query .= "order by ".$this->convert_sortmode("pos_asc");
		$result2 = $this->query($query,array($parent_id, $page_pos));
		
		if ($result2->numRows()) {
			$res = $result2->fetchRow();
			$next_page["page_ref_id"] = $res["page_ref_id"];
			$next_page["pageName"] = $res["pageName"];
			$next_page["page_alias"] = $res["page_alias"];
			return $next_page;
		} 
    else {
			return $this->get_next_page($parent_id, false);
		}
	}
	
	function get_prev_page($page_ref_id, $deep = false) {
  
    //Drill down to last child for this tree node
    if ($deep) {
  		$query  = "select `page_ref_id`, `pageName`, `page_alias` ";
      $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
      $query .= "where ts.`page_id`=tp.`page_id` and `parent_id`=? ";
      $query .= "order by ".$this->convert_sortmode("pos_desc");
  		$result = $this->query($query,array($page_ref_id));
  		
  		if ($result->numRows()) {
        //There are more children
  			$res = $result->fetchRow();
  			$prev_page = $this->get_prev_page($res["page_ref_id"], true);
  		} 
      else {
        //This is the last child
        $page_info = $this->get_page_info($page_ref_id);
  			$prev_page["page_ref_id"] = $page_info["page_ref_id"];
  			$prev_page["pageName"]    = $page_info["pageName"];
  			$prev_page["page_alias"]  = $page_info["page_alias"];
  		}
			return $prev_page;
    }
		// Try to get the previous page with the same parent as this
    $page_info = $this->get_page_info($page_ref_id);
    $parent_id = $page_info["parent_id"];
    $pos       = $page_info["pos"];

    //At the top of the tree
		if (!isset($parent_id))
			return null;

		$query  = "select `page_ref_id`, `pageName`, `page_alias` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `parent_id`=? and `pos`<? ";
    $query .= "order by ".$this->convert_sortmode("pos_desc");
		$result = $this->query($query,array($parent_id,$pos));

		if ($result->numRows()) {
      //There is a previous sibling
			$res = $result->fetchRow();
 			$prev_page = $this->get_prev_page($res["page_ref_id"], true);

		} 
    else {
      //No previous siblings, just the parent
      $parent_info = $this->get_parent_info($page_ref_id);
			$prev_page["page_ref_id"] = $parent_info["page_ref_id"];
			$prev_page["pageName"] = $parent_info["pageName"];
			$prev_page["page_alias"] = $parent_info["page_alias"];
		}
		return $prev_page;
	}

	function get_prev_next_pages($page_ref_id) {
    $struct_nav_pages = array();
		// Get structure info for this page
 		$prev_pages = $this->get_prev_page($page_ref_id);
 		if ($prev_pages) {
 			$struct_nav_pages["prev_page_ref_id"] = $prev_pages["page_ref_id"];
 			$struct_nav_pages["prev_pageName"]    = $prev_pages["pageName"];
 			$struct_nav_pages["prev_page_alias"]  = $prev_pages["page_alias"];
 		}
 		
 		$next_pages = $this->get_next_page($page_ref_id);
 		if ($next_pages) {
 			$struct_nav_pages["next_page_ref_id"] = $next_pages["page_ref_id"];
 			$struct_nav_pages["next_pageName"]    = $next_pages["pageName"];
 			$struct_nav_pages["next_page_alias"]  = $next_pages["page_alias"];
 		}
 		
 		return $struct_nav_pages;			
	}
	
	/** Return an array of subpages
      Used by the 'After Page' select box 
  */
	function get_pages($parent_id) {
		$ret = array();
		$query =  "select `page_ref_id`, `pageName`, `page_alias` from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `parent_id`=? order by ".$this->convert_sortmode("pos_asc");
		$result = $this->query($query,array($parent_id));
		while ($res = $result->fetchRow()) {
      $aux["page_ref_id"] = $res["page_ref_id"];
      $aux["pageName"] = $res["pageName"];
      $aux["page_alias"] = $res["page_alias"];
			$ret[] = $aux;
		}
		return $ret;
	}

	function get_page_structures($pageName) {
		$ret = array();
		$pages_added = array();
		$query = "select `page_ref_id` ";
    $query .= "from `tiki_structures` as ts, `tiki_pages` as tp ";
    $query .= "where ts.`page_id`=tp.`page_id` and `pageName`=?";
		$result = $this->query($query,array($pageName));
		while ($res = $result->fetchRow()) {
      $next_page = $this->get_structure_info($res["page_ref_id"]);
      //Add each structure head only once
      if (!in_array($next_page["page_ref_id"], $pages_added)) {
        $pages_added[] = $next_page["page_ref_id"];
			  $ret[] = $next_page;
      }
		}
		return $ret;
	}

	function get_max_children($page_ref_id) {

		$query = "select `page_ref_id` from `tiki_structures` where `parent_id`=?";
		$result = $this->query($query,array($page_ref_id));
		if (!$result->numRows()) {
			return '';
		}
		$res = $result->fetchRow();
		return $res;
	}

	// Return all the pages belonging to the structure in an array
	function get_structure_pages($structure_id, $page_ref_id) {
    if ($page_ref_id) {
      $ret = array($page_ref_id);
    }
 	  $query =  "select `page_ref_id`, `pageName`, `page_alias` from ";
    $query .= "`tiki_structures` as ts, `tiki-pages` as tp ";
    $query .= "where tp.`page_id`=ts.`page_id` and `parent_id`=?";
 	  $result = $this->query($query,array($page_ref_id));
		while ($res = $result->fetchRow()) {
			$ret[] = $res["page"];
			$ret2 = $this->get_structure_pages($structID, $res["page"]);
			$ret = array_unique(array_merge($ret, $ret2));
		}
		$ret = array_unique($ret);
		return $ret;
	}

	// Return all the pages belonging to the structure in an array ordered from first 
	// to last page.
	function get_structure_pages_ordered($page) {
		$ret = array($page);
		$query = "select `page` from `tiki_structures` where `parent`=? order by pos asc";
		$result = $this->query($query,array($page));
		while ($res = $result->fetchRow()) {
			$ret[] = $res["page"];
			$ret2 = $this->get_structure_pages($res["page"]);
			$ret = array_unique(array_merge($ret, $ret2));
		}
		$ret = array_unique($ret);
		return $ret;
	}
	
	function list_structures($offset, $maxRecords, $sort_mode, $find) {

		if ($find) {
			$findesc = '%' . $find . '%';
			$mid = " where ts.`page_id`= tp.`page_id` and `parent_id` is null and (tp.`pageName` like ?)";
			$bindvars=array($findesc);
		} else {
			$mid = " where ts.`page_id`= tp.`page_id` and `parent_id` is null";
			$bindvars=array();
		}

		$query = "select * from `tiki_structures` as ts, `tiki_pages` as tp $mid order by ".$this->convert_sortmode($sort_mode);
		$query_cant = "select count(*) from `tiki_structures` as ts, `tiki_pages` as tp $mid";
		$result = $this->query($query,$bindvars,$maxRecords,$offset);
		$cant = $this->getOne($query_cant,$bindvars);
		$ret = array();

		while ($res = $result->fetchRow()) {
			$ret[] = $res;
		}

		$retval = array();
		$retval["data"] = $ret;
		$retval["cant"] = $cant;
		return $retval;
	}
  
  function get_page_alias($page_ref_id) {
		$query = "select `page_alias` from `tiki_structures` where `page_ref_id`=?";
		$res = $this->getOne($query, array($page_ref_id));
    return $res;
  }
  
  function set_page_alias($page_ref_id, $pageAlias) {
		$query = "update `tiki_structures` set `page_alias`=? where `page_ref_id`=?";
		$this->query($query, array($pageAlias, $page_ref_id));
  }
}

$structlib = new StructLib($dbTiki);

?>
