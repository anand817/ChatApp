import json
from channels.generic.websocket import WebsocketConsumer
from asgiref.sync import async_to_sync

group = 0
people = 0

class ChatConsumer(WebsocketConsumer):
    def connect(self):
        global group
        global people

        if(people == 2) :
            group = group + 1
            people = 0
        
        people = people + 1
        
        self.room_group_name = str(group)
        print(self.room_group_name)
        print(people)

        async_to_sync(self.channel_layer.group_add)(
            self.room_group_name,
            self.channel_name
        )

        self.accept()

    def disconnect(self, close_code):
        async_to_sync(self.channel_layer.group_discard)(
            self.room_group_name,
            self.channel_name
        )

    def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json['message']
        print(message)

        async_to_sync(self.channel_layer.group_send)(
            self.room_group_name,
            {
                'type' : 'chat_message',
                'message' : message
            }
        )

    def chat_message(self , event) :
        message = event['message']

        self.send(text_data = json.dumps({
            'message' : message
        }))