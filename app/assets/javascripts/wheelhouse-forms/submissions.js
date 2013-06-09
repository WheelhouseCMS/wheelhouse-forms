$(function() {

function updateSubmission(url, spam, callback) {
  $.ajax({
    type: 'PUT',
    url: url,
    data: { spam: spam },    
    dataType: 'json',
    success: function() {
      Wheelhouse.Flash.message("Submission updated.");
      callback();
    }
  });
  
  Wheelhouse.Flash.loading("Marking submission as spam.");
}

function clickHandler(spam) {
  return function() {
    var url = $(this).attr('href');
    var row = $(this).closest('tr');
    
    updateSubmission(url, spam, function() {
      row.remove();
    });
    
    return false;
  }
}

$('#submissions').on('click', 'a.mark-spam', clickHandler(true));
$('#submissions').on('click', 'a.not-spam', clickHandler(false));

$('button.mark-spam').click(function() {
  var url = $(this).closest('form').attr('action');
  
  updateSubmission(url, true, function() {
    $('button.mark-spam').hide();
    $('button.not-spam').show();
  });
  
  return false;
});

$('button.not-spam').click(function() {
  var url = $(this).closest('form').attr('action');
  
  updateSubmission(url, false, function() {
    $('button.not-spam').hide();
    $('button.mark-spam').show();
  });
  
  return false;
});

});
