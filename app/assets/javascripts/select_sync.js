/*
 * Syncs two selects based in the input of the first and use a rails
 * route for it.
 *
 * Made for RailsRumble competition ;-)
 * TODO: refactor!
 */

$(document).ready(function(){
  $('[data-select-sync]').change(function(ev){
    var syncdElement = $(this).attr('data-select-sync');
    var alpha2 = $(this).val();
    console.log(alpha2);
    console.log(syncdElement);

    $.get('/services/states/'+alpha2, function(res){
      $('[data-'+syncdElement+']').html(res).trigger('liszt:updated');
    });
  });
});
