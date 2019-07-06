function castelo_load()
	castelo={
		x=10, 
		y=10, 
		altura=love.graphics.getHeight()-20,
		largura=280,
		meio=190,
		larguraBloco=15, 
		alturaBloco=15,
		quantVida=200
	}
	canhao_load()
	ultimoTempo=love.timer.getTime()
end

function colisaoCastelo()
	for i,inimigo in pairs(inimigos) do
		for i=castelo.y, castelo.altura, castelo.alturaBloco do
			for j=castelo.x, castelo.largura, castelo.larguraBloco do
				if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
					(j==castelo.meio and ((i>0 and i<=175) or (i>=310 and i<=475))) or 
					(j==castelo.largura and (i>190 and i<295)) then
				 	
				 	colidiu=detectarColisaoFora(inimigo,j,i,castelo.alturaBloco,castelo.larguraBloco)
				 	tempoAtual=love.timer.getTime()
				 	
				 	if colidiu and tempoAtual-inimigo.ultimoTempo>2 then
						love.audio.play(sons.zumbi)
						castelo.quantVida=castelo.quantVida-1
						inimigo.ultimoTempo=love.timer.getTime()
				 		break
				 	end
				end
			end
			if colidiu then
				break
			end
		end
	end
end

function castelo_update()
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
			(j==castelo.meio and ((i>0 and i<=25) or (i>=160 and i<=175) or (i>=310 and i<=325) or (i>=460  and i<=475))) or 
			(j==castelo.largura and (i==190 or i==295)) then
				detectarColisaoFora(heroina,j,i,castelo.alturaBloco,castelo.larguraBloco)

			 	for k,bala in pairs(balas) do
					bloco={
						x=j,
						y=i,
						altura=castelo.alturaBloco,
						largura=castelo.larguraBloco
					}
					if detectarColisao(bala,bloco) then
						balas_remove(k)
					end
				end
			end
		end
	end
end

function castelo_draw()
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
				(j==castelo.meio and ((i>0 and i<=25) or (i>=160 and i<=175) or (i>=310 and i<=325) or (i>=460  and i<=475))) or (j==castelo.largura and (i==190 or i==295)) then
				mensagem('Vida do Castelo: '..castelo.quantVida, janela.largura-220, 15)
				mudancaCastelo(j,i,castelo.larguraBloco,castelo.alturaBloco)
 			end
 			if (j==castelo.largura and (i>190 and i<295)) or (j==castelo.meio and ((i>25 and i<160) or (i>325 and i<460)) or 
 				(j>15 and j<castelo.meio) and (i>15 and i<castelo.altura-5)) or ((i>175 and i<310) and (j>=castelo.meio and j<castelo.largura)) then
				love.graphics.draw(imagens.chao,j,i,0,0.0375,0.0375,castelo.larguraBloco,castelo.alturaBloco)
 			end
 			if (j==castelo.meio and ((i>40 and i<175) or (i>340 and i<475))) or (j==castelo.largura and (i>=220 and i<=295)) then
				love.graphics.draw(imagens.portao,j+15,i,0,1,1,castelo.larguraBloco,castelo.alturaBloco)
 			end
 		end
 	end
end

function mudancaCastelo(x,y,largura,altura)
	tempoAtual=love.timer.getTime()
	if castelo.quantVida>150 then 
		love.graphics.draw(imagens.castelo1,x,y,0,0.066,0.066,largura,altura)
	elseif castelo.quantVida>100 and castelo.quantVida<=150 then
		if tempoAtual-ultimoTempo<3 and math.cos(2 * math.pi * tempoAtual) > 0 then
			mensagem('Defenda seu castelo!',220,10)
		end
		love.graphics.draw(imagens.castelo2,x,y,0,0.066,0.066,largura,altura)
	elseif castelo.quantVida<=100 and castelo.quantVida>50  then
		mensagem('Defenda seu castelo!',220,10)
		love.graphics.draw(imagens.castelo3,x,y,0,0.066,0.066,largura,altura)
	elseif castelo.quantVida<=50 then
		mensagem('Seu castelo está ruindo!',220,10)
		love.graphics.draw(imagens.castelo4,x,y,0,0.066,0.066,largura,altura)
	elseif castelo.quantVida<=20 then
		mensagem('Seu castelo vai ruir!',220,10)
	end
	ultimoTempo=tempoAtual
end

function mensagem(mensagem,x,y)
 	love.graphics.setColor(255,0,0)
    love.graphics.setFont(fontes.pequena)
    love.graphics.printf(mensagem,x,y,1000)
 	love.graphics.setColor(255,255,255)
end