function detectarColisaoFora(personagem,x2,y2,alt2,larg2)
	if personagem.x<x2+larg2 and x2<personagem.x+personagem.largura and personagem.y<y2+alt2 and y2<personagem.y+personagem.altura then
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
	return personagem
end

function detectarColisaoParede(heroina,obstaculo)
	if heroina.y<obstaculo.borda then
		heroina.y=obstaculo.borda
	end
	if heroina.x<obstaculo.borda then
		heroina.x=obstaculo.borda
	end
	if heroina.y+heroina.altura>obstaculo.altura-obstaculo.borda then
		heroina.y=obstaculo.altura-heroina.altura-obstaculo.borda
	end
	if heroina.x+heroina.largura>obstaculo.largura-obstaculo.borda then
		heroina.x=obstaculo.largura-heroina.largura-obstaculo.borda
	end
	return heroina
end

function detectarColisao(heroina,obstaculo)
	return heroina.x<obstaculo.x+obstaculo.largura and obstaculo.x<heroina.x+heroina.largura and heroina.y<obstaculo.y+obstaculo.altura and obstaculo.y<heroina.y+heroina.altura
end

function clamp(x, min, max)
    return math.min(math.max(x, min), max)
end