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
end

function castelo_update()
	for i,inimigo in pairs(inimigos) do
		for i=castelo.y, castelo.altura, castelo.alturaBloco do
			for j=castelo.x, castelo.largura, castelo.larguraBloco do
				if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
					(j==castelo.meio and ((i>0 and i<=175) or (i>=310 and i<=475))) or 
					(j==castelo.largura and (i>190 and i<295)) then
				 	
				 	inimigo,colidiu=detectarColisaoFora(inimigo,j,i,castelo.alturaBloco,castelo.larguraBloco)
				 	tempoAtual=love.timer.getTime()
				 	
				 	if colidiu and tempoAtual-inimigo.ultimoTempo>2 then
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

function castelo_draw()
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
				(j==castelo.meio and ((i>0 and i<=25) or (i>=160 and i<=175) or (i>=310 and i<=325) or (i>=460  and i<=475))) or (j==castelo.largura and (i==190 or i==295)) then
				love.graphics.draw(imagens.castelo,j,i,0,0.066,0.066,castelo.larguraBloco,castelo.alturaBloco)
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
 	love.graphics.setColor(255,0,0)
    love.graphics.setFont(fontes.pequena)
    love.graphics.printf('Vida do Castelo: '..castelo.quantVida, janela.largura-220, 15, 1000)
end