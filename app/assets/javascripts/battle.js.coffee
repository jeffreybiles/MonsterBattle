class Monster
  constructor: (json, all_techniques) ->
    @name = json.name
    @max_attack = json.attack
    @current_attack = json.current_attack || @max_attack
    @max_defense = json.defense
    @current_defense = json.current_defense || @max_defense
    @max_hp = json.hp
    @current_hp = json.current_hp || @max_hp
    @id = json.id
    @techniques = json.techniques.map((index) -> new Technique(all_techniques[index]))
    @image_url = json.image_url

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
    $('#techniques').html('<ul></ul>')
    for technique in @techniques
      @attachTechnique(technique)

  attachTechnique: (technique) ->
    html = "<li class='#{technique.name} technique' data-power='#{technique.power}' data-name='#{technique.name}'><a href='#' id='#{technique.name}'>#{technique.name}</a></li>"
    $('#techniques').append(html)
    hero = this
    $("#techniques .#{technique.name}").click(->
      enemy.update_hp($(this).data('power')*-1)
      #TODO: start an animation here!
      $('#techniques').slideUp()
      $('#message').text("#{hero.name} hits #{enemy.name} with #{$(this).data('name')}").slideDown()
      #TODO: make enemy take turn, then slide techniques back down
    )

class Enemy extends Monster
  constructor: (json, all_techniques) ->
    json = json.enemy if json.enemy
    @type = 'enemy'
    super json, all_techniques

  #must figure out how to select a random technique
#  attack: (technique = null) ->
#    unless technique
#      technique = @techniques

class Technique
  constructor: (json) ->
    @id = json.id
    @name = json.name
    @power = json.power

$(document).ready ->
  json =
    hero:
      id: 4
      name: "Thesis"
      attack: 10
      hp: 20
      defense: 5
      techniques: [0, 1]
      image_url: "http://avatarswizard.com/uploads/av/2009-03/thumbs/100x100_1236347910_lego-pokemon-1.jpg"
    enemy:
      id: 1
      name: "AntiThesis"
      attack: 9
      hp: 18
      defense: 4
      techniques: [0]
      image_url: "http://avatarmaker.eu/free-avatars/avatars/games_225/super_mario_259/super_mario_panic_avatar_100x100_25831.gif"

  all_techniques =
    0:
      id: 0
      name: 'push'
      power: 2
    1:
      id: 1
      name: 'shove'
      power: 4

  hero = new Hero(json, all_techniques)
  enemy = new Enemy(json, all_techniques)

  hero.update_hp()
  enemy.update_hp()
  hero.update_image()
  enemy.update_image()

  hero.showTechniques()

  #for debugging.  REMOVE BEFORE PRODUCTION
  window.hero = hero
  window.enemy = enemy
