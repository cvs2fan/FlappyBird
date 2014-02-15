local Bird = import('..views.bird')
local Background = import('..views.background')
local Hose = import('..views.hose')
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
    self:loadGround()
    self:run()
end


function GameScene:run()
end

function GameScene:loadResource()
    self:loadScore()
    self:loadReady()
    self:loadTapTip()
    self:loadBird()
    self:createHose()

    self.layerTouch = display.newLayer()
    self.layerTouch:addTouchEventListener(function(event, x, y)
        return self:onTap(event, x, y)
    end, true)
    self.layerTouch:setTouchEnabled(true)
    self:addChild(self.layerTouch)
end

function GameScene:resetResource()
end

function GameScene:loadBackground()
    self.bg = display.newSprite(BACKGROUND_FILENAME, display.cx, display.cy)
    self:addChild(self.bg)
end

function GameScene:loadGround()
    self.ground = display.newSprite(GROUND_FILENAME, display.cx, display.bottom)
    self:addChild(self.ground, ZORDER.ground)
    self:moveGround()
end

function GameScene:moveGround()
    self.ground:runAction(
        CCRepeatForever:create(
            transition.sequence({
                CCMoveTo:create(0.3, ccp(display.cx - 60, display.bottom)),
                CCMoveTo:create(0, ccp(display.cx, display.bottom))
            })
        )
    )
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
    self.tapTip = display.newSprite('#click.png')
    self.tapTip:setPosition(display.width / 2, display.height / 2)
    self.tapTip:setScaleX(0.5)
    self.tapTip:setScaleY(0.5)
    self.batch:addChild(self.tapTip)
end

function GameScene:loadBird()
    self.bird = Bird.new()
    self.bird:setScaleX(0.5)
    self.bird:setScaleY(0.5)
    self.bird:setPosition(display.width / 3, display.height / 2)
    self.bird:flap()
    self.batch:addChild(self.bird)
end

function GameScene:createHose()
    local hose = Hose.new()
    self.batch:addChild(hose.up, ZORDER.hose)
    self.batch:addChild(hose.down, ZORDER.hose)
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

function GameScene:removeReadyChildren()
    self.batch:removeChild(self.tapTip)
    self.batch:removeChild(self.getReady)
end

function GameScene:onTap(event, x, y)
    if event == 'began' then
        if self.state == State.ready then
            self:removeReadyChildren()
            self.state = State.flying
            self.bird:fly()
        elseif self.state == State.flying then
            self.bird:fly()
        end
    end
end

return GameScene
