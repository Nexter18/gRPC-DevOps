import greet_pb2_grpc
import greet_pb2
import time
import grpc

def get_client_stream_requests():
    while True:
        name = input("Please enter a name (or do nothing and chat will end): ")
        
        if name == "":
            break
        
        hello_request = greet_pb2.HelloRequest(greeting = "Hi", name = name)
        yield hello_request
        time.sleep(1)
            

def run():
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = greet_pb2_grpc.GreeterStub(channel)
        print ("1. SayHello - Unary")
        print ("1. DogSaysHello - Server Side Streaming")
        print ("1. CatSaysHello - Client Side Streaming")
        print ("1. InteractingHello - Bidirectional Streaming")
        rpc_call= input ("Which rpc would you like to make?: ")
        
        if rpc_call == "1":
            hello_request = greet_pb2.HelloRequest(greeting = "Salute", name = "Nexter")
            hello_reply = stub.SayHello(hello_request)
            print("Comm received: ")
            print(hello_reply)
        elif rpc_call == "2":
            hello_request = greet_pb2.HelloRequest(greeting = "Wuf", name = "Sassy")
            hello_replies = stub.DogSaysHello(hello_request)
            
            for hello_reply in hello_replies:
                print("Comm received: ")
                print(hello_reply)                        
        elif rpc_call == "3":
            delayed_reply = stub.CatClientSaysHello(get_client_stream_requests())
            
            print("Comm received: ")
            print(delayed_reply)
        elif rpc_call == "4":
            responses = stub.InteractingHello(get_client_stream_requests())
            
            for response in responses:
                print("Comm received: ")
                print(response)


if __name__ == "__main__":
    run()
    