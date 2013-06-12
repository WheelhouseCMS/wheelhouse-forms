$.fn.options = function() {
  function addField(li) {
    var next = li.clone().find('div').remove().end().insertAfter(li);
    next.find('input').val('').width('auto').autoGrowInput().focus();
  }
  
  return $(this).each(function() {
    $(this).delegate("li input", "blur", function() {
      var li = $(this).parent();
      var value = $(this).val();
      
      if (value == "" && !li.is(":last-child")) {
        li.remove();
      } else if (value != "" && li.is(":last-child")) {
        addField(li);
      }
    });
    
    $(this).delegate("li:last-child input", "keydown", function(e) {
      // Tab key pressed
      if (e.keyCode == '9' && $(this).val() != '') {
        e.preventDefault();
        
        var li = $(this).parent();
        addField(li);
      }
    });
    
    $("input:text", this).autoGrowInput();
  });
};
