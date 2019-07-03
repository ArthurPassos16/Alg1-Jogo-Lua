function bala_load()
	velocidade = 250
	tempoRecarga = 2
	tempoUltBala = love.timer.getTime()
	balas={}	
	return balas									
end

function bala_update(dt,objeto)
	if love.mouse.isDown(1) then
		tempoAtual=love.timer.getTime()

		if tempoAtual-tempoUltBala>0.5 then			
			--Sets the starting position of the bullet, this code makes the bullets start in the middle of the player.
			local posX = objeto.x + objeto.largura / 2
			local posY = objeto.y + objeto.altura / 2
			local mouseX, mouseY = love.mouse.getPosition()

			--Basic maths and physics, calculates the angle so the code can calculate deltaX and deltaY later.
			local angulo = math.atan2((mouseY - posY), (mouseX - posX))
			
			-- cria uma nova bala e a insere no vetor de balas
			novaBala={
				x=posX,
				y=posY,
				largura=imagens.bala:getWidth(),
				altura=imagens.bala:getHeight(),
				angulo=angulo
			}
			table.insert(balas,novaBala)
			tempoUltBala=tempoAtual
		end
	end
	
	-- posição da bala dentro do vetor de balas 
	for i, bala in pairs(balas) do
		local Dx = velocidade * math.cos(bala.angulo)		
		local Dy = velocidade * math.sin(bala.angulo)
		bala.x = bala.x + (Dx * dt)
		bala.y = bala.y + (Dy * dt)
		
		-- remove a bala assim que ela sai da janela
		if bala.x > love.graphics.getWidth() or bala.y > love.graphics.getHeight() or bala.x < 0 or bala.y < 0 then
			balas_remove(i)
		end
	end
	return balas
end

function bala_updateCanhao(dt,objeto)
	if areaCanhaoDireito(objeto) then--or areaCanhaoEsquerda(objeto) then			
		--Sets the starting position of the bullet, this code makes the bullets start in the middle of the player.
		local posX = objeto.x + objeto.largura / 2
		local posY = objeto.y + objeto.altura / 2

		--Basic maths and physics, calculates the angle so the code can calculate deltaX and deltaY later.
		local angulo = math.atan2((posY), (posX))
		
		-- cria uma nova bala e a insere no vetor de balas
		novaBala={
			x=posX,
			y=posY,
			largura=imagens.bala:getWidth(),
			altura=imagens.bala:getHeight(),
			angulo=angulo
		}
		table.insert(balas,novaBala)
	end
	
	-- posição da bala dentro do vetor de balas 
	for i, bala in pairs(balas) do
		local Dx = velocidade * math.cos(bala.angulo)		
		local Dy = velocidade * math.sin(bala.angulo)
		bala.x = bala.x + (Dx * dt)
		bala.y = bala.y + (Dy * dt)
		
		-- remove a bala assim que ela sai da janela
		if bala.x > love.graphics.getWidth() or bala.y > love.graphics.getHeight() or bala.x < 0 or bala.y < 0 then
			balas_remove(i)
		end
	end
	return balas
end

function bala_draw()
	for i,bala in pairs(balas) do
		love.graphics.draw(imagens.bala,bala.x,bala.y,0,1,1,bala.largura,bala.altura)
	end
end

function balaAtingeInimigo(balas,inimigos)
	for i,bala in pairs(balas) do
		for j,inimigo in pairs(inimigos) do
			if detectarColisao(bala,inimigo) then
				balas_remove(i)
				inimigos_remove(j)
			end
		end	 	
	end
end

function balas_remove(posicao)
	table.remove(balas,posicao)
	return balas
end