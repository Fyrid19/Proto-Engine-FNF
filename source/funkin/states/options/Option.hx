package funkin.states.options;

class Option {
    var name:String;
    var description:String;
    var variable:String;
    var type:String; // String, Bool, Array, Dynamic

    public function new(name:String, description:String, variable:String, type:String) {
        this.name = name;
        this.description = description;
        this.variable = variable;
        this.type = type;
    }
}