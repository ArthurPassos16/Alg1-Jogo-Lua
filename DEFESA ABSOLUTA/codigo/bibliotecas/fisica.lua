function detectarColisaoFora(personagem,x2,y2,alt2,larg2)
	colidiu=(personagem.x<x2+larg2 and x2<personagem.x+personagem.largura and personagem.y<y2+alt2 and y2<personagem.y+personagem.altura)
	if colidiu then
		if personagem.direcao=='cima' then
			personagem.y=y2+alt2
		end
		if personagem.direcao=='baixo' then
			personagem.y=y2-personagem.altura
		end
		if personagem.direcao=='direita' then
			personagem.x=x2-personagem.largura
		end
		if personagem.direcao=='esquerda' then
			personagem.x=x2+larg2	
		end
	end
	return colidiu
end

function detectarColisao(objeto,obstaculo)
	return objeto.x<obstaculo.x+obstaculo.largura and obstaculo.x<objeto.x+objeto.largura and objeto.y<obstaculo.y+obstaculo.altura and obstaculo.y<objeto.y+objeto.altura
end

function clamp(x, min, max)
    return math.min(math.max(x, min), max)
end

function tempoVivo(temp,ultTemp)
	tempoAtual=love.timer.getTime()
	if tempoAtual-ultTemp>=1 then
		ultTemp=tempoAtual
		return temp+1,ultTemp
    end
    return temp,ultTemp
end