-- DuckDB plugin configuration for structured data preview
-- Enhanced settings for expert-level data preview with colors and better column handling
require("duckdb"):setup({
	mode = "summary", -- "summary" shows statistics, "standard" shows data rows
	cache_size = 1000, -- Increased cache for better performance
	row_id = true, -- Show row numbers for easier navigation
	minmax_column_width = 15, -- Minimum column width for readability
	column_fit_factor = 8.0, -- Better column fitting in preview pane
	header_style = "bold", -- Bold headers for better visibility
	null_style = "dim", -- Dim NULL values
	border_style = "rounded", -- Rounded borders for aesthetics
})
