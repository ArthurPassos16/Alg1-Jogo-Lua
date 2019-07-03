function castelo_load()
	castelo={
		x=10, 
		y=10, 
		altura=love.graphics.getHeight()-20,
		largura=280,
		meio=190,
		larguraBloco=15, 
		alturaBloco=15
	}
	return castelo
end

function colisaoCastelo(obstaculo)
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
			 (j==castelo.meio and (i<=175 or i>=310)) or (j==castelo.largura and (i==190 or i==295)) then
			 	obstaculo=detectarColisaoFora(obstaculo,j,i,castelo.alturaBloco,castelo.larguraBloco)
			end
		end
	end
	return obstaculo
end

function castelo_draw()
	love.graphics.setColor(255,0,255)
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
				(j==castelo.meio and (i<=175 or i>=310)) or (j==castelo.largura and (i==190 or i==295)) then
 				love.graphics.rectangle('fill', j, i, castelo.larguraBloco, castelo.alturaBloco) 
 			end
 		end
 	end
end