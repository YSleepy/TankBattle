# TankBattle
_____________

* "To recreate the childhood game 'Tank Battle' using Godot."
* Godot v4.1.3.stable.official [f06b6836a]
* @Author:XSleepy , YSleepy


# Design
_____________

Pawn And Bullet
> * 'Player Move':Correction Position when facing_direction changed
> * 'Enemy Move': Correction Position when facing_direction changed
> * 'Bullet':There is no collision between bullets.(To increase the difficulty of the game)

Scene
> * 'Rock':Can Destroy(2 times) :: <Design Error>
> * 'Brick':Can Destroy(1 times)
> * 'Iron':Can't Destroy
> * 'Grass':Cover
> * 'StaticWater,DynamicWater':Obstruct Player.Unblock Bullet
> * 'Attack Border':Do not play sound effects
> * 'Attack Scene':Play sound effects
> * 'EnemyFactory': Spawn enemy using probabilities and enemy totals


Game
> * 'GameMoe': Unlock next level
> * 'GameOver': GameOver UI
> * 'HealthUi':show player factory remain num



# TODO
* 'Target':Game Over
* 'UI': Back,rollback can use the stack(this project does not use)
* 'Player Move': input optimization(use stack),rocker input Ui

# Code Standard
* None
