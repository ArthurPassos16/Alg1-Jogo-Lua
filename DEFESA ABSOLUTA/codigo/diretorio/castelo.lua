function castelo_load()
	castelo={
		x=10, 
		y=10, 
		altura=love.graphics.getHeight()-20,
		largura=280,
		meio=190,
		larguraBloco=15, 
		alturaBloco=15,
		quantVida=150
	}
	canhao_load()
	adicionaCanhao(castelo.meio-30,100,10)
	adicionaCanhao(castelo.meio-30,400,310)
	adicionaCanhao(castelo.largura-30,250,160)
	ultimoTempo=love.timer.getTime()
end

function colisaoCasteloInimigo()
	for i,inimigo in pairs(inimigos) do
		for i=castelo.y, castelo.altura, castelo.alturaBloco do
			for j=castelo.x, castelo.largura, castelo.larguraBloco do
				if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
					(j==castelo.meio and ((i>0 and i<=175) or (i>=310 and i<=475))) or 
					(j==castelo.largura and (i>190 and i<295)) then
				 	
				 	colidiu=detectarColisaoFora(inimigo,j,i,castelo.alturaBloco,castelo.larguraBloco)
				 	tempoAtual=love.timer.getTime()
				 	
				 	if colidiu and tempoAtual-inimigo.ultimoTempo>1.5 then
						love.audio.play(sons.zumbi)
						sons.zumbi:setVolume(0.3)
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

-- detecta colisão das balas(da heroina e do canhão) com o castelo
function castelo_update()
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
			(j==castelo.meio and ((i>0 and i<=25) or (i>=160 and i<=175) or (i>=310 and i<=325) or (i>=460  and i<=475))) or 
			(j==castelo.largura and (i==190 or i==295)) then
			 	for k,bala in pairs(balas) do
					bloco={
						x=j,
						y=i,
						altura=castelo.alturaBloco,
						largura=castelo.larguraBloco
					}
					if detectarColisao(bala,bloco) then
						bala_remove(k)
					end
				end
				for k,balaCanhao in pairs(balasCanhao) do
					bloco={
						x=j,
						y=i,
						altura=castelo.alturaBloco,
						largura=castelo.larguraBloco
					}
					if detectarColisao(balaCanhao,bloco) then
						balaCanhao_remove(k)
					end
				end
			end
		end
	end
	colisaoCasteloInimigo()
end

function colisaoCasteloHeroina()
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
			(j==castelo.meio and ((i>0 and i<=25) or (i>=160 and i<=175) or (i>=310 and i<=325) or (i>=460  and i<=475))) or 
			(j==castelo.largura and (i==190 or i==295)) then
				detectarColisaoFora(heroina,j,i,castelo.alturaBloco,castelo.larguraBloco)
			end
		end
	end
end

function castelo_draw()
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
 			love.graphics.setColor(255,255,255)
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or 
				((i==175 or i==310) and j>castelo.meio) or (j==castelo.largura and (i==190 or i==295)) or 
				(j==castelo.meio and ((i>0 and i<=25) or (i>=160 and i<=175) or (i>=310 and i<=325) or (i>=460  and i<=475)))  then
				mudancaCastelo(j,i,castelo.larguraBloco,castelo.alturaBloco)
 			end
 			if (j==castelo.largura and (i>190 and i<295)) or (j==castelo.meio and ((i>25 and i<160) or (i>325 and i<460)) or 
 				(j>15 and j<castelo.meio) and (i>15 and i<castelo.altura-5)) or ((i>175 and i<310) and (j>=castelo.meio and j<castelo.largura)) then
				love.graphics.draw(imagens.chao,j,i,0,0.0375,0.0375,castelo.larguraBloco,castelo.alturaBloco)
 			end
 			if (j==castelo.meio and ((i>40 and i<175) or (i>340 and i<475))) or (j==castelo.largura and (i>=220 and i<=295)) then
				love.graphics.draw(imagens.portao,j+15,i,0,1,1,castelo.larguraBloco,castelo.alturaBloco)
 			end
 			love.graphics.setColor(255,0,0)
			love.graphics.setFont(fontes.pequena)
			love.graphics.printf('Vida do Castelo: '..castelo.quantVida, janela.largura-220, 15,1000)
 		end
 	end
	canhao_draw()
end

function mudancaCastelo(x,y,largura,altura)
	tempoAtual=love.timer.getTime()
	if castelo.quantVida>120 then 
		love.graphics.draw(imagens.castelo1,x,y,0,0.066,0.066,largura,altura)
	elseif castelo.quantVida>90 and castelo.quantVida<=120 then
		love.graphics.draw(imagens.castelo2,x,y,0,0.066,0.066,largura,altura)
		mensagem('Defenda seu castelo!',220,10)
	elseif castelo.quantVida<=90 and castelo.quantVida>60  then
		love.graphics.draw(imagens.castelo3,x,y,0,0.066,0.066,largura,altura)
		mensagem('Defenda seu castelo!',220,10)
	elseif castelo.quantVida<=60 and castelo.quantVida>30 then
		mensagem('Seu castelo está ruindo!',220,10)
		love.graphics.draw(imagens.castelo4,x,y,0,0.066,0.066,largura,altura)
	elseif castelo.quantVida<=30 and castelo.quantVida>15 then
		mensagem('Seu castelo está ruindo!',220,10)
		love.graphics.draw(imagens.castelo4,x,y,0,0.066,0.066,largura,altura)
	elseif castelo.quantVida<=15 then
		mensagem('Seu castelo vai ruir!',220,10)
		love.graphics.draw(imagens.castelo4,x,y,0,0.066,0.066,largura,altura)
	end
	ultimoTempo=tempoAtual
end

function mensagem(mensagem,x,y)
	if tempoAtual-ultimoTempo<3 and math.cos(2 * math.pi * tempoAtual) > 0 then
	 	love.graphics.setColor(255,0,0)
	    love.graphics.setFont(fontes.pequena)
	    love.graphics.printf(mensagem,x,y,1000)
	 	love.graphics.setColor(255,255,255)
	end
end