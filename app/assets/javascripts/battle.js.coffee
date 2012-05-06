initializeFromJSON = (self, json) ->
  jQuery.each(json, ((key, value) ->
    eval("self.#{key} = value")
  ))

selector = 0

class Monster
  constructor: (id) ->
    monster = this
    $.ajax
      url: "http://localhost:3000/monsters/#{id}",
      dataType: "json",
      type: "GET",
      processData: false,
      contentType: "application/json"
      success: (json, status, xhr) ->
        initializeFromJSON(monster, json.monster)
        console.log(monster)
        @techniques = json.techniques.map((tech) -> new Technique(tech))

  update_hp: (change = 0) ->
    @current_hp += change
    $("##{@type} .hp").text("#{@current_hp}/#{@max_hp}")

  update_image: (url = @image_url) ->
    @image_url = url
    $("##{@type} .portrait img").attr('src', @image_url)

class Hero extends Monster
  constructor: (id) ->
    @type = 'hero'
    super id

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
    console.log(json)
    initializeFromJSON(this, json)
    console.log(this)

  execute: (target, attacker) ->
    damage = @calculateDamage(target, attacker)
    target.update_hp(-damage)
    playAnimation(target, @animation)
    $('#message').text("#{attacker.name} hit #{target.name} with #{@name}").slideDown()

  calculateDamage: (target, attacker) ->
    @power + attacker.current_attack - target.current_defense


playAnimation = (target, animation) ->
  $("##{target.type} .portrait img").addClass(animation)

removeAnimation = (target) ->
  $("##{target.type} .portrait img").attr('class', 'blank')

rand = (max) ->
  Math.ceil(Math.random()*max)


hero = new Hero(3)
#enemy = new Enemy(json, all_techniques)
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
