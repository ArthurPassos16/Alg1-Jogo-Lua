
function inimigos_load()
	velocidade=100
    ultimoTempoVida=love.timer.getTime()
	inimigos={}
	return inimigos
end

function inimigos_update(dt)
	 if #inimigos<6 then
        tempoAtual=love.timer.getTime()

        if tempoAtual-ultimoTempoVida>=2 then
            novoInimigo={
				x=janela.largura-40,
				y=math.random(10, janela.altura-50),
				largura=30,
				altura=30,
				direcao='esquerda',
				quantVida=5
			}
			table.insert(inimigos,novoInimigo)
            ultimoTempoVida=tempoAtual
        end
    end

    for i, inimigo in pairs(inimigos) do
		inimigo.x = inimigo.x + velocidade * dt
	end
	return inimigos
end

function inimigos_draw()
	for i,inimigo in pairs(inimigos) do
		love.graphics.setColor(0,255,0)
 		love.graphics.rectangle('fill', inimigo.x, inimigo.y , inimigo.largura, inimigo.altura) 
	end
end