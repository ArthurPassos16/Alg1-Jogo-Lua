function detectarColisaoFora(heroina,x2,y2,alt2,larg2)
	if heroina.x<x2+larg2 and x2<heroina.x+heroina.largura and heroina.y<y2+alt2 and y2<heroina.y+heroina.altura then
		if heroina.direcao=='cima' then
			heroina.y=y2+alt2
		end
		if heroina.direcao=='baixo' then
			heroina.y=y2-heroina.altura
		end
		if heroina.direcao=='direita' then
			heroina.x=x2-heroina.largura
		end
		if heroina.direcao=='esquerda' then
			heroina.x=x2+larg2
		end
	end
	return heroina
end

function detectarColisaoDentro(heroina,obstaculo)
	if heroina.y<obstaculo.y then
		heroina.y=obstaculo.y 
	end
	if heroina.x<obstaculo.x then
		heroina.x=obstaculo.x
	end
	if heroina.y+heroina.altura>obstaculo.altura-obstaculo.y then
		heroina.y=obstaculo.altura-heroina.altura-obstaculo.y
	end
	if heroina.x+heroina.largura>obstaculo.largura-obstaculo.x then
		heroina.x=obstaculo.largura-heroina.largura-obstaculo.x
	end
	return heroina
end

function detectarColisao(heroina,obstaculo)
	return heroina.x<obstaculo.x+obstaculo.largura and obstaculo.x<heroina.x+heroina.largura and heroina.y<obstaculo.y+obstaculo.altura and obstaculo.y<heroina.y+heroina.altura
end