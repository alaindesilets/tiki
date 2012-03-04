<?php                                                                                  
// (c) Copyright 2002-2012 by authors of the Tiki Wiki CMS Groupware Project           
//                                                                                     
// All Rights Reserved. See copyright.txt for details and a complete list of authors.  
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.  
// $Id$

function wikiplugin_convene_info()
{
	return array(
		'name' => tra('Convene'),
		'documentation' => 'PluginConvene',
		'description' => tra('Convene an event with schedule and members'),
		'introduced' => 9.0,
		'prefs' => array('wikiplugin_convene','feature_calendar'),
		'body' => tra('Convene data generated from user input'),
		'icon' => 'img/icons/arrow_in.png',
		'filter' => 'rawhtml_unsafe',
		'tags' => array( 'basic' ),	
		'params' => array(
			'title' => array(
				'required' => false,
				'name' => tra('Title of Event'),
				'default' => tra('Convene')
			),
		),
	);
}

function wikiplugin_convene($data, $params)
{
	global $tikilib, $headerlib, $page, $caching, $tiki_p_edit;

	static $htmlFeedLinkI = 0;
	++$conveneI;
	$i = $conveneI;
	
	$params = array_merge(array("title" => "Convene"), $params);	
	extract($params, EXTR_SKIP);
	
	$dataString = $data . '';
	$dataArray = array();
	
	$existingUsers = json_encode(TikiLib::lib("user")->get_users_names());
	
	//start flat static text to prepared array
	$lines = explode("\n", trim($data));
	sort($lines);
	foreach ($lines as $line) {
		$line = trim($line);
		
		$parts = explode(':', $line);
		$dataArray[trim($parts[0])] = trim($parts[1]);
	}
	
	$data = TikiFilter_PrepareInput::delimiter('_')->prepare($dataArray);
	//end flat static text to prepared array
	
	//start get users from array
	$users = array();
	foreach (end($data['dates']) as $user => $vote) {
		$users[] = $user;
	}
	//end get users from array
	
	
	//start votes summed together
	$votes = array();
	foreach ($data['dates'] as $stamp => $date) {
		foreach ($date as $vote) {
			$votes[$stamp] += $vote;
		}
	}
	//end votes summed together
	
	
	//start find top vote stamp
	$topVoteStamp = 0;
	foreach ($votes as $stamp => $vote) {
		$topVoteStamp = ($vote > $votes[$topVoteStamp] ? $stamp : $topVoteStamp);
	}
	//end find top vote stamp
	
	
	//start reverse array for easy listing as table
	$rows = array();
	foreach ($data['dates'] as $stamp => $date) {
		foreach ($date as $user => $vote) {
			if (isset($rows[$user][$stamp])) $rows[$user][$stamp] = array();
			 
			$rows[$user][$stamp] = $vote;
		}
	}
	//end reverse array for easy listing as table
	
	$result = "";
	
	//start date header
	$dateHeader = "";
	foreach ($votes as $stamp => $totals) {
		$dateHeader .= "<td>". $tikilib->get_long_datetime($stamp) .
			($tiki_p_edit == 'y' ? " <button class='conveneDeleteDate$i icon ui-widget-header ui-corner-all' data-date='$stamp'><img src='img/icons/delete.png' title='" . tr("Delete Date") . "'/></button>" : "").
		"</td>";
	}
	$result .= "
		<tr>
			<td>".
				(
				$tiki_p_edit == 'y'
					? 
					"<button class='conveneAddUser$i icon ui-widget-header ui-corner-all' style='margin: 0px;'>
						<img src='img/icons/user.png' title='".tr('Add User')."' />
					</button><button class='conveneAddDate$i icon ui-widget-header ui-corner-all' style='margin: 0px;'>
						<img src='img/icons/calendar_add.png' title='".tr('Add Date')."' />
					</button>"
					: ""
				).
			"</td>
			$dateHeader
		</tr>";
	//end date header
	
	
	//start user list and votes 
	$userList = "";
	foreach ($rows as $user => $row) {
		$userList .= "<tr class='conveneUserVotes$i'>";
		$userList .= "<td>". ($tiki_p_edit == 'y' ? "<button class='conveneUpdateUser$i icon ui-widget-header ui-corner-all'><img src='img/icons/pencil.png' title='" . tr("Edit User/Save changes") . "' /></button><button data-user='$user' title='" . tr("Delete User") . "' class='conveneDeleteUser$i icon ui-widget-header ui-corner-all'><img src='img/icons/delete.png'/></button> " : "") . $user . "</td>";
		foreach ($row as $stamp => $vote) {
			$class = 	"ui-state-default ui-state-active";
			$text = 	($vote  == 1 ? "<img src='img/icons/tick.png' alt='OK' class='vote' />" : "<img src='img/icons/cross.png' class='vote' />" );
			
			$userList .= "<td class='$class'>". $text
				."<input type='hidden' name='dates_" . $stamp . "_" . $user . "' value='$vote' class='conveneUserVote$i' />"
				."</td>";
		}
		$userList .= "</tr>";
	}
	$result .= $userList;
	//end user list and votes
	
	
	//start add new user and votes
	$result .= "<tr><td />";
	//end add new user and votes
	
	
	//start last row with auto selected date(s)
	$lastRow = "";
	foreach ($votes as $stamp => $total) {
		$pic = "";
		if ($total == $votes[$topVoteStamp]) {
			$pic .= ($tiki_p_edit != "y" ? "<img src='img/icons/tick.png' class='icon' title='" . tr("Selected Date") . "' />" : "");
			if ($tiki_p_edit == 'y') {
				$pic .= "<button class='icon ui-widget-header ui-corner-all' onclick='document.location = $(this).find(\"a\").attr(\"href\"); return false;'><a href='tiki-calendar_edit_item.php?todate=$stamp&calendarId=1' title='" . tr("Add as Calendar Event") . "'><img src='img/icons/calendar_add.png' class='icon' /></a></button>";
			}
		}
		
		$lastRow .= "<td>". $total ."&nbsp;$pic</td>";
	}
	$result .= $lastRow . "</tr>";
	//end last row with auto selected date(s)
	
	
	$result = <<<FORM
			<form id='pluginConvene$i'>
				<table cellpadding="2" cellspacing="2" border="0" style="width: 100%;">$result</table>
			</form>
FORM;
	
	$conveneData = json_encode(
					array(
						"dates" => $data['dates'],
						"users" => $users,
						"votes" => $votes,
						"topVote" => $votes[$topVoteStamp],
						"rows" =>	$rows,
						"data" => $dataString,
					)
	);
	
	$n = '\n\r';
	
	$headerlib->add_jsfile("lib/jquery/jquery-ui-timepicker-addon.js");
	$headerlib->add_jq_onready(
<<<JQ
		
		var convene$i = $.extend({
			fromBlank: function(user, date) {
				if (!user || !date) return;
				this.data = "dates_" + Date.parseUnix(date) + "_" + user;
				this.save();
			},
			updateUsersVotes: function() {
				var data = [];
				$('.conveneUserVotes$i').each(function() {
					$('.conveneUserVote$i').each(function() {
						data.push($(this).attr('name') + ' : ' + $(this).val());
					});
				});
				
				this.data = data.join('$n');
				
				this.save();
			},
			addUser: function(user) {
				if (!user) return;
				
				var data = [];
				
				for(date in this.dates) {
					data.push("dates_" + date + "_" + user);
				}
				
				this.data += '$n' + data.join('$n');
				
				this.save();
			},
			deleteUser: function(user) {
				if (!user) return;
				var data = '';
				
				for(date in this.dates) {
					for(i in this.users) {
						if (this.users[i] != user) {
							data += 'dates_' + date + '_' + this.users[i] + ' : ' + this.dates[date][this.users[i]] + '$n';
						}
					}
				}
				
				this.data = data;
				
				this.save();
			},
			addDate: function(date) {
				if (!date) return;
				date = Date.parseUnix(date);
				var addedData = '';
				
				for(user in this.users) {
					addedData += 'dates_' + date + '_' + this.users[user] + ' : 0$n';
				}
				
				this.data = (this.data + '$n' + addedData).split(/$n/).sort();
				
				//remove empty lines
				for(line in this.data) {
					if (!this.data[line]) this.data.splice(line, 1);
				}
				
				this.data = this.data.join('$n');
				
				this.save();
			},
			deleteDate: function(date) {
				if (!date) return;
				var addedData = '';
				
				for(user in this.users) {
					addedData += 'dates_' + date + '_' + this.users[user] + ' : 0$n';
				}
				
				var lines = convene$i.data.split(/$n/);
				var newData = [];
				for(line in lines) {
					if (!(lines[line] + '').match(date)) {
						 newData.push(lines[line]);
					}
				}
				
				this.data = newData.join('$n');
				
				this.save();
			},
			save: function() {
				$.modal(tr("Loading..."));
				
				$('<form id="conveneSave$i" method="post" action="tiki-wikiplugin_edit.php">'+
					'<div>'+
						'<input type="hidden" name="page" value="$page"/>'+
						'<input type="hidden" name="content" value="' + $.trim(this.data) + '"/>'+
						'<input type="hidden" name="index" value="$i"/>'+
						'<input type="hidden" name="type" value="convene"/>'+
						'<input type="hidden" name="params[title]" value="$title"/>'+
					'</div>'+
				'</form>')
				.appendTo('body')
				.submit();
			}
		}, $conveneData);
		
		
		//handle a blank convene
		if ("$tiki_p_edit" == 'y') {
			$('#conveneBlank$i').each(function() {
				var table = $('<table>' +
					'<tr>' +
						'<td>' +
							'User: <input type="text" style="width: 100px;" id="conveneNewUser$i" />' +
						'</td>' +
						'<td>' +
							'Date/Time: <input style="width: 100px;" id="conveneNewDatetime$i" />' +
						'</td>' +
						'<td style="vertical-align: middle;">' +
							'<input type="button" id="conveneNewUserAndDate$i" value="' + tr("Add User & Date") + '" />' +
						'</td>' +
					'</tr>' +
				'</table>').appendTo(this);
				
				$('#conveneNewUser$i').autocomplete({
					source: $existingUsers
				});
				
				$('#conveneNewDatetime$i').datetimepicker();
				
				$('#conveneNewUserAndDate$i').click(function() {
					convene$i.fromBlank($('#conveneNewUser$i').val(), $('#conveneNewDatetime$i').val());
				});
			});
		} else {
			$('#conveneBlank$i').each(function() {
				$('<div />').text(tr("Login to edit Convene")).appendTo(this);
			});
		}
		
		$('.conveneAddDate$i').click(function() {
			var dialogOptions = {
				modal: true,
				title: tr("Add Date"),
				buttons: {}
			};
			
			dialogOptions.buttons[tr("Add")] = function() {
				convene$i.addDate(o.find('input:first').val());
				o.dialog('close');
			}
			
			var o = $('<div><input type="text" style="width: 100%;" /></div>')
				.dialog(dialogOptions);
			
			o.find('input:first')
				.datetimepicker()
				.focus();
			return false;
		});
		
		$('.conveneDeleteDate$i')
			.click(function() {
				convene$i.deleteDate($(this).data("date"));
				return false;
			});
		
		$('.conveneDeleteUser$i')
			.click(function() {
				convene$i.deleteUser($(this).data("user"));
				return false;
			});
		
		$('.conveneUpdateUser$i').toggle(function() {
			$('.conveneUpdateUser$i').not(this).hide();
			$('.conveneDeleteUser$i').hide();
			$('.conveneDeleteDate$i').hide();
			$('.conveneMain$i').hide();
			$(this).parent().parent()
				.addClass('ui-state-highlight')
				.find('td').not(':first')
				.addClass('conveneTd$i')
				.removeClass('ui-state-default')
				.addClass('ui-state-highlight');
			
			$(this).find('img').attr('src', 'img/icons/accept.png');
			var parent = $(this).parent().parent();
			parent.find('.vote').hide();
			parent.find('input').each(function() {
				$('<input type="checkbox" value="1"/>')
					.attr('checked', ($(this).val() == 1 ? true : false))
					.insertAfter(this)
					.click(function() {
						convene$i.updateUsers = true;
					});
			});
		}, function () {
			$('.conveneUpdateUser$i').show();
			$('.conveneDeleteUser$i').show();
			$('.conveneDeleteDate$i').show();
			$(this).parent().parent()
				.removeClass('ui-state-highlight')
				.find('.conveneTd$i')
				.removeClass('ui-state-highlight')
				.addClass('ui-state-default');
			
			$('.conveneMain$i').show();
			$(this).find('img').attr('src', 'img/icons/pencil.png');
			var parent = $(this).parent().parent();
			parent.find('.vote').show();
			parent.find('input:checkbox').each(function(i) {
				parent.find('input.conveneUserVote$i').eq(i).val( $(this).is(':checked') ? 1 : 0);
				
				$(this).remove();
			});
			
			if (convene$i.updateUsers) {
				convene$i.updateUsersVotes();
			}
		});
		
		$('.conveneAddUser$i').click(function() {
			var dialogOptions = {
				title: tr("User Name"),
				modal: true,
				buttons: {}
			};
			
			dialogOptions.buttons[tr("Add")] = function() {
				convene$i.addUser($('#conveneNewUser$i').val());
				o.dialog('close');
			};
			
			var o = $('<div><input type="text" id="conveneNewUser$i" style="width: 100%;" /></div>')
				.dialog(dialogOptions);
			
			$('#conveneNewUser$i').autocomplete({
				source: $existingUsers
			});
			return false;
		});
		
		$('#pluginConvene$i .icon').css('cursor', 'pointer');
JQ
);
	
	if (empty($dataString)) {
		$result = "<div id='conveneBlank$i'></div>";
	}
	
	return
<<<RETURN
~np~
	<div class="ui-widget-content ui-corner-all">
		<div class="ui-widget-header ui-corner-top">
			<h5 style="margin: 5px;">$title</h5>
		</div>
			$result
	</div>
~/np~
RETURN;
}
