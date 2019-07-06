

function heroina_load()
	heroina={
		x=50,
		y=love.graphics.getHeight()/2,
		largura=40,
		altura=45,
		colisao=false,
		direcao='baixo'
	}
	bala_load()
end

function heroina_update(dt)
	local velocidade=150
	-- movimento
	if love.keyboard.isDown("up","w") then
		heroina.y=heroina.y-velocidade*dt
		heroina.direcao='cima'
		animacoes.heroina.cima:update(dt)
	end
	if love.keyboard.isDown("down","s") then
		heroina.y=heroina.y+velocidade*dt
		heroina.direcao='baixo'
		animacoes.heroina.baixo:update(dt)
	end
	if love.keyboard.isDown("right","d") then
		heroina.x=heroina.x+velocidade*dt
		heroina.direcao='direita'
		animacoes.heroina.direita:update(dt)
	end
	if love.keyboard.isDown("left","a") then
		heroina.x=heroina.x-velocidade*dt
		heroina.direcao='esquerda'
		animacoes.heroina.esquerda:update(dt)
	end
	heroina.x = clamp(heroina.x,10,janela.largura-10)
	heroina.y = clamp(heroina.y,10,janela.altura-40)

	bala_update(dt,heroina)
	return heroina
end

function heroina_draw()
 	bala_draw()
	love.graphics.setColor(255,255,255)
	if heroina.direcao=='cima' then
		animacao=animacoes.heroina.cima
	elseif heroina.direcao=='baixo' then
		animacao=animacoes.heroina.baixo
	elseif heroina.direcao=='esquerda' then
		animacao=animacoes.heroina.esquerda
	elseif heroina.direcao=='direita' then
		animacao=animacoes.heroina.direita
	end
 	animacao:draw(heroina.x+40, heroina.y+40, 0, 1, 1, heroina.largura, heroina.altura) 
 	--love.graphics.rectangle('fill', heroina.x, heroina.y , heroina.largura, heroina.altura) 
end