GridironGuru.User = DS.Model.extend({
  username:        DS.attr('string'),
  firstName:       DS.attr('string'),
  lastName:        DS.attr('string'),
  email:           DS.attr('string'),
  teams:           DS.hasMany('team', { async: true }),
  managedLeagues:  DS.hasMany('league', { async: true })
});
