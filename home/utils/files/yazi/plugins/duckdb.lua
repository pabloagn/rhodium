-- DuckDB plugin configuration for structured data preview
-- Uses "standard" mode to display actual data rows (not statistics)
require("duckdb"):setup({
	mode = "standard", -- "standard" shows data rows, "summarized" shows statistics
	cache_size = 1000, -- Increased cache for better performance
	row_id = "dynamic", -- Show row numbers only when scrolling columns
	column_fit_factor = 8.0, -- Average character space per column for display optimization
})
