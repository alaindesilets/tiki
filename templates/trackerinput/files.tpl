<ol class="tracker-item-files" id="{$field.ins_id|escape}-files">
	{foreach from=$field.files item=info}
		<li>
			{$info.name|escape}
			<label>
				<input type="checkbox" name="{$field.ins_id|escape}_remove" value="{$info.fileId|escape}"/>
				{icon _id=cross}
			</label>
		</li>
	{/foreach}
</ol>
<input id="{$field.ins_id|escape}-input" type="hidden" name="{$field.ins_id|escape}" value="{$field.value|escape}"/>
{if $field.canUpload}
	<fieldset id="{$field.ins_id|escape}-drop" class="file-drop">
		<legend>{tr}Upload files{/tr}</legend>
		<p>{tr}Drop files from your desktop here or browse for them{/tr}</p>
		<input type="file" name="{$field.ins_id|escape}[]" accept="{$field.filter|escape}" multiple="multiple"/>
	</fieldset>
{/if}
<fieldset>
	<legend>Existing files</legend>
	<input type="text" id="{$field.ins_id|escape}-search" placeholder="{tr}Search query{/tr}"/>
	<ol class="results tracker-item-files">
	</ol>
</fieldset>
{jq}
(function () {
var $drop = $('#{{$field.ins_id|escape}}-drop');
var $files = $('#{{$field.ins_id|escape}}-files');
var $field = $('#{{$field.ins_id|escape}}-input');
var $search = $('#{{$field.ins_id|escape}}-search');

var handleFiles = function (files) {
	$.each(files, function (k, file) {
		var reader = new FileReader();
		var li = $('<li/>').appendTo($files);

		li.text(file.name + ' (...)');

		$(window).queue('process-upload', function () {
			reader.onloadend = function (e) {
				var xhr, provider;

				xhr = jQuery.ajaxSettings.xhr();
				if (xhr.upload) {
					xhr.upload.addEventListener('progress', function (e) {
						li.text(file.name + ' (' + Math.round(e.position / e.total * 100) + '%)');
					}, false);
				}
				provider = function () {
					return xhr;
				};

				var data = e.target.result;
				data = data.substr(data.indexOf('base64') + 7);

				$.ajax({
					type: 'POST',
					url: 'tiki-ajax_services.php?controller=file&action=upload',
					xhr: provider,
					dataType: 'json',
					success: function (data) {
						var fileId = data.fileId;
						li.text(data.name);

						$field.input_csv('add', ',', fileId);

						li.append($('<label>{{icon _id=cross}}</label>'));
						li.find('img').click(function () {
							$field.input_csv('delete', ',', fileId);
							$(this).closest('li').remove();
						});
					},
					error: function () {
						li.remove();
					},
					complete: function () {
						$(window).dequeue('process-upload');
					},
					data: {
						name: file.name,
						size: file.size,
						type: file.type,
						data: data,
						galleryId: {{$field.galleryId|escape}}
					}
				});
			};
			reader.readAsDataURL(file);
		});
	});
	$(window).dequeue('process-upload');
};

$files.find('input').hide();
$files.find('img').click(function () {
	var fileId = $(this).parent().find('input').val();
	$field.input_csv('delete', ',', fileId);
	$(this).closest('li').remove();
});

$drop.bind('dragenter', function (e) {
	e.preventDefault();
	e.stopPropagation();
	$drop.addClass('highlight');
	return false;
});
$drop.bind('dragexit', function (e) {
	e.preventDefault();
	e.stopPropagation();
	$drop.removeClass('highlight');
	return false;
});
$drop.bind('dragover', function (e) {
	e.preventDefault();
	e.stopPropagation();
	return false;
});
$drop.bind('drop', function (e) {
	e.preventDefault();
	e.stopPropagation();
	$drop.removeClass('highlight');

	var dataTransfer = e.dataTransfer;
	if (! dataTransfer) {
		dataTransfer = e.originalEvent.dataTransfer;
	}

	if (dataTransfer && dataTransfer.files) {
		handleFiles(dataTransfer.files);
	}
	return false;
});

$drop.find('input').change(function () {
	if (this.files) {
		handleFiles(this.files);
		$(this).val('');
	}
});

$search.keypress(function (e) {
	if (e.which === 13) {
		var results = $(this).parent().find('.results');
		results.empty();

		$.getJSON('tiki-searchindex.php', {
			"filter~type": "file",
			"filter~content": $(this).val(),
			"filter~filetype": "{{$field.filter|escape}}",
			"filter~gallery_id": "{{$field.galleryId|escape}}",
		}, function (data) {
			$.each(data, function () {
				var item = $('<li/>').append(this.link), icon = $('<label>{{icon _id=add}}</label>'), data = this;
				item.append(icon);
				icon.click(function () {
					var li = $('<li/>');
					li.text(item.text());
					li.append($('<label>{{icon _id=cross}}</label>'));
					li.find('img').click(function () {
						$field.input_csv('delete', ',', data.object_id);
						$(this).closest('li').remove();
					});

					$files.append(li);
					$field.input_csv('add', ',', data.object_id);
				});

				results.append(item);
			});
		});
		return false;
	}
});
}());
{/jq}
