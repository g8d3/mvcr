cs = 
  collections:
    name:
      type: String
  views:
    name:
      type: String
  templates:
    name:
      type: String
  routes:
    name:
      type: String

@tables = {}    

schema = (col, sch) ->
  col.attachSchema(new SimpleSchema(sch))

table = (name, opts = {}) ->
  new Tabular.Table _(opts).extend(
    name: name, collection: this[name],
    columns: []
  )

for own c, sch of cs
  this[c] = new Meteor.Collection(c)
  schema this[c], sch 
  tables[c] = table c

