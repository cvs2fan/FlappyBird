local Bird = import('..views.bird')
local Background = import('..views.background')
local State = {
    ready=1,
    flying=2,
    dead=3
}
local GameScene = class('GameScene', function()
    return display.newScene('GameScene')
end)


function GameScene:ctor()
    self:loadBackground()

    self.state = State.ready
    self.birdHeight = 0
    self.batch = display.newBatchNode(TEXTURES_IMAGE_FILENAME)
    self:addChild(self.batch)

    self:loadResource()
    self:run()
end


function GameScene:run()
    if self.state == State.start then
    elseif self.state == State.running then
    elseif self.state == State.stop then
    end
end

function GameScene:loadResource()
    self:loadScore()
    self:loadReady()
    self:loadTapTip()
    self:loadBird()
end

function GameScene:resetResource()
end

function GameScene:loadBackground()
    local background = Background.new()
    self:addChild(background)
end

function GameScene:loadScore()
end

function GameScene:loadReady()
    self.getReady = display.newSprite('#getready.png')
    self.getReady:setPosition(display.width / 2, display.height * 2 / 3)
    local ratio = (display.width * 2 / 3) / self.getReady:getContentSize().width
    self.getReady:setScaleX(ratio)
    self.getReady:setScaleY(ratio)
    self.batch:addChild(self.getReady)
end

function GameScene:loadTapTip()
end

function GameScene:loadBird()
end

function GameScene:loadNextLoopButton()
    -- TODO refactor this button. It's the same as MenuScene
    local button = display.newSprite('#start.png')
    button:setPosition(display.width - 3 * display.width / 4, 170)
    button:setScaleX(0.5)
    button:setScaleY(0.5)
    self.batch:addChild(button)
    button:setTouchEnabled(true)
    button:addTouchEventListener(function(event, x, y)
        app:enterGameScene()
    end)
end

function GameScene:loadGradeButton()
    -- TODO refactor this button. It's the same as MenuScene
    local button = display.newSprite('#grade.png')
    button:setPosition(display.width - 1 * display.width / 4, 170)
    button:setScaleX(0.5)
    button:setScaleY(0.5)
    self.batch:addChild(button)
end

function GameScene:loadGameOver()
    -- TODO load game over png
end

function GameScene:onDead()
    self:loadGameOver()
    self:loadNextLoopButton()
    self:loadGradeButton()
end

function GameScene:onEnter()
end

function GameScene:onTap()
end

return GameScene
