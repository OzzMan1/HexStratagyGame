extends Node

const PORT = 7000
const IP_ADDRESS = "127.0.0.1" # IPv4 localhost
const MAX_CONNECTIONS = 6

# This will contain player info for every player,
# with the keys being each player's unique IDs.
# All connected players: { peer_id: { name, ready } }
# Players {int : {  {str : str }, {str : bool} } 
var players = {}
#  {  {str : str }, {str : bool} } 
var player_info

var player_name: String = "Player"

signal player_connected()
signal game_started

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.connected_to_server.connect(_on_connected_ok) 
	
func host_game():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT,MAX_CONNECTIONS)
	multiplayer.multiplayer_peer = peer
	var peer_id = multiplayer.get_unique_id()
	player_info =  { "name": player_name, "ready": false }
	players[multiplayer.get_unique_id()] = player_info
	player_connected.emit()

func join_game():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
	
#func disconnect_from_game():
	#players.clear()
	#multiplayer.multiplayer_peer = null

# Call when a new clinet connects to the server
func _on_player_connected(id):
	_register_player.rpc_id(id,player_info)
@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit()

func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	player_info =  { "name": player_name, "ready": false }
	players[peer_id] = player_info
	player_connected.emit()
