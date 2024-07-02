package funkin.options.sections;

class OptionSection {
    public var sectionName:String;
    public var options:Array<Option> = [];

    public function new(sectionName:String, ?options:Array<Option> = null) {
        this.sectionName = sectionName;
        if (options != null) this.options = options;
    }
}

class Option {
    var name:String;
    var description:String;
    var variable:String;
    var type:String;
}