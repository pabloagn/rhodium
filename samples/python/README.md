Python Data Science Environment

A Nix-based Python development environment with uv package management and JupyterLab integration.

# Quick Start

```bash
# Set up password for JupyterLab (one-time)
just set-password

# Lock dependencies from pyproject.toml
just lock
```

# Daily Development

```bash
# Start JupyterLab in Firefox
just lab-firefox Personal

# Add new packages
just add numpy
just add pandas

# Update environment after adding packages
just update
```

# Package Management

```bash
# Add packages
just add package-name

# Remove packages
just remove package-name

# Update dependencies
just update
```

# Cleanup

```bash
# Kill all Jupyter servers
just kill-all
```
