{title help="ImportingPagesAdmin"}{tr}Import pages from a Structured Text Dump{/tr}{/title}

<form method="post" action="tiki-import_structuredtext.php">
<table class="normal">
<tr>
  <td class="formcolor">{tr}Name of the dump file (it has to be in dump/){/tr}:</td>
  <td class="formcolor"><input type="text" name="path" /></td>
</tr>
<tr>
  <td class="formcolor">{tr}Overwrite existing pages if the name is the same{/tr}:</td>
  <td class="formcolor">{tr}Yes{/tr}<input type="radio" name="crunch" value='y' /><input checked="checked" type="radio" name="crunch" value='n' />{tr}No{/tr}</td>
</tr>
<tr>
  <td class="formcolor">{tr}Previously remove existing page versions{/tr}:</td>
  <td class="formcolor">{tr}Yes{/tr}<input type="radio" name="remo" value='y' /><input checked="checked" type="radio" name="remo" value='n' />{tr}No{/tr}</td>
</tr>
<tr>
  <td class="formcolor">&nbsp;</td>
  <td class="formcolor"><input type="submit" name="import" value="{tr}import{/tr}" /></td>
</tr>
</table>
</form>
<br /><br />
{if $result eq 'y'}
<table class="normal">
<tr>
  <td class="heading">{tr}page{/tr}</td>
  <td class="heading">{tr}excerpt{/tr}</td>
  <td class="heading">{tr}Result{/tr}</td>
  <td class="heading">{tr}body{/tr}</td>
</tr>
{cycle values="odd,even" print=false}
{section name=ix loop=$lines}
<tr>
  <td class="{cycle advance=false}">{$lines[ix].page}</td>
  <td class="{cycle advance=false}">{$lines[ix].ex}</td>
  <td class="{cycle advance=false}">{$lines[ix].msg}</td>
  <td class="{cycle}">{$lines[ix].body}</td>
</tr>
{/section}
</table>
<br /><br />
{/if}
