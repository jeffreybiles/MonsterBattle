initializeJsonAttributes = (self, json) ->
  jQuery.each(json, ((key, value) ->
    if isNumericString(value)
      console.log(key, 'was numeric')
      eval("self.#{key} = parseFloat(value)")
    else
      console.log(key, 'was NOT numeric')
      eval("self.#{key} = value")
  ))

isNumericString = (string) ->
  regex = /^[0-9]+\.?[0-9]*$/
  regex.exec(string)

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
      #should add an error as well
      success: (json, status, xhr) ->
        monster.buildFromJson(json)
        
  buildFromJson: (json) ->
    initializeJsonAttributes(@, json.monster)
    @techniques = json.techniques.map((tech) -> new Technique(tech))
    if @type == 'hero' then @showTechniques()
    @update_hp()
    @update_image(@image_url)


  update_hp: (change = 0) ->
    @current_hp += parseFloat(change)
    $("##{@type} .hp").text("#{@current_hp}/#{@max_hp}")

  update_image: (url = @image_url || '/assets/hero_default.jpg') ->
    @image_url = url
    $("##{@type} .portrait img").attr('src', @image_url)

class Hero extends Monster
  constructor: (id) ->
    @type = 'hero'
    super id
    window.Hero = this

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
    initializeJsonAttributes(this, json)

  execute: (target, attacker) ->
    damage = @calculateDamage(target, attacker)
    console.log(damage)
    target.update_hp(-damage)
    console.log(target.current_hp)
    playAnimation(target, @animation)
    $('#message').text("#{attacker.name} hit #{target.name} with #{@name}").slideDown()

  calculateDamage: (target, attacker) ->
    console.log(@power, attacker.current_attack, target.current_defense)
    return @power + attacker.current_attack - target.current_defense


playAnimation = (target, animation) ->
  $("##{target.type} .portrait img").addClass(animation)

removeAnimation = (target) ->
  $("##{target.type} .portrait img").attr('class', 'blank')

rand = (max) ->
  Math.ceil(Math.random()*max)


hero = ''
enemy = ''
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
  hero = new Hero(3)
  enemy = new Enemy(3)
  return

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

window.addEventListener 'keydown', ((event) -> Key.onKeydown(event); return false), false
