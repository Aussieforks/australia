function aus.fname_with_suffix_ext(fname, suffix)
	local char
	local n = #fname
	local i = n
	for i=n,1,-1 do
		if fname:sub(i,i) == '.' then
			return fname:sub(1, i-1) .. suffix .. fname:sub(i)
		end
	end
	-- File with no extension just appends suffix
	return fname .. suffix
end

function aus.iswater(node)
	return node.name == "default:water_source"
		or node.name == "default:water_flowing"
end
