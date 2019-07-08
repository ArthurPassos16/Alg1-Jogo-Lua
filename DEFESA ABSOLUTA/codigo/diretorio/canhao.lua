
function canhao_load()
	canhoes={}
	balaCanhao_load()
end

function adicionaCanhao(posX,posY,areaY)
	novoCanhao={
		x=posX,
		y=posY,
		largura=castelo.alturaBloco,
		altura=castelo.larguraBloco,
		area={
			x=posX,
			y=areaY,
			largura=200,
			altura=180
		}
	}
	table.insert(canhoes,novoCanhao)
end

function canhao_update(dt,canhao,inimigo)
	balaCanhao_update(dt,canhao,inimigo)
end

function canhao_draw()
	love.graphics.setColor(255,255,255)
	for i,canhao in pairs(canhoes) do
		love.graphics.draw(imagens.canhao,canhao.x-25,canhao.y-20,0,0.37,0.36,canhao.largura,canhao.altura)
	end
	balaCanhao_draw()
end
