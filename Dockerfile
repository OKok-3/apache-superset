FROM apache/superset:5.0.0

USER root

# Set environment variable for Playwright
ENV PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers

COPY requirements.txt /app/requirements.txt

# Install packages using uv into the virtual environment
RUN . /app/.venv/bin/activate && \
    uv pip install --no-cache-dir -r /app/requirements.txt \
    && playwright install-deps \
    && PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers playwright install chromium

# Switch back to the superset user
USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]