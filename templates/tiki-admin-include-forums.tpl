{* $Header: /cvsroot/tikiwiki/tiki/templates/tiki-admin-include-forums.tpl,v 1.21 2007-07-08 17:39:05 nyloth Exp $ *}
<div class="rbox" name="tip">
<div class="rbox-title" name="tip">{tr}Tip{/tr}</div>  
<div class="rbox-data" name="tip">{tr}To add/remove forums, look for "Admin forums" under "Forums" on the application menu, or{/tr} <a class="rbox-link" href="tiki-admin_forums.php">{tr}click here{/tr}</a>.</div>
</div>
<br />

<div class="cbox">
  <div class="cbox-title">{tr}Home Forum{/tr}</div>
  <div class="cbox-data">
      <form method="post" action="tiki-admin.php?page=forums">
        <table class="admin"><tr class="form">
          <td><label>{tr}Home Forum (main forum){/tr}</label></td>
          <td><select name="home_forum">
          		<option value="">-</option>
              {section name=ix loop=$forums}
                <option value="{$forums[ix].forumId|escape}" {if $forums[ix].forumId eq $home_forum}selected="selected"{/if}>{$forums[ix].name|truncate:20:"...":true}</option>
              {/section}
              </select></td>
          <td><input type="submit" name="homeforumprefs"
              value="{tr}ok{/tr}" /></td>
        </tr></table>
      </form>
  </div>
</div>

<div class="cbox">
  <div class="cbox-title">{tr}Forums features{/tr}</div>
  <div class="cbox-data">
      <form method="post" action="tiki-admin.php?page=forums">
        <table class="admin"><tr class="form">
          <td><label>{tr}Rankings{/tr}:</label></td>
          <td><input type="checkbox" name="feature_forum_rankings"
              {if $feature_forum_rankings eq 'y'}checked="checked"{/if}/></td>
        </tr><tr class="form">
          <td><label>{tr}Accept wiki syntax{/tr}:</label></td>
          <td><input type="checkbox" name="feature_forum_parse"
              {if $feature_forum_parse eq 'y'}checked="checked"{/if}/></td>
        </tr><tr class="form">
          <td><label>{tr}Reply posts are empty{/tr}:</label></td>
          <td><input type="checkbox" name="feature_forum_replyempty"
              {if $feature_forum_replyempty eq 'y'}checked="checked"{/if}/></td>
        </tr>
	  <tr class="form">
          <td><label>{tr}Forum quick jumps{/tr}:</label></td>
          <td><input type="checkbox" name="feature_forum_quickjump"
              {if $feature_forum_quickjump eq 'y'}checked="checked"{/if}/></td>
        </tr><tr class="form">
          <td><label>{tr}Ordering for forums in the forum listing{/tr}</label></td>
          <td><select name="forums_ordering">
              <option value="created_desc" {if $forums_ordering eq 'created_desc'}selected="selected"{/if}>{tr}Creation Date (desc){/tr}</option>
              <option value="threads_desc" {if $forums_ordering eq 'threads_desc'}selected="selected"{/if}>{tr}Topics (desc){/tr}</option>
              <option value="comments_desc" {if $forums_ordering eq 'comments_desc'}selected="selected"{/if}>{tr}Threads (desc){/tr}</option>
              <option value="lastPost_desc" {if $forums_ordering eq 'lastPost_desc'}selected="selected"{/if}>{tr}Last post (desc){/tr}</option>
              <option value="hits_desc" {if $forums_ordering eq 'hits_desc'}selected="selected"{/if}>{tr}Visits (desc){/tr}</option>
              <option value="name_desc" {if $forums_ordering eq 'name_desc'}selected="selected"{/if}>{tr}Name (desc){/tr}</option>
              <option value="name_asc" {if $forums_ordering eq 'name_asc'}selected="selected"{/if}>{tr}Name (asc){/tr}</option>
              </select></td>
        </tr><tr class="form">
          <td><label>{tr}Tiki search local to a forum{/tr}</td>
          <td><input type="checkbox" name="feature_forum_local_tiki_search"
              {if $feature_forum_local_tiki_search eq 'y'}checked="checked"{/if}/></td>			
        </tr><tr class="form">
          <td><label>{tr}Non-Tiki search local to a forum{/tr}</td>
          <td><input type="checkbox" name="feature_forum_local_search"
              {if $feature_forum_local_search eq 'y'}checked="checked"{/if}/></td>			
        </tr><tr class="form">
          <td><label>{tr}Tiki search local to forums{/tr}</td>
          <td><input type="checkbox" name="feature_forums_tiki_search"
              {if $feature_forums_tiki_search eq 'y'}checked="checked"{/if}/></td>			
        </tr><tr class="form">
          <td><label>{tr}Non-Tiki search local to forums{/tr}</td>
          <td><input type="checkbox" name="feature_forums_search"
              {if $feature_forums_search eq 'y'}checked="checked"{/if}/></td>			
        </tr><tr>
          <td colspan="2" class="button"><input type="submit" name="forumprefs"
              value="{tr}Change preferences{/tr}" /></td>
        </tr></table>
      </form>
  </div>
</div>

<div class="cbox">
  <div class="cbox-title">{tr}Forum listing configuration{/tr}</div>
  <div class="cbox-data">
      <form method="post" action="tiki-admin.php?page=forums">
        <table class="admin"><tr class="form">
          <td><label>{tr}Topics{/tr}</label></td>
          <td><input type="checkbox" name="forum_list_topics"
              {if $forum_list_topics eq 'y'}checked="checked"{/if} /></td>
        </tr><tr class="form">
          <td><label>{tr}Posts{/tr}</label></td>
          <td><input type="checkbox" name="forum_list_posts"
              {if $forum_list_posts eq 'y'}checked="checked"{/if} /></td>
        </tr><tr class="form">
          <td><label>{tr}Posts per day{/tr}</label></td>
          <td><input type="checkbox" name="forum_list_ppd"
              {if $forum_list_ppd eq 'y'}checked="checked"{/if} /></td>
        </tr><tr class="form">
          <td><label>{tr}Last post{/tr}</label></td>
          <td><input type="checkbox" name="forum_list_lastpost"
              {if $forum_list_lastpost eq 'y'}checked="checked"{/if} /></td>
        </tr><tr class="form">
          <td><label>{tr}Visits{/tr}</label></td>
          <td><input type="checkbox" name="forum_list_visits"
              {if $forum_list_visits eq 'y'}checked="checked"{/if} /></td>
        </tr><tr class="form">
          <td><label>{tr}Description{/tr}</label></td>
          <td><input type="checkbox" name="forum_list_desc"
              {if $forum_list_desc eq 'y'}checked="checked"{/if} /></td>
        </tr><tr>
          <td colspan="2" class="button"><input type="submit" name="forumlistprefs"
              value="{tr}Change preferences{/tr}" /></td>
        </tr></table>
      </form>
  </div>
</div>    

<div class="cbox">
  <div class="cbox-title">{tr}Threads default preferences{/tr}</div>
  <div class="cbox-data">
      <form method="post" action="tiki-admin.php?page=forums">
        <table class="admin"><tr class="form">
          <td><label>{tr}Allow to manage thread defaults in each forum configuration{/tr}</label></td>
	  <td><input type="checkbox" name="forum_thread_defaults_by_forum"
		{if $forum_thread_defaults_by_forum eq 'y'}checked="checked"{/if} /></td>
	</td>
        </tr><tr class="form">
          <td><label>{tr}Display thread configuration bar to override defaults{/tr}</label></td>
	  <td><input type="checkbox" name="forum_thread_user_settings"
		{if $forum_thread_user_settings eq 'y'}checked="checked"{/if} />
	</td>
	</tr><tr class="form">
          <td><label>{tr}Configuration bar settings are the kept for all forums during the user session:{/tr}</label></td>
	  <td><input type="checkbox" name="forum_thread_user_settings_keep"
		{if $forum_thread_user_settings_keep eq 'y'}checked="checked"{/if} />
	</td>
        </tr><tr class="form">
          <td><label>{tr}Default number of comments per page{/tr}</label></td>
	  <td><input size="5" type="text" name="forum_comments_per_page" value="{$forum_comments_per_page|escape}" /></td></tr>
	</td>
        </tr><tr class="form">
          <td><label>{tr}Default thread style{/tr}</label></td>
	  <td><select name="forum_thread_style">
	  	<option value="commentStyle_plain" {if $forum_thread_style eq 'commentStyle_plain'}selected="selected"{/if}>{tr}Plain{/tr}</option>
		<option value="commentStyle_threaded" {if $forum_thread_style eq 'commentStyle_threaded'}selected="selected"{/if}>{tr}Threaded{/tr}</option>
		<option value="commentStyle_headers" {if $forum_thread_style eq 'commentStyle_headers'}selected="selected"{/if}>{tr}Headers Only{/tr}</option>
	  </select></td>
        </tr><tr class="form">
          <td><label>{tr}Default thread sort mode{/tr}</label></td>
	  <td><select name="forum_thread_sort_mode">
		<option value="commentDate_desc" {if $forum_thread_sort_mode eq 'commentDate_desc'}selected="selected"{/if}>{tr}Newest first{/tr}</option>
		<option value="commentDate_asc" {if $forum_thread_sort_mode eq 'commentDate_asc'}selected="selected"{/if}>{tr}Oldest first{/tr}</option>
		<option value="points_desc" {if $forum_thread_sort_mode eq 'points_desc'}selected="selected"{/if}>{tr}Score{/tr}</option>
		<option value="title_desc" {if $forum_thread_sort_mode eq 'title_desc'}selected="selected"{/if}>{tr}Title (desc){/tr}</option>
		<option value="title_asc" {if $forum_thread_sort_mode eq 'title_asc'}selected="selected"{/if}>{tr}Title (asc){/tr}</option>
	  </select></td>
        </tr><tr>
          <td colspan="2" class="button"><input type="submit" name="forumthreadprefs"
              value="{tr}Change preferences{/tr}" /></td>
        </tr></table>
      </form>
  </div>
</div>    
