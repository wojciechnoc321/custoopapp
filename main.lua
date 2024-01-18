function love.load() --wstepna funkcja ladujaca dane itp
    target = {}
    target.x = 300 --wstepne wspolrzedne celu
    target.y = 300
    target.radius = 50 --promien okregu
    score = 0 --wynik
    timer = 0 --countdown

    gameState = 1 --1 menu 2 w trakcie

    gameFont = love.graphics.newFont(40) -- nowa czcionka

    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    love.mouse.setVisible(false)
end

function love.update(dt) --petla gry, updatuje sie 60 razy na sekunde --dt dynamicznie oblicza o zmiane fps
    if timer > 0 then
    timer = timer - dt--1/60 sekundy
    end 
    
    if timer < 0 then  --limit konczaczy timer
        timer = 0
        gameState = 1 --zatrzymanie gry
    end
end
function love.draw() --zmiana na naszym ekranie
    love.graphics.draw(sprites.sky, 0,0)
    --love.graphics.setColor(1,0,0)
    --love.graphics.circle("fill", target.x, target.y, target.radius) --odwolanie sie do wartosci w poprzedniej funkcji definiujacej
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont) --uzycie zadeklorawnej czcionki
    love.graphics.print("Score:"..score, 2, 2)
    love.graphics.print("Countdown:"..math.ceil(timer), 300, 2) --zaokreglenie +
    
    if gameState == 1 then
        love.graphics.printf("Click with right button to start a game", 0, 250, love.graphics.getWidth(),"center")
    end   

    if gameState == 2 then
        love.graphics.draw(sprites.target,  target.x-target.radius, target.y-target.radius)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20) --celownik i powiazanie go z pozycja myszy , na sile przesuniecie o 20px przesuwajace celownik na srodek kursora
    



end

function love.mousepressed( x, y, button, istouch, presses ) --determinacja czy zostanie klikniety cel
    if button == 1 and gameState == 2 then -- strzelamy LPM
        local mouseToTarget = distanceBetween(x, y, target.x, target.y) --x y lokalizacja myszki, target lokalizacja celu
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth()-target.radius) --przedzial losowej liczby --pobranie szerokosci 
            target.y = math.random(target.radius, love.graphics.getHeight()-target.radius) -- przedzial liczbowy losowej liczby --pobranie wysokosci
        end 
    end    
    if button == 2 and gameState == 1 then --gra uruchamia sie po kliknieciu RPM
        gameState = 2
        timer = 10
        score = 0
    end    

end

function distanceBetween(x1, y1, x2, y2) 
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end