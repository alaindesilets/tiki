%lex

PLUGIN_ID   					[A-Z]+
INLINE_PLUGIN_ID				[a-z]+
SMILE							[a-z]+

%s 
	bold box
	center
	colortext
	italic
	header6
	header5
	header4
	header3
	header2
	header1
	link
	strikethrough
	table
	titlebar
	underscore
	wikilink

%%

"{"{INLINE_PLUGIN_ID}.*?"}"
	%{
		var pluginName = yytext.match(/^\{([a-z]+)/)[1];
		var pluginParams =  yytext.match(/[ ].*?[}]|[/}]/);
		yytext = {
			name: pluginName,
			params: pluginParams,
			body: ''
		};
		return 'INLINE_PLUGIN';
	%}

"{"{PLUGIN_ID}"(".*?")}"
	%{
		var pluginName = yytext.match(/^\{([A-Z]+)/)[1];
		var pluginParams =  yytext.match(/[(].*?[)]/);
		
		if (!yy.pluginStack) yy.pluginStack = [];
		yy.pluginStack.push({
			name: pluginName,
			params: pluginParams
		});
		
		if (yy.pluginStack.length == 1) {
			return 'PLUGIN_START';
		} else {
			return 'CONTENT';
		}
	%}

"{"{PLUGIN_ID}"}"
	%{
		if (yy.pluginStack) {
			if (
				yy.pluginStack.length &&
				yytext.match(yy.pluginStack[yy.pluginStack.length - 1].name)
			) {
				var readyPlugin = yy.pluginStack.pop();
				if (yy.pluginStack.length == 0) {
					yytext = readyPlugin;
					return 'PLUGIN_END';
				} else {
					return 'CONTENT';
				}
			}
		}
		return 'CONTENT';
	%}

("~np~")
	%{
		if (!yy.npStack) yy.npStack = [];
		yy.npStack.push(true);
		yy.npOn = true;
		
		return 'NP_START';
	%}

("~/np~")
	%{
		if (!yy.npStack) yy.npStack = [];
		yy.npStack.pop();
		if (!yy.npStack.length) yy.npOn = false;
		
		return 'NP_END';
	%}

"---" 
	%{
		yytext = "<hr />";
		return 'HORIZONTAL_BAR';
	%}

"(:"{SMILE}":)"
	%{
		var smile = yytext.substring(2, yytext.length - 2);
		yytext = "<img src='img/smiles/icon_" + smile + ".gif' alt='" + smile + "' />";
		return 'SMILE';
	%}

"[[".*?
	%{
		var smile = yytext.substring(2, yytext.length - 2);
		yytext = "<img src='img/smiles/icon_" + smile + ".gif' alt='" + smile + "' />";
		return 'CONTENT';
	%}

<bold>[_][_]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'BOLD_END'); %}
[_][_]						%{ this.begin('bold');			return (this.yy.npOn ? 'CONTENT' : 'BOLD_START'); %}
<box>[\^]					%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'BOX_END'); %}
[\^]						%{ this.begin('box');			return (this.yy.npOn ? 'CONTENT' : 'BOX_START'); %}
<center>[:][:]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'CENTER_END'); %}
[:][:]						%{ this.begin('center');		return (this.yy.npOn ? 'CONTENT' : 'CENTER_START'); %}
<colortext>[\~][\~]			%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'COLORTEXT_END'); %}
[\~][\~][#]					%{ this.begin('colortext');		return (this.yy.npOn ? 'CONTENT' : 'COLORTEXT_START'); %}
<header6>[\n]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'HEADER6_END'); %}
[\n]("!!!!!!")				%{ this.begin('header6');		return (this.yy.npOn ? 'CONTENT' : 'HEADER6_START'); %}
<header5>[\n]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'HEADER5_END'); %}
[\n]("!!!!!")				%{ this.begin('header5');		return (this.yy.npOn ? 'CONTENT' : 'HEADER5_START'); %}
<header4>[\n]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'HEADER4_END'); %}
[\n]("!!!!")				%{ this.begin('header4');		return (this.yy.npOn ? 'CONTENT' : 'HEADER4_START'); %}
<header3>[\n]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'HEADER3_END'); %}
[\n]("!!!")					%{ this.begin('header3');		return (this.yy.npOn ? 'CONTENT' : 'HEADER3_START'); %}
<header2>[\n]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'HEADER2_END'); %}
[\n]("!!")					%{ this.begin('header2');		return (this.yy.npOn ? 'CONTENT' : 'HEADER2_START'); %}
<header1>[\n]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'HEADER1_END'); %}
[\n]("!")					%{ this.begin('header1');		return (this.yy.npOn ? 'CONTENT' : 'HEADER1_START'); %}
<italic>['][']				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'ITALIC_END'); %}
['][']						%{ this.begin('italic');		return (this.yy.npOn ? 'CONTENT' : 'ITALIC_START'); %}
<link>("]")					%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'LINK_END'); %}
("[")						%{ this.begin('link');			return (this.yy.npOn ? 'CONTENT' : 'LINK_START'); %}
<strikethrough>[-][-]		%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'STRIKETHROUGH_END'); %}
[-][-]						%{ this.begin('strikethrough');	return (this.yy.npOn ? 'CONTENT' : 'STRIKETHROUGH_START'); %}
<table>[|][|]				%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'TABLE_END'); %}
[|][|]						%{ this.begin('table');			return (this.yy.npOn ? 'CONTENT' : 'TABLE_START'); %}
<titlebar>[=][-]			%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'TITLEBAR_END'); %}
[-][=]						%{ this.begin('titlebar');		return (this.yy.npOn ? 'CONTENT' : 'TITLEBAR_START'); %}
<underscore>[=][=][=]		%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'UNDERSCORE_END'); %}
[=][=][=]					%{ this.begin('underscore');	return (this.yy.npOn ? 'CONTENT' : 'UNDERSCORE_START'); %}
<wikilink>[)][)]			%{ this.popState();				return (this.yy.npOn ? 'CONTENT' : 'WIKILINK_END'); %}
[(][(]						%{ this.begin('wikilink');		return (this.yy.npOn ? 'CONTENT' : 'WIKILINK_START'); %}

"<"(.|\n)*?">"								return 'HTML'
(.)											return 'CONTENT'
(\n)
	%{
		yytext = yytext.replace(/\n/g, '<br />');
		return 'CONTENT';
	%}

<<EOF>>                         			return 'EOF'

/lex

%%

wiki
 : wiki_contents EOF
	{return $1;}
 ;

wiki_contents
 :
 | contents
	{$$ = $1;}
 | wiki_contents plugin
	{$$ = ($1 ? $1 : '') + ($2 ? $2 : '');}
 | wiki_contents plugin contents
	{$$ = ($1 ? $1 : '') + ($2 ? $2 : '') + ($3 ? $3 : '');}
 ;

plugin
 : INLINE_PLUGIN
	{$$ = plugin($1);}
 | PLUGIN_START wiki_contents PLUGIN_END
	{
		$3.body = $2;
		$$ = plugin($3);
	}
 ;

contents
 : content
	{$$ = $1;}
 | contents content
	{$$ = $1 + $2;}
 ;

content
 : CONTENT
	{$$ = $1;}
 | HTML
	{$$ = isHtmlPermissible($1);}
 | LINK
	{$$ = $1;}
 | HORIZONTAL_BAR
	{$$ = $1;}
 | SMILE
	{$$ = $1;}
 | BOLD_START wiki_contents BOLD_END
	{$$ = "<b>" + $2 + "</b>";}
 | BOX_START wiki_contents BOX_END
	{$$ = "<div style='border: solid 1px black;'>" + $2 + "</div>";}
 | CENTER_START wiki_contents CENTER_END
	{$$ = "<center>" + $2 + "</center>";}
 | COLORTEXT_START wiki_contents COLORTEXT_END
	{
		var text = $2.split(':');
		$$ = "<span style='color: #" + text[0] + ";'>" +text[1] + "</span>";
	}
 | ITALIC_START wiki_contents ITALIC_END
	{$$ = "<i>" + $2 + "</i>";}
 | HEADER6_START wiki_contents HEADER6_END
	{$$ = "<h6>" + $2 + "</h6>";}
 | HEADER5_START wiki_contents HEADER5_END
	{$$ = "<h5>" + $2 + "</h5>";}
 | HEADER4_START wiki_contents HEADER4_END
	{$$ = "<h4>" + $2 + "</h4>";}
 | HEADER3_START wiki_contents HEADER3_END
	{$$ = "<h3>" + $2 + "</h3>";}
 | HEADER2_START wiki_contents HEADER2_END
	{$$ = "<h2>" + $2 + "</h2>";}
 | HEADER1_START wiki_contents HEADER1_END
	{$$ = "<h1>" + $2 + "</h1>";}
 | LINK_START wiki_contents LINK_END
	{
		var link = $2.split('|');
		var href = $2;
		var text = $2;
		
		if ($2.match(/\|/)) {
			href = link[0];
			text = link[1];
		}
		
		$$ = "<a href='" + href + "'>" + text  + "</a>";
	}
 | NP_START wiki_contents NP_END
	{$$ = $2;}
 | STRIKETHROUGH_START wiki_contents STRIKETHROUGH_END
	{$$ = "<span style='text-decoration: line-through;'>" + $2 + "</span>";}
 | TABLE_START wiki_contents TABLE_END
	{
		var tableContents = '';
		var rows = $2.split('<br />');
		for(var i = 0; i < rows.length; i++) {
			var cells = rows[i].split('|');
			tableContents += "<tr>";
			for(var j = 0; j < cells.length; j++) {
				tableContents += "<td>" + cells[j] + "</td>";
			}
			tableContents += "</tr>";
		}
		$$ = "<table style='width: 100%;'>" + tableContents + "</table>";
	}
 | TITLEBAR_START wiki_contents TITLEBAR_END
	{$$ = "<div class='titlebar'>" + $2 + "</div>";}
 | UNDERSCORE_START wiki_contents UNDERSCORE_END
	{$$ = "<u>" + $2 + "</u>";}
 | WIKILINK_START wiki_contents WIKILINK_END
	{
		var wikilink = $2.split('|');
		var href = $2;
		var text = $2;
		
		if ($2.match(/\|/)) {
			href = wikilink[0];
			text = wikilink[1];
		}
		
		$$ = "<a href='" + href + "'>" + text  + "</a>";
	}
 ;