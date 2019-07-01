require 'codigo/diretorio/castelo'

function inimigo_load(x,y)
	inimigo={
		x=x,
		y=y,
		largura=30,
		altura=30,
		direcao='esquerda',
		quantVida=5
	}
	return inimigo
end

function inimigo_update(dt,inimigo)
	inimigo.x=inimigo.x-100*dt
	return inimigo
end

function inimigo_draw(inimigo)
	love.graphics.setColor(0,255,0)
 	love.graphics.rectangle('fill', inimigo.x, inimigo.y, inimigo.largura, inimigo.altura) 
end