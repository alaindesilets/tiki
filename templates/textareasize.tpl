{* $Header: /cvsroot/tikiwiki/tiki/templates/textareasize.tpl,v 1.7 2006-09-30 13:53:22 ohertel Exp $ *}
{* \brief: the 4 buttoms to change a textarea size (only one per form)
  * \param: $area_name = the textarea id
  * \param: $formId = the form id
  * the form needs 2 hidden input named 'rows' and 'cols' to remember the settings for a preview
  *}

<a href="javascript:textareasize('{$area_name}', +10, 0, '{$formId}')" title="{tr}Enlarge area height{/tr}"><img src="pics/icons/arrow_out.png" border="0" width="16" height="16" alt="{tr}Enlarge area height{/tr}" /></a> &nbsp;
<a href="javascript:textareasize('{$area_name}', -10, 0, '{$formId}')" title="{tr}Reduce area height{/tr}"><img src="pics/icons/arrow_in.png" border="0" width="16" height="16" alt="{tr}Reduce area height{/tr}" /></a>
