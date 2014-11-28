@Waitlists = new Meteor.Collection "waitlist"


StatsSchema = new SimpleSchema
  logi:
    type: Number
  dps:
    type: Number
  other:
    type: Number

WaitSchema = new SimpleSchema
  commander:
    type: String
  stats:
    type: StatsSchema
  finished:
    type: Boolean
    index: true

Waitlists.attachSchema WaitSchema
