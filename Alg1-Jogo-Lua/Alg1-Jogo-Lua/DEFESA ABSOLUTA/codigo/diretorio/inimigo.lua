
function inimigos_load()
	velocidade=150
    ultimoTempoVida=love.timer.getTime()
    inimigosMandados=0
	inimigos={}
end

function inimigos_update(dt)
	if #inimigos<6 then
		 tempoAtual=love.timer.getTime()
        if tempoAtual-ultimoTempoVida>=1 then
            novoInimigo={
				x=janela.largura-40,
				y=math.random(10, janela.altura-50),
				largura=40,
				altura=45,
				raio=45,
				direcao='esquerda',
				ultimoTempo=0,
				quantVida=2
			}
			table.insert(inimigos,novoInimigo)
            ultimoTempoVida=tempoAtual
        end
        inimigosMandados=inimigosMandados+1
    end

    for i, inimigo in pairs(inimigos) do
		inimigo.x = inimigo.x - velocidade * dt
		animacoes.zumbi:update(dt)
	end
end

function inimigos_draw()
	for i,inimigo in pairs(inimigos) do
		love.graphics.setColor(255,255,255)
		anim=animacoes.zumbi
 		anim:draw(inimigo.x+55,inimigo.y+60,0,1.40,1.45,inimigo.largura,inimigo.altura)
 		--love.graphics.rectangle('fill', inimigo.x, inimigo.y , inimigo.largura, inimigo.altura) 	
	end
end

function inimigos_remove(posicao)
	table.remove(inimigos,posicao)
end