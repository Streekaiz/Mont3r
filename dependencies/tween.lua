local library = {}
library.__index = library

function library.tween.new(instance, properties, duration, easingStyle, easingDirection)
    local self = setmetatable({}, library)
    self.instance = instance
    self.properties = properties
    self.duration = duration
    self.easingStyle = easingStyle
    self.easingDirection = easingDirection
    self.tween = nil
    self.onPlay = nil
    self.onPause = nil
    self.onCancel = nil
    self.onDestroy = nil
    return self
end

function library.tween:initialize()
    local tweenInfo = TweenInfo.new(
        self.duration,
        self.easingStyle,
        self.easingDirection
    )
    self.tween = tweenService:Create(self.instance, tweenInfo, self.properties)
end

function library.tween:play()
    if self.tween then
        self.tween:Play()
        if self.onPlay then
            self.onPlay(self)
        end
    end
end

function library.tween:pause()
    if self.tween then
        self.tween:Pause()
        if self.onPause then
            self.onPause(self)
        end
    end
end

function library.tween:cancel()
    if self.tween then
        self.tween:Cancel()
        if self.onCancel then
            self.onCancel(self)
        end
    end
end

function library.tween:destroy()
    if self.tween then
        self.tween:Destroy()
        if self.onDestroy then
            self.onDestroy(self)
        end
        self.tween = nil
    end
end

function library.tween:setCallback(event, callback)
    if event == "play" then
        self.onPlay = callback
    elseif event == "pause" then
        self.onPause = callback
    elseif event == "cancel" then
        self.onCancel = callback
    elseif event == "destroy" then
        self.onDestroy = callback
    end
end

function library.tween:create(instance, properties, duration, easingStyle, easingDirection)
    local tween = library.tween.new(instance, properties, duration, easingStyle, easingDirection)
    tween:initialize()
    tween:play()
    return tween
end

--[=[
    Documentation
    local myTween = library.tween:create(instance, {Position = UDim2.new(0, 100, 0, 100)}, 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    myTween:setCallback("play", function(self)
        print("Tween started")
    end)

    myTween:setCallback("pause", function(self)
        print("Tween paused")
    end)

    myTween:setCallback("cancel", function(self)
        print("Tween canceled")
    end)

    myTween:setCallback("destroy", function(self)
        print("Tween destroyed")
    end)
]=]

return library