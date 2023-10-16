# Use an official Python runtime as a parent image
FROM python:3.8

# Set the working directory to /app
WORKDIR /app

# Copy the server code and generated code to the container
COPY comm_client.py protos/greet.proto /app/


# Install any needed packages
RUN pip install grpcio-tools
RUN python -m grpc_tools.protoc -I . --python_out=. --grpc_python_out=. greet.proto

# Make port 50051 available to the world outside this container
EXPOSE 50051

# Define environment variable
ENV NAME gRPCServer

# Run the server when the container launches
CMD ["python", "comm_client.py"]
