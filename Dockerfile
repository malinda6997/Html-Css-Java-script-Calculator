# Use the official Node.js image for serving static content (slim variant)
FROM node:16-alpine AS builder

# Set working directory
WORKDIR /app

# Copy your HTML, CSS, and JS files
COPY index.html style.css script.js ./

# Expose port 80
EXPOSE 80

# Use nginx image for serving static content efficiently
FROM nginx:alpine

# Copy the static content from the builder stage
COPY --from=builder /app /usr/share/nginx/html

# Configure default server block for serving index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
