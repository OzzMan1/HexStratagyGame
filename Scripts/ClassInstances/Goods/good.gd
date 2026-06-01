extends Resource

class_name Good
 
@export var name : String
@export var isRaw : bool 
# recipe
@export var input : Dictionary[Good,int] 
@export var output : int
