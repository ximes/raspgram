json.array! @light_client.lights do |light|
	json.extract! light, :id, :hue, :brightness, :saturation, :color_temperature, :on?, :reachable?
end