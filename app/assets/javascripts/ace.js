$(document).ready(function(){
var editor = ace.edit("editor");
editor.setTheme("ace/theme/twilight");

$("#textarea_ID").hide();
$("#form_ID").submit(function(){
$("#textarea_ID").val(editor.getSession().getValue());
});
});