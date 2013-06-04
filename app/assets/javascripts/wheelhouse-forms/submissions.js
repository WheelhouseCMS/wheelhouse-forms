$(function() {

function clickHandler(spam) {
  return function() {
    var url = $(this).attr('href');
    var row = $(this).closest('tr');

    $.ajax({
      type: 'PUT',
      url: url,
      data: { spam: spam },    
      dataType: 'json',
      success: function() {
        Wheelhouse.Flash.message("Submission updated.");
        row.remove();
      }
    });
    
    Wheelhouse.Flash.loading("Marking submission as spam.");

    return false;
  }
}

$('#submissions').on('click', 'a.mark-spam', clickHandler(true));
$('#submissions').on('click', 'a.not-spam', clickHandler(false));

});
