cs = 
  collections:
    name:
      type: String
    createdAt:
      type: Date
    updatedAt:
      type: Date
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
  cols = _(cs[name]).map (sch,c) -> data: c, title: c
  new Tabular.Table _(opts).extend(
    name: name, collection: this[name],
    columns: cols
  )

for own c, sch of cs
  this[c] = new Meteor.Collection(c)
  this[c].attachBehaviour('timestampable')
  schema this[c], sch 
  # this["#{c}_table"] = table c
  tables[c] = table c

if Meteor.isClient
  Template.registerHelper('tables', tables)
  # Template.registerHelper('t', (c) -> tables[c])
  Template.registerHelper('cs', _(cs).map((sch, c)->
    c: c, t: tables[c], f: "#{c}_form", co: this[c]
  ))

