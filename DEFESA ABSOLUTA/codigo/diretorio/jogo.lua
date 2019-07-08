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

	ultimoTempoVivo=love.timer.getTime()
	segundos=0
	minutos=0
	morte=false
end

function jogo_update(dt)
 	if morte then
 		musicas.tema:stop()
		if love.keyboard.isDown('space') then
			fimDoJogo_update(dt)
		end
	elseif love.keyboard.isDown('escape') then
		fimDoJogo_update(dt)
	else 
		segundos,ultimoTempoVivo = tempoVivo(segundos,ultimoTempoVivo)
		if segundos>59 then
			segundos=0
			minutos=minutos+1
		end

		inimigos_update(dt)
		heroina_update(dt)
		-- quando o inimigo entra na área do canhão, o canhão dispara contra ele 
		for i, canhao in pairs(canhoes) do
			for j, inimigo in pairs(inimigos) do
				canhao_update(dt,canhao,inimigo)
			end
		end

	 	-- mata os inimigos
	 	balaAtingeInimigo()	
	 	balaCanhaoAtingeInimigo()

	 	-- verifica a colisão das balas(da heroina e dos canhões) e dos inimigos com o castelo
	 	castelo_update()	

		-- detecta colisão com o inimigo
		for i,inimigo in pairs(inimigos) do
			if detectarColisao(heroina,inimigo) then
				causaMorte='Um zumbi te pegou!'
				morte=true
			 	break
			elseif castelo.quantVida<=0 then
				causaMorte='O castelo ruiu!'
				morte=true
			 	break
			end	 	
		end	
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

    love.graphics.setColor(255, 0, 0)
    love.graphics.setFont(fontes.pequena)
    if segundos<10 then
		love.graphics.printf('Tempo Vivo: '..minutos..':0'..segundos, janela.largura-200, janela.altura-40, 1000)
	else
		love.graphics.printf('Tempo Vivo: '..minutos..':'..segundos, janela.largura-200, janela.altura-40, 1000)
	end

	if morte then
		love.graphics.clear()
		fimDoJogo_draw()
	end	
end

function fimDoJogo_update(dt)
	love.graphics.clear()
	love.load()
	love.update(dt)
	love.draw()
end

function fimDoJogo_draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(imagens.fundo,710,415,0,0.889,0.83,janela.largura+20,janela.altura+20)
	-- Desenhando 'FIM DO JOGO'
    love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(fontes.grande)
    love.graphics.printf('Fim do Jogo', janela.largura/2-500, janela.altura/2-200, 1000, 'center')

	love.graphics.setFont(fontes.media)
    love.graphics.printf(causaMorte, janela.largura/2-500, janela.altura/2-100, 1000, 'center')
	
	love.graphics.setFont(fontes.media)
	if segundos<10 then
	    love.graphics.printf('Tempo Vivo: '..minutos..':0'..segundos, janela.largura/2-500, janela.altura/2, 1000, 'center')
	else
	    love.graphics.printf('Tempo Vivo: '..minutos..':'..segundos, janela.largura/2-500, janela.altura/2, 1000, 'center')
	end

    if math.cos(2 * math.pi * love.timer.getTime()) > 0 then
		love.graphics.setFont(fontes.media)
        love.graphics.printf('PRESSIONE ESPAÇO PARA REINICIAR', janela.largura/2-500, janela.altura/2+100, 1000, 'center')
    end
end