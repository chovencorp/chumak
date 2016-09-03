"""
@copyright 2016 Choven Corp.

This file is part of chumak.

chumak is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

chumak is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with chumak.  If not, see <http://www.gnu.org/licenses/>
"""
import zmq
import time
context = zmq.Context()

print('Connection to hello world server')
socket = context.socket(zmq.REP)
socket.setsockopt(zmq.IDENTITY, b"PEER")

socket.bind("tcp://*:5555")


while True:
    message = socket.recv()
    print("Received reply [ %s ]" % message)

    if message == 'delay':
        time.sleep(0.2)

    print("Sending response")
    socket.send(message)

