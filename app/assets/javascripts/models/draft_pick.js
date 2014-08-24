GridironGuru.DraftPick = DS.Model.extend({
  round:   DS.attr('string'),
  team:    DS.belongsTo('team', { async: true }),
  player:  DS.belongsTo('player', { async: true })
});
