Spine = require 'spine'
$ = Spine.$

DECKS = require 'models/decks'
SUITS = require 'models/suits'

STATUS =
  LQ: 'К сожалению, качество сканов этой колоды неудовлетворительно.
    Мы будем благодарны, если вы пришлёте нам более качественную версию на <a href="mailto:editor@mantike.pro">editor@mantike.pro</a>.'

CARD_WIDTH = 245
CARD_HEIGHT = 360
GRID_FACTOR = 12
BG_WIDTH = 30*CARD_WIDTH
BG_HEIGHT = 30*CARD_HEIGHT
ROTATION_ANGLE = 15*Math.PI/180
ROTATION_ANGLE_PRECISE = Math.PI/180
TURN_ANGLE = Math.PI

brightness = (rgb) ->
  Math.sqrt(0.241*rgb[0]*rgb[0] + 0.691*rgb[1]*rgb[1] + 0.068*rgb[2]*rgb[2])

class Tarot extends Spine.Controller
  el: '#tarot'

  events:
    'click .suit':           'select_suit'
    'click .card':           'toggle_card'
    'click #reset-cards':    'reset_cards'
    'click #remove-card':    'remove_card'
    'click #up-card':        'up_card'
    'click #down-card':      'down_card'
    'click #mirror-card':    'flop_card'
    'click #turn-card':      'turn_card'
    'click #cw-card':        'cw_card'
    'click #ccw-card':       'ccw_card'
    'click #transparent-bg': 'transparent_bg'
    'change #bg-color':      'set_bg_color'
    'click #refill-labels':  'refill_labels'
    'click #toggle-grid':    'toggle_grid'
    'click #toggle-label-type': 'toggle_label_type'
    'click #add-label':      'add_label'
    'click #remove-label':   'remove_label'
    'change #stage-scale':   'set_scale'
    'change #label-font-size':   'set_label_font_size'
    'click #get-link':       'get_link'
    'click #html-code':      'html_code'
    'click #bb-code':        'bb_code'
    'click #toggle-snap':    'toggle_snap'
    'click #foretell-1':     'foretell_1'

  elements:
    '.suits':                 '$suits'
    '#v-suits':               '$v_suits'
    '#h-suits':               '$h_suits'
    '#stage-scale':           '$stage_scale'
    '#label-font-size':        '$label_font_size'
    '.cards':                 '$cards'
    '#select-deck':           '$select_deck'
    '#transparent-bg':        '$transparent_bg'
    '#bg-color':              '$bg_color'
    '#label-color':           '$label_color'
    '#toggle-grid':           '$toggle_grid'
    '#toggle-snap':           '$toggle_snap'
    '#link':                  '$link'
    '#open-link':             '$open_link'
    '#get-link':              '$get_link'
    '#html-code':             '$html_code'
    '#bb-code':               '$bb_code'
    '#snippet':               '$snippet'
    '#snippet>textarea':      '$snippet_area'
    '#canvas':                '$canvas'
    '#toggle-label-type>.o1': '$label_number'
    '#toggle-label-type>.o2': '$label_text'
    '#deck-status':           '$deck_status'
    '#is-foretell-with-reversed': '$is_foretell_with_reversed'
    '#is-precise-rotation': '$is_precise_rotation'

  pings: 0
  snap: false
  labels:
    count: 0
    content: []
  label_font_size: 20
  deck: 'RiderWaiteTarot'
  ext: 'jpg'
  suitcase: 'tarot'
  active_card: null
  $decklist: $('#decklist')

  constructor: ->
    super

    @load_help_titles()

    @$select_deck.autocomplete
      source: DECKS
      select: @select_deck

    @bg_color = new jscolor.color @$bg_color[0], {}
    @label_color = new jscolor.color @$label_color[0], {}

    @stage = new Kinetic.Stage
      container: 'canvas'
      width:     2*CARD_WIDTH
      height:    2*CARD_HEIGHT

    @bg = new Kinetic.Rect
      x: -BG_WIDTH
      y: -BG_HEIGHT
      width: BG_WIDTH*2
      height: BG_HEIGHT*2
      fill: '#'+@bg_color.toString()

    @grid = new Kinetic.Group
      visible: false

    for i in [-BG_WIDTH..BG_WIDTH] by CARD_WIDTH/GRID_FACTOR
      @grid.add(
        new Kinetic.Line
          points: [i, -BG_HEIGHT, i, BG_HEIGHT]
          stroke: '#888888'
          strokeWidth: 1
      )
    for i in [-BG_HEIGHT..BG_HEIGHT] by CARD_HEIGHT/GRID_FACTOR
      @grid.add(
        new Kinetic.Line
          points: [-BG_WIDTH, i, BG_WIDTH, i]
          stroke: '#888888'
          strokeWidth: 1
      )
    @bg_layer = new Kinetic.Layer()
    @cards_layer = new Kinetic.Layer()
    @labels_layer = new Kinetic.Layer()

    @bg_layer.add @bg
    @bg_layer.add @grid
    @stage.add @bg_layer
    @stage.add @cards_layer
    @stage.add @labels_layer

    @make_canvas_resizable()

    @reset_cards null, true

    @set_suitcase()
    @show_suit 'major'

    @hide_decklist()
    @load_decklist()

    @routes
      ###
      "decks-json": ->
        @el.hide()
        @$decklist.show()
        @$decklist.text JSON.stringify(DECKS)
      "suits-json": ->
        @el.hide()
        @$decklist.show()
        @$decklist.text JSON.stringify(SUITS)
      ###
      "tour": @tour
      "decks": @show_decklist
      ":deck": @load_deck

    Spine.Route.setup()

  load_deck: (params) ->
    if params.deck in _(DECKS).pluck('value')
      @deck = params.deck
      deck = _(DECKS).chain().where(value: @deck).first().value() # TODO optimize!
      suitcase = deck.suitcase or 'tarot'
      @ext = deck.ext or 'jpg'
      unless suitcase is @suitcase
        @suitcase = suitcase
        @set_suitcase()
      @hide_decklist()
      @show_suit $('.suit.active', @$suits).data 'suit'
      @$deck_status.html(STATUS[deck.status] or deck.status or '')
      $('html,body').animate {scrollTop: 0}, 0

  set_title: ->
    $('title').text "#{@deck} | Tarot Spread Typewriter"

  set_suitcase: ->
    @$suits.empty()
    i = 1
    for name, suit of SUITS[@suitcase]
      $suit = $ '<div />'
      $suit.addClass 'suit'
      if suit.icon
        if suit.icon[0] is '/'
          path = 'http://static.mantike.pro/img'
        else
          path = ['/img/', @suitcase, '/'].join('')
        $suit.css('background-image', "url(#{path}#{suit.icon})")
      else if suit.label
        $suit.html suit.label
      else
        $suit.html(i + '&ndash;' + (i+suit.cards.length-1))

      $suit.data('suit', name)

      if suit.place is 'h'
        @$h_suits.append($suit)
      else
        @$v_suits.append($suit)

      i += suit.cards.length

    # TODO if empty, then activate first in h_suits
    @$v_suits.children().first().addClass 'active'

  load_decklist: ->
    $ol = $ '<ol />'
    template = require 'views/deck-entry'
    for deck in DECKS
       $ol.append template deck
    @$decklist.append $ol

  show_decklist: ->
    @el.hide()
    @$decklist.show()
    $('title').text "Список колод | Tarot Spread Typewriter"

  hide_decklist: ->
    @$decklist.hide()
    @el.show()
    @set_title()

  load_help_titles: ->
    $('#help-tour>li').each (i, e) ->
      $e = $(e)
      $('#'+$e.data('id')).attr 'title', $e.text()

  helpme: ->
    $('div[id^="joyRidePopup"]').remove()
    $(document).joyride
      tipContent: '#help-tour'
      postRideCallback: ->
        $('div[id^="joyRidePopup"]').remove()

  tour: ->
    @hide_decklist()
    @helpme()
    @navigate ''

  make_canvas_resizable: ->
    @$canvas.resizable
      helper: 'ui-resize-helper'
      handles: 'n, e, s, w, se, sw'
      stop: (e, ui) =>
        @$canvas.width(ui.size.width).height(ui.size.height)
        @stage.setSize ui.size.width, ui.size.height
        @stage.setX(@stage.getX()-ui.position.left+ui.originalPosition.left)
        @stage.setY(@stage.getY()-ui.position.top+ui.originalPosition.top)
        @render()

  set_scale: ->
    pp = @$stage_scale.val()
    @$stage_scale.next().text pp+'%'
    @stage.setScale(pp/100.0)
    @render()

  set_label_font_size: ->
    @label_font_size = @$label_font_size.val()

  toggle_label_type: ->
    @$label_number.toggleClass 'active'
    @$label_text.toggleClass 'active'

  add_label: ->
    isNumber = @$label_number.hasClass 'active'
    if isNumber
      @labels.count += 1
      text = @labels.count.toString()
    else
      text = prompt 'Введите текст ярлычка'
    if text?
      fg = if brightness(@label_color.rgb) < 0.5 then 'white' else 'black'
      label = {}
      label.text = new Kinetic.Text
        x: -@stage.getX()
        y: -@stage.getY()
        text: text
        fontSize: @label_font_size
        fontStyle: if isNumber then 'bold' else 'normal'
        padding: 10
        align: 'center'
        lineHeight: 0.8
        fill: fg

      label.rect = new Kinetic.Rect
        x: -@stage.getX()
        y: -@stage.getY()
        width: label.text.getWidth()
        height: label.text.getHeight()
        cornerRadius: 4
        fill: '#'+@label_color.toString()
        stroke: fg
        strokeWidth: 1
        opacity: 0.8

      label.group = new Kinetic.Group
        draggable: true

      label.group.add label.rect
      label.group.add label.text

      @labels.content.push
        image: label
        isNumber: isNumber
      @labels_layer.add label.group
      @render()

  remove_label: ->
    label = @labels.content.pop()
    @labels.count -= 1 if label.isNumber and @labels.count > 0
    label.image.group.remove()
    @render()

  set_bg_color: ->
    @$transparent_bg.removeClass 'active'
    @bg.setFill '#'+@bg_color.toString()
    @bg.show()
    @render()

  refill_labels: ->
    fg = if brightness(@label_color.rgb) < 0.5 then 'white' else 'black'
    for label in @labels.content
      label.image.text.setAttrs
        fill: fg
      label.image.rect.setAttrs
        fill: '#'+@label_color.toString()
        stroke: fg
    @render()

  select_deck: (e, ui) =>
    deck = ui.item.value
    @navigate deck

  reset_cards: (e, noConfirm) ->
    if noConfirm or confirm 'Действительно убрать все карты?'
      @cards = {}
      @cards_layer.removeChildren()
      @active_card = null
      @render()

  render: ->
    @bg_layer.draw()
    @cards_layer.draw()
    @labels_layer.draw()
    @$link.val ''
    @$open_link.hide()
    @$html_code.hide()
    @$bb_code.hide()
    @$snippet.hide()
    @$get_link.show()

  card_id: (card) ->
    "#{@deck}/#{card}"

  delete_card: (card) ->
    if card
      card = @card_id card
    else
      card = @active_card
    @cards[card].image.remove()
    delete @cards[card]
    @active_card = null
    @render()

  add_card: (card, angle = 0) ->
    _card = @card_id card
    card = _card
    card += new Date().getTime()
    imageObj = new Image()
    imageObj.onload = =>
      hw = imageObj.width/2
      hh = imageObj.height/2
      @cards[card] =
        angle: angle
        flip: 1
        flop: 1
        deck: @deck
        id: _card
        image: new Kinetic.Image
          draggable: true
          image: imageObj
          x: hw+Math.random()*CARD_WIDTH
          y: hh+Math.random()*CARD_HEIGHT
          rotation: angle
          offset:
            x: hw
            y: hh
      img = @cards[card].image
      img.on 'dragend', =>
        if @snap
          img.setX Math.round(GRID_FACTOR*(img.getX()-hw)/CARD_WIDTH)*CARD_WIDTH/GRID_FACTOR+hw
          img.setY Math.round(GRID_FACTOR*(img.getY()-hh)/CARD_HEIGHT)*CARD_HEIGHT/GRID_FACTOR+hh
        @render()
      img.on 'dragstart', =>
        @select_card card
      img.on 'click', =>
        @select_card card
      @cards_layer.add @cards[card].image
      @select_card card
    imageObj.src = "/decks/#{_card}.#{@ext}"

  select_card: (card) ->
    @remove_stroke @active_card if @active_card
    @add_stroke card
    @cards[card].image.setZIndex(_(@cards).reduce(
      (z, c) -> Math.max z, c.image.getZIndex()
      0) + 1) unless @active_card is card
    @active_card = card
    @render()

  add_stroke: (card) ->
    @cards[card].image.setAttrs
      stroke: '#88f'
      strokeWidth: 5

  remove_stroke: (card) ->
    @cards[card].image.setAttrs
      stroke: ''
      strokeWidth: 0

  toggle_card: (e) ->
    @add_card $(e.target).attr 'data-card'

  select_suit: (e) ->
    $('.suit', @$suits).removeClass 'active'
    suit = $(e.target).closest('.suit')
    suit.addClass 'active'
    @show_suit(suit.data 'suit')

  show_suit: (suit) ->
    mini = require('views/mini')
    @req.abort() if @req?
    @$cards.empty()
    for card in SUITS[@suitcase][suit].cards
      @$cards.append(
        mini
          deck: @deck
          card: card
          ext: @ext
      )
    @req = $.get "/decks/#{@deck}/back.#{@ext}", =>
      @$cards.append(
        mini
          deck: @deck
          card: 'back'
          ext: @ext
      )

  get_link: ->
    if @active_card
      @remove_stroke @active_card
      @active_card = null
      @render()
    @$link.val 'подождите немного...'
    @stage.toDataURL callback: (dataUrl) =>
      $.ajax
        url: '/api/mix'
        type: 'POST'
        data: dataUrl
        processData: false
        contentType: 'text/plain'
        dataType: 'text'
        success: (id) =>
          url = "http://editor.mantike.pro/spreads/#{id}"
          @$link.val(url)
          @$link.select() unless /(iPad|iPhone|iPod)/g.test navigator.userAgent
          @$open_link.attr 'href', url
          @$get_link.hide()
          @$open_link.show()
          @$html_code.show()
          @$bb_code.show()
        error: (request, status, error) ->
          alert 'Произошла ошибка! Попробуйте ещё раз чуть позже.'

  html_code: ->
    @show_code 'html'

  bb_code: ->
    @show_code 'bb'

  show_code: (kind) ->
    template = require "views/#{kind}-code"
    @$snippet.show()
    @$snippet_area.text(template src: @$link.val())
    @$snippet_area.select() unless /(iPad|iPhone|iPod)/g.test navigator.userAgent

  up_card: ->
    if @active_card
      i = @cards[@active_card].image
      i.setZIndex(i.getZIndex()+1)
      @render()

  down_card: ->
    if @active_card
      i = @cards[@active_card].image
      i.setZIndex(i.getZIndex()-1)
      @render()

  transparent_bg: ->
    @$transparent_bg.toggleClass 'active'
    if @$transparent_bg.hasClass 'active' then @bg.hide() else @bg.show()
    @render()

  toggle_grid: ->
    if @$toggle_grid.hasClass 'on'
      @$toggle_grid.removeClass('on').text 'показать'
      @grid.hide()
    else
      @$toggle_grid.addClass('on').text 'скрыть'
      @grid.show()
    @render()

  toggle_snap: ->
    @$toggle_snap.toggleClass 'active'
    @snap = @$toggle_snap.hasClass 'active'

  remove_card: ->
    @delete_card() if @active_card

  rotate_card: (card, angle) ->
    card = @cards[card]
    card.angle += angle
    card.image.transitionTo
      rotation: card.angle
      duration: 0.2
      easing: 'linear'
      callback: => @render()

  turn_card: ->
    @rotate_card @active_card, TURN_ANGLE if @active_card

  rot_card: (dir) ->
    precise = @$is_precise_rotation.is ':checked'
    @rotate_card @active_card, dir*(if precise then ROTATION_ANGLE_PRECISE else ROTATION_ANGLE) if @active_card

  cw_card: ->
    @rot_card 1

  ccw_card:->
    @rot_card -1

  foretell_1: ->
    $.get ("/api/foretell?n=1&suitcase=#{@suitcase}&reversed=#{if @$is_foretell_with_reversed.attr 'checked' then 1 else 0}"), (cards) =>
      card = cards[0]
      id = @card_id card.card
      if _(@cards).find((c) -> c.id is id)
        @pings++
        if @pings<78
          @foretell_1()
        else
          alert 'Ой-йой! Кнопка сломается, если столько нажимать на неё!'
      else
        @pings = 0
        @add_card card.card, card.angle

  mirror_card: (flop, flip) ->
    return unless @active_card
    card = @cards[@active_card]
    card.flop *= flop
    card.flip *= flip
    card.image.transitionTo
      scale:
        x: card.flop
        y: card.flip
      duration: 0.5
      easing: 'linear'
      callback: => @render()

  flip_card: ->
    @mirror_card 1, -1

  flop_card: ->
    @mirror_card -1, 1


module.exports = Tarot
