.PHONY: nohup stop status logs clean

# Run Rails development server in background with nohup
nohup:
	@echo "Starting Rails development server in background..."
	nohup ./bin/dev > dev.log 2>&1 &
	@echo "Server started! Check logs with 'make logs'"
	@echo "Stop server with 'make stop'"

# Stop the development server (improved version)
stop:
	@echo "Stopping Rails development server..."
	@# Kill processes using port 3000
	@if lsof -ti:3000 >/dev/null 2>&1; then \
		lsof -ti:3000 | xargs kill -9 2>/dev/null && echo "✓ Killed processes on port 3000"; \
	else \
		echo "- No processes found on port 3000"; \
	fi
	@# Kill any remaining Rails-related processes
	@pkill -9 -f "bin/dev" 2>/dev/null && echo "✓ Killed bin/dev processes" || echo "- No bin/dev processes"
	@pkill -9 -f "rails server" 2>/dev/null && echo "✓ Killed rails server processes" || echo "- No rails server processes"
	@pkill -9 -f "puma.*rails-webview" 2>/dev/null && echo "✓ Killed puma processes" || echo "- No puma processes"
	@sleep 1
	@echo "✅ Server stop completed"

# Check server status
status:
	@echo "Checking Rails server status..."
	@if ss -tulpn | grep -q ":3000"; then \
		echo "✅ Rails server is running on port 3000"; \
		ss -tulpn | grep ":3000"; \
		echo "Active processes:"; \
		ps aux | grep -E "(bin/dev|rails server|puma)" | grep -v grep | head -5; \
	else \
		echo "❌ No Rails server found on port 3000"; \
	fi

# Show recent logs
logs:
	@if [ -f dev.log ]; then \
		echo "Recent development server logs:"; \
		tail -f dev.log; \
	else \
		echo "No dev.log file found"; \
	fi

# Clean up log files
clean:
	@echo "Cleaning up log files..."
	@rm -f dev.log nohup.out
	@echo "Log files cleaned"

# Restart server
restart: stop
	@sleep 2
	@$(MAKE) nohup

# Help target
help:
	@echo "Available targets:"
	@echo "  nohup    - Start Rails dev server in background"
	@echo "  stop     - Stop the Rails dev server"
	@echo "  restart  - Stop and start the server"
	@echo "  status   - Check if server is running"
	@echo "  logs     - Show recent server logs (tail -f)"
	@echo "  clean    - Remove log files"
	@echo "  help     - Show this help message"
