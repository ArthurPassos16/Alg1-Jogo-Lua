require 'codigo/diretorio/jogo'
 anim = require 'anim8'

function love.load()
	math.randomseed(os.time())

	fontes={}
	fontes.grande = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 128)
	fontes.pequena = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 64)

	animacaoes={}
	animacoes.heroina={}
	animacoes.heroina.cima=animacao('cima')
	animacoes.heroina.baixo=animacao('baixo')
	animacoes.heroina.direita=animacao('direita')
	animacoes.heroina.esquerda=animacao('esquerda')

	--animacoes.zumbi={}

	janela={
		x=10,
		y=10,
		borda=10,
		largura=love.graphics.getWidth(),
		altura=love.graphics.getHeight()
	}
	menuAtivado=true

	jogo_load()
	--love.mouse.setVisible(false)
end

function love.update(dt)
	if love.keyboard.isDown("space") then
		menuAtivado=false
	end 
	if not menuAtivado then
		jogo_update(dt)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(0,0,0)
	if menuAtivado then
		love.graphics.setColor(255,0,255)
		love.graphics.rectangle('fill',janela.x,janela.y,janela.largura-20,janela.altura-20)
		love.graphics.setColor(255,255,255)
	    love.graphics.setFont(fontes.grande)
	    love.graphics.printf('CASTELO -', janela.largura / 2 - 500, janela.altura / 2-100, 1000, 'center')
	    love.graphics.printf('7 RINGS', janela.largura / 2 - 500, janela.altura / 2, 1000, 'center')
	else
		love.graphics.setColor(255,133,255)
		love.graphics.rectangle('fill',janela.x,janela.y,janela.largura-20,janela.altura-20)
		jogo_draw()
	end
end

function animacao(direcao)
  	imagem = love.graphics.newImage('arquivos/imagens/heroina/'..direcao..'.png')
 	grade = anim.newGrid(32, 32, imagem:getWidth(), imagem:getHeight())
  	animacao = anim.newAnimation(grade('1-3',1), 0.1)
  	return animacao
end