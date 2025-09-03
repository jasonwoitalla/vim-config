LAZY_PLUGIN_SPEC = {
    checker = { notify = false},
}

function spec(item)
	table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

