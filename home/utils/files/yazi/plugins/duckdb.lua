-- DuckDB plugin configuration for structured data preview
require("duckdb"):setup({
	mode = "standard",
	cache_size = 500,
	row_id = false,
	minmax_column_width = 21,
	column_fit_factor = 10.0,
})
