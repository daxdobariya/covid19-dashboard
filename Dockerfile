# Step 1: Use a lightweight Python image
FROM python:3.10-slim

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy all project files into the container
COPY . /app

# Step 4: Install required Python packages
RUN pip install --upgrade pip && pip install -r requirements.txt

# Step 5: Expose the Django default port
EXPOSE 8000

# Step 6: Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

