Collide:
	lda O2Left
	cmp O1Right
 	bcs NoCollision       ;If the left edge of the enemy is farther than the Player's Right edge, there is could be no collision.
 	lda O2Right
 	cmp O1Left
 	bcc NoCollision       ;If the Player's Left edge is beyond the enemy's right, there's no way there could be a collision.
 	lda O2Top
 	cmp O1Bottom
 	bcs NoCollision       ;If the Player's Bottom Border is above the top of the enemy, there is no way for collision.
 	lda O2Bottom
 	cmp O1Top
 	bcc NoCollision
	lda #1
	rts

NoCollision:
	lda #0
	rts