GridironGuru.PlayersController = Ember.ArrayController.extend({
  actions: {
    draftPlayer: function(player) {
      var draftPicks = this.store.findAll('draftPick')
      console.log(player.get('fullName'));
      console.log(draftPicks[0])
    }
  }
});
