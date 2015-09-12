cs = ['collections', 'views', 'templates', 'routes']
for c in cs
  this[c] = new Meteor.Collection(c)
