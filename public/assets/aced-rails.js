(function(){var e;e=jQuery,e.fn.extend({acedInit:function(t){return null==t&&(t={}),this.each(function(){var a;return a=ace.edit(this),null!=t.theme&&a.setTheme("ace/theme/"+t.theme),null!=t.mode&&a.getSession().setMode("ace/mode/"+t.mode),e(this).data("ace-editor",a)})},acedInitTA:function(t){return this.each(function(){var a,n,i,c,r;return c=e(this),i=c.height(),r=c.width(),a=e('<div style="height: '+i+"px; width: "+r+'px;"></div>'),c.hide(),c.before(a),c.data("ace-div",a),a.acedInit(t),n=a.aced(),n.setValue(c.text()),n.clearSelection(),n.getSession().on("change",function(){return c.text(n.getValue())})})},aced:function(){return e(this).data("ace-editor")},acedSession:function(){return e(this).data("ace-editor").getSession()}}),e(document).ready(function(){return e("div[ace-editor]").each(function(){var t,a,n;return t=e(this),n=t.attr("ace-theme"),a=t.attr("ace-mode"),t.acedInit({theme:n,mode:a})}),e("textarea[ace-editor]").each(function(){var t,a,n;return a=e(this),n=a.attr("ace-theme"),t=a.attr("ace-mode"),a.acedInitTA({theme:n,mode:t})})})}).call(this);