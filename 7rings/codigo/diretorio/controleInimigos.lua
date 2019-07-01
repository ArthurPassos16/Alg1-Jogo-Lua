function inimigos_load()
	inimigos={
        ultimoTempoVida=love.timer.getTime()
    } 
	return inimigos
 end

function inimigos_update(dt)
	for i = 1,#inimigos do
        inimigo_update(dt,inimigos[i])
        --[[if inimigos[i].to_delete then
            table.remove(inimigos, i)
        end--]]
    end
    return inimigos
end

function gerenciador_update(dt)
    -- adiciona um inimigo
    if #inimigos < 6 then
        tempoAtual=love.timer.getTime()

        if tempoAtual-inimigos.ultimoTempoVida>=2 then
            x = janela.largura-40
            y = math.random(10, janela.altura-50,30)
            inimigos=inimigos_add(inimigo_load(x, y))
            inimigos.ultimoTempoVida=tempoAtual
        end
    end
    return inimigos
end

function inimigos_draw()
	for i=1,#inimigos do
		inimigo_draw(inimigos[i])
	end
end

function inimigos_add(inimigo)
	table.insert(inimigos,inimigo)
	return inimigos
end
