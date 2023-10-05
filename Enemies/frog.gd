extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = $"../../Player/Player"
@onready var anim = $AnimatedSprite2D
var chase = false
var SPEED = 50
func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	if chase == true:
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
		
		if anim.animation != "Death":
			anim.play("Jump")
			velocity.x = direction.x * SPEED
		else:
			velocity.x = 0
	else:
		velocity.x = 0
		if anim.animation != "Death":
			anim.play("Idle")
	move_and_slide()
	
func _on_player_detectot_body_entered(body):
	if body.name == "Player":
		chase = true
		

func _on_player_detectot_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_death_body_entered(body):
	if body.name == "Player":
		deathFrog()

	
func deathFrog():
	Game.Gold += 5
	Utilitis.saveGame()
	anim.play("Death")
	await anim.animation_finished
	self.queue_free()


func _on_player_damage_body_entered(body):
	if body.name == "Player":
		print("Entro")
		Game.PlayerHP -= 5
		deathFrog()
