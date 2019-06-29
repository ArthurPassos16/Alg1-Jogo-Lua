require 'codigo/diretorio/jogo'

function love.load()
	math.randomseed(os.time())

	fontes={}
	fontes.large = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 128)

	janela={
		x=0,
		y=0,
		borda=10,
		largura=love.graphics.getWidth(),
		altura=love.graphics.getHeight()
	}

	jogo_load()
	--love.mouse.setVisible(false)
end

function love.update(dt)
	jogo_update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle('fill',janela.x,janela.y,10,janela.altura)
	love.graphics.rectangle('fill',janela.x,janela.y,janela.largura,10)
	love.graphics.rectangle('fill',janela.largura-10,0,10,janela.altura)
	love.graphics.rectangle('fill',janela.x,janela.altura-10,janela.largura,10)

	jogo_draw()
end