{title help="TikiWikiImporter"}TikiWiki importer{/title}

<br />

{if $chooseSoftware}
    {remarksbox type="warning" title="{tr}Warning:{/tr}"}
        {tr}If you are NOT running a new Tiki installation, make a backup of your database before using this importer!{/tr}
    {/remarksbox}
    {if ini_get('safe_mode')}
        {remarksbox type="warning" title="{tr}Warning:{/tr}"}
            {tr}Your PHP is running with safe mode enabled. This might cause problems to the import process as safe mode limits the possibly to change in run time some PHP settings (like max_execution_time). It is recommended to run this script without safe mode.{/tr}
        {/remarksbox}
    {/if}
    {remarksbox type="note" title="{tr}Note:{/tr}"}
        {tr}Depending on the size of the file from the source software the import process may take a while to complete. This migth be a problem according to your PHP and web server settings. This script tries to change the relevant settings but there are some settings that the script cannot change. So if you are having problems with the script try to increase the value of the following settings: max_input_time, post_max_size, upload_max_filesize. It is recommended that you run this script in a server where you can change the values of those settings if needed.{/tr}
    {/remarksbox}
       
    <br />
    
    Please choose the software to import from:
    <form method="post" name="chooseSoftware" action="tiki-importer.php">
        <select name="importerClassName">
            <option value=""></option>
            {foreach from=$availableSoftwares key=softwareClassName item=softwareName}
                <option value="{$softwareClassName}">{$softwareName}</option>
            {/foreach}
        </select>
        <input type="submit" value="{tr}Ok{/tr}"/>
    </form>
{elseif $softwareSpecificOptions}
    <h4>Import options:</h4>
    <form method="post" enctype="multipart/form-data" action="tiki-importer.php" onsubmit="return confirm('{tr}ATTENTION: make sure to have a backup before running the script. If you do not have a backup this is the last chance to cancel the importer by clicking on the cancel button.{/tr}');";>
        <input type="hidden" name="importerClassName" value="{$importerClassName}"/>
        {foreach from=$importerOptions item=option}
            {if $option.type eq 'checkbox'}
                <input type="checkbox" name="{$option.name}"/><label for="{$options.name}">{tr}{$option.label}{/tr}</label><br />
            {elseif $option.type eq 'text'}
                {tr}{$option.label}{/tr}: <input type="text" name="{$option.name}"/><br />
            {elseif $option.type eq 'select'}
		        {tr}{$option.label}{/tr}<br />
		        <select name="{$option.name}">
		        {foreach from=$option.options item=selectOption}
                    <option value="{$selectOption.name}">{$selectOption.label}</option>
		        {/foreach}
		        </select>
            {/if}
        {/foreach}
        <br /><br />
        <input type="file" name="importFile"/><br />
        <input type="submit" value="{tr}Import!{/tr}"/>
    </form>
{elseif !empty($importFeedback)}
    <h4>{tr}Congratulations! You have successful imported your {$softwareName} data to Tikiwiki.{/tr}</h4>
    <p>{$importFeedback.importedPages} {tr}pages imported from a total of{/tr} {$importFeedback.totalPages}</p>
    <p>{tr}You can see the list of wiki pages in your site{/tr} <a href="tiki-listpages.php">{tr}here{/tr}</a></p>

    <br /><br />
    <p><b>{tr}Importer log:{/tr}</b></p>
    <code>
        {$importLog}
    </code>
{/if}
