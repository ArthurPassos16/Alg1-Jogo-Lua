require 'codigo/diretorio/jogo'
require 'codigo/bibliotecas/anal'

function love.load()
	math.randomseed(os.time())

	fontes={}
	fontes.grande = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 128)
	fontes.media = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 64)
	fontes.pequena = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 32)

	imagens={}
	imagens.bala=love.graphics.newImage('arquivos/imagens/projetil.png')
	imagens.castelo=love.graphics.newImage('arquivos/imagens/castelo/castelo.jpg')
	imagens.portao=love.graphics.newImage('arquivos/imagens/castelo/portao.png')
	imagens.chao=love.graphics.newImage('arquivos/imagens/castelo/chao.jpg')
	imagens.canhao=love.graphics.newImage('arquivos/imagens/castelo/canhao.png')
	imagens.grama=love.graphics.newImage('arquivos/imagens/grama.jpg')

	animacoes={}
    tempoFrame = 0.15
	animacoes.heroina={}
	animacoes.heroina.cima=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/cima.png'), 47, 47, tempoFrame, 3)
	animacoes.heroina.baixo=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/baixo.png'), 47, 47, tempoFrame, 3)
	animacoes.heroina.direita=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/direita.png'), 47, 47, tempoFrame, 3)
	animacoes.heroina.esquerda=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/esquerda.png'), 47, 47, tempoFrame, 3)

	animacoes.zumbi=newAnimation(love.graphics.newImage('arquivos/imagens/zumbi/esquerda.png'), 32, 31, tempoFrame, 3)

	janela={
		x=10,
		y=10,
		largura=love.graphics.getWidth()-20,
		altura=love.graphics.getHeight()-20
	}
	tela='inicio'
	tempoClique=0
	jogo_load()
	--love.mouse.setVisible(false)
end

function love.update(dt)
	tempoAtual=love.timer.getTime()
	if love.keyboard.isDown("right") and tela=='inicio' then
		tempoClique=love.timer.getTime()
		tela='instrucoes'
	end 
	if love.keyboard.isDown("right") and tela=='instrucoes' and tempoAtual-tempoClique>1 then
		tela='jogo'
	end
	if tela=='jogo' then
		jogo_update(dt)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(0,0,0)
	if tela=='inicio' then
		--love.graphics.setColor(255,255 	,255)
		--love.graphics.rectangle('fill',janela.x,janela.y,janela.largura,janela.altura)
		love.graphics.setColor(0,255,0)
	    love.graphics.setFont(fontes.grande)
	    love.graphics.printf('DEFESA ABSOLUTA', janela.largura / 2 - 500, 100, 1000, 'center')
	    love.graphics.setFont(fontes.media)
	    love.graphics.printf('Defenda seu castelo do', janela.largura / 2 - 500, 200, 1000, 'center')
	    love.graphics.printf('ataque dos zumbis', janela.largura / 2 - 500, 250, 1000, 'center')
	    love.graphics.setFont(fontes.pequena)
	    love.graphics.printf('próximo ->', janela.largura-150, janela.altura-30, 1000, 'left')

	elseif tela=='instrucoes' then
		love.graphics.setColor(0,255,0)
	    love.graphics.setFont(fontes.grande)
	    love.graphics.printf('INSTRUÇÕES', 30, 10, 1000, 'left')
	    love.graphics.setFont(fontes.media)
	    love.graphics.printf('Use A,S,D,F ou as setas para ',30, 200, 1000, 'left')
	    love.graphics.printf('locomover a heroina',30, 230, 1000, 'left')
	    love.graphics.printf('Use o mouse para atirar',30, 270, 1000, 'left')
	    love.graphics.printf('E divirta-se!',30, 310, 1000, 'left')
	    love.graphics.setFont(fontes.pequena)
	    love.graphics.printf('próximo ->', janela.largura-150, janela.altura-30, 1000, 'left')

	elseif tela=='jogo' then
		love.graphics.setColor(0,255,0)
		love.graphics.rectangle('fill',janela.x,janela.y,janela.largura,janela.altura)
		jogo_draw()
	end
end