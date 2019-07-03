require 'codigo/diretorio/heroina'
require 'codigo/diretorio/castelo'
require 'codigo/diretorio/inimigo'
require 'codigo/diretorio/bala'
require 'codigo/diretorio/canhao'
require 'codigo/bibliotecas/fisica'

function jogo_load()
	heroina=heroina_load()
	castelo=castelo_load()
	inimigos=inimigos_load()
	canhao=canhao_load(castelo)
	balas=bala_load()

	morte=false
end

function jogo_update(dt)
 	if not morte then
		inimigos=inimigos_update(dt)
		heroina=heroina_update(dt)
		balas=bala_update(dt,heroina)
		balas=bala_updateCanhao(dt,canhao.direito)
		balas=bala_updateCanhao(dt,canhao.esquerdo)
		
		-- detecta a colisao da heorina e dos inimigos com o castelo
		for i=castelo.y, castelo.altura, castelo.alturaBloco do
			for j=castelo.x, castelo.largura, castelo.larguraBloco do
				if ((i==castelo.y or j==castelo.x or i==castelo.altura-5) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
					(j==castelo.meio and (i<=175 or i>=310)) or (j==castelo.largura and (i==190 or i==295)) then
				 	heroina=detectarColisaoFora(heroina,j,i,castelo.alturaBloco,castelo.larguraBloco)
				 	for k,inimigo in pairs(inimigos) do
						inimigo=detectarColisaoFora(inimigo,j,i,castelo.alturaBloco,castelo.larguraBloco)
					end
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
	 	balaAtingeInimigo(balas,inimigos)	

		-- detecta colisão com o inimigo
		for i,inimigo in pairs(inimigos) do
			if detectarColisao(heroina,inimigo) then
				morte=true
			 	break
			end	 	
		end	
	else 
		fimDoJogo_update(dt)
	end
end

function jogo_draw()
	castelo_draw()
	bala_draw()
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
    love.graphics.setColor(255, 0, 255)
    love.graphics.printf('FIM DO JOGO', janela.largura/2-500, janela.altura/2-100, 1000, 'center')

    if math.cos(2 * math.pi * love.timer.getTime()) > 0 then
		love.graphics.setFont(fontes.pequena)
        love.graphics.setColor(255, 0, 255)
        love.graphics.printf('PRESSIONE ESPAÇO PARA REINICIAR', janela.largura/2-500, janela.altura/2, 1000, 'center')
    end
end