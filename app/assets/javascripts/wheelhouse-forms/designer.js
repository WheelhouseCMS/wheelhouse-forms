//= require ./jquery.autogrow
//= require ./jquery.options

$(function() {

var root = $('#fields');
var target;

var nextId = 0;
function uniqueId() {
  ++nextId;
  return "content-" + nextId;
}

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
    $.scrollTo(field, { duration: 300 });
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
$('.tools li.submit-button a').click(insertFieldHandler("#submit-button-template"));
$('.tools li.radio-buttons a').click(insertFieldHandler("#radio-buttons-template", true));
$('.tools li.states-dropdown a').click(insertFieldHandler("#states-dropdown-template"));
$('.tools li.countries-dropdown a').click(insertFieldHandler("#countries-dropdown-template"));
$('.tools li.content-field a').click(insertFieldHandler("#content-field-template", false, function(field) {
  var textarea = $('textarea.editor', field);
  textarea.attr('id', uniqueId());
  textarea.editor();
}));
$('.tools li.custom-field a').click(insertFieldHandler("#custom-field-template"));

$('.tools li.field-set a').click(function() {
  var nextIndex = parseInt($('#fields > :last-child').attr('data-index')) + 1 || 0;
  var fieldset = $('#field-set-template').tmpl({ index: nextIndex, prefix: prefixFor(root, nextIndex) });
  
  fieldset.appendTo(root);
  $.scrollTo(fieldset, { duration: 300 });
  
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

function replacePrefix(input, prefix) {
  var name = $(input).attr('name').replace(/.*(\[[^\[\]]+\](\[\])?)$/, "$1");
  $(input).attr('name', prefix + name);
}

function updateFieldPrefixes(root) {
  var children = $('> div', root);
  
  children.each(function(index) {
    var field = $(this);
    field.attr('data-index', index);
    
    var prefix = prefixFor(root, index);
    
    $('input, textarea, select', field).each(function() {
      replacePrefix(this, prefix);
    });
    
    var subfields = $('> .fields', field);
    subfields.attr('data-prefix', prefix + "[fields]");
    updateFieldPrefixes(subfields)
  });
}

function refreshFields() {
  updateFieldPrefixes(root);
}

var BaseSortableOptions = {
  items:       '> div',
  handle:      '> .drag',
  placeholder: 'drag-placeholder',
  tolerance:   'intersect',
  connectWith: '.fields',
  forcePlaceholderSize: true,
  start: function(e, ui) {
    $('textarea.editor', ui.item).removeEditor();
  },
  stop: function(e, ui) {
    $('textarea.editor', ui.item).editor();
    refreshFields();
  }
};
var SortableOptions = $.extend({}, BaseSortableOptions, { connectWith: '#fields, .fields' });

$('#fields').sortable(BaseSortableOptions); // Top-level
$('.fields').sortable(SortableOptions);     // Fieldsets

});
