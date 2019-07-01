function projetil_load(x,y)
	projetil={
		projetil.x=x,
		projetil.y=y,
		posX=0,
		posY=0,
		direcao=false
		mantemDirecao=true
	}
	return projetil
end

function projetil_update(dt)
	projetil.x=love.mouse.getX-janela.largura/2
	projetil.y=love.mouse.getY-janela.largura/2
	--angulo=math.atan2(projetil.x,projetil.y)

	if direcao and mantemDirecao then
		projetil.x=projetil.x+projetil.posX*dt
		projetil.x=projetil.x+projetil.posX*dt
	else
		projetil.x=x
		projetil.y=y
	end

	return projetil
end

function projetil_draw()
	love.graphics.draw()
end