function asset_mapper(asset_name)
	assets_path = tostring(debug.getinfo(1).source):match("(/.*/)")
	return assets_path .. asset_name
end

return asset_mapper
