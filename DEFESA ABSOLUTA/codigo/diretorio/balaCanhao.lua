function balaCanhao_load() 
	velocidade = 1
	tempoUltBalaCanhao = love.timer.getTime()
	balasCanhao={}							
end

function canhaoLado(canhao,inimigo)
	tempoAtual=love.timer.getTime()

	if tempoAtual-tempoUltBalaCanhao>1 then
		local posX = canhao.x
		local posY = canhao.y
		local posX2 = inimigo.x + inimigo.largura/2
		local posY2 = inimigo.y + inimigo.altura/2

		local angulo = math.atan2((posY2  - posY), ( posX2 - posX))
		
		-- cria uma nova bala e a insere no vetor de balas
		novaBalaCanhao={
			x=posX,
			y=posY,
			largura=imagens.bala:getWidth(),
			altura=imagens.bala:getHeight(),
			angulo=angulo
		}
		table.insert(balasCanhao,novaBalaCanhao)
		love.audio.play(sons.canhao)
		sons.canhao:setVolume(0.6)
		tempoUltBalaCanhao=tempoAtual
	end
end

function balaCanhao_update(dt,canhao,inimigo)
	if (canhao.y==400 or canhao.y==100 or canhao.y==250) and  detectarColisao(canhao.area,inimigo)  then
		canhaoLado(canhao,inimigo)
	end
	-- posição da bala dentro do vetor de balas 
	for i, balaCanhao in pairs(balasCanhao) do
		local Dx = velocidade * math.cos(balaCanhao.angulo)		
		local Dy = velocidade * math.sin(balaCanhao.angulo)
		balaCanhao.x = balaCanhao.x + (Dx * dt)
		balaCanhao.y = balaCanhao.y + (Dy * dt)
		
		-- remove a bala assim que ela sai da janela
		if balaCanhao.x > love.graphics.getWidth() or balaCanhao.y > love.graphics.getHeight() or balaCanhao.x < 0 or balaCanhao.y < 0 then
			balaCanhao_remove(i)
		end
	end
end

function balaCanhao_draw()
	love.graphics.setColor(255,255,255)
	for i,balaCanhao in pairs(balasCanhao) do
		love.graphics.draw(imagens.bala,balaCanhao.x,balaCanhao.y,0,1,1,balaCanhao.largura,balaCanhao.altura)
	end
end

function balaCanhaoAtingeInimigo()
	for i,balaCanhao in pairs(balasCanhao) do
		for j,inimigo in pairs(inimigos) do
			if detectarColisao(balaCanhao,inimigo) then
				inimigo.quantVida=inimigo.quantVida-1
				balaCanhao_remove(i)
			end
			if inimigo.quantVida==0 then
				inimigos_remove(j)
			end
		end	 	
	end
end

function balaCanhao_remove(posicao)
	table.remove(balasCanhao,posicao)
end
