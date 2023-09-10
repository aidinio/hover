function icon_mapper(icon_name)
	icons_path = tostring(debug.getinfo(1).source):match("(/.*/)")
	return icons_path .. icon_name ..".svg"
end

return icon_mapper
