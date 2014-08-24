GridironGuru.League = DS.Model.extend({
  name:           DS.attr('string'),
  tagline:        DS.attr('string'),
  manager:        DS.belongsTo('user', { async: true }),
  numberOfTeams:  DS.attr('number'),
  positions:      DS.attr('object'),
  teams:          DS.hasMany('team', { async: true })
});
