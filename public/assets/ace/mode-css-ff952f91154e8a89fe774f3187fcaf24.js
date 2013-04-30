define("ace/mode/css",["require","exports","module","ace/lib/oop","ace/mode/text","ace/tokenizer","ace/mode/css_highlight_rules","ace/mode/matching_brace_outdent","ace/worker/worker_client","ace/mode/behaviour/css","ace/mode/folding/cstyle"],function(e,t){var n=e("../lib/oop"),r=e("./text").Mode,o=e("../tokenizer").Tokenizer,i=e("./css_highlight_rules").CssHighlightRules,a=e("./matching_brace_outdent").MatchingBraceOutdent,s=e("../worker/worker_client").WorkerClient,l=e("./behaviour/css").CssBehaviour,c=e("./folding/cstyle").FoldMode,u=function(){this.$tokenizer=new o((new i).getRules(),"i"),this.$outdent=new a,this.$behaviour=new l,this.foldingRules=new c};n.inherits(u,r),function(){this.foldingRules="cStyle",this.getNextLineIndent=function(e,t,n){var r=this.$getIndent(t),o=this.$tokenizer.getLineTokens(t,e).tokens;if(o.length&&"comment"==o[o.length-1].type)return r;var i=t.match(/^.*\{\s*$/);return i&&(r+=n),r},this.checkOutdent=function(e,t,n){return this.$outdent.checkOutdent(t,n)},this.autoOutdent=function(e,t,n){this.$outdent.autoOutdent(t,n)},this.createWorker=function(e){var t=new s(["ace"],"ace/mode/css_worker","Worker");return t.attachToDocument(e.getDocument()),t.on("csslint",function(t){e.setAnnotations(t.data)}),t.on("terminate",function(){e.clearAnnotations()}),t}}.call(u.prototype),t.Mode=u}),define("ace/mode/css_highlight_rules",["require","exports","module","ace/lib/oop","ace/lib/lang","ace/mode/text_highlight_rules"],function(e,t){var n=e("../lib/oop"),r=e("../lib/lang"),o=e("./text_highlight_rules").TextHighlightRules,i=t.supportType="animation-fill-mode|alignment-adjust|alignment-baseline|animation-delay|animation-direction|animation-duration|animation-iteration-count|animation-name|animation-play-state|animation-timing-function|animation|appearance|azimuth|backface-visibility|background-attachment|background-break|background-clip|background-color|background-image|background-origin|background-position|background-repeat|background-size|background|baseline-shift|binding|bleed|bookmark-label|bookmark-level|bookmark-state|bookmark-target|border-bottom|border-bottom-color|border-bottom-left-radius|border-bottom-right-radius|border-bottom-style|border-bottom-width|border-collapse|border-color|border-image|border-image-outset|border-image-repeat|border-image-slice|border-image-source|border-image-width|border-left|border-left-color|border-left-style|border-left-width|border-radius|border-right|border-right-color|border-right-style|border-right-width|border-spacing|border-style|border-top|border-top-color|border-top-left-radius|border-top-right-radius|border-top-style|border-top-width|border-width|border|bottom|box-align|box-decoration-break|box-direction|box-flex-group|box-flex|box-lines|box-ordinal-group|box-orient|box-pack|box-shadow|box-sizing|break-after|break-before|break-inside|caption-side|clear|clip|color-profile|color|column-count|column-fill|column-gap|column-rule|column-rule-color|column-rule-style|column-rule-width|column-span|column-width|columns|content|counter-increment|counter-reset|crop|cue-after|cue-before|cue|cursor|direction|display|dominant-baseline|drop-initial-after-adjust|drop-initial-after-align|drop-initial-before-adjust|drop-initial-before-align|drop-initial-size|drop-initial-value|elevation|empty-cells|fit|fit-position|float-offset|float|font-family|font-size|font-size-adjust|font-stretch|font-style|font-variant|font-weight|font|grid-columns|grid-rows|hanging-punctuation|height|hyphenate-after|hyphenate-before|hyphenate-character|hyphenate-lines|hyphenate-resource|hyphens|icon|image-orientation|image-rendering|image-resolution|inline-box-align|left|letter-spacing|line-height|line-stacking-ruby|line-stacking-shift|line-stacking-strategy|line-stacking|list-style-image|list-style-position|list-style-type|list-style|margin-bottom|margin-left|margin-right|margin-top|margin|mark-after|mark-before|mark|marks|marquee-direction|marquee-play-count|marquee-speed|marquee-style|max-height|max-width|min-height|min-width|move-to|nav-down|nav-index|nav-left|nav-right|nav-up|opacity|orphans|outline-color|outline-offset|outline-style|outline-width|outline|overflow-style|overflow-x|overflow-y|overflow|padding-bottom|padding-left|padding-right|padding-top|padding|page-break-after|page-break-before|page-break-inside|page-policy|page|pause-after|pause-before|pause|perspective-origin|perspective|phonemes|pitch-range|pitch|play-during|position|presentation-level|punctuation-trim|quotes|rendering-intent|resize|rest-after|rest-before|rest|richness|right|rotation-point|rotation|ruby-align|ruby-overhang|ruby-position|ruby-span|size|speak-header|speak-numeral|speak-punctuation|speak|speech-rate|stress|string-set|table-layout|target-name|target-new|target-position|target|text-align-last|text-align|text-decoration|text-emphasis|text-height|text-indent|text-justify|text-outline|text-shadow|text-transform|text-wrap|top|transform-origin|transform-style|transform|transition-delay|transition-duration|transition-property|transition-timing-function|transition|unicode-bidi|vertical-align|visibility|voice-balance|voice-duration|voice-family|voice-pitch-range|voice-pitch|voice-rate|voice-stress|voice-volume|volume|white-space-collapse|white-space|widows|width|word-break|word-spacing|word-wrap|z-index",a=t.supportFunction="rgb|rgba|url|attr|counter|counters",s=t.supportConstant="absolute|after-edge|after|all-scroll|all|alphabetic|always|antialiased|armenian|auto|avoid-column|avoid-page|avoid|balance|baseline|before-edge|before|below|bidi-override|block-line-height|block|bold|bolder|border-box|both|bottom|box|break-all|break-word|capitalize|caps-height|caption|center|central|char|circle|cjk-ideographic|clone|close-quote|col-resize|collapse|column|consider-shifts|contain|content-box|cover|crosshair|cubic-bezier|dashed|decimal-leading-zero|decimal|default|disabled|disc|disregard-shifts|distribute-all-lines|distribute-letter|distribute-space|distribute|dotted|double|e-resize|ease-in|ease-in-out|ease-out|ease|ellipsis|end|exclude-ruby|fill|fixed|georgian|glyphs|grid-height|groove|hand|hanging|hebrew|help|hidden|hiragana-iroha|hiragana|horizontal|icon|ideograph-alpha|ideograph-numeric|ideograph-parenthesis|ideograph-space|ideographic|inactive|include-ruby|inherit|initial|inline-block|inline-box|inline-line-height|inline-table|inline|inset|inside|inter-ideograph|inter-word|invert|italic|justify|katakana-iroha|katakana|keep-all|last|left|lighter|line-edge|line-through|line|linear|list-item|local|loose|lower-alpha|lower-greek|lower-latin|lower-roman|lowercase|lr-tb|ltr|mathematical|max-height|max-size|medium|menu|message-box|middle|move|n-resize|ne-resize|newspaper|no-change|no-close-quote|no-drop|no-open-quote|no-repeat|none|normal|not-allowed|nowrap|nw-resize|oblique|open-quote|outset|outside|overline|padding-box|page|pointer|pre-line|pre-wrap|pre|preserve-3d|progress|relative|repeat-x|repeat-y|repeat|replaced|reset-size|ridge|right|round|row-resize|rtl|s-resize|scroll|se-resize|separate|slice|small-caps|small-caption|solid|space|square|start|static|status-bar|step-end|step-start|steps|stretch|strict|sub|super|sw-resize|table-caption|table-cell|table-column-group|table-column|table-footer-group|table-header-group|table-row-group|table-row|table|tb-rl|text-after-edge|text-before-edge|text-bottom|text-size|text-top|text|thick|thin|transparent|underline|upper-alpha|upper-latin|upper-roman|uppercase|use-script|vertical-ideographic|vertical-text|visible|w-resize|wait|whitespace|z-index|zero",l=t.supportConstantColor="aqua|black|blue|fuchsia|gray|green|lime|maroon|navy|olive|orange|purple|red|silver|teal|white|yellow",c=t.supportConstantFonts="arial|century|comic|courier|garamond|georgia|helvetica|impact|lucida|symbol|system|tahoma|times|trebuchet|utopia|verdana|webdings|sans-serif|serif|monospace",u=t.numRe="\\-?(?:(?:[0-9]+)|(?:[0-9]*\\.[0-9]+))",d=t.pseudoElements="(\\:+)\\b(after|before|first-letter|first-line|moz-selection|selection)\\b",g=t.pseudoClasses="(:)\\b(active|checked|disabled|empty|enabled|first-child|first-of-type|focus|hover|indeterminate|invalid|last-child|last-of-type|link|not|nth-child|nth-last-child|nth-last-of-type|nth-of-type|only-child|only-of-type|required|root|target|valid|visited)\\b",p=function(){var e=this.createKeywordMapper({"support.function":a,"support.constant":s,"support.type":i,"support.constant.color":l,"support.constant.fonts":c},"text",!0),t=[{token:"comment",regex:"\\/\\*",next:"ruleset_comment"},{token:"string",regex:'["](?:(?:\\\\.)|(?:[^"\\\\]))*?["]'},{token:"string",regex:"['](?:(?:\\\\.)|(?:[^'\\\\]))*?[']"},{token:["constant.numeric","keyword"],regex:"("+u+")(ch|cm|deg|em|ex|fr|gd|grad|Hz|in|kHz|mm|ms|pc|pt|px|rad|rem|s|turn|vh|vm|vw|%)"},{token:"constant.numeric",regex:u},{token:"constant.numeric",regex:"#[a-f0-9]{6}"},{token:"constant.numeric",regex:"#[a-f0-9]{3}"},{token:["punctuation","entity.other.attribute-name.pseudo-element.css"],regex:d},{token:["punctuation","entity.other.attribute-name.pseudo-class.css"],regex:g},{token:e,regex:"\\-?[a-zA-Z_][a-zA-Z0-9_\\-]*"}],n=r.copyArray(t);n.unshift({token:"paren.rparen",regex:"\\}",next:"start"});var o=r.copyArray(t);o.unshift({token:"paren.rparen",regex:"\\}",next:"media"});var p=[{token:"comment",regex:".+"}],m=r.copyArray(p);m.unshift({token:"comment",regex:".*?\\*\\/",next:"start"});var h=r.copyArray(p);h.unshift({token:"comment",regex:".*?\\*\\/",next:"media"});var b=r.copyArray(p);b.unshift({token:"comment",regex:".*?\\*\\/",next:"ruleset"}),this.$rules={start:[{token:"comment",regex:"\\/\\*",next:"comment"},{token:"paren.lparen",regex:"\\{",next:"ruleset"},{token:"string",regex:"@.*?{",next:"media"},{token:"keyword",regex:"#[a-z0-9-_]+"},{token:"variable",regex:"\\.[a-z0-9-_]+"},{token:"string",regex:":[a-z0-9-_]+"},{token:"constant",regex:"[a-z0-9-_]+"}],media:[{token:"comment",regex:"\\/\\*",next:"media_comment"},{token:"paren.lparen",regex:"\\{",next:"media_ruleset"},{token:"string",regex:"\\}",next:"start"},{token:"keyword",regex:"#[a-z0-9-_]+"},{token:"variable",regex:"\\.[a-z0-9-_]+"},{token:"string",regex:":[a-z0-9-_]+"},{token:"constant",regex:"[a-z0-9-_]+"}],comment:m,ruleset:n,ruleset_comment:b,media_ruleset:o,media_comment:h}};n.inherits(p,o),t.CssHighlightRules=p}),define("ace/mode/matching_brace_outdent",["require","exports","module","ace/range"],function(e,t){var n=e("../range").Range,r=function(){};(function(){this.checkOutdent=function(e,t){return/^\s+$/.test(e)?/^\s*\}/.test(t):!1},this.autoOutdent=function(e,t){var r=e.getLine(t),o=r.match(/^(\s*\})/);if(!o)return 0;var i=o[1].length,a=e.findMatchingBracket({row:t,column:i});if(!a||a.row==t)return 0;var s=this.$getIndent(e.getLine(a.row));e.replace(new n(t,0,t,i-1),s)},this.$getIndent=function(e){var t=e.match(/^(\s+)/);return t?t[1]:""}}).call(r.prototype),t.MatchingBraceOutdent=r}),define("ace/mode/behaviour/css",["require","exports","module","ace/lib/oop","ace/mode/behaviour","ace/mode/behaviour/cstyle","ace/token_iterator"],function(e,t){var n=e("../../lib/oop"),r=(e("../behaviour").Behaviour,e("./cstyle").CstyleBehaviour),o=e("../../token_iterator").TokenIterator,i=function(){this.inherit(r),this.add("colon","insertion",function(e,t,n,r,i){if(":"===i){var a=n.getCursorPosition(),s=new o(r,a.row,a.column),l=s.getCurrentToken();if(l&&l.value.match(/\s+/)&&(l=s.stepBackward()),l&&"support.type"===l.type){var c=r.doc.getLine(a.row),u=c.substring(a.column,a.column+1);if(":"===u)return{text:"",selection:[1,1]};if(!c.substring(a.column).match(/^\s*;/))return{text:":;",selection:[1,1]}}}}),this.add("colon","deletion",function(e,t,n,r,o){var i=r.doc.getTextRange(o);if(!o.isMultiLine()&&":"===i){var a=r.doc.getLine(o.start.row),s=a.substring(o.end.column,o.end.column+1);if(";"===s)return o.end.column++,o}}),this.add("semicolon","insertion",function(e,t,n,r,o){if(";"===o){var i=n.getCursorPosition(),a=r.doc.getLine(i.row),s=a.substring(i.column,i.column+1);if(";"===s)return{text:"",selection:[1,1]}}})};n.inherits(i,r),t.CssBehaviour=i}),define("ace/mode/behaviour/cstyle",["require","exports","module","ace/lib/oop","ace/mode/behaviour","ace/token_iterator","ace/lib/lang"],function(e,t){var n=e("../../lib/oop"),r=e("../behaviour").Behaviour,o=e("../../token_iterator").TokenIterator,i=e("../../lib/lang"),a=["text","paren.rparen","punctuation.operator"],s=["text","paren.rparen","punctuation.operator","comment"],l=0,c=-1,u="",d=0,g=-1,p="",m="",h=function(){h.isSaneInsertion=function(e,t){var n=e.getCursorPosition(),r=new o(t,n.row,n.column);if(!this.$matchTokenType(r.getCurrentToken()||"text",a)){var i=new o(t,n.row,n.column+1);if(!this.$matchTokenType(i.getCurrentToken()||"text",a))return!1}return r.stepForward(),r.getCurrentTokenRow()!==n.row||this.$matchTokenType(r.getCurrentToken()||"text",s)},h.$matchTokenType=function(e,t){return t.indexOf(e.type||e)>-1},h.recordAutoInsert=function(e,t,n){var r=e.getCursorPosition(),o=t.doc.getLine(r.row);this.isAutoInsertedClosing(r,o,u[0])||(l=0),c=r.row,u=n+o.substr(r.column),l++},h.recordMaybeInsert=function(e,t,n){var r=e.getCursorPosition(),o=t.doc.getLine(r.row);this.isMaybeInsertedClosing(r,o)||(d=0),g=r.row,p=o.substr(0,r.column)+n,m=o.substr(r.column),d++},h.isAutoInsertedClosing=function(e,t,n){return l>0&&e.row===c&&n===u[0]&&t.substr(e.column)===u},h.isMaybeInsertedClosing=function(e,t){return d>0&&e.row===g&&t.substr(e.column)===m&&t.substr(0,e.column)==p},h.popAutoInsertedClosing=function(){u=u.substr(1),l--},h.clearMaybeInsertedClosing=function(){d=0,g=-1},this.add("braces","insertion",function(e,t,n,r,o){var a=n.getCursorPosition(),s=r.doc.getLine(a.row);if("{"==o){var l=n.getSelectionRange(),c=r.doc.getTextRange(l);if(""!==c&&"{"!==c&&n.getWrapBehavioursEnabled())return{text:"{"+c+"}",selection:!1};if(h.isSaneInsertion(n,r))return/[\]\}\)]/.test(s[a.column])?(h.recordAutoInsert(n,r,"}"),{text:"{}",selection:[1,1]}):(h.recordMaybeInsert(n,r,"{"),{text:"{",selection:[1,1]})}else if("}"==o){var u=s.substring(a.column,a.column+1);if("}"==u){var g=r.$findOpeningBracket("}",{column:a.column+1,row:a.row});if(null!==g&&h.isAutoInsertedClosing(a,s,o))return h.popAutoInsertedClosing(),{text:"",selection:[1,1]}}}else if("\n"==o||"\r\n"==o){var p="";h.isMaybeInsertedClosing(a,s)&&(p=i.stringRepeat("}",d),h.clearMaybeInsertedClosing());var u=s.substring(a.column,a.column+1);if("}"==u||""!==p){var m=r.findMatchingBracket({row:a.row,column:a.column},"}");if(!m)return null;var b=this.getNextLineIndent(e,s.substring(0,a.column),r.getTabString()),f=this.$getIndent(s);return{text:"\n"+b+"\n"+f+p,selection:[1,b.length,1,b.length]}}}}),this.add("braces","deletion",function(e,t,n,r,o){var i=r.doc.getTextRange(o);if(!o.isMultiLine()&&"{"==i){var a=r.doc.getLine(o.start.row),s=a.substring(o.end.column,o.end.column+1);if("}"==s)return o.end.column++,o;d--}}),this.add("parens","insertion",function(e,t,n,r,o){if("("==o){var i=n.getSelectionRange(),a=r.doc.getTextRange(i);if(""!==a&&n.getWrapBehavioursEnabled())return{text:"("+a+")",selection:!1};if(h.isSaneInsertion(n,r))return h.recordAutoInsert(n,r,")"),{text:"()",selection:[1,1]}}else if(")"==o){var s=n.getCursorPosition(),l=r.doc.getLine(s.row),c=l.substring(s.column,s.column+1);if(")"==c){var u=r.$findOpeningBracket(")",{column:s.column+1,row:s.row});if(null!==u&&h.isAutoInsertedClosing(s,l,o))return h.popAutoInsertedClosing(),{text:"",selection:[1,1]}}}}),this.add("parens","deletion",function(e,t,n,r,o){var i=r.doc.getTextRange(o);if(!o.isMultiLine()&&"("==i){var a=r.doc.getLine(o.start.row),s=a.substring(o.start.column+1,o.start.column+2);if(")"==s)return o.end.column++,o}}),this.add("brackets","insertion",function(e,t,n,r,o){if("["==o){var i=n.getSelectionRange(),a=r.doc.getTextRange(i);if(""!==a&&n.getWrapBehavioursEnabled())return{text:"["+a+"]",selection:!1};if(h.isSaneInsertion(n,r))return h.recordAutoInsert(n,r,"]"),{text:"[]",selection:[1,1]}}else if("]"==o){var s=n.getCursorPosition(),l=r.doc.getLine(s.row),c=l.substring(s.column,s.column+1);if("]"==c){var u=r.$findOpeningBracket("]",{column:s.column+1,row:s.row});if(null!==u&&h.isAutoInsertedClosing(s,l,o))return h.popAutoInsertedClosing(),{text:"",selection:[1,1]}}}}),this.add("brackets","deletion",function(e,t,n,r,o){var i=r.doc.getTextRange(o);if(!o.isMultiLine()&&"["==i){var a=r.doc.getLine(o.start.row),s=a.substring(o.start.column+1,o.start.column+2);if("]"==s)return o.end.column++,o}}),this.add("string_dquotes","insertion",function(e,t,n,r,o){if('"'==o||"'"==o){var i=o,a=n.getSelectionRange(),s=r.doc.getTextRange(a);if(""!==s&&"'"!==s&&'"'!=s&&n.getWrapBehavioursEnabled())return{text:i+s+i,selection:!1};var l=n.getCursorPosition(),c=r.doc.getLine(l.row),u=c.substring(l.column-1,l.column);if("\\"==u)return null;for(var d,g=r.getTokens(a.start.row),p=0,m=-1,b=0;g.length>b&&(d=g[b],"string"==d.type?m=-1:0>m&&(m=d.value.indexOf(i)),!(d.value.length+p>a.start.column));b++)p+=g[b].value.length;if(!d||0>m&&"comment"!==d.type&&("string"!==d.type||a.start.column!==d.value.length+p-1&&d.value.lastIndexOf(i)===d.value.length-1)){if(!h.isSaneInsertion(n,r))return;return{text:i+i,selection:[1,1]}}if(d&&"string"===d.type){var f=c.substring(l.column,l.column+1);if(f==i)return{text:"",selection:[1,1]}}}}),this.add("string_dquotes","deletion",function(e,t,n,r,o){var i=r.doc.getTextRange(o);if(!o.isMultiLine()&&('"'==i||"'"==i)){var a=r.doc.getLine(o.start.row),s=a.substring(o.start.column+1,o.start.column+2);if(s==i)return o.end.column++,o}})};n.inherits(h,r),t.CstyleBehaviour=h}),define("ace/mode/folding/cstyle",["require","exports","module","ace/lib/oop","ace/range","ace/mode/folding/fold_mode"],function(e,t){var n=e("../../lib/oop"),r=(e("../../range").Range,e("./fold_mode").FoldMode),o=t.FoldMode=function(){};n.inherits(o,r),function(){this.foldingStartMarker=/(\{|\[)[^\}\]]*$|^\s*(\/\*)/,this.foldingStopMarker=/^[^\[\{]*(\}|\])|^[\s\*]*(\*\/)/,this.getFoldWidgetRange=function(e,t,n){var r=e.getLine(n),o=r.match(this.foldingStartMarker);if(o){var i=o.index;return o[1]?this.openingBracketBlock(e,o[1],n,i):e.getCommentFoldRange(n,i+o[0].length,1)}if("markbeginend"===t){var o=r.match(this.foldingStopMarker);if(o){var i=o.index+o[0].length;return o[1]?this.closingBracketBlock(e,o[1],n,i):e.getCommentFoldRange(n,i,-1)}}}}.call(o.prototype)});