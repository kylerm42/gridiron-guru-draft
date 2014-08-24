GridironGuru.BoardRoute = Ember.Route.extend({
  renderTemplate: function() {
    $('.container-fluid.no-padding').remove();

    this.render('board');
  },

  model: function() {
    return this.store.findAll('draftPick')
  }
});
