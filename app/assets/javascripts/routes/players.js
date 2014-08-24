GridironGuru.PlayersRoute = Ember.Route.extend({
  renderTemplate: function() {
    $('.container-fluid.no-padding').remove();

    this.render('players');
  },

  model: function() {
    return this.store.findAll('player')
  }
});
