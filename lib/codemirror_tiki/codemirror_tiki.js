//$Id$

jQuery.fn.extend({
	flexibleCodeMirror: function(settings) {
		settings = jQuery.extend({
			parse: ["tiki"],
			changeText: "Change Highlighter",
			languages: ["csharp","css","html","java","javascript","lua","ometa","sparql","php","plsql","python","r","scheme","sql","tiki","xml","xquery"],
			buttonText: {
				update: "Update",
				cancel: "Cancel"
			},
			parent: jQuery(this)
		},settings);
		
		jQuery(this).each(function() { 
			var textarea = jQuery(this);
			
			if (textarea.attr('codeMirrorRelationshipFullscreen')) return false;
			
			//ensure that codemirror is running and CKEditor isn't, if so run
			if (window.CKEDITOR) return false;
			if (!textarea.length) return false;
			if (!window.CodeMirror) return false;
			
			var parserfiles = [];
			var stylesheet = [];
			
			var parse = textarea.attr('parse');
			if (parse) settings.parse = (parse + '').split(',');
			
			parse = settings.parse;
			
			function addParser(type, isContrib, hasTokenizer, hasColors) {
				var src = '';
				if (isContrib) {
					src = '../contrib/' + type + '/js/';
				}
				
				if (hasTokenizer) {
					parserfiles.push(src + 'tokenize' + type + '.js');
				}
				
				parserfiles.push(src + 'parse' + type + '.js');
				
				if (hasColors)
					addStylesheet(type, isContrib);
			}
			
			function addStylesheet(type, isContrib) {
				var src = 'lib/codemirror/';
				if (isContrib) {
					src += 'contrib/' + type + '/css/';
				} else {
					src += 'css/';
				}
				
				stylesheet.push(src + type + 'colors.css');
			}
			
			jQuery(parse).each(function(i) {
				switch (parse[i]) {
					case "csharp":
						addParser(parse[i], true, true, true);
						break;
					case "css": 		
						addParser(parse[i], false, false, true);
						break;
					case "html":
						addParser(parse[i] + 'mixed');
						addParser('xml', false, false, true);
						break;
					case "java":
						addParser(parse[i], true, true, true);
						break;
					case "javascript":
						addParser(parse[i], false, true);
						addStylesheet('js');
						break;
					case "lua":
						addParser(parse[i], true, false, true);
						break;
					case "ometa": 
						addParser(parse[i], true, true, true);
						break;
					case "sparql": 
						addParser(parse[i], false, false, true);
						break;
					case "php":
						addParser(parse[i], true, true, true);
						break;
					case "plsql":
						addParser(parse[i], true, false, true);
						break;
					case "python":
						addParser(parse[i], false, false, true); 
						break;
					case "r": 			
						parserfiles.push('../../codemirror_tiki/js/parsersplus.js'); 
						stylesheet.push('lib/codemirror_tiki/css/rspluscolors.css'); 
						break;
					case "scheme":
						addParser(parse[i], true, true, true);
						break;
					case "sql": 		
						addParser(parse[i], true, false, true); 
						break;
					case "tiki":
						parserfiles.push('../../codemirror_tiki/js/parsetikisyntax.js');
						stylesheet.push('lib/codemirror_tiki/css/tikiwikisyntaxcolors.css');
						break;
					case "xml":
						addParser(parse[i], false, false, true);
						break;
					case "xquery": 
						addParser(parse[i], true, true);
						stylesheet.push('lib/codemirror/contrib/xquery/css/xqcolors.css');
						break;
				}
			});

			var editor = CodeMirror.fromTextArea(textarea[0], {
				height: 'dynamic',
				width: '100%',
				path: 'lib/codemirror/js/',
				parserfile: parserfiles,
				stylesheet: stylesheet,
				onChange: function() {
					//Setup codemirror to send the text back to the textarea
					textarea.val(editor.getCode()).change();
				}
			});
			
			addCodeMirrorEditorRelation(editor, textarea);
			
			var changeButton = jQuery('<div class="button">' + 
					'<a>' + settings.changeText + '</a>' +
				'</div>')
				.insertAfter(textarea.next())
				.click(function() {
					var options = '';
					jQuery(settings.languages).each(function() {
						var lang = this + '';
						options += '<input type="checkbox" value="' + lang + '" ' + (parse.indexOf(lang) > -1 ? 'checked="true"' : '') + '/>' + lang + '<br />';
					});
					var msg = jQuery('<div />')
						.html(options)
						.dialog({
							title: settings.changeText,
							modal: true,
							buttons: {
								"Update": function() {
									var newParse = [];
									msg.find('input').each(function() {
										var o = jQuery(this);
										if (o.is(':checked')) {
											newParse.push(o.val());	
										}
									});
									
									changeButton.remove();
									editor.toTextArea();
									
									textarea.flexibleCodeMirror(jQuery.extend(settings,{
										parse: newParse
									}));
									
									msg.dialog("destroy");
								},
								"Cancel": function() {
									msg.dialog("destroy");
								}
							}
						});
				});
		});
	}
});
