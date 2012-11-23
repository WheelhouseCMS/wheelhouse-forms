$.fn.options = function() {
  return $(this).each(function() {
    $(this).delegate("li input", "blur", function() {
      var li = $(this).parent();
      
      if ($(this).val() == "" && !li.is(":last-child")) {
        li.remove();
      }
    });
    
    $(this).delegate("li:last-child input", "keydown", function(e) {
      // Tab key pressed
      if (e.keyCode == '9' && $(this).val() != '') {
        e.preventDefault();
        
        var li = $(this).parent();
        var next = li.clone().find('div').remove().end().insertAfter(li);
        next.find('input').val('').width('auto').autoGrowInput().focus();
      }
    });
    
    $("input:text", this).autoGrowInput();
  });
};
