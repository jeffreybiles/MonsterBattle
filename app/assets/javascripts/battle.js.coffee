json =
  hero:
    id: 4
    name: "Thesis"
    max_attack: 10
    current_attack: 9
    max_hp: 20
    current_hp: 20
    max_defense: 5
    current_defense: 4
    techniques: [0, 1]
    image_url: "http://avatarswizard.com/uploads/av/2009-03/thumbs/100x100_1236347910_lego-pokemon-1.jpg"
  enemy:
    id: 1
    name: "AntiThesis"
    max_attack: 9
    current_attack: 9
    max_hp: 18
    current_hp: 18
    max_defense: 4
    current_defense: 4
    techniques: [0]
    image_url: "http://avatarmaker.eu/free-avatars/avatars/games_225/super_mario_259/super_mario_panic_avatar_100x100_25831.gif"

all_techniques =
  0:
    id: 0
    name: 'push'
    power: 2
    animation: 'shake'
  1:
    id: 1
    name: 'shove'
    power: 4
    animation: 'shake'

initializeFromJSON = (self, attributes, json) ->
  for attribute in attributes
    eval("self.#{attribute} = json.#{attribute}")

selector = 0

class Monster
  constructor: (json, all_techniques) ->
    attributes = [ 'id', 'name', 'max_attack', 'current_attack', 'max_defense', 'current_defense', 'max_hp', 'current_hp', 'image_url']
    initializeFromJSON(this, attributes, json)
    @techniques = json.techniques.map((index) -> new Technique(all_techniques[index]))

  update_hp: (change = 0) ->
    @current_hp += change
    $("##{@type} .hp").text("#{@current_hp}/#{@max_hp}")

  update_image: (url = @image_url) ->
    @image_url = url
    $("##{@type} .portrait img").attr('src', @image_url)

class Hero extends Monster
  constructor: (json, all_techniques) ->
    json = json.hero if json.hero
    @type = 'hero'
    super json, all_techniques

  showTechniques: () ->
    for technique in @techniques
      html = "<li class='#{technique.name} technique' data-power='#{technique.power}' data-name='#{technique.name}'><a href='#' id='#{technique.name}'>#{technique.name}</a></li>"
      $('#techniques').append(html)
      hero = this
      $("#techniques .#{technique.name}").click(-> hero.attack(technique)    )

  attack: (technique, target = enemy) ->
    if state == 'playerTurn'
      technique.execute(target)
      $('#techniques').slideUp()
      state = 'enemyTurn'



class Enemy extends Monster
  constructor: (json, all_techniques) ->
    json = json.enemy if json.enemy
    @type = 'enemy'
    super json, all_techniques

  attack: (technique = null, target = hero) ->
    unless technique
      technique = @techniques[rand(@techniques.length) - 1]
    technique.execute(target)

class Technique
  constructor: (json) ->
    attributes = ['id', 'name', 'power', 'animation']
    initializeFromJSON(this, attributes, json)

  execute: (target) ->
    target.update_hp(-@power)
    playAnimation(target, @animation)
    $('#message').text("#{target.name} was hit with #{@name}").slideDown()

playAnimation = (target, animation) ->
  $("##{target.type} .portrait img").addClass(animation)

removeAnimation = (target) ->
  $("##{target.type} .portrait img").attr('class', 'blank')

rand = (max) ->
  Math.ceil(Math.random()*max)

hero = new Hero(json, all_techniques)
enemy = new Enemy(json, all_techniques)
state = 'playerTurn'

$(document).ready ->
  $("body").click(->
    console.log(state)
    if state == 'playerTurn'

    else if state == 'enemyTurn'
      removeAnimation(enemy)
      enemy.attack()
      state = 'playerTurn'
      $("#techniques").slideDown()
  )



  hero.update_hp()
  enemy.update_hp()
  hero.update_image()
  enemy.update_image()


  hero.showTechniques()

#for debugging.  REMOVE BEFORE PRODUCTION
#  window.hero = hero
#  window.enemy = enemy

changeSelector = ->
  techniques = $("#techniques").children()
  if selector < 0 then selector += techniques.length
  if selector >= techniques.length then selector -= techniques.length
  techniques.removeClass('selected')
  $("#techniques li:nth-child(#{selector+1})").addClass('selected')

Key =
  LEFT: 37,
  A: 65,
  UP: 38,
  W: 87,
  RIGHT: 39,
  D: 68,
  DOWN: 40,
  S: 83,
  SPACE: 32,

  onKeydown: (event) ->
    if event.keyCode == 38
      console.log('up', event)
      selector--
      changeSelector()
    else if event.keyCode == 40
      console.log('down', event)
      selector++
      changeSelector()
    else
      console.log('idk', event)

window.addEventListener 'keydown', ((event) -> Key.onKeydown(event); event.preventDefault(); return false), false
