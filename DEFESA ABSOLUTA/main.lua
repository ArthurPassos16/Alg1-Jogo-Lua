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
	imagens.castelo1=love.graphics.newImage('arquivos/imagens/castelo/castelo1.jpg')
	imagens.castelo2=love.graphics.newImage('arquivos/imagens/castelo/castelo2.jpg')
	imagens.castelo3=love.graphics.newImage('arquivos/imagens/castelo/castelo3.jpg')
	imagens.castelo4=love.graphics.newImage('arquivos/imagens/castelo/castelo4.jpg')
	imagens.portao=love.graphics.newImage('arquivos/imagens/castelo/portao.png')
	imagens.chao=love.graphics.newImage('arquivos/imagens/castelo/chao.jpg')
	imagens.canhao=love.graphics.newImage('arquivos/imagens/castelo/canhao.png')
	imagens.grama=love.graphics.newImage('arquivos/imagens/grama.jpg')
	imagens.arma=love.graphics.newImage('arquivos/imagens/arma.png')
	imagens.fundo=love.graphics.newImage('arquivos/imagens/fundo.jpg')

	animacoes={}
    tempoFrame = 0.15
	animacoes.heroina={}
	animacoes.heroina.cima=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/cima.png'), 47, 47, tempoFrame, 3)
	animacoes.heroina.baixo=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/baixo.png'), 47, 47, tempoFrame, 3)
	animacoes.heroina.direita=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/direita.png'), 47, 47, tempoFrame, 3)
	animacoes.heroina.esquerda=newAnimation(love.graphics.newImage('arquivos/imagens/heroina/esquerda.png'), 47, 47, tempoFrame, 3)

	animacoes.zumbi=newAnimation(love.graphics.newImage('arquivos/imagens/zumbi/esquerda.png'), 32, 31, tempoFrame, 3)

	sons={}
	sons.zumbi=love.audio.newSource('arquivos/sons/zumbi.wav','static')
	sons.canhao=love.audio.newSource('arquivos/sons/canhão.ogg','static')
	
	musicas={}
	musicas.tema=love.audio.newSource('arquivos/musicas/musicaTema.mp3','static')

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
	if love.keyboard.isDown("escape") then
		os.exit()
	elseif love.keyboard.isDown("right") and tela=='inicio' and tempoAtual-tempoClique>1 then
		tempoClique=love.timer.getTime()
		tela='historia'
	elseif love.keyboard.isDown("right") and tela=='historia' and tempoAtual-tempoClique>1 then
		tela='jogo'
	elseif love.keyboard.isDown("left") and tela=='inicio' then
		tela='instrucoes'	
	elseif love.keyboard.isDown("right") and tela=='instrucoes' then
		tempoClique=love.timer.getTime()
		tela='inicio'
	elseif tela=='jogo' then
		musicas.tema:setLooping(true)
		musicas.tema:play()
		jogo_update(dt)
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(imagens.fundo,710,415,0,0.889,0.83,janela.largura+20,janela.altura+20)
	love.graphics.setColor(0,0,0)
	if tela=='inicio' then
	    love.graphics.setFont(fontes.grande)
	    love.graphics.printf('DEFESA ABSOLUTA', janela.largura / 2 - 500, 100, 1000, 'center')
	    love.graphics.setFont(fontes.media)
	    love.graphics.printf('Defenda seu castelo do', janela.largura / 2 - 500, 200, 1000, 'center')
	    love.graphics.printf('ataque dos zumbis', janela.largura / 2 - 500, 250, 1000, 'center')
	    love.graphics.setFont(fontes.pequena)
	    love.graphics.printf('iniciar ->', -250, janela.altura-30, 1000, 'right')
	    love.graphics.printf('<- instruções', 10, janela.altura-30, 1000, 'left')

	elseif tela=='instrucoes' then
	    love.graphics.setFont(fontes.grande)
	    love.graphics.printf('INSTRUÇÕES', 30, 10, 1000, 'left')
	    love.graphics.setFont(fontes.media)
	    love.graphics.printf('Use as teclas A,W,S,D ou as setas',30, 200, 1000, 'left')
	    love.graphics.printf('para locomover a heroina',30, 230, 1000, 'left')
	    love.graphics.printf('Use o mouse para atirar',30, 270, 1000, 'left')
	    love.graphics.printf('Use a tecla esc para sair',30, 310, 1000, 'left')
	    love.graphics.printf('E divirta-se!',30, 350, 1000, 'left')
	    love.graphics.setFont(fontes.pequena)
	    love.graphics.printf('voltar ->', janela.largura-150, janela.altura-30, 1000, 'left')

	elseif tela=='historia' then
	    love.graphics.setFont(fontes.grande)
	    love.graphics.printf('História', -100, 10, 1000, 'center')
	    love.graphics.setFont(fontes.media)
	    love.graphics.printf('Em um mundo pós-apocalíptico',40, 160, 1000, 'left')
	    love.graphics.printf('zumbis  tentam  invandir  uma',40, 195, 1000, 'left')
	    love.graphics.printf('das  grandes  fortalezas  da',40, 230, 1000, 'left')
	    love.graphics.printf('humanidade.',40, 265, 1000, 'left')
	    love.graphics.printf('proteja a fortaleza e garanta',40, 310, 1000, 'left')
	    love.graphics.printf('a sobrevivência da humanidade.',40, 345, 1000, 'left')
	    love.graphics.printf('o futuro está em suas mãos!',40, 390, 1000, 'left')
	    love.graphics.setFont(fontes.pequena)
	    love.graphics.printf('iniciar ->', janela.largura-150, janela.altura-30, 1000, 'left')

	elseif tela=='jogo' then
		love.graphics.clear()
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle('fill',janela.x,janela.y,janela.largura,janela.altura)
		jogo_draw()
	end
end