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
    $('#techniques').html('')
    for technique in @techniques
      html = "<div class='#{technique.name} technique' data-power='#{technique.power}' data-name='#{technique.name}'>#{technique.name}</div>"
      $('#techniques').append(html)
      hero = this
      $("#techniques .#{technique.name}").click(-> hero.attack(technique))
    updateSelector()

  attack: (technique) ->
    technique.execute(enemy, this)

class Enemy extends Monster
  constructor: (json, all_techniques) ->
    json = json.enemy if json.enemy
    @type = 'enemy'
    super json, all_techniques

  attack: (technique = null, target = hero) ->
    unless technique
      technique = @techniques[rand(@techniques.length) - 1]
    technique.execute(target, this)

class Technique
  constructor: (json) ->
    attributes = ['id', 'name', 'power', 'animation']
    initializeFromJSON(this, attributes, json)

  execute: (target, attacker = null) ->
    target.update_hp(-@power)
    playAnimation(target, @animation)
    $('#message').text("#{attacker.name} hit #{target.name} with #{@name}").slideDown()

playAnimation = (target, animation) ->
  $("##{target.type} .portrait img").addClass(animation)

removeAnimation = (target) ->
  $("##{target.type} .portrait img").attr('class', 'blank')

rand = (max) ->
  Math.ceil(Math.random()*max)

hero = new Hero(json, all_techniques)
enemy = new Enemy(json, all_techniques)
state = 'selectAttack'

next = ->
  if state == 'selectAttack'
    removeAnimation(hero)
    technique = hero.techniques[selector]
    hero.attack(technique)
    $('#techniques').slideUp()
    state = 'enemyTurn'
  else if state == 'enemyTurn'
    removeAnimation(enemy)
    enemy.attack()
    state = 'selectAttack'
    $("#techniques").slideDown()

$(document).ready ->
  hero.update_hp()
  enemy.update_hp()
  hero.update_image()
  enemy.update_image()

  hero.showTechniques()

updateSelector = ->
  techniques = $("#techniques").children()
  if selector < 0 then selector += techniques.length
  if selector >= techniques.length then selector -= techniques.length
  techniques.removeClass('selected')
  $("#techniques div:nth-child(#{selector+1})").addClass('selected')

Key =
  LEFT: 37,
  UP: 38,
  RIGHT: 39,
  DOWN: 40,
  SPACE: 32,

  onKeydown: (event) ->
    if event.keyCode == 38
      selector--
      updateSelector()
    else if event.keyCode == 40
      selector++
      updateSelector()
    else if event.keyCode == 32
      next()

window.addEventListener 'keydown', ((event) -> Key.onKeydown(event); event.preventDefault(); return false), false
