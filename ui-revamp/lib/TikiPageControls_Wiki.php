<?php

require_once 'TikiPageControls.php';

class TikiPageControls_Wiki extends TikiPageControls
{
	// Controls base configuration
	private $page;
	private $info;

	// Flags
	private $isAllLanguage = false;

	// Data caches
	private $backlinks;
	private $trads;
	private $canEdit;
	private $canUndo;
	private $canSlideshow;
	private $structureInfo;
	private $attachmentCount;
	private $commentCount;

	function __construct( $info ) // {{{
	{
		$this->page = $info['pageName'];
		$this->info = $info;
	} // }}}

	function build() // {{{
	{
		switch($mode) {
		case 'translate_new':
		case 'translate_update':
			$this->setHeading( tr('%0 (translation of %1)', $this->page, $this->translationSource), $this->link( 'wiki page', $this->page ) );
			break;
		default:
			$this->setHeading( $this->page, $this->link( 'wiki page', $this->page ) );
			break;
		}

		if( $this->hasPref('feature_multilingual') ) {
			$this->addLanguageMenu();
		}

		$this->addActionMenu();

		if( $this->hasPref('feature_backlinks') ) {
			$backlinksMenu = $this->addMenu( tra('Backlinks') );

			foreach( $this->getBacklinks() as $back ) {
				$link = $this->link( 'wiki page', $back['fromPage'] );
				$backlinksMenu->addItem( $back['fromPage'], $link );
			}
		}

		$this->addTabs();
	} // }}}

	function setTranslations( $trads ) // {{{
	{
		$this->trads = $trads;
	} // }}}

	function setBacklinks( $backlinks ) // {{{
	{
		$this->backlinks = $backlinks;
	} // }}}

	function setStructureInfo( $info ) // {{{
	{
		$this->structureInfo = $info;
	} // }}}

	function setCanEdit( $can ) // {{{
	{
		$this->canEdit = (bool) $can;
	} // }}}

	function setCanUndo( $can ) // {{{
	{
		$this->canUndo = (bool) $can;
	} // }}}

	function setCanSlideshow( $can ) // {{{
	{
		$this->canSlideshow = (bool) $can;
	} // }}}

	function setAttachmentCount( $count ) // {{{
	{
		$this->attachmentCount = (int) $count;
	} // }}}

	function isAllLanguage( $isAllLanguage ) // {{{
	{
		$this->isAllLanguage = (bool) $isAllLanguage;
	} // }}}

	function setTranslationSource( $sourcePage ) // {{{
	{
		$this->translationSource = $sourcePage;
	} // }}}

	private function getBacklinks() // {{{
	{
		if( $this->backlinks )
			return $this->backlinks;

		return $this->backlinks = $wikilib->get_backlinks($this->page);
	} // }}}

	private function getTranslations() // {{{
	{
		if( $this->trads )
			return $this->trads;

		return $this->trads = $multilinguallib->getTranslations('wiki page', $this->info['page_id'], $this->page, $this->info['lang']);
	} // }}}

	private function addLanguageMenu() // {{{
	{
		$langMenu = $this->addMenu( tra('Language') );

		foreach( $this->getTranslations() as $trad ) {
			$link = $this->link( 'wiki page', $trad['objName'] );
			$item = $langMenu->addItem( $trad['langName'], $link );
			$item->setSelected( ! $this->isAllLanguage && $this->info['lang'] == $trad['lang'] );
		}

		if( $this->hasPref('feature_multilingual_one_page') ) {
			$link = $this->link( 'url', 'tiki-all_languages', array(
				'page' => $this->page,
			) );
			$langMenu->addSeparator();
			$item = $langMenu->addItem( tra('All'), $link );
			$item->setSelected( $this->isAllLanguage );
		}

		if( $this->hasPerm('tiki_p_edit') ) {
			$link = $this->link( 'url', 'tiki-edit_translation.php', array(
				'page' => $this->page,
			) );
			$langMenu->addSeparator();
			$langMenu->addItem( tra('Translate'), $link );
		}
	} // }}}
	
	private function addActionMenu() // {{{
	{
		$actionMenu = $this->addMenu( tra('Actions') );

		if( $this->hasPerm('tiki_p_rename') ) {
			$link = $this->link( 'url', 'tiki-rename_page.php', array(
				'page' => $this->page,
			) );
			$actionMenu->addItem( tra('Rename'), $link )
				->setSelected( $this->isMode('rename') );
		}

		if( $this->hasPerm('tiki_p_remove') ) {
			$link = $this->link( 'url', 'tiki-removepage.php', array(
				'page' => $this->page,
				'version' => 'last',
			) );
			$actionMenu->addItem( tra('Remove'), $link )
				->setSelected( $this->isMode('remove') );
		}

		if( $this->hasPerm('tiki_p_assign_perm_wiki_page') 
		 || $this->hasPerm('tiki_p_admin_wiki') ) {
			$link = $this->link( 'url', 'tiki-objectpermissions.php', array(
				'objectId' => $this->page,
				'objectName' => $this->page,
				'objectType' => 'wiki page',
				'permType' => 'wiki',
			) );
			$actionMenu->addItem( tra('Permissions'), $link )
				->setSelected( $this->isMode('permissions') );
		}

		if( $this->hasPref('feature_likePages') ) {
			$link = $this->link( 'url', 'tiki-likePages.php', array(
				'page' => $this->page,
			) );
			$actionMenu->addItem( tra('Similar'), $link )
				->setSelected( $this->isMode('similar') );
		}

		if( $this->hasPref('feature_wiki_undo') && $this->canUndo() ) {
			$link = $this->link( 'wiki page', $this->page, array(
				'undo' => 1,
			) );
			$actionMenu->addItem( tra('Undo'), $link )
				->setSelected( $this->isMode('undo') );
		}

		if( $this->hasPref('feature_wiki_make_structure') 
		 && $this->hasPerm('tiki_p_edit_structures')
		 && $this->canEdit()
		 && ! $this->hasStructure() ) {
			$link = $this->link( 'wiki page', $this->page, array(
				'convertstructure' => 1,
			) );
			$actionMenu->addItem( tra('Make Structure'), $link )
				->setSelected( $this->isMode('structure_make') );
		}

		if( $this->hasPref('wiki_uses_slides') ) {
			if( $this->hasSlideshow() ) {
				$link = $this->link( 'url', 'tiki-slideshow.php', array(
					'page' => $this->page,
				) );
				$actionMenu->addItem( 'Slides', $link )
					->setSelected( $this->isMode('slide') );
			}
			if( $this->hasStructure() ) {
				$link = $this->link( 'url', 'tiki-slideshow2.php', array(
					'page_ref_id' => $this->structureInfo['page_ref_id'],
				) );
				$actionMenu->addItem( 'Structure Slides', $link )
					->setSelected( $this->isMode('slide_structure') );
			}
		}

		if( $actionMenu->isEmpty() ) {
			$this->removeMenu( $actionMenu );
		}
	} // }}}

	private function addTabs() // {{{
	{
		$link = $this->link( 'wiki page', $this->page );
		$tab = $this->addTab( tra('View'), $link );
		$tab->setSelected( $this->isMode('view') );

		if( $this->hasPerm('tiki_p_edit') ) {
			$link = $this->link( 'url', 'tiki-editpage.php', array(
				'page' => $this->page
			) );
			switch($this->getMode()) {
			case 'translate_new':
			case 'translate_update':
				$tab = $this->addTab( tra('Translate'), $link );
				$tab->setSelected( $this->isMode('translate_new', 'translate_update') );
				break;
			case 'edit_section':
				$tab = $this->addTab( tra('Edit Section'), $link );
				$tab->setSelected( $this->isMode('edit_section') );
				break;
			default:
				$tab = $this->addTab( tra('Edit'), $link );
				$tab->setSelected( $this->isMode('edit') );
				break;
			}
		}

		if( $this->hasPref('feature_categories')
		 && $this->hasPerm('tiki_p_view_categories') ) {
			// TODO : Determine where this goes
			$link = $this->link( 'url', 'tiki-index.php', array(
				'page' => $this->page
			) );
			$tab = $this->addTab( tra('Categorize'), $link );
			$tab->setSelected( $this->isMode('category') );
		}

		if( $this->hasPref('feature_wiki_comments')
		 && $this->hasPerm('tiki_p_wiki_view_comments') ) {
			// TODO : Determine where this goes
			$link = $this->link( 'url', 'tiki-index.php', array(
				'page' => $this->page
			) );
			$tab = $this->addTab( tra('Comments'), $link, $this->getCommentCount() );
			$tab->setSelected( $this->isMode('comment') );
		}

		if( $this->hasPref('feature_wiki_attachments')
		 && $this->hasPerm('tiki_p_wiki_view_attachments') ) {
			// TODO : Determine where this goes
			$link = $this->link( 'url', 'tiki-index.php', array(
				'page' => $this->page
			) );
			$tab = $this->addTab( tra('Attachments'), $link, $this->getAttachmentCount() );
			$tab->setSelected( $this->isMode('attach') );
		}

		if( $this->hasPref('feature_history')
		 && $this->hasPerm('tiki_p_wiki_view_history') ) {
			// TODO : Determine where this goes
			$link = $this->link( 'url', 'tiki-pagehistory.php', array(
				'page' => $this->page
			) );
			$tab = $this->addTab( tra('History'), $link );
			$tab->setSelected( $this->isMode('history') );
		}
	} // }}}

	private function canUndo() // {{{
	{
		if ( $this->canUndo !== null ) return $this->canUndo;

		global $tiki_p_admin_wiki, $tiki_p_remove, $tiki_p_edit;

		if ( $this->info['flag'] != 'L'
			&& (
				( $tiki_p_edit == 'y' && $this->info['user'] == $this->user ) || $tiki_p_remove == 'y'
			) )  {
			$this->canUndo = true;
		}
		if ( $tiki_p_admin_wiki == 'y' ) {
			$this->canUndo = true;
		}

		return $this->canUndo;
		
	} // }}}

	private function canEdit() // {{{
	{
		if( !is_null($this->canEdit) )
			return $this->canEdit;

		$this->canEdit = $wikilib->is_editable($this->page, $this->user, $this->info);
		return $this->canEdit;
	} // }}}

	private function hasStructure() // {{{
	{
		return ! is_null($this->getStructureInfo());
	} // }}}

	private function getStructureInfo() // {{{
	{
		if( $this->structureInfo ) {
			return $this->structureInfo;
		}
		
		// TODO : Fetch structure info here if not present
	} // }}}

	private function getAttachmentCount() // {{{
	{
		if( ! is_null($this->attachmentCount) )
			return $this->attachmentCount;

		// TODO : Fetch attachment count here
	} // }}}

	private function getCommentCount() // {{{
	{
		if( !is_null($this->commentCount) )
			return $this->commentCount;

		// TODO : Fetch comment count here
	} // }}}

	private function hasSlideshow() // {{{
	{
		if( ! is_null( $this->canSlideshow ) )
			return $this->canSlideshow;

		if ($prefs['wiki_uses_slides'] != 'y') {
			return $this->canSlideshow = false;
		}

		$slides = split("-=[^=]+=-",$this->info['data']);
		if(count($slides)>1) {
			return $this->canSlideshow = true;
		} else {
			$slides = explode('...page...',$this->info['data']);

			return $this->canSlideshow = count($slides) > 1;
		}
	} // }}}
}

?>
