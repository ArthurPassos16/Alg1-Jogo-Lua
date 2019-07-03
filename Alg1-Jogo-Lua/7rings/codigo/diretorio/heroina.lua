

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
	if love.keyboard.isDown("up","w") then
		heroina.y=heroina.y-velocidade*dt
		heroina.direcao='cima'
		--animations.heroina.cima:update(dt)
	end
	if love.keyboard.isDown("down","s") then
		heroina.y=heroina.y+velocidade*dt
		heroina.direcao='baixo'
		--animations.heroina.baixo:update(dt)
	end
	if love.keyboard.isDown("right","d") then
		heroina.x=heroina.x+velocidade*dt
		heroina.direcao='direita'
		--animations.heroina.direita:update(dt)
	end
	if love.keyboard.isDown("left","a") then
		heroina.x=heroina.x-velocidade*dt
		heroina.direcao='esquerda'
		--animations.heroina.esquerda:update(dt)
	end
	heroina.x = clamp(heroina.x,25,janela.largura-heroina.largura-10)
	heroina.y = clamp(heroina.y,10,janela.altura-heroina.altura-10)
	return heroina
end

function heroina_draw()
	love.graphics.setColor(255,0,0)
 	love.graphics.rectangle('fill', heroina.x, heroina.y, heroina.largura, heroina.altura) 
end