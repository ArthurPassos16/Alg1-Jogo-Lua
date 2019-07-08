
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
				angulo=0,
				quantVida=2
			}
			table.insert(inimigos,novoInimigo)
            ultimoTempoVida=tempoAtual
        end
        inimigosMandados=inimigosMandados+1
    end

	local posX2 = heroina.x + heroina.largura/2
	local posY2 = heroina.y + heroina.altura/2

	for i, inimigo in pairs(inimigos) do
		if heroinaForaCastelo() then
			local posX = inimigo.x + inimigo.largura/2
			local posY = inimigo.y + inimigo.altura/2

			inimigo.angulo = math.atan2((posY2  - posY), ( posX2 - posX))

			local Dx = velocidade * math.cos(inimigo.angulo)		
			local Dy = velocidade * math.sin(inimigo.angulo)

			inimigo.x = inimigo.x + Dx * dt - 10 * dt
			inimigo.y = inimigo.y + Dy * dt - 10 * dt
		else
			inimigo.angulo=0
			inimigo.x = inimigo.x - velocidade * dt
			animacoes.zumbi:update(dt)
		end
	end
end

function inimigos_draw()
	for i,inimigo in pairs(inimigos) do
		love.graphics.setColor(255,255,255)
		anim=animacoes.zumbi
 		anim:draw(inimigo.x+55,inimigo.y+60,0,1.40,1.45,inimigo.largura,inimigo.altura)	
	end
end

function inimigos_remove(posicao)
	table.remove(inimigos,posicao)
end