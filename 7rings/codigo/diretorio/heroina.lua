local anim = require 'codigo/bibliotecas/anal'

function heroina_load()
	heroina={
		x=love.graphics.getWidth()/2,
		y=love.graphics.getHeight()/2,
		largura=32,
		altura=64,
		colisao=false,
		direcao='baixo'
	}
	return heroina
end

function heroina_update(dt)
	local velocidade=150
	-- movimento
	if love.keyboard.isDown("up") then
		heroina.y=heroina.y-velocidade*dt
		heroina.direcao='cima'
	end
	if love.keyboard.isDown("down") then
		heroina.y=heroina.y+velocidade*dt
		heroina.direcao='baixo'
	end
	if love.keyboard.isDown("right") then
		heroina.x=heroina.x+velocidade*dt
		heroina.direcao='direita'
	end
	if love.keyboard.isDown("left") then
		heroina.x=heroina.x-velocidade*dt
		heroina.direcao='esquerda'
	end
	return heroina
end

function heroina_draw()
	love.graphics.setColor(0,0,0)
 	love.graphics.rectangle('fill', heroina.x, heroina.y, heroina.largura, heroina.altura) 
end