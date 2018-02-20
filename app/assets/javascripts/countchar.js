//= require jquery

var fn=function(){
  var textarea = $("textarea[name='micropost[content]']");
  if(textarea.val().length > 140) {
    textarea.css('background','#FF0000');
    $("span[name='140']").text(140 - textarea.val().length);
    return false;
  }
  else {
    textarea.css('background','#FFFFFF');
    $("span[name='140']").text(140 - textarea.val().length);
    return true;
  }
}

setInterval( fn, 500 );   