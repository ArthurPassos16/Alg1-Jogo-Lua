require 'codigo/diretorio/heroina'
require 'codigo/diretorio/castelo'
require 'codigo/diretorio/inimigo'
require 'codigo/diretorio/bala'
require 'codigo/diretorio/balaCanhao'
require 'codigo/diretorio/canhao'
require 'codigo/bibliotecas/fisica'

function jogo_load()
	heroina_load()
	castelo_load()
	inimigos_load()

	morte=false
end

function jogo_update(dt)
 	if not morte then
		inimigos_update(dt)
		heroina=heroina_update(dt)	

	 	-- verifica a colisão dos inimigos com o castelo
	 	castelo_update()

		-- quando o inimigo entra na área do canhão, o canhão dispara contra ele 
		for i, inimigo in pairs(inimigos) do
			canhao_update(dt,canhao.esquerdo,inimigo)
			canhao_update(dt,canhao.direito,inimigo)
		end
		
		-- detecta a colisao da heorina e dos balas com o castelo
		for i=castelo.y, castelo.altura, castelo.alturaBloco do
			for j=castelo.x, castelo.largura, castelo.larguraBloco do
				if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
				(j==castelo.meio and ((i>0 and i<=25) or (i>=160 and i<=175) or (i>=310 and i<=325) or (i>=460  and i<=475))) or (j==castelo.largura and (i==190 or i==295)) then
				 	detectarColisaoFora(heroina,j,i,castelo.alturaBloco,castelo.larguraBloco)

			 		for k,bala in pairs(balas) do
						bloco={
							x=j,
							y=i,
							altura=castelo.alturaBloco,
							largura=castelo.larguraBloco
						}
						if detectarColisao(bala,bloco) then
							balas_remove(k)
						end
					end
				end
			end
		end

	 	-- mata os inimigos
	 	balaAtingeInimigo()	
	 	balaCanhaoAtingeInimigo()

		-- detecta colisão com o inimigo
		for i,inimigo in pairs(inimigos) do
			if detectarColisao(heroina,inimigo) or castelo.quantVida<=0 then
				morte=true
			 	break
			end	 	
		end	
	else 
		fimDoJogo_update(dt)
	end
end

function jogo_draw()
    love.graphics.setColor(255, 255, 255)
	for i=40, janela.altura+10,30 do
		for j=40,janela.largura+10,30 do
			love.graphics.draw(imagens.grama,j,i,0,0.078125,0.078125,imagens.grama:getWidth(),imagens.grama:getHeight())
		end
	end
	castelo_draw()
	heroina_draw()
	inimigos_draw()
	canhao_draw()

	if morte then
		love.graphics.clear()
		fimDoJogo_draw()
	end	
end

function fimDoJogo_update(dt)
	if love.keyboard.isDown('space') then
		love.graphics.clear()
		love.load()
		love.update(dt)
		love.draw()
	end
end

function fimDoJogo_draw()
	love.graphics.setBackgroundColor(255,255,255)

	-- Desenhando 'FIM DO JOGO'
	love.graphics.setFont(fontes.grande)
    love.graphics.setColor(0, 255, 0)
    love.graphics.printf('FIM DO JOGO', janela.largura/2-500, janela.altura/2-100, 1000, 'center')

    if math.cos(2 * math.pi * love.timer.getTime()) > 0 then
		love.graphics.setFont(fontes.media)
    	love.graphics.setColor(0, 255, 0)
        love.graphics.printf('PRESSIONE ESPAÇO PARA REINICIAR', janela.largura/2-500, janela.altura/2, 1000, 'center')
    end
end