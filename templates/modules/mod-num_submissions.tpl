<!-- START of {$smarty.template} -->{* $Id$ *}

{if $prefs.feature_submissions eq 'y'}
{if !isset($tpl_module_title)}{assign var=tpl_module_title value="{tr}Waiting Submissions{/tr}"}{/if}
{tikimodule error=$module_params.error title=$tpl_module_title name="num_submissions" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
  {tr}We have{/tr} {$modNumSubmissions} <a class="linkmodule" href="tiki-list_submissions.php">{tr}submissions waiting to be examined{/tr}</a>.
{/tikimodule}
{/if}
