GridironGuru.Team = DS.Model.extend({
  name:        DS.attr('string'),
  owner:       DS.belongsTo('user', { async: true }),
  league:      DS.belongsTo('league', { async: true }),
  draftPicks:  DS.hasMany('draftPick', { async: true }),
  draftSlot:   DS.attr('number'),
  color:       DS.attr('string')
});
