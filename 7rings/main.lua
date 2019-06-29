require 'codigo/diretorio/jogo'

function love.load()
	math.randomseed(os.time())

	fontes={}
	fontes.grande = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 128)
	fontes.pequena = love.graphics.newFont('arquivos/fontes/Gamer.ttf', 64)

	janela={
		x=0,
		y=0,
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
	jogo_update(dt)
end

function love.draw()
	if menuAtivado then
		love.graphics.setBackgroundColor(255,0,255)
		background()
		love.graphics.setColor(255,255,255)
	    love.graphics.setFont(fontes.grande)
	    love.graphics.printf('CASTELO -', janela.largura / 2 - 500, janela.altura / 2-100, 1000, 'center')
	    love.graphics.printf('7 RINGS', janela.largura / 2 - 500, janela.altura / 2, 1000, 'center')
	else
		love.graphics.setBackgroundColor(255,133,255)
		background()
		jogo_draw()
	end
end

function background()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle('fill',janela.x,janela.y,10,janela.altura)
	love.graphics.rectangle('fill',janela.x,janela.y,janela.largura,10)
	love.graphics.rectangle('fill',janela.largura-10,0,10,janela.altura)
	love.graphics.rectangle('fill',janela.x,janela.altura-10,janela.largura,10)
end