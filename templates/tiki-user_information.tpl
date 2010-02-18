{* $Id$ *}

{title url="tiki-user_information.php?view_user=$userwatch"}{tr}User Information{/tr}{/title}

{if $prefs.feature_tabs neq 'y' and $user and $prefs.feature_messages eq 'y' and $tiki_p_messages eq 'y' and $allowMsgs eq 'y'}
<div class="navbar">
	{button href="#message" _text="{tr}Send me a message{/tr}"}
</div>
{/if}

{tabset name="user_information"}
	{tab name="{tr}Basic Data{/tr}"}
	<div>
		<div style="vertical-align: top">
					<div class="clearfix">
		 				<div class="floatleft">
		 					<h2><big>{$userinfo.login|userlink}</big></h2>
		 				</div>
						<div class="form floatright">
		{if $tiki_p_admin eq 'y' or $userinfo.login eq $user}
			{if $tiki_p_admin eq 'y'}
							<a class="link" href="tiki-assignuser.php?assign_user={$userinfo.login|escape:"url"}" title="{tr}Assign Group{/tr}">{icon _id='key' align="right" alt="{tr}Assign Group{/tr}"}</a>
			{/if}
							<a class="link" href="tiki-user_preferences.php?userId={$userinfo.userId}" title="{tr}Change user preferences{/tr}">{icon _id='wrench' align="right" alt="{tr}Change user preferences{/tr}"}</a>
		{/if}
						</div>
					</div>
		
					{if $user_picture_id}
					<div class="userpicture">
						{wikiplugin _name="img" fileId="$user_picture_id"}{/wikiplugin}
					</div>
					{/if}
					
					<div class="simplebox">
						<div>
		{if $avatar}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Avatar{/tr} ({tr}User Icon{/tr}):</div>
								<div class="form floatright">{if $userinfo.login eq $user}<a href="tiki-pick_avatar.php">{/if}{$avatar}{if $userinfo.login eq $user}</a>{/if}</div>
							</div>
		{/if}
							
		{cycle values="even,odd" print=false}
		{if $realName }
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Real Name{/tr}:</div>
								<div class="form floatright">{$realName}</div>
							</div>
		{/if}
		{if $prefs.feature_community_gender eq 'y' and $gender neq 'Hidden' and $gender}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Gender{/tr}:</div>
								<div class="form floatright">{tr}{$gender}{/tr}</div>
							</div>
		{/if}
		{if $email_isPublic neq 'n' and $userinfo.email neq ''}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Email{/tr}:</div>
								<div class="form floatright">{mailto address=$userinfo.email encode="javascript"}</div>
							</div>
		{elseif $email_isPublic eq 'n' and $userinfo.email neq '' and $tiki_p_admin eq 'y'}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Email{/tr}:</div>
								<div class="form floatright">{mailto address=$userinfo.email encode="javascript"} <i>{tr}(non public){/tr}</i></div>
							</div>
		{/if}
		{if !empty($country) and $country != 'Other'}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Country{/tr}:</div>
								<div class="form floatright">{$userinfo.login|countryflag} {tr}{$country|stringfix}{/tr}</div>
							</div>
		{/if}
		{if $prefs.change_theme ne 'n'}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Theme{/tr}:</div>
								<div class="form floatright">{$user_style}</div>
							</div>
		{/if}
		{if $prefs.change_language eq 'y'}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Language{/tr}:</div>
								<div class="form floatright">{$user_language}</div>
							</div>
		{/if}
		{if $homepage}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Homepage{/tr}:</div>
								<div class="form floatright">{if $homePage ne ""}<a href="{$homePage}" class="link" title="{tr}Users HomePage{/tr}">{$homePage}</a>{/if}</div>
							</div>
		{/if}
		{if $prefs.feature_score eq 'y'}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Score{/tr}:</div>
								<div class="form floatright">{$userinfo.score|star}{$userinfo.score}</div>
							</div>
		{/if}
		{if $prefs.feature_wiki eq 'y' && $prefs.feature_wiki_userpage eq 'y' && ($userPage_exists or $user == $userinfo.login)}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Personal Wiki Page{/tr}:</div>
								<div class="form floatright">
			{if $userPage_exists}
									<a class="link" href="tiki-index.php?page={$prefs.feature_wiki_userpage_prefix|escape:'url'}{$userinfo.login|escape:'url'}">{$prefs.feature_wiki_userpage_prefix}{$userinfo.login}</a>
			{elseif $user == $userinfo.login}
				{$prefs.feature_wiki_userpage_prefix}{$userinfo.login}<a class="link" href="tiki-editpage.php?page={$prefs.feature_wiki_userpage_prefix|escape:'url'}{$userinfo.login|escape:'url'}" title="{tr}Create page{/tr}">?</a>
			{else}&nbsp;{/if}
								</div>
							</div>
		{/if}
		
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Last login{/tr}:</div>
								<div class="form floatright">{$userinfo.lastLogin|tiki_short_datetime}</div>
							</div>
		
		
							{*<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}Displayed time zone{/tr}:</div>
								<div class="form floatright">{$user_prefs.display_timezone|default:"{tr}System{/tr}"}</div>
							</div>*}

		{* Custom database fields *}
		{section name=ir loop=$customfields}
			{cycle values="even,odd" print=false}
			{if $customfields[ir].show}
							<div class="clearfix {cycle}">
								<div class="form floatleft">{tr}{$customfields[ir].label}{/tr}:</div>
								<div class="form floatright">{$customfields[ir].value}</div>
							</div>
			{/if}
		{/section}
		
			
						</div>
					</div>
					
		{if $prefs.feature_friends eq 'y' && $user ne $userwatch && $user}
			<div class="cbox-data">
			{if $friend}
							<div class="clearfix">
								<div class="form">{icon _id='user'} <a class="link" href="tiki-friends.php">{tr}This user is your friend !{/tr}</a></div>
							</div>  
			{elseif $friend_pending}
							<div class="clearfix">
								<div class="form">{icon _id='user_delete'} {tr}The user requested friendship with you{/tr} <br /><a class="link" href="tiki-friends.php?accept={$userinfo.login}">{tr}Accept friendship from this user{/tr}</a> <br /><a class="link" href="tiki-friends.php?refuse={$userinfo.login}">{tr}Refuse friendship from this user{/tr}</a>
 								</div>
							</div>
			{elseif $friend_waiting}
							<div class="clearfix">
								<div class="form">{icon _id='user_delete'} {tr}Currently waiting for user approval{/tr} <br />
									<a class="link" href="tiki-friends.php?cancel_waiting_friendship={$userinfo.login}">{tr}Cancel friendship request towards this user{/tr}</a>
								</div>
							</div>  
			{else}
							<div class="clearfix">
								<div class="form">{icon _id='user_delete'} <a class="link" href="tiki-friends.php?request_friendship={$userinfo.login}">{tr}Request friendship from this user{/tr}</a>
								</div>
							</div>
			{/if}
			</div>
		{/if}
					
		</div>
	</div>
	{/tab}
	
	{if $prefs.user_tracker_infos}{tab name="{tr}Additional Information{/tr}"}
	<div class="simplebox">
		<h2 class="center">{tr}Additional Information{/tr} &ndash; {$userinfo.login|userlink}</h2>
			{cycle values="even,odd" print=false}
			{foreach item=itemField from=$userItem.field_values}
				{if $itemField.value ne '' or !empty($itemField.categs) or !empty($itemField.links)}
		<div class="clearfix {cycle}">
			<div class="form floatleft" style="width: 25%">{tr}{$itemField.name}{/tr}:</div>
			<div class="form floatright" style="width: 75%">{include file="tracker_item_field_value.tpl" field_value=$itemField item=$itemField}</div>
		</div>
				{/if}
			{/foreach}
	</div>
	{/tab}{/if}
	
	{if $prefs.feature_display_my_to_others eq 'y'}{tab name="{tr}User Contribution{/tr}"}
	<div>
		<div class="simplebox">
		{if ($user_pages|@count > 0) or ($user_galleries|@count > 0) or ($user_blogs|@count > 0) or ($user_articles|@count > 0) or ($user_forum_comments|@count > 0) or ($user_forum_topics|@count > 0) or ($user_items|@count > 0)}
			<h2 class="center">{tr}User{/tr} {$userinfo.login|userlink} {tr}has contributed to the following content{/tr}&hellip;</h2>
		{else}
			<h2 class="center">{tr}User{/tr} {$userinfo.login|userlink} {tr}has not contributed to any content yet{/tr}</h2>
		{/if}
		
			{if $user_pages|@count > 0}
			<h3>{tr}Wiki Pages{/tr}</h3>
			<div class="normal">
				{cycle values="even,odd" print=false}
				{section name=ix loop=$user_pages}
				<div>
					<div class="{cycle}">
						<a class="link" title="{tr}View{/tr}: {$user_pages[ix].pageName}" href="tiki-index.php?page={$user_pages[ix].pageName|escape:"url"}">{$user_pages[ix].pageName|truncate:40:"(...)"}</a>
					</div>
				</div>
				{/section}
			</div>
			{/if}
			{if $user_galleries|@count > 0}
			<h3>{tr}Image Galleries{/tr}</h3>
			<div class="normal">
				{cycle values="even,odd" print=false}
				{section name=ix loop=$user_galleries}
				<div>
					<div class="{cycle}">
						<a class="link" href="{$user_galleries[ix].galleryId|sefurl:gallery}">{$user_galleries[ix].name|escape}</a>{/section}
					</div>
				</div>
			</div>
			{/if}
			{if $user_blogs|@count > 0}
			<h3>{tr}Blogs{/tr}</h3>
			<div class="normal">
				{cycle values="even,odd" print=false}
				{section name=ix loop=$user_blogs}
				<div>
					<div class="{cycle}">
						<a class="link" title="{tr}View{/tr}" href="{$user_blogs[ix].blogId|sefurl:blog}">{$user_blogs[ix].title|escape}</a>
					</div>
				</div>
				{/section}
			</div>
			{/if}
			{if $user_articles|@count > 0}
			<h3>{tr}Articles{/tr}</h3>
			<div class="normal">
				{cycle values="even,odd" print=false}
				{section name=ix loop=$user_articles}
				<div>
					<div class="{cycle}">
						<a class="link" title="{tr}View{/tr}" href="{$user_articles[ix].articleId|sefurl:article}">{$user_articles[ix].title|escape}</a>
					</div>
				</div>
				{/section}
			</div>
			{/if}
			{if $user_forum_comments|@count > 0}
			<h3>{tr}Forum comments{/tr}</h3>
			<div class="normal">
				{cycle values="even,odd" print=false}
				{section name=ix loop=$user_forum_comments}
				<div>
					<div class="{cycle}">
						<a class="link" title="{tr}View{/tr}" href="tiki-view_forum_thread.php?comments_parentId={$user_forum_comments[ix].threadId}&forumId={$user_forum_comments[ix].object}">{$user_forum_comments[ix].title|escape}</a>
					</div>
				</div>
				{/section}
			</div>
			{/if}
			{if $user_forum_topics|@count > 0}
			<h3>{tr}Forum topics{/tr}</h3>
			<div class="normal">
				{cycle values="even,odd" print=false}
				{section name=ix loop=$user_forum_topics}
				<div>
					<div class="{cycle}"><a class="link" title="{tr}View{/tr}" href="tiki-view_forum_thread.php?comments_parentId={$user_forum_topics[ix].threadId}&forumId={$user_forum_topics[ix].object}">{$user_forum_topics[ix].title|escape}</a></div>
				</div>
				{/section}
			</div>
			{/if}
			{if $user_items|@count > 0}
			<h3>{tr}User Items{/tr}</h3>
			<div class="normal">
				{cycle values="even,odd" print=false}
				{section name=ix loop=$user_items}
				<div>
					<div class="{cycle}">
						<a class="link" title="{tr}View{/tr}" href="tiki-view_tracker_item.php?trackerId={$user_items[ix].trackerId}&amp;itemId={$user_items[ix].itemId}">{$user_items[ix].name|escape}: {$user_items[ix].value|escape}</a>
					</div>
				</div>
				{/section}
			</div>
			{/if}
		</div>
	</div>		
	{/tab}{/if}
	
	
	{if $prefs.feature_actionlog eq 'y' && $prefs.user_who_viewed_my_stuff eq 'y'}
	{tab name="{tr}Who Looks At Your Stuff?{/tr}"}	
		<div class="simplebox">
			<h2 class="center">{tr}Who Looks At Your Stuff?{/tr}</h2>
			{cycle values="even,odd" print=false}
			{section name=ix loop=$whoviewed}
			<div class="clearfix {cycle}">
		 		<div class="form floatleft">
					{$whoviewed[ix].user|userlink} - {$whoviewed[ix].lastViewed|tiki_short_datetime}
		 		</div>
				<div class="form floatright">
					<a href="{$whoviewed[ix].link|escape:url}">{$whoviewed[ix].object|escape} ({$whoviewed[ix].objectType|escape})</a>
				</div>
			</div>
			{/section}
		</div>
	{/tab}
	{/if}
	
	{if $user and $prefs.feature_messages eq 'y' and $tiki_p_messages eq 'y' and $allowMsgs eq 'y'}{tab name="{tr}Send Me A Message{/tr}"}
			<div id="message" class="simplebox">
		{if $sent}
			{$message}
		{else}
				<h2 class="center">{tr}Send me a message !{/tr}</h2>
				<form method="post" action="tiki-user_information.php" name="f">
					<input type="hidden" name="to" value="{$userwatch|escape}" />
					<input type="hidden" name="view_user" value="{$userwatch|escape}" />
					<div class="normalnoborder">
						<p>{tr}The following message will be sent to user{/tr} {$userinfo.login|userlink}&hellip;</p>
						<div class="clearfix">
							<div class="form floatleft" style="width: 25%"><label for="priority"><span>{tr}Priority{/tr}</span></label>:</div>
							<div class="form floatleft" style="width: 50%">
								<select name="priority" id="priority">
									<option value="1" {if $priority eq 1}selected="selected"{/if}>1 -{tr}Lowest{/tr}-</option>
									<option value="2" {if $priority eq 2}selected="selected"{/if}>2 -{tr}Low{/tr}-</option>
									<option value="3" {if $priority eq 3}selected="selected"{/if}>3 -{tr}Normal{/tr}-</option>
									<option value="4" {if $priority eq 4}selected="selected"{/if}>4 -{tr}High{/tr}-</option>
									<option value="5" {if $priority eq 5}selected="selected"{/if}>5 -{tr}Very High{/tr}-</option>
								</select>
							</div>
							<div class="form floatright input_submit_container">
								<input type="submit" name="send" value="{tr}Send{/tr}" />
							</div>
						</div>
						<div class="clearfix">
							<label><span>{tr}Subject{/tr}</span>: <input type="text" name="subject" value="" maxlength="255" style="width:100%;" /></label>
						</div>
						<div>
							<label><span>{tr}Message Body{/tr}</span>:
								<textarea rows="20" cols="80" name="body" style="border: solid 1px #000; width: 100%;"></textarea>
							</label>
						</div>
					</div>

				</form>
		{/if}
			</div>
	{/tab}{/if}
{/tabset}

