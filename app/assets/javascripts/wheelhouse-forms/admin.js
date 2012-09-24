$(function() {

$.fn.autoGrowInput = function(o) {
  o = $.extend({
      maxWidth: 1000,
      minWidth: 0,
      comfortZone: 10
    }, o);

  this.filter('input:text').each(function() {
    var minWidth = o.minWidth || $(this).width(),
      val = '',
      input = $(this),
      testSubject = $('<div />').css({
        position: 'absolute',
        top: -9999,
        left: -9999,
        width: 'auto',
        fontSize: input.css('fontSize'),
        fontFamily: input.css('fontFamily'),
        fontWeight: input.css('fontWeight'),
        letterSpacing: input.css('letterSpacing'),
        whiteSpace: 'nowrap'
      }),
      check = function() {
        if (val === (val = input.val())) {return;}
        
        // Enter new content into testSubject
        var escaped = val.replace(/&/g, '&amp;').replace(/\s/g,'&nbsp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        testSubject.html(escaped);
        
        // Calculate new width + whether to change
        var testerWidth = testSubject.width(),
          newWidth = (testerWidth + o.comfortZone) >= minWidth ? testerWidth + o.comfortZone : minWidth,
          currentWidth = input.width(),
          isValidWidthChange = (newWidth < currentWidth && newWidth >= minWidth)
                                 || (newWidth > minWidth && newWidth < o.maxWidth);
        
        // Animate width
        if (isValidWidthChange) {
          input.width(newWidth);
        }
      };

    testSubject.insertAfter(input);

    $(this).bind('keyup keydown blur update', check);
    check();
  });

  return this;

};

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

var root = $('#fields');
var target;

function resetTarget() {
  target = $('.fields:last', root);
  if (target.length < 1) target = root;
}
resetTarget();

function prefixFor(container, index) {
  return container.attr('data-prefix') + "[" + index + "]";
}

function insertFieldHandler(template, optionize, callback) {
  return function() {
    var nextIndex = parseInt($('> :last-child', target).attr('data-index')) + 1 || 0;
    var field = $(template).tmpl({ index: nextIndex, prefix: prefixFor(target, nextIndex) });

    field.appendTo(target);
    $('input[placeholder]', field).placeholder().click();
    
    if (optionize) { $('ul.options', field).options(); }
    if ($.isFunction(callback)) { callback(field); }
    
    return false;
  }
}

$('.tools li.text-field a').click(insertFieldHandler("#text-field-template"));
$('.tools li.text-area a').click(insertFieldHandler("#text-area-template"));
$('.tools li.select-field a').click(insertFieldHandler("#select-field-template", true));
$('.tools li.checkbox a').click(insertFieldHandler("#checkbox-template"));
$('.tools li.checkboxes a').click(insertFieldHandler("#checkboxes-template", true));
$('.tools li.radio-buttons a').click(insertFieldHandler("#radio-buttons-template", true));
$('.tools li.states-dropdown a').click(insertFieldHandler("#states-dropdown-template"));
$('.tools li.countries-dropdown a').click(insertFieldHandler("#countries-dropdown-template"));
$('.tools li.content-field a').click(insertFieldHandler("#content-field-template", false, function(field) {
  $('textarea.editor', field).editor();
}));
$('.tools li.custom-field a').click(insertFieldHandler("#custom-field-template"));

$('.tools li.field-set a').click(function() {
  var nextIndex = parseInt($('.field-set:last', root).attr('data-index')) + 1 || 0;
  var fieldset = $('#field-set-template').tmpl({ index: nextIndex, prefix: prefixFor(root, nextIndex) });
  fieldset.appendTo(root);
  
  target = $('.fields', fieldset);
  target.sortable(SortableOptions);
  
  return false;
});

$('ul.options', root).options();

root.delegate('a.delete', 'click', function() {
  if (confirm("Are you sure you want to remove this field?")) {
    var field = $(this).parent();
    var isCurrentTarget = field.find('.fields').get(0) == target.get(0);
    
    field.remove();
    if (isCurrentTarget) { resetTarget(); }
    
    refreshFields();
  }
  
  return false;
});


function refreshFields() {
  function replacePrefix(input, prefix) {
    var name = $(input).attr('name').replace(/.*(\[[^\[\]]+\](\[\])?)$/, "$1");
    $(input).attr('name', prefix + name);
  }
  
  $('#fields > div').each(function(index) {
    var prefix = $('#fields').attr("data-prefix") + "[" + index + "]";
    $(this).attr('data-index', index);
    
    $('input:not(.fields input), textarea:not(.fields textarea)', this).each(function() { replacePrefix(this, prefix); });
    $('> .fields', this).attr('data-prefix', prefix + "[fields]");
  });
  
  $('.fields').each(function() {
    var fieldsPrefix = $(this).attr('data-prefix');
    
    $('> div', this).each(function(index) {
      var prefix = fieldsPrefix + "[" + index + "]";
      $(this).attr('data-index', index);
      
      $('input, textarea', this).each(function() { replacePrefix(this, prefix); });
    });
  });
}

var BaseSortableOptions = {
  items:       '> div',
  handle:      '> .drag',
  placeholder: 'drag-placeholder',
  tolerance:   'intersect',
  forcePlaceholderSize: true,
  stop:        refreshFields,
  connectWith: '.fields'
};
var SortableOptions = $.extend({}, BaseSortableOptions, { connectWith: '#fields, .fields' });

$('#fields').sortable(BaseSortableOptions); // Top-level
$('.fields').sortable(SortableOptions);     // Fieldsets

});
