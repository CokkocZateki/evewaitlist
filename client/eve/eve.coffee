Meteor.startup ->
  Tracker.autorun ->
    page = Session.get("igbpage")
    if !page? || (page.canView? && !page.canView())
      Session.set "igbpage", "waitlist"
    else
      page = Pages[page]
      if !page?
        return
      if page.subscriptions?
        for sub in page.subscriptions
          Meteor.subscribe sub
      page.onView() if page.onView?
Template.eveClient.helpers
  "character": ->
    # Meteor.user()
    Session.get "me"
  "avatar": (character)->
    return "" if !character?
    "https://image.eveonline.com/Character/#{character._id}_64.jpg"
  "activeTemplate": ->
    page = Pages[Session.get "igbpage"]
    if !page?
      return ""
    page.template
  "activePage": ->
    Pages[Session.get "igbpage"]
  "canView": (pagen)->
    page = Pages[pagen]
    unless page?
      return ->
    page.canView? and page.canView()
  "isBanned": ->
    char = Session.get "me"
    unless char?
      return false
    return char.banned

Template.eveClient.events
  "click .destoToStaging": (e)->
    e.preventDefault()
    Meteor.call('setWaypoint', true, false, Settings.findOne({_id: "incursion"}).sysid)
  "click .logoutBtn": () ->
    Meteor.logout()
  "click .gotoLink": (e)->
    e.preventDefault()
    Session.set "igbpage", e.currentTarget.attributes["page-target"].value
  "click .da": (e)->
    e.preventDefault()
  "click .sign-in-button": ->
    Meteor.loginWithEveonline {scope: 'characterLocationRead fleetRead fleetWrite publicData remoteClientUI'}
