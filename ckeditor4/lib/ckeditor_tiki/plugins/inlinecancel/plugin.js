// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

CKEDITOR.plugins.add('inlinecancel',
{
	init: function (editor) {

		var asplugin = this; // for closure references later
		this.editor = editor;

		editor.ui.addButton('inlinecancel', {
			label: 'Cancel',
			command: 'inlinecancel',
			icon: this.path + 'images/cross.png'

		});

		command = editor.addCommand('inlinecancel', new CKEDITOR.command(editor,
		{
			modes: { wysiwyg: 1, source: 1 },
			// button clicked or timer
			exec: function (elem, editor, data) {
				// Close the editable area
				$("#page-data > *").attr("contenteditable", false);

				//kill all inline editors
				var instances = CKEDITOR.instances;
				forEach(ed in instances) {
					if (ed != null) {
						ed.destroy();
					}
				}
			}
		}));

	}
});
