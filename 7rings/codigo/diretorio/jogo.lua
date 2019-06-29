require 'codigo/diretorio/heroina'
require 'codigo/diretorio/castelo'
require 'codigo/diretorio/inimigo'
require 'codigo/bibliotecas/fisica'

function jogo_load()
	heroina=heroina_load()
	castelo=castelo_load()
	inimigo=inimigo_load()

	morte=false
end

function jogo_update(dt)
	heroina=heroina_update(dt)
	inimigo=inimigo_update(dt)

	-- detecta colisão com as extremidades
	heroina=detectarColisaoDentro(heroina,janela)
	-- detecta colisão com o inimigo
	morte=detectarColisao(heroina,inimigo)
	-- detecta colisao com o castelo
	for i=castelo.y, castelo.altura, castelo.alturaBloco do
		for j=castelo.x, castelo.largura, castelo.larguraBloco do
			if ((i==castelo.y or j==castelo.x or i==castelo.altura) and j<=castelo.meio) or ((i==175 or i==310) and j>castelo.meio) or 
			 (j==castelo.meio and (i<=175 or i>=310)) or (j==castelo.largura and (i==190 or i==295)) then
 				detectarColisaoFora(heroina,j,i,castelo.alturaBloco,castelo.larguraBloco)
 			end
 		end
 	end
end

function jogo_draw()
	castelo_draw()
	heroina_draw()
	inimigo_draw()

	if morte then
		love.graphics.clear()
		love.graphics.setFont(fontes.large)
        love.graphics.setColor(255, 0, 255)
        love.graphics.printf('FIM DO JOGO', janela.largura / 2 - 500, janela.altura / 2, 1000, 'center')
    end
end