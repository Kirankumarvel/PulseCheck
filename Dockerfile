# Use official lightweight Python image
FROM python:3.12-slim

# Create non-root user
RUN useradd -m appuser

# Set working directory
WORKDIR /app

# Copy only requirements (minimal install)
COPY app.py .

# Install dependencies
RUN pip install --no-cache-dir fastapi uvicorn

# Expose application port
EXPOSE 8000

# Switch to non-root user
USER appuser

# Start the FastAPI app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
