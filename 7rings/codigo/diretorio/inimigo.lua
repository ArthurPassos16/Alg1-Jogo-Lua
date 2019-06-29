function inimigo_load()
	inimigo={
		x=love.graphics.getWidth()-40,
		y=math.random(0,love.graphics.getHeight()-40),
		largura=30,
		altura=30,
		quantVida=5
	}
	return inimigo
end

function inimigo_update(dt)
	inimigo.x=inimigo.x-60*dt
	return inimigo
end

function inimigo_draw()
 	love.graphics.rectangle('fill', inimigo.x, inimigo.y, inimigo.largura, inimigo.altura) 
end