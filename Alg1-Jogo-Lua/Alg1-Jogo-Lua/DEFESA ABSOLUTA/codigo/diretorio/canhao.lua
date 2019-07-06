
function canhao_load()
	canhao={}
	canhao.esquerdo={
		x=castelo.meio,
		y=100,
		largura=castelo.alturaBloco,
		altura=castelo.larguraBloco,
		raio=150
	}
	canhao.direito={
		x=castelo.meio,
		y=400,
		largura=castelo.alturaBloco,
		altura=castelo.larguraBloco,
		raio=150
	}
	balaCanhao_load()
end

function canhao_update(dt,canhao,inimigo)
	balaCanhao_update(dt,canhao,inimigo)
end

function areaCanhaoDireito(inimigo)
	x=inimigo.x-canhao.direito.x
	y=inimigo.y-canhao.direito.y
	distancia=math.sqrt(x^2+y^2)

	return distancia<=canhao.direito.raio+inimigo.raio and distancia>=0
end

function areaCanhaoEsquerdo(inimigo)
	x=inimigo.x-canhao.esquerdo.x
	y=inimigo.y-canhao.esquerdo.y
	distancia=math.sqrt(x^2+y^2)

	return distancia<=canhao.esquerdo.raio+inimigo.raio and distancia>=0
end

function canhao_draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(imagens.canhao,canhao.esquerdo.x-25,canhao.esquerdo.y-20,0,0.37,0.36,canhao.esquerdo.largura,canhao.esquerdo.altura)
	love.graphics.draw(imagens.canhao,canhao.direito.x-25,canhao.direito.y-15,0,0.37,0.36,canhao.direito.largura,canhao.direito.altura)
	balaCanhao_draw()
end
