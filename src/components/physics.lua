Physics = class("Physics")

function Physics:__init(body, fixture, shape)
    self.body = body
    self.shape = shape
    self.fixture = fixture
end