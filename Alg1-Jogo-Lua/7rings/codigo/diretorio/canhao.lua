
function canhao_load(castelo)
	canhao={}
	canhao.esquerdo={
		x=100,
		y=castelo.meio,
		largura=castelo.alturaBloco,
		altura=castelo.larguraBloco,
		raio=200
	}
	canhao.direito={
		x=400,
		y=castelo.meio,
		largura=castelo.alturaBloco,
		altura=castelo.larguraBloco,
		raio=200
	}
	return canhao
end

function areaCanhaoDireito(inimigo)
	x=inimigo.x-canhao.direito.x
	y=inimigo.y-canhao.direito.y
	distancia=math.sqrt(x^2+y^2)

	return distancia<=canhao.direito.raio and distancia>=0
end

function areaCanhaoEsquerdo(inimigo)
	x=inimigo.x-canhao.esquerdo.x
	y=inimigo.y-canhao.esquerdo.y
	distancia=math.sqrt(x^2+y^2)

	return distancia<=canhao.esquerdo.raio and distancia>=0
end

function canhao_draw()
	love.graphics.setColor(255,0,0)
	--love.graphics.circle('fill',canhao.direito.y,canhao.direito.x,canhao.direito.raio)
	love.graphics.rectangle('fill',canhao.direito.y,canhao.direito.x,canhao.direito.largura,canhao.direito.altura)
	love.graphics.rectangle('fill',canhao.esquerdo.y,canhao.esquerdo.x,canhao.esquerdo.largura,canhao.esquerdo.altura)
end
