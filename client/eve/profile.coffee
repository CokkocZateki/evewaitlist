Template.profile.helpers
  "character": ->
    Characters.findOne {_id: Session.get("profilechar")}
  "banDisabled": ->
    @roles? and "admin" in @roles
  "noRoles": ->
    !(@roles? and @roles.length>0)
  "avatar": (id)->
    "https://image.eveonline.com/Render/#{id}_128.png"
  "shiptype": (id)->
    typeids[id]
  "events": ->
    EventLog.find {charid: parseInt Session.get("profilechar")}
  "allroles": ->
    Roles.find {}
  "hasRole": ->
    char = Characters.findOne {_id: Session.get("profilechar")}
    return false if !char? or !char.roles?
    @_id in char.roles
Template.profile.events
  "click .viewFit": (e)->
    e.preventDefault()
    CCPEVE.showFitting @dna
