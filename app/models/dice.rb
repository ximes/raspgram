class Dice < Trick
    def self.throw(val)
        "Yeah, here's your result: #{(rand(val) + 1)}"
    end
end
